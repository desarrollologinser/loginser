unit u_main;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,midaslib,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, sSkinManager, sGroupBox, inifiles,jpeg,
  JvDBGrid, Vcl.StdCtrls,
  sTooledit, sEdit, sBitBtn, sLabel,
  sGauge, sPanel, sdialogs,strutils,types,System.DateUtils,
  Data.DB, pfibdataset,
  sRadioButton,registry, sCheckBox,
  System.Variants,
  Xml.XMLDoc, IdTCPConnection,
  IdFTP,IdFTPList, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom,
  IdBaseComponent, IdComponent, IdTCPClient, IdExplicitTLSClientServerBase,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, frxClass, frxDBSet,frxbarcode,
  sButton,printers,Winapi.WinSpool,adodb, XLSSheetData5, XLSReadWriteII5,Xc12Utils5;

type
  Tstock = record
    id_art:Integer;
    uds:Integer;
  end;
  Tf_main = class(TForm)
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    pn_spnl1: TsPanel;
    ga_stat: TsGauge;
    lb_st1: TsLabel;
    sGroupBox1: TsGroupBox;
    bt_import: TsBitBtn;
    sGroupBox2: TsGroupBox;
    bt_genera: TsBitBtn;
    gb_1: TsGroupBox;
    rg_state: TsRadioGroup;
    gr_envs: TJvDBGrid;
    gb_date: TsGroupBox;
    rb_alldate: TsRadioButton;
    rb_adate: TsRadioButton;
    de_ini: TsDateEdit;
    de_fin: TsDateEdit;
    gb_search: TsGroupBox;
    ed_search_envio: TsEdit;
    cb_envio: TsCheckBox;
    lb_n: TsLabel;
    bt_nuevo: TsBitBtn;
    bt_reexp: TsBitBtn;
    bt_anular: TsBitBtn;
    ftp_1: TIdFTP;
    xml_1: TXMLDocument;
    bt_send: TsBitBtn;
    rep_db_bultos: TfrxDBDataset;
    rep_asm: TfrxReport;
    sButton1: TsButton;
    sGroupBox3: TsGroupBox;
    sBitBtn1: TsBitBtn;
    de_1: TsDateEdit;
    xls_1: TXLSReadWriteII5;
    bt1: TsButton;
    procedure rg_stateClick(Sender: TObject);
    procedure bt_importClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bt_generaClick(Sender: TObject);
    procedure filter;
    function busca_art(codigo:string):integer;
    procedure limpiar_stock;
    procedure get_stock;
    function verif_stock(pedido:Integer):boolean;
    procedure descuenta_stock(pedido:Integer);
    procedure informe_sin_stock;
    function ruta_escritorio:string;
    procedure genera_albaranes;
    procedure genera_picking;
    procedure gr_envsDblClick(Sender: TObject);
    procedure bt_reexpClick(Sender: TObject);
    procedure bt_nuevoClick(Sender: TObject);
    procedure bt_anularClick(Sender: TObject);
    procedure ed_search_orderClick(Sender: TObject);
    function verif_stock_x_art(id_art,uds:Integer):boolean;
    function busca_art_x_id(id_articulo:integer):string;
    function GrabaServicio(sociedad,id_cliente,id_order,id_muzybar:integer;
                       dst_nombre,dst_calle,dst_cp,dst_localidad,dst_provincia,dst_telefono,dst_persona:string;
                       observaciones:string;
                       id_repartidor,kgs:integer; var bultos:Integer;
                       fecha:tdate):integer;
    function SiguienteLaboral(fecha:tdate):TDate;
    procedure bt_sendClick(Sender: TObject);
    procedure leer_ini;
    procedure imprime_bultos;
    function imprime_eti_bulto_asm(codalbaran:integer):string;
    function limpiachar(frase: string):string;
    procedure sButton1Click(Sender: TObject);
    procedure imprime_eti_bulto_chrono(codalbaran:integer; var prim_ch_codbulto,ult_ch_codbulto:string);
    function WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
    function get_chrono_bulto(cp:integer):string;
    Function calc_digcon_chrono(codbar:string):Integer;
    procedure envia_ficheros(todos:Boolean=False);
    function genera_fichero_asm(ruta:string; todos:boolean):integer;
    function linea_asm(codalbaran:Integer):string;
    function get_cp_ext(poblacion:string):string;
    function get_nombrefichero_chrono(fecha: TDateTime):string;
    function genera_fichero_chrono(ruta:string; todos:boolean):integer;
    function linea_chrono(codalbaran:Integer; ch_bulto_ini,ch_bulto_fin:string):string;
    function cadLongitudFija (cadena : string; longitud : Integer;
                  posicionIzquierda : boolean; valorRelleno : string) : string;
    procedure sBitBtn1Click(Sender: TObject);
    procedure bt1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure send_file(id_muzybar:integer);
  end;

var
  f_main: Tf_main;

  ar_stock:array of Tstock;                    //stock
  idx_stock:Integer=0;

  imp_eti:string;

const
  //cli_inf_asm = '41968';
  cli_inf_asm = '62119';
  version = '[2.1]';

  //[2.1] Versión. ServerUpdate. Remitente según el caso de la sociedad. Control de aplicación abierta Mutex.

implementation

uses u_dm, u_detail, Documento, u_gen_gl, u_cam_gl, u_envia_mail, u_globals;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_main.FormShow(Sender: TObject);
begin
  de_ini.Date:=now;
  de_fin.Date:=now;

  de_1.Date:=now;

  leer_ini;
  u_globals.leer_ini;
  u_globals.ini_bd_simple;

  Caption := 'Gestión Ficheros Muzybar ' + version;

  filter;
end;

procedure Tf_main.leer_ini;
var ini:tinifile;  exe,ruta_exe,ruta_ini:string;
begin
  exe:=ExtractFileName(ParamStr(0));
  exe:=Copy(exe,1,Length(exe)-4);

  ruta_exe:=ExtractFilePath(ParamStr(0));
  IncludeTrailingPathDelimiter(ruta_exe);

  if FileExists(ruta_exe+'config.ini') then ruta_ini:=ruta_exe+'config.ini'          //al lado del exe o en C
    else if FileExists('C:\config.ini') then ruta_ini:='C:\config.ini'
      else raise exception.Create('No Encontrado Config.ini');

  ini:=TIniFile.Create(ruta_ini);
  try
    imp_eti:=ini.readstring('Datos','imp_eti','');
  finally
    ini.free;
  end;
end;

{$ENDREGION}

{$REGION 'Filters Importar'}
procedure Tf_main.rg_stateClick(Sender: TObject);                        //CAMBIA RADIOGROUP ESTADOS DE VISUALIZACION
begin
 if dm.db.Connected then filter;
end;

procedure Tf_main.ed_search_orderClick(Sender: TObject);
begin
  if cb_envio.Checked then filter;
end;

procedure Tf_main.filter;
var s:string;
begin
  dm.q_peds.Close;
  dm.q_peds.SelectSQL.Clear;
  dm.q_peds.SelectSQL.Add('select * ');
  dm.q_peds.SelectSQL.Add(' from c_pedidos_muzybar ');

  dm.q_peds_count.Close;
  dm.q_peds_count.SelectSQL.Clear;
  dm.q_peds_count.SelectSQL.Add('select count(*) as tot ');
  dm.q_peds_count.SelectSQL.Add(' from c_pedidos_muzybar ');

  if rb_alldate.checked then begin
    dm.q_peds.SelectSQL.Add('where 1=1 ');

    dm.q_peds_count.SelectSQL.Add('where 1=1 ');
  end else begin
    dm.q_peds.SelectSQL.Add('where cast(fecha_imp as date) between :f1 and :f2 ');
    dm.q_peds.ParamByName('f1').AsDate:=de_ini.Date;
    dm.q_peds.ParamByName('f2').AsDate:=de_fin.Date;

    dm.q_peds_count.SelectSQL.Add('where cast(fecha_imp as date) between :f1 and :f2 ');
    dm.q_peds_count.ParamByName('f1').AsDate:=de_ini.Date;
    dm.q_peds_count.ParamByName('f2').AsDate:=de_fin.Date;
  end;

  s:='';
  case (rg_state.ItemIndex) of
    0: s:='and estado=''P'' ';          //Pendientes
    1: s:='and estado=''X'' ';          //sin stock
    2: s:='and estado=''G'' ';          //generados
    3: s:='and estado=''E'' ';          //enviados
    4: s:='and estado=''A'' ';          //anulados
  end;

  if cb_envio.Checked then begin
    dm.q_peds.SelectSQL.Add('and id_order=:busc ');
    dm.q_peds.ParamByName('busc').AsString:=ed_search_envio.Text;

    dm.q_peds_count.SelectSQL.Add('and id_order= :busc ');
    dm.q_peds_count.ParamByName('busc').AsString:=ed_search_envio.Text;
  end;

  dm.q_peds.SelectSQL.Add(s);
  dm.q_peds.SelectSQL.Add('order by id_order ');
  dm.q_peds.Open;

  dm.q_peds_count.SelectSQL.Add(s);
  dm.q_peds_count.Open;

  lb_n.Caption:=IntToStr(dm.q_peds_count.FieldByName('tot').asinteger)+' lineas';
end;

procedure Tf_main.gr_envsDblClick(Sender: TObject);
begin
  u_detail.mode:=0;
  f_detail.ShowModal;
end;

procedure Tf_main.bt_reexpClick(Sender: TObject);
begin
  u_detail.mode:=2;
  f_detail.ShowModal;
end;

procedure Tf_main.bt_nuevoClick(Sender: TObject);
begin
  u_detail.mode:=1;
  f_detail.ShowModal;
end;

procedure Tf_main.bt1Click(Sender: TObject);
var
  aux:Integer;
  d: tdate;
begin
  GrabaServicio(100,0,0,0,'','','','','','','','',0,0,aux,d);
end;

procedure Tf_main.bt_anularClick(Sender: TObject);
begin
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos_muzybar set estado=''A'' where id_muzybar=:id_muzybar');
    dm.q_1.ParamByName('id_muzybar').AsInteger:=dm.q_peds.fieldbyname('id_muzybar').asinteger;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end;

  filter;
end;

{$ENDREGION}

{$REGION 'Importar'}
procedure Tf_main.bt_importClick(Sender: TObject);                //IMPORTAR PEDIDOS DESDE FTP
var        exp_xml:IXMLDocumento;       id_line,n,i,j,id_order,id_muzybar,id_articulo,cp, sociedad:integer;
           xml_path,pdf_path,codigo_art:string;
           dirs_in, dirs_out: TStringList;
begin  
  n:=0;

  lb_st1.Caption:='Consultando Pedidos Muzybar en FTP';
  application.ProcessMessages;

  ftp_1.Connect;
  try
    with dm.q_aux do
    begin
              //Directorios de entrada
      Close;
      sqls.SelectSQL.clear;
      sqls.SelectSQL.Add('select muzybar_dir_ftp_in from c_aux');
      Open;

      dirs_in := TStringList.Create;
      dirs_in.Delimiter := '|';
      dirs_in.StrictDelimiter := True;
      dirs_in.DelimitedText := FieldByName('muzybar_dir_ftp_in').AsString;
     end;

    for j := 0 to dirs_in.Count-1 do
    begin
      //ftp_1.ChangeDir('/sync/muzybar/in');
      ftp_1.ChangeDir(dirs_in[j]);
      ftp_1.List('.');

      sociedad := StrToInt(Copy(dirs_in[j],LastDelimiter('/',Copy(dirs_in[j],0,Length(dirs_in[j])-1))+1,3));

      for i:=0 to ftp_1.DirectoryListing.Count-1 do begin
        if ((ftp_1.DirectoryListing[i].ItemType=ditFile) and (ExtractFileExt(ftp_1.DirectoryListing[i].FileName)='.xml')) then begin
          xml_path:='\\seth\sysfiles\Importacion\Muzybar\In\'+ftp_1.DirectoryListing[i].FileName;
          ftp_1.Get(ftp_1.DirectoryListing[i].FileName,xml_path,True,false);                                                     //Get XML

          xml_1.FileName:=xml_path;
          xml_1.Active:=true;
          exp_xml:=GetDocumento(xml_1);

          id_order:=exp_xml.InfGeneral.InfAlb.IdAlb;

          pdf_path:='\\seth\sysfiles\Importacion\Muzybar\In\PreExpedicion'+IntToStr(id_order)+'.pdf';

          if ftp_1.Size('PreExpedicion'+IntToStr(id_order)+'.pdf')<>-1 then
              ftp_1.Get('PreExpedicion'+IntToStr(id_order)+'.pdf',pdf_path,True,false);                                              //Get PDF

          with TpFIBDataSet.Create(self) do
          try
            Database:=dm.db;
            sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_MUZYBAR_ID,1) FROM RDB$DATABASE');
            Open;
            id_muzybar:=FieldByName('gen_id').AsInteger;
          finally
            free;
          end;

          dm.t_write.StartTransaction;
          try
            dm.q_1.Close;
            dm.q_1.sql.Clear;
            dm.q_1.sql.Add('insert into c_pedidos_muzybar '+
              '(ID_MUZYBAR,ID_ORDER,NOMBRE,DIR_1,POBLACION,PROVINCIA,CP,PAIS,TELEFONO,FECHA_PED,ID_REPARTIDOR,REPARTIDOR,BULTOS,XML_PATH,PDF_PATH,SOCIEDAD) '+
              'values (:ID_MUZYBAR,:ID_ORDER,:NOMBRE,:DIR_1,:POBLACION,:PROVINCIA,:CP,:PAIS,:TELEFONO,:FECHA_PED,:ID_REPARTIDOR,:REPARTIDOR,:BULTOS,:XML_PATH,:PDF_PATH,:SOCIEDAD)');
            dm.q_1.ParamByName('ID_MUZYBAR').AsInteger:=id_muzybar;
            dm.q_1.ParamByName('ID_ORDER').AsInteger:=id_order;
            dm.q_1.ParamByName('NOMBRE').asstring:=exp_xml.InfGeneral.InfAlb.NomEnv;
            dm.q_1.ParamByName('DIR_1').asstring:=exp_xml.InfGeneral.InfAlb.DirEnv;
            dm.q_1.ParamByName('POBLACION').asstring:=exp_xml.InfGeneral.InfAlb.PobEnv;
            dm.q_1.ParamByName('PROVINCIA').asstring:=exp_xml.InfGeneral.InfAlb.ProEnv;
            if TryStrToInt(exp_xml.InfGeneral.InfAlb.CPEnv,cp) then dm.q_1.ParamByName('CP').asinteger:=cp
              else dm.q_1.ParamByName('CP').asinteger:=0;
            dm.q_1.ParamByName('PAIS').asstring:=exp_xml.InfGeneral.InfAlb.PaiEnv;
            dm.q_1.ParamByName('TELEFONO').asstring:=exp_xml.InfGeneral.InfAlb.TlfEnv;
            dm.q_1.ParamByName('FECHA_PED').AsDateTime:=EncodeDate(strtoint(Copy(exp_xml.InfGeneral.InfAlb.Fecha,1,4)),strtoint(Copy(exp_xml.InfGeneral.InfAlb.Fecha,6,2)),StrToInt(Copy(exp_xml.InfGeneral.InfAlb.Fecha,9,2)));
            dm.q_1.ParamByName('ID_REPARTIDOR').asinteger:=exp_xml.InfGeneral.InfAlb.IdTrans;
            dm.q_1.ParamByName('REPARTIDOR').asstring:=exp_xml.InfGeneral.InfAlb.Transpor;
            dm.q_1.ParamByName('BULTOS').asinteger:=exp_xml.InfGeneral.InfAlb.Bultos;
            dm.q_1.ParamByName('XML_PATH').asstring:=xml_path;
            dm.q_1.ParamByName('PDF_PATH').asstring:=pdf_path;
            dm.q_1.ParamByName('SOCIEDAD').AsInteger:=sociedad;
            dm.q_1.ExecQuery;

            for id_line:=0 to exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb-1 do begin
              codigo_art:='7078'+rightstr(StringOfChar('0',5)+IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt),5);
              id_articulo:=busca_art(codigo_art);

              dm.q_1.Close;
              dm.q_1.sql.Clear;
              dm.q_1.sql.Add('insert into c_pedidos_muzybar_lines '+
                '(id_muzybar, id_line, id_articulo, cantidad,sku,nombre_art) '+
                'values (:id_muzybar, :id_line, :id_articulo, :cantidad, :sku, :nombre_art)');
              dm.q_1.ParamByName('id_muzybar').AsInteger:=id_muzybar;
              dm.q_1.ParamByName('id_line').AsInteger:=exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdLin;
              dm.q_1.ParamByName('id_articulo').asinteger:=id_articulo;
              dm.q_1.ParamByName('cantidad').asinteger:=exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Unidades div 1000000;
              dm.q_1.ParamByName('sku').AsString:=IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt);
              dm.q_1.ParamByName('nombre_art').AsString:=Copy(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Articulo,1,100);
              dm.q_1.ExecQuery;
            end;
            dm.t_write.CommitRetaining;
          except
            dm.t_write.Rollback;
            raise Exception.Create('Error Generando Expedición '+inttostr(id_order)+' = '+xml_path);
          end;

          ftp_1.Rename(ftp_1.DirectoryListing[i].FileName,'./bak/'+ftp_1.DirectoryListing[i].FileName);               //Move Files to Bak in FTP

          if FileExists(pdf_path) then
              ftp_1.Rename('PreExpedicion'+IntToStr(id_order)+'.pdf','./bak/PreExpedicion'+IntToStr(id_order)+'.pdf');

          inc(n);
        end;
      end;
    end;
  finally
    ftp_1.Disconnect;
  end;

  lb_st1.Caption:='Importación Finalizada, '+inttostr(n)+' Pedidos Importados';
  application.ProcessMessages;
  filter;
  sMessageDlg('Importación Finalizada, '+inttostr(n)+' Pedidos Importados',mtInformation,[mbok],0);
end;
{$ENDREGION}

{$REGION 'Generar'}
procedure Tf_main.bt_generaClick(Sender: TObject);                //GENERA ENVIOS
begin
  //*********************************************************************VERIFICA STOCK
  lb_st1.Caption:='Verificando Stock';
  application.ProcessMessages;

  get_stock;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select id_muzybar '+
      'from c_pedidos_muzybar '+
      'where estado in(''P'',''X'')');
    Open;

    first;
    while not(Eof) do begin
      if verif_stock(FieldByName('id_muzybar').asinteger) then begin                 //si tiene stock
        descuenta_stock(FieldByName('id_muzybar').asinteger);
        dm.t_write.StartTransaction;
        try
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos_muzybar set estado=''P'' where id_muzybar=:id_muzybar');
          dm.q_1.ParamByName('id_muzybar').AsInteger:=FieldByName('id_muzybar').asinteger;
          dm.q_1.ExecQuery;
          dm.t_write.Commit;
        except
          dm.t_write.rollback;
        end;

      end else begin                                                   //no hay stock para este pedido
        dm.t_write.StartTransaction;
        try
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos_muzybar set estado=''X'' where id_muzybar=:id_muzybar');
          dm.q_1.ParamByName('id_muzybar').AsInteger:=FieldByName('id_muzybar').asinteger;
          dm.q_1.ExecQuery;
          dm.t_write.Commit;
        except
          dm.t_write.rollback;
        end;
      end;
      next;
    end;
  finally
    free;
  end;

  lb_st1.Caption:='Generando Informe Sin Stock';
  application.ProcessMessages;

  informe_sin_stock;

  //*******************************************************************ALBARANES
  lb_st1.Caption:='Generando Albaranes';
  application.ProcessMessages;

  genera_albaranes;

  //*******************************************************************PICKING
  lb_st1.Caption:='Generando Picking';
  application.ProcessMessages;

  genera_picking;

{  //*******************************************************************IMPRIME ETIQUETAS BULTOS
  lb_st1.Caption:='Imprime Etiquetas de Bultos';
  application.ProcessMessages;

  imprime_bultos;

  //*******************************************************************ENVIA FICHERO ASM
  lb_st1.Caption:='Enviando Fichero a ASM/ChronoExpress';
  application.ProcessMessages;

  envia_ficheros;    }

  //*******************************************************************MARCAR COMO GENERADOS
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos_muzybar set estado=''G'',fecha_gen=:fecha where estado=''P'' ');
    dm.q_1.ParamByName('fecha').AsDateTime:=Now;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end;

  //******************************************************************

  filter;

  sMessageDlg('Done!!',mtInformation,[mbok],0);
end;
{$ENDREGION}

{$REGION 'Aux'}
function Tf_main.busca_art(codigo:string):integer;
begin                                       //devuelve id de articulo a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=-1;

    Free;
  end;
end;

function Tf_main.busca_art_x_id(id_articulo:integer):string;
begin                                       //devuelve codigo de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo from g_articulos where id_articulo=:id_articulo');
    ParambyName('id_articulo').asinteger:=id_articulo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('codigo').asstring
    else result:='ERR';

    Free;
  end;
end;

function tf_main.ruta_escritorio:string;
var
  sEscritorio: String;
  Registro: TRegistry;
begin
  sEscritorio:='';
  Registro := TRegistry.Create;

  // Leemos la ruta del escritorio
  try
    Registro.RootKey := HKEY_CURRENT_USER;

    if Registro.OpenKey( '\Software\Microsoft\Windows\CurrentVersion\explorer\Shell Folders', True ) then
      sEscritorio := Registro.ReadString( 'Desktop' );
  finally
    Registro.CloseKey;
    Registro.Free;
  end;

  result:=sEscritorio;
end;

function Tf_main.SiguienteLaboral(fecha:tdate):TDate;
begin
  fecha:=incday(fecha);
  while ((DayOfWeek(fecha)=1) or (DayOfWeek(fecha)=7)) do fecha:=incday(fecha);
  Result:=fecha;
end;
{$ENDREGION}

{$REGION 'Verif Stock'}
procedure Tf_main.limpiar_stock;
begin
  idx_stock:=0;
  setlength(ar_stock,idx_stock);
end;

procedure Tf_main.get_stock;
begin
  limpiar_stock;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select s.id_articulo,sum(s.cantidad) as uds '+
      'from a_stock s '+
      'inner join g_articulos a on (s.id_articulo=a.id_articulo) '+
      'inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where a.id_cliente=7078 and u.id_almacen=1 and u.id_zona=0 and u.id_ubicacion<>361 '+
      'group by s.id_articulo');
    Open;

    first;
    while not(Eof) do begin
      Inc(idx_stock);
      setlength(ar_stock,idx_stock);

      ar_stock[idx_stock-1].id_art:=FieldByName('id_articulo').asinteger;
      ar_stock[idx_stock-1].uds:=FieldByName('uds').asinteger;

      next;
    end;
  finally
    free;
  end;
end;

function Tf_main.verif_stock(pedido:Integer):boolean;
var    ok,enc:Boolean;    i:integer;
begin
  ok:=true;
  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds '+
      'from c_pedidos_muzybar_lines l '+
      'where l.id_muzybar=:id_muzybar '+
      'group by l.id_articulo');
    parambyname('id_muzybar').AsInteger:=pedido;
    Open;

    first;
    while (not(Eof) and (ok)) do begin
      enc:=False;
      i:=0;
      while (not(enc) and (i<idx_stock)) do begin                                //se encuentra
        if (ar_stock[i].id_art=FieldByName('id_articulo').asinteger) then begin
          if ar_stock[i].uds<FieldByName('uds').asinteger then ok:=false;
          enc:=True;
        end;
        Inc(i);
      end;
      if not(enc) then ok:=false;        //art no encontrado

      next;
    end;
  finally
    free;
  end;

  result:=ok;
end;

function Tf_main.verif_stock_x_art(id_art,uds:Integer):boolean;     //true=si hay stock   false=no hay stock
var   enc:Boolean;    i:integer;
begin
  Result:=true;

  enc:=False;
  i:=0;
  while (not(enc) and (i<idx_stock)) do begin                                //se encuentra
    if (ar_stock[i].id_art=id_art) then begin
      if ar_stock[i].uds<uds then result:=false;
      enc:=True;
    end;
    Inc(i);
  end;
  if not(enc) then result:=false;        //art no encontrado
end;

procedure Tf_main.descuenta_stock(pedido:Integer);
var    enc:Boolean;    i:integer;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds '+
      'from c_pedidos_muzybar_lines l '+
      'where l.id_muzybar=:id_muzybar '+
      'group by l.id_articulo');
    parambyname('id_muzybar').AsInteger:=pedido;
    Open;

    first;
    while not(Eof) do begin
      enc:=False;
      i:=0;
      while (not(enc) and (i<idx_stock)) do begin                                //se encuentra
        if (ar_stock[i].id_art=FieldByName('id_articulo').asinteger) then begin
          ar_stock[i].uds := ar_stock[i].uds - FieldByName('uds').asinteger;
          enc:=True;
        end;
        Inc(i);
      end;

      next;
    end;
  finally
    free;
  end;
end;

procedure Tf_main.informe_sin_stock;
var line:integer;     exist:Boolean;
begin
  exist:=false;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select * '+
      'from c_pedidos_muzybar '+
      'where estado=''X''');
    Open;

    first;
    line:=0;
    xls_1.Clear;
    xls_1.Sheets[0].AsString[0,line]:='PEDIDOS PENDIENTES SIN STOCK '+formatdatetime('dd/mm/yyyy hh:nn',Now);
    inc(line,2);
    while not(Eof) do begin
      exist:=true;
      xls_1.Sheets[0].AsString[0,line]:=fieldbyname('id_order').AsString;
      xls_1.Sheets[0].AsString[2,line]:=fieldbyname('nombre').AsString;
      xls_1.Sheets[0].AsString[3,line]:=fieldbyname('dir_1').AsString;
      xls_1.Sheets[0].AsString[5,line]:=fieldbyname('poblacion').AsString;
      xls_1.Sheets[0].AsString[6,line]:=fieldbyname('provincia').AsString;
      xls_1.Sheets[0].AsString[7,line]:=fieldbyname('cp').AsString;
      xls_1.Sheets[0].AsString[8,line]:=fieldbyname('pais').AsString;
      xls_1.Sheets[0].AsString[10,line]:=fieldbyname('fecha_ped').AsString;
      xls_1.Sheets[0].AsString[11,line]:=fieldbyname('telefono').AsString;
      inc(line);

      dm.ds_1.close;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select * from c_pedidos_muzybar_lines where id_muzybar=:id_muzybar order by id_line');
      dm.ds_1.ParamByName('id_muzybar').AsInteger:=FieldByName('id_muzybar').AsInteger;
      dm.ds_1.Open;

      dm.ds_1.First;
      while not(dm.ds_1.Eof) do begin
        xls_1.Sheets[0].AsString[1,line]:=dm.ds_1.fieldbyname('sku').AsString;
        xls_1.Sheets[0].AsString[2,line]:=dm.ds_1.fieldbyname('nombre_art').AsString;
        xls_1.Sheets[0].AsString[3,line]:=dm.ds_1.fieldbyname('cantidad').AsString;
        if not(verif_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger,dm.ds_1.fieldbyname('cantidad').AsInteger)) then
          xls_1.Sheets[0].Cell[1,line].FillPatternForeColor:=xcred;
        inc(line);

        dm.ds_1.Next;
      end;

      next;
    end;
  finally
    free;
  end;

  if exist then begin
    xls_1.Filename:=IncludeTrailingPathDelimiter(ruta_escritorio)+'MUZYBAR_NO_STOCK_'+formatdatetime('dd_mm_yyyy__hh_nn',Now)+'.xls';
    xls_1.Write;
    sMessageDlg('Fichero Sin Stock Guardado en '+xls_1.Filename,mtWarning,[mbok],0);
  end;            
end;
{$ENDREGION}

{$REGION 'Albaranes'}
procedure Tf_main.genera_albaranes;
var codalbaran,bultos:integer;
begin
  dm.ds_1.close;
  dm.ds_1.SelectSQL.clear;
  dm.ds_1.SelectSQL.Add('select s.fecha_ped,s.id_order,s.id_muzybar,s.nombre,s.dir_1,s.poblacion,s.provincia,s.cp,s.pais,s.id_repartidor,s.repartidor,s.observaciones,s.telefono,s.bultos, s.sociedad, sum(l.cantidad) as uds '+
    'from c_pedidos_muzybar s '+
    'inner join c_pedidos_muzybar_lines l on (s.id_muzybar=l.id_muzybar) '+
    'where estado=''P'' '+
    'group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15');
  dm.ds_1.Open;

  dm.ds_1.First;
  while not(dm.ds_1.Eof) do begin
    bultos:=dm.ds_1.fieldbyname('bultos').Asinteger;
    codalbaran:=GrabaServicio(dm.ds_1.fieldbyname('sociedad').asinteger,7078,dm.ds_1.fieldbyname('id_order').asinteger,dm.ds_1.fieldbyname('id_muzybar').asinteger,
      dm.ds_1.fieldbyname('nombre').AsString,dm.ds_1.fieldbyname('dir_1').AsString,dm.ds_1.fieldbyname('cp').AsString,dm.ds_1.fieldbyname('poblacion').AsString,
      dm.ds_1.fieldbyname('provincia').AsString,dm.ds_1.fieldbyname('telefono').AsString,'',
      dm.ds_1.fieldbyname('repartidor').AsString,
      dm.ds_1.fieldbyname('id_repartidor').asinteger,1,bultos,
      dm.ds_1.fieldbyname('fecha_ped').AsDateTime);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos_muzybar set codalbaran=:codalbaran,bultos=:bultos where id_muzybar=:id_muzybar');
      dm.q_1.ParamByName('codalbaran').AsInteger:=codalbaran;
      dm.q_1.ParamByName('id_muzybar').asinteger:=dm.ds_1.fieldbyname('id_muzybar').asinteger;
      dm.q_1.ParamByName('bultos').AsInteger:=bultos;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_1.Next;
  end;
end;

function Tf_main.GrabaServicio(sociedad,id_cliente,id_order,id_muzybar:integer;
                       dst_nombre,dst_calle,dst_cp,dst_localidad,dst_provincia,dst_telefono,dst_persona:string;
                       observaciones:string;
                       id_repartidor,kgs:integer; var bultos:Integer;
                       fecha:tdate):integer;
var
  codalb,codservicio,codmovimiento,ruta,cod_art:integer;    s,codigo_art:string;
begin
  dm.q_sql.sql.clear;
  dm.q_sql.sql.add('select dbo.getcodalbaran() as codalb');
  dm.q_sql.open;

  codalb:=dm.q_sql.fieldbyname('codalb').AsInteger;

  dm.stpGrabaSrv.parameters.ParamByName('@codservicio').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@tipo_servicio').Value:= 'P';
  dm.stpGrabaSrv.parameters.ParamByName('@codcli').Value:= id_cliente;
  dm.stpGrabaSrv.parameters.ParamByName('@falta').Value:= fecha;
  dm.stpGrabaSrv.parameters.ParamByName('@sureferencia').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@observaciones').Value:=observaciones;
  dm.stpGrabaSrv.parameters.ParamByName('@codcli_paga').Value:=id_cliente;
  dm.stpGrabaSrv.parameters.ParamByName('@e_s_r').Value:='S';
  dm.stpGrabaSrv.parameters.ParamByName('@codremitente').Value:= (id_cliente*1000)+0;
  dm.stpGrabaSrv.parameters.ParamByName('@org_codcli').Value:= id_cliente;

  case sociedad of
    100: begin
            dm.stpGrabaSrv.parameters.ParamByName('@org_coddel').Value:= 0;
            dm.stpGrabaSrv.parameters.ParamByName('@org_nombre').Value:= 'MUZYBAR COMPUTER S.L.';
            dm.stpGrabaSrv.parameters.ParamByName('@org_calle').Value:= 'Poniente, 10';
            dm.stpGrabaSrv.parameters.ParamByName('@org_cp').Value:= 46394;
            dm.stpGrabaSrv.parameters.ParamByName('@org_localidad').Value:= 'Ribarroja Del Turia';
            dm.stpGrabaSrv.parameters.ParamByName('@org_provincia').Value:= 'VALENCIA';
            dm.stpGrabaSrv.parameters.ParamByName('@org_tfno').Value:= '902108957';
    end;
    200: begin
          dm.stpGrabaSrv.parameters.ParamByName('@org_coddel').Value:= 1;
          dm.stpGrabaSrv.parameters.ParamByName('@org_nombre').Value:= 'TCANG EUROPE S.L.';
          dm.stpGrabaSrv.parameters.ParamByName('@org_calle').Value:= 'Antonio Suarez, 48';
          dm.stpGrabaSrv.parameters.ParamByName('@org_cp').Value:= 46021;
          dm.stpGrabaSrv.parameters.ParamByName('@org_localidad').Value:= 'Valencia';
          dm.stpGrabaSrv.parameters.ParamByName('@org_provincia').Value:= 'VALENCIA';
          dm.stpGrabaSrv.parameters.ParamByName('@org_tfno').Value:= '631153862';
    end;
  end;

  dm.stpGrabaSrv.parameters.ParamByName('@org_persona').Value:= '';

  dm.stpGrabaSrv.parameters.ParamByName('@coddestinatario').Value:= (id_cliente*10000)+9999;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_codcli').Value:= id_cliente;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_coddel').Value:= 9999;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_nombre').Value:= dst_nombre;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_calle').Value:= dst_calle;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_cp').Value:= dst_cp;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_localidad').Value:= dst_localidad;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_provincia').Value:= dst_provincia;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_persona').Value:= dst_persona;
  dm.stpGrabaSrv.parameters.ParamByName('@dst_tfno').Value:= dst_telefono;
  dm.stpGrabaSrv.parameters.ParamByName('@codalbaran').Value:= codalb;
  dm.stpGrabaSrv.parameters.ParamByName('@codarticulo').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@refarticulo').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@unidades').Value:= 1;
  dm.stpGrabaSrv.parameters.ParamByName('@sulinea').Value:= id_order;
  dm.stpGrabaSrv.parameters.ParamByName('@kgs').Value:= 1;
  dm.stpGrabaSrv.parameters.ParamByName('@att').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@DATOSVAERSA').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@CIFVAERSA').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@TelVAERSA').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@REEMBOLSO').Value:= null;
  dm.stpGrabaSrv.parameters.ParamByName('@VASEGURADO').Value:= null;
  dm.stpGrabaSrv.ExecProc;

  codservicio:=dm.stpGrabaSrv.Parameters.ParamByName('@codservicio').Value;

  dm.ds_2.close;
  dm.ds_2.SelectSQL.clear;
  dm.ds_2.SelectSQL.Add('select id_articulo,sum(cantidad) as uds '+
    'from c_pedidos_muzybar_lines '+
    'where id_muzybar=:id_muzybar '+
    'group by 1');
  dm.ds_2.ParamByName('id_muzybar').AsInteger:=id_muzybar;
  dm.ds_2.Open;

  dm.ds_2.First;
  while not(dm.ds_2.Eof) do begin
    dm.q_sql.sql.clear;
    dm.q_sql.sql.add('select dbo.getCodMovimiento()');
    dm.q_sql.open;
    codmovimiento:=dm.q_sql.fields[0].asinteger;
    dm.q_sql.Close;
    dm.q_sql.SQL.Clear;
    s:='insert into servicios_lineas (codservicio,codmovimiento,fmovimiento,codarticulo,e_s,codalbaran,unidades,sulinea) '+
    ' values (:codservicio,:codmovimiento,:fmovimiento,:codarticulo,:es,:codalbaran,:unidades,:sulinea) ';
    dm.q_sql.SQL.Add(s);
    dm.q_sql.Parameters.ParamByName('codservicio').value:=codservicio;
    dm.q_sql.Parameters.ParamByName('codmovimiento').value:=codmovimiento;
    dm.q_sql.Parameters.ParamByName('fmovimiento').Value:= date;
    dm.q_sql.Parameters.ParamByName('sulinea').Value:= id_order;

    codigo_art:=busca_art_x_id(dm.ds_2.FieldByName('id_articulo').AsInteger);

    dm.q_sql2.Close;
    dm.q_sql2.SQL.Clear;
    dm.q_sql2.SQL.Add('select codarticulo from articulos where referencia=:ref');
    dm.q_sql2.Parameters.ParamByName('ref').value:=codigo_art;
    dm.q_sql2.Open;
    cod_art:=dm.q_sql2.FieldByName('codarticulo').asinteger;

    dm.q_sql.Parameters.ParamByName('codarticulo').value:=cod_art;
    dm.q_sql.Parameters.ParamByName('es').value:='S';
    dm.q_sql.Parameters.ParamByName('codalbaran').value:=codalb;
    dm.q_sql.Parameters.ParamByName('unidades').value:=dm.ds_2.FieldByName('uds').AsInteger;
    dm.q_sql.ExecSQL;

    dm.ds_2.Next;
  end;
                                                                                        //Albaranes
  dm.qryAlbEdit.open;
  dm.qryAlbEdit.append;
  dm.qryAlbEdit.fieldbyname('codalbaran').asstring:=IntToStr(codalb);
  dm.qryAlbEdit.fieldbyname('serie').asstring := '02';
  dm.qryAlbEdit.fieldbyname('fecha').asdatetime:=SiguienteLaboral(fecha);
  dm.qryAlbEdit.fieldbyname('codcli').asstring:=IntToStr(id_cliente);

  dm.q_sql.sql.clear;
  dm.q_sql.sql.add('select * from dbo.getUnidadesAlbaranxServicio('+inttostr(codservicio)+')');
  dm.q_sql.open;
  bultos:=dm.q_sql.FieldByName('bultos').AsInteger;
  dm.qryAlbEdit.fieldbyname('paquetes').asinteger:=dm.q_sql.FieldByName('paquetes').AsInteger;
  dm.qryAlbEdit.fieldbyname('bultos').asinteger:=bultos;
  dm.qryAlbEdit.fieldbyname('kgs').AsFloat:=dm.q_sql.FieldByName('kgs').AsInteger;
  dm.q_sql.close;

  if id_repartidor<>28 then begin
    dm.qryAlbEdit.fieldbyname('codruta').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('codrepartidor').asinteger:=0;
  end else begin
    dm.q_sql.sql.clear;
    dm.q_sql.sql.add('select dbo.getRutaxServicio('+inttostr(codservicio)+')');
    dm.q_sql.open;
    ruta:=dm.q_sql.fields[0].asinteger;
    dm.qryAlbEdit.fieldbyname('codruta').asinteger:=ruta;
    dm.q_sql.close;

    dm.qryAlbEdit.fieldbyname('codrepartidor').asinteger:=46120;
    dm.q_sql.close;
  end;

  dm.qryAlbEdit.fieldbyname('codremitente').asstring :=IntToStr((id_cliente*1000)+0);
  dm.qryAlbEdit.fieldbyname('org_codcli').asstring :=IntToStr(id_cliente);

  case sociedad of
    100: begin
            dm.qryAlbEdit.fieldbyname('org_coddel').asstring :='0';
            dm.qryAlbEdit.fieldbyname('org_nombre').asstring :='MUZYBAR COMPUTER S.L.';
            dm.qryAlbEdit.fieldbyname('org_calle').asstring :='Poniente, 10';
            dm.qryAlbEdit.fieldbyname('org_cp').asstring :='46394';
            dm.qryAlbEdit.fieldbyname('org_localidad').asstring :='Ribarroja Del Turia';
            dm.qryAlbEdit.fieldbyname('org_provincia').asstring :='VALENCIA';
            dm.qryAlbEdit.fieldbyname('org_tfno').asstring :='902108957';
    end;
    200: begin
          dm.qryAlbEdit.fieldbyname('org_coddel').asstring :='1';
          dm.qryAlbEdit.fieldbyname('org_nombre').asstring := 'TCANG EUROPE S.L.';
          dm.qryAlbEdit.fieldbyname('org_calle').asstring := 'Antonio Suarez, 48';
          dm.qryAlbEdit.fieldbyname('org_cp').asstring :='46021';
          dm.qryAlbEdit.fieldbyname('org_localidad').asstring :='Valencia';
          dm.qryAlbEdit.fieldbyname('org_provincia').asstring :='VALENCIA';
          dm.qryAlbEdit.fieldbyname('org_tfno').asstring :='631153862';
    end;
  end;

  dm.qryAlbEdit.fieldbyname('org_persona').asstring :='';

  dm.qryAlbEdit.fieldbyname('coddestinatario').asstring :=IntToStr(id_Cliente*10000+9999);
  dm.qryAlbEdit.fieldbyname('dst_codcli').asstring :=IntToStr(id_cliente);
  dm.qryAlbEdit.fieldbyname('dst_coddel').asstring :=IntToStr(9999);
  dm.qryAlbEdit.fieldbyname('dst_nombre').asstring :=dst_nombre;
  dm.qryAlbEdit.fieldbyname('dst_calle').asstring :=dst_calle;
  dm.qryAlbEdit.fieldbyname('dst_cp').asstring :=dst_cp;
  dm.qryAlbEdit.fieldbyname('dst_localidad').asstring :=dst_localidad;
  dm.qryAlbEdit.fieldbyname('dst_provincia').asstring :=dst_provincia;
  dm.qryAlbEdit.fieldbyname('dst_persona').asstring :=dst_persona;
  dm.qryAlbEdit.fieldbyname('dst_tfno').asstring :=dst_telefono;
  dm.qryAlbEdit.fieldbyname('observaciones').asstring :=observaciones;
  dm.qryAlbEdit.fieldbyname('asegurado').asinteger:=0;
  dm.qryAlbEdit.fieldbyname('pdebido').asinteger:=0;
  dm.qryAlbEdit.fieldbyname('reembolso').asinteger:=0;
  dm.qryAlbEdit.fieldbyname('km').asinteger:=0;
  dm.qryAlbEdit.fieldbyname('e_s_r').asstring:='S';
  dm.qryAlbEdit.post;

  s:='insert into albaranes_estados '+
      ' (codalbaran,festado,codestado,persona,observaciones,ultimo) '+
      ' values('+ IntToStr(codalb) + ',''' + formatdatetime('dd/mm/yyyy hh:nn:ss',now) + ''',0,null,''Insertado por grabación de albarán'',''S'')';

  dm.db_sql.execute(s);
  dm.db_sql.execute('exec lgAjustaMedidasAlbaran ' + IntToStr(codalb));

  dm.q_sql.SQL.Clear;
  dm.q_sql.sql.Add('declare @r int');
  dm.q_sql.sql.add('exec @r=lgAsignaHoja ');
  dm.q_sql.sql.add(inttostr(codalb));
  dm.q_sql.sql.add('select @r');
  dm.q_sql.Open;

  result:=codalb;
end;
{$ENDREGION}

{$REGION 'Picking'}
procedure Tf_main.genera_picking;
var   pick_cab,id_articulo:integer;   nom_pick:string;  linea:Integer;
begin
  dm.ds_3.Close;                                                           //para cada expedicion
  dm.ds_3.SQLs.SelectSQL.Clear;
  dm.ds_3.SQLs.SelectSQL.Add('SELECT * from c_pedidos_muzybar where estado=''P'' ');
  dm.ds_3.Open;

  dm.ds_3.First;
  while not(dm.ds_3.Eof) do begin
    linea:=1;
    dm.t_write.StartTransaction;
    try
      dm.ds_1.Close;                                                            //id cabecera
      dm.ds_1.SQLs.SelectSQL.Clear;
      dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_pickcab_id,1) FROM RDB$DATABASE');
      dm.ds_1.Open;

      pick_cab:=dm.ds_1.FieldByName('gen_id').AsInteger;

      dm.q_1.Close;                                                                   //genera cabecera
      dm.q_1.SQL.Clear;
      dm.q_1.SQL.Add('insert into a_pickcab (ID_PICKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO,modo) '+
        ' values (:ID_PICKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO,:modo)');
      dm.q_1.ParamByName('id_pickcab').AsInteger:=pick_cab;
      dm.q_1.ParamByName('id_doc').AsInteger:=1;
      dm.q_1.ParamByName('id_cliente').AsInteger:=7078;
      nom_pick:='Pick Muzybar 7078-'+dm.ds_3.FieldByName('id_order').asstring+'-'+formatdatetime('dd/mm/yy',date);
      dm.q_1.ParamByName('nombre').asstring:=nom_pick;
      dm.q_1.ParamByName('fecha').asdate:=date;
      dm.q_1.ParamByName('hora').astime:=time;
      dm.q_1.ParamByName('id_usuario').AsInteger:=1;
      dm.q_1.ParamByName('id_empresa').AsInteger:=1;
      dm.q_1.ParamByName('estado').asstring:='A';
      dm.q_1.ParamByName('modo').AsInteger:=1;
      dm.q_1.ExecQuery;
      dm.t_write.CommitRetaining;

      dm.ds_2.close;                                                 //recoge picking
      dm.ds_2.SelectSQL.clear;
      dm.ds_2.SelectSQL.Add('select l.id_muzybar,l.id_line,l.id_articulo,l.sku,l.nombre_art,l.cantidad '+
        'from c_pedidos_muzybar_lines l '+
        'where id_muzybar=:id_muzybar');
      dm.ds_2.ParamByName('id_muzybar').AsInteger:=dm.ds_3.FieldByName('id_muzybar').asinteger;
      dm.ds_2.Open;

      while not(dm.ds_2.Eof) do begin           //para cada pedido
        id_articulo:=dm.ds_2.FieldByName('id_articulo').asinteger;

        dm.q_1.Close;
        dm.q_1.SQL.Clear;
        dm.q_1.SQL.Add('insert into a_picklin (ID_PICKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,ID_UBICACION,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,SULINEA) '+
          ' values (:ID_PICKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:ID_UBICACION,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:SULINEA)');
        dm.q_1.ParamByName('id_pickcab').AsInteger:=pick_cab;
        dm.q_1.ParamByName('id_agrupa').AsInteger:=0;
        dm.q_1.ParamByName('nivel_agr').AsInteger:=1;

        dm.q_1.ParamByName('linea').AsInteger:=linea;
        Inc(linea);
        dm.q_1.ParamByName('id_ruta').AsInteger:=0;
        dm.q_1.ParamByName('id_articulo').AsInteger:=id_articulo;

        dm.ds_1.Close;                                                            //ubicacion de picking
        dm.ds_1.SQLs.SelectSQL.Clear;
        dm.ds_1.SQLs.SelectSQL.Add('SELECT u.id_ubicacion,u.id_estanteria,u.id_posicion,u.id_altura '+
          ' from a_stock s '+
          '   inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
          ' where s.id_articulo='+inttostr(id_articulo)+' and s.cantidad>0 and u.id_zona=0 and s.id_ubicacion<>361 and s.id_empresa=1 and s.id_almacen=1 '+
          ' order by 4,2,3');
        dm.ds_1.Open;

        dm.q_1.ParamByName('id_ubicacion').AsInteger:=dm.ds_1.FieldByName('id_ubicacion').asinteger;
        dm.q_1.ParamByName('cantidad').AsInteger:=dm.ds_2.FieldByName('cantidad').asinteger;
        dm.q_1.ParamByName('id_empresa').AsInteger:=1;
        dm.q_1.ParamByName('estado').asstring:='A';
        dm.q_1.ParamByName('codalbaran').AsInteger:=dm.ds_2.FieldByName('id_muzybar').asinteger;
        dm.q_1.ParamByName('codmovimiento').AsInteger:=dm.ds_2.FieldByName('id_line').asinteger;
        dm.q_1.ParamByName('sulinea').AsString:='';
        dm.q_1.ExecQuery;

        dm.ds_2.Next;
      end;
      dm.t_write.Commit;
    except
      dm.t_write.Rollback;
    end;

    dm.ds_3.Next;
  end;
end;
{$ENDREGION}

{$REGION 'Send Files'}
procedure Tf_main.bt_sendClick(Sender: TObject);
var n:integer;
begin
  n:=0;
  dm.ds_3.Close;                                                           //para cada expedicion
  dm.ds_3.SQLs.SelectSQL.Clear;
  dm.ds_3.SQLs.SelectSQL.Add('SELECT * from c_pedidos_muzybar where estado=''G'' ');
  dm.ds_3.Open;

  dm.ds_3.First;
  while not(dm.ds_3.Eof) do begin
    send_file(dm.ds_3.FieldByName('id_muzybar').asinteger);
    dm.ds_3.Next;
    inc(n);
  end;

  lb_st1.Caption:='Finalizado, '+inttostr(n)+' Expediciones Enviadas';
  application.ProcessMessages;
  filter;
  sMessageDlg('Finalizado, '+inttostr(n)+' Expediciones Enviadas',mtInformation,[mbok],0);
end;

procedure Tf_main.send_file(id_muzybar:integer);
var   exp_xml:IXMLDocumento;         xml_path:string;          i,line,id_order:integer;
begin
  dm.ds_2.Close;
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('SELECT * from c_pedidos_muzybar where id_muzybar=:id_muzybar ');
  dm.ds_2.ParamByName('id_muzybar').AsInteger:=id_muzybar;
  dm.ds_2.Open;

  xml_path:=dm.ds_2.FieldByName('xml_path').asstring;
  xml_1.FileName:=xml_path;
  xml_1.Active:=true;
  exp_xml:=GetDocumento(xml_1);

  {if dm.ds_2.FieldByName('tracking_number').asstring='' then exp_xml.InfGeneral.InfAlb.Tracking:=dm.ds_2.FieldByName('codalbaran').asstring
  else exp_xml.InfGeneral.InfAlb.Tracking:=dm.ds_2.FieldByName('tracking_number').asstring;       }

  exp_xml.InfGeneral.InfAlb.Tracking:=dm.ds_2.FieldByName('codalbaran').asstring;

  dm.ds_1.Close;
  dm.ds_1.SQLs.SelectSQL.Clear;
  dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos_muzybar_lines where id_muzybar=:id_muzybar order by id_line');
  dm.ds_1.ParamByName('id_muzybar').AsInteger:=id_muzybar;
  dm.ds_1.Open;

  dm.ds_1.First;
  while not(dm.ds_1.Eof) do begin
    line:=-1;
    for i:=0 to exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb-1 do begin
      if exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[i].IdLin=dm.ds_1.FieldByName('id_line').asinteger then begin
        line:=i;
        Break;
      end;
    end;

    if line<>-1 then exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[line].NSerie:=RightStr(dm.ds_1.FieldByName('n_serie').asstring,15);  //longitud máxima del nserie para muzybar

    dm.ds_1.Next;
  end;

  id_order:=dm.ds_2.fieldbyname('id_order').asinteger;

  xml_path:='\\seth\sysfiles\Importacion\Muzybar\Out\Alb_'+inttostr(id_order)+'.xml';
  xml_1.SaveToFile(xml_path);

  ftp_1.connect;
  try
    ftp_1.ChangeDir('/sync/muzybar/out/'+dm.ds_2.FieldByName('sociedad').AsString);
    ftp_1.Put(xml_path,'Alb_'+inttostr(id_order)+'.xml');
  finally
    ftp_1.Disconnect;
  end;

  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos_muzybar set estado=''E'',fecha_env=:fecha where id_muzybar=:id_muzybar');
    dm.q_1.ParamByName('id_muzybar').AsInteger:=id_muzybar;
    dm.q_1.ParamByName('fecha').AsDateTime:=now;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end;
end;
{$ENDREGION}

{$REGION 'Bultos'}
procedure Tf_main.imprime_bultos;
var tracking,prim_codbulto,ult_codbulto:string;
begin
  dm.ds_1.close;                                                 //recoge pedidos de asm
  dm.ds_1.SelectSQL.clear;
  dm.ds_1.SelectSQL.Add('select * '+
    'from c_pedidos_muzybar '+
    'where estado=''P'' and id_repartidor=28 and not cp between 7000 and 7999');
    //'where estado=''E'' and id_repartidor=28 and not cp between 7000 and 7999 and cast(fecha_imp as date)=''23.10.2015'' ');
  dm.ds_1.Open;

  dm.ds_1.First;
  while not(dm.ds_1.Eof) do begin
    tracking:=imprime_eti_bulto_asm(dm.ds_1.FieldByName('codalbaran').AsInteger);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos_muzybar set tracking_number=:tracking where id_muzybar=:id_muzybar');
      dm.q_1.ParamByName('tracking').asstring:=tracking;
      dm.q_1.ParamByName('id_muzybar').asinteger:=dm.ds_1.fieldbyname('id_muzybar').AsInteger;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_1.Next;
  end;


  dm.ds_1.close;                                                 //recoge pedidos de chrono
  dm.ds_1.SelectSQL.clear;
  dm.ds_1.SelectSQL.Add('select * '+
    'from c_pedidos_muzybar '+
    'where estado=''P'' and id_repartidor=28 and cp between 7000 and 7999');
    //'where estado=''E'' and id_repartidor=28 and cp between 7000 and 7999 and cast(fecha_imp as date)=''23.10.2015'' ');
  dm.ds_1.Open;

  dm.ds_1.First;
  while not(dm.ds_1.Eof) do begin
    imprime_eti_bulto_chrono(dm.ds_1.FieldByName('codalbaran').AsInteger,prim_codbulto,ult_codbulto);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos_muzybar set tracking_number=:tracking,CHRONO_BULTO_1=:CHRONO_BULTO_1,CHRONO_BULTO_ULT=:CHRONO_BULTO_ULT where id_muzybar=:id_muzybar');
      dm.q_1.ParamByName('tracking').asstring:=prim_codbulto;
      dm.q_1.ParamByName('CHRONO_BULTO_1').asstring:=prim_codbulto;
      dm.q_1.ParamByName('CHRONO_BULTO_ULT').asstring:=ult_codbulto;
      dm.q_1.ParamByName('id_muzybar').asinteger:=dm.ds_1.fieldbyname('id_muzybar').AsInteger;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_1.Next;
  end;
end;

function Tf_main.imprime_eti_bulto_asm(codalbaran:integer):string;
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel,bulto,s1,s2,dc:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;    asm_correo,asm_horario,asm_codcli,bc:string;
      fichero: TextFile;
begin
  dm.q_sql2.Close;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value:=codalbaran;
  dm.q_sql2.Open;

  codrepartidor:=dm.q_sql2.FieldByName('codrepartidor').AsInteger;
  poblacion:=dm.q_sql2.FieldByName('dst_localidad').AsString;
  codigopostal:=Trim(dm.q_sql2.FieldByName('dst_cp').AsString);
  dst_coddel:=dm.q_sql2.FieldByName('dst_coddel').asinteger;
// obtengo delegacion para ASM
//
  dm.qrytemp.Close;
  dm.qrytemp.SQL.Clear;
  dm.qrytemp.SQL.Add('select top 1 d.id_del as id_del,d.nombre as nombre '+                    //qrym
  ' from asm_deleg d '+
  ' inner join asm_cp c on ((d.id_del = c.id_del) and (d.id_subdel=c.id_subdel)) '+
  ' where c.cp = '+codigopostal+' and c.pais = 34');
  dm.qrytemp.Open;
//
// obtengo tipo de envio para ASM
//
  //asm_codcli:='7078';
  asm_codcli:='17078'; //01-03-2018
  asm_correo:='COURIER';
  asm_horario:='ASM24';

  dm.cds_bultos.Close;
  dm.cds_bultos.Active:=true;
  dm.cds_bultos.EmptyDataSet;

  for bulto:=1 to dm.q_sql2.FieldByName('bultos').asinteger do begin      //etiqueta para cada bulto
    dm.cds_bultos.Insert;

    dm.cds_bultos.FieldByName('id_caja').AsInteger:=0;
    dm.cds_bultos.FieldByName('tipo_caja').asstring:='';
    dm.cds_bultos.FieldByName('codcli').AsInteger:=dm.q_sql2.FieldByName('codcli').AsInteger;
    dm.cds_bultos.FieldByName('codalbaran').AsInteger:=codalbaran;
    dm.cds_bultos.FieldByName('unidades').AsInteger:=dm.q_sql2.FieldByName('paquetes').AsInteger;;
    dm.cds_bultos.FieldByName('fecha').AsDateTime:=dm.q_sql2.FieldByName('fecha').AsDateTime;
    dm.cds_bultos.FieldByName('codruta').AsInteger:=dm.q_sql2.FieldByName('codruta').AsInteger;
    dm.cds_bultos.FieldByName('coddst').AsString:=FormatFloat('0000',dm.q_sql2.FieldByName('dst_codcli').AsInteger)+formatfloat('0000',dm.q_sql2.FieldByName('dst_coddel').AsInteger);
    dm.cds_bultos.fieldbyname('dst_nombre').asstring:=dm.q_sql2.fieldbyname('dst_nombre').asstring;
    dm.cds_bultos.fieldbyname('dst_calle').asstring:=dm.q_sql2.fieldbyname('dst_calle').asstring;
    dm.cds_bultos.fieldbyname('dst_cp').asstring:=FormatFloat('00000',StrToInt(codigopostal));
    dm.cds_bultos.fieldbyname('dst_localidad').asstring:=dm.q_sql2.fieldbyname('dst_localidad').asstring;
    dm.cds_bultos.fieldbyname('dst_provincia').asstring:=dm.q_sql2.fieldbyname('dst_provincia').asstring;
    dm.cds_bultos.FieldByName('bultos').AsInteger:=dm.q_sql2.fieldbyname('bultos').asinteger;;
    dm.cds_bultos.FieldByName('observaciones').AsString:=dm.q_sql2.fieldbyname('observaciones').AsString;
    dm.cds_bultos.FieldByName('dst_tfno').AsString:=dm.q_sql2.FieldByName('dst_tfno').AsString;
    dm.cds_bultos.FieldByName('dst_coddel').AsString:=dm.q_sql2.FieldByName('dst_coddel').AsString;
    dm.cds_bultos.FieldByName('dst_persona').AsString:=dm.q_sql2.FieldByName('dst_persona').AsString;
    dm.cds_bultos.FieldByName('ordenbulto').asinteger:=bulto;
    dm.cds_bultos.FieldByName('codrepartidor').AsInteger:=codrepartidor;
    dm.cds_bultos.fieldbyname('org_nombre').asstring:= dm.q_sql2.fieldbyname('org_nombre').asstring;
    dm.cds_bultos.fieldbyname('org_calle').asstring:= dm.q_sql2.fieldbyname('org_calle').asstring;
    dm.cds_bultos.fieldbyname('org_cp').asstring:= dm.q_sql2.fieldbyname('org_cp').asstring;
    dm.cds_bultos.fieldbyname('org_localidad').asstring:= dm.q_sql2.fieldbyname('org_localidad').asstring;
    dm.cds_bultos.fieldbyname('org_provincia').asstring:= dm.q_sql2.fieldbyname('org_provincia').asstring;
    dm.cds_bultos.FieldByName('org_tfno').AsString:= dm.q_sql2.FieldByName('org_tfno').AsString;
    dm.cds_bultos.FieldByName('reembolso').AsString:= dm.q_sql2.FieldByName('reembolso').AsString;
    dm.cds_bultos.FieldByName('referencia').AsString:= '';
    dm.cds_bultos.FieldByName('kgs').AsString:=dm.q_sql2.FieldByName('Kgs').AsString;
    if dm.q_sql2.FieldByName('pdebido').AsFloat <= 0 then
       dm.cds_bultos.FieldByName('sempor').AsString:='PAGADOS' else dm.cds_bultos.FieldByName('sempor').AsString:='DEBIDOS';

    dm.cds_bultos.FieldByName('asm_correo').AsString:= asm_correo;
    dm.cds_bultos.FieldByName('asm_horario').AsString:= asm_horario;
    dm.cds_bultos.FieldByName('asm_codcli').AsString:= asm_codcli;
    dm.cds_bultos.FieldByName('asm_mnemo').AsString:= dm.qrytemp.FieldByName('id_del').AsString;
    dm.cds_bultos.FieldByName('asm_pobla').AsString:= dm.qrytemp.FieldByName('nombre').AsString;
    dm.cds_bultos.FieldByName('asm_bc_human').AsString:='31-' + cli_inf_asm + '-'+formatfloat('0000000',codalbaran);
    dm.cds_bultos.FieldByName('asm_tracking').AsString:='31' + cli_inf_asm + formatfloat('0000000',codalbaran);
    bc:='31' + cli_inf_asm + formatfloat('0000000',codalbaran)+formatfloat('000',bulto);
    s1:=strtoint(bc[1])+strtoint(bc[3])+strtoint(bc[5])+strtoint(bc[7])+strtoint(bc[9])+strtoint(bc[11])+strtoint(bc[13])+strtoint(bc[15])+strtoint(bc[17]);
    s2:=strtoint(bc[2])+strtoint(bc[4])+strtoint(bc[6])+strtoint(bc[8])+strtoint(bc[10])+strtoint(bc[12])+strtoint(bc[14])+strtoint(bc[16]);
    s1:=s1*3;
    s1:=s1+s2;
    dc:=0;
    while ((s1+dc) mod 10)<>0 do inc(dc);
    dm.cds_bultos.FieldByName('asm_bc').AsString:=bc+formatfloat('0',dc);

    dm.cds_bultos.FieldByName('codbulto').AsString:='';

    pdf417:=
        limpiachar(FormatDateTime('dd-mm-aaaa',dm.cds_bultos.FieldByName('fecha').AsDateTime)) + cr +
        limpiachar(dm.cds_bultos.FieldByName('codcli').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_nombre').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_calle').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_cp').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_localidad').asstring) + cr +
        limpiachar(dm.cds_bultos.FieldByName('org_tfno').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_nombre').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_calle').asstring) + cr +
        limpiachar(codigopostal) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_localidad').asstring) + cr +
        limpiachar(dm.cds_bultos.FieldByName('dst_tfno').AsString) + cr +
        limpiachar(dm.cds_bultos.FieldByName('dst_persona').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('codalbaran').Asstring) + cr +
        limpiachar(dm.cds_bultos.FieldByName('dst_coddel').AsString) + cr +
        limpiachar(dm.cds_bultos.FieldByName('kgs').AsString) + cr +
        dm.cds_bultos.FieldByName('ordenbulto').AsString + cr +
        dm.cds_bultos.FieldByName('bultos').AsString;

    dm.cds_bultos.FieldByName('pdf417').AsString:=pdf417;

    dm.cds_bultos.Post;
  end;

  rep_asm.PrintOptions.Printer:=imp_eti;
  if rep_asm.PrepareReport(True) then rep_asm.print;

  result:=dm.cds_bultos.FieldByName('asm_tracking').AsString;
end;

procedure Tf_main.imprime_eti_bulto_chrono(codalbaran:integer; var prim_ch_codbulto,ult_ch_codbulto:string);
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel,bulto,s1,s2,dc:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s,pdebido:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;    asm_correo,asm_horario,asm_codcli,bc:string;
      fichero: TextFile;
begin
  dm.q_sql2.Close;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value:=codalbaran;
  dm.q_sql2.Open;

  codrepartidor:=dm.q_sql2.FieldByName('codrepartidor').AsInteger;
  poblacion:=dm.q_sql2.FieldByName('dst_localidad').AsString;
  codigopostal:=Trim(dm.q_sql2.FieldByName('dst_cp').AsString);
  dst_coddel:=dm.q_sql2.FieldByName('dst_coddel').asinteger;

  producto_chrono:='MARITIMO';

  prim_ch_codbulto:='';

  if dm.q_sql2.FieldByName('pdebido').AsFloat <= 0 then
    pdebido:='PAGADOS' else pdebido:='DEBIDOS';

  dm.cds_bultos.Close;
  dm.cds_bultos.Active:=true;
  dm.cds_bultos.EmptyDataSet;

  for bulto:=1 to dm.q_sql2.FieldByName('bultos').asinteger do begin      //etiqueta para cada bulto
    ch_codbulto:=get_chrono_bulto(dm.q_sql2.FieldByName('DST_CP').AsInteger);
    if bulto=1 then prim_ch_codbulto:=ch_codbulto;

    pdf417:=
      FormatDateTime('dd-mm-aaaa',dm.q_sql2.fieldbyname('fecha').AsDateTime) + cr +
      dm.q_sql2.FieldByName('codcli').AsString + cr +
      dm.q_sql2.fieldbyname('org_nombre').asstring + cr +
      dm.q_sql2.fieldbyname('org_calle').asstring + cr +
      dm.q_sql2.fieldbyname('org_cp').asstring + cr +
      dm.q_sql2.fieldbyname('org_localidad').asstring + cr +
      dm.q_sql2.FieldByName('org_tfno').AsString + cr +
      dm.q_sql2.fieldbyname('dst_nombre').asstring + cr +
      dm.q_sql2.fieldbyname('dst_calle').asstring + cr +
      dm.q_sql2.fieldbyname('dst_cp').asstring + cr +
      dm.q_sql2.fieldbyname('dst_localidad').asstring + cr +
      dm.q_sql2.FieldByName('dst_tfno').AsString + cr +
      dm.q_sql2.fieldByName('dst_persona').AsString + cr +
      dm.q_sql2.fieldbyname('codalbaran').Asstring + cr +
      ch_codbulto + cr +
      dm.q_sql2.FieldByName('dst_coddel').AsString + cr +
      '46' + cr +// keytsy
      IntToStr(codalbaran)+ cr +
      dm.q_sql2.FieldByName('Kgs').AsString + cr +
      inttostr(bulto) + cr +
      dm.q_sql2.FieldByName('bultos').AsString+ cr +
      'Pagados'+ cr +
      dm.q_sql2.FieldByName('reembolso').AsString + cr +
      dm.q_sql2.FieldByName('observaciones').AsString;

    lf:=chr(10);             //line feed
    s:='';
    s:=s+'N'+lf;
    s:=s+'OD'+lf;
    s:=s+'q816'+lf;
    s:=s+'Q?'+lf;
    s:=s+'S6'+lf;
    s:=s+'D13'+lf;
    s:=s+'ZT'+lf;
    s:=s+'A460,1155,3,1,2,2,N,"COD.BULTO:'+ch_codbulto+'"'+lf;
    s:=s+'B770,410,1,1,4,2,256,N,"'+ch_codbulto+'"'+lf;
    s:=s+'A30,1155,3,1,2,1,N," LOGINSER '+dm.q_sql2.fieldbyname('org_nombre').asstring+'"'+lf;
    s:=s+'A60,1155,3,1,1,1,N,"'+dm.q_sql2.fieldbyname('org_calle').asstring+'"'+lf;
    s:=s+'A80,1155,3,1,1,1,N,"'+dm.q_sql2.fieldbyname('org_localidad').asstring+'"'+lf;
    s:=s+'A80,830,3,1,1,1,N,"Telf.:'+dm.q_sql2.FieldByName('org_tfno').AsString+'"'+lf;
    s:=s+'LO95,650,4,500'+lf;
    s:=s+'A120,1155,3,3,2,3,N,"DESTINATARIO"'+lf;
    s:=s+'A160,1155,3,1,2,1,N,"'+dm.q_sql2.fieldbyname('dst_nombre').asstring+'"'+lf;
    s:=s+'A200,1155,3,1,1,1,N,"ATT: '+dm.q_sql2.FieldByName('dst_persona').AsString+'"'+lf;
    s:=s+'A220,1155,3,1,1,1,N,"TELF.: '+dm.q_sql2.FieldByName('dst_tfno').AsString+'"'+lf;
    s:=s+'A240,1155,3,2,2,1,N,"'+dm.q_sql2.fieldbyname('dst_calle').asstring+'"'+lf;
    s:=s+'A280,1155,3,3,3,6,N,"'+dm.q_sql2.fieldbyname('dst_cp').asstring+'"'+lf;

    s:=s+'A400,1155,3,1,2,1,N,"'+dm.q_sql2.fieldbyname('dst_localidad').asstring+'"'+lf;
    s:=s+'A440,1155,3,1,1,2,N,"REF: '+IntToStr(codalbaran)+'"'+lf;
    s:=s+'A340,1155,3,3,2,3,N,"'+dm.q_sql2.FieldByName('dst_coddel').AsString+'"'+lf;
   // s:=s+'A340,1155,3,3,2,3,N,"<<PAIS>>"'+lf;
    s:=s+'LO430,590,4,600'+lf;
    s:=s+'A350,500,3,1,1,1,N,"OBSERVACIONES:"'+lf;
    s:=s+'A380,500,3,1,1,1,N,"'+dm.q_sql2.FieldByName('observaciones').AsString+'"'+lf;
  //  writeln(f,'A410,500,3,1,1,1,N,"<<OBSER2>>"'+lf;

    s:=s+'A50,550,3,1,2,2,N,"EXP:'+IntToStr(codalbaran)+'"'+lf;
    s:=s+'A700,360,3,1,1,1,N,"PESO:"'+lf;
    s:=s+'A730,360,3,1,1,2,N,"'+formatfloat('0.000',dm.q_sql2.FieldByName('kgs').asfloat)+' Kgs."'+lf;
    s:=s+'A640,360,3,1,1,1,N,"BULTOS:"'+lf;
    s:=s+'A670,360,3,1,2,2,N,"'+inttostr(bulto)+' de '+dm.q_sql2.FieldByName('bultos').Asstring+'"'+lf;
    s:=s+'A460,360,3,1,1,1,N,"PRODUCTO: "'+lf;
    s:=s+'A490,360,3,1,1,2,N,"'+producto_chrono+'"'+lf;
    s:=s+'A520,360,3,1,1,1,N,"REEMBOLSO:"'+lf;
    s:=s+'A550,360,3,1,1,2,N,"'+dm.q_sql2.FieldByName('reembolso').AsString+'"'+lf;
    s:=s+'A580,360,3,1,1,1,N,"TIPO DE PORTES:"'+lf;
    s:=s+'A610,360,3,1,2,2,N,"'+pdebido+'"'+lf;
    s:=s+'A80,520,3,1,1,1,N,"Envio retorno: "'+lf;
    s:=s+'A760,360,3,3,1,1,N,"FECHA:'+formatdatetime('dd/mm/yyyy',dm.q_sql2.FieldByName('fecha').AsDateTime)+'"'+lf;
    s:=s+'A250,41,0,3,2,2,N,"'+producto_chrono+'"'+lf;
    s:=s+'b100,600,P,800,600,s5,f0,x2,y7,l9,t0,o3,"'+pdf417+'"'+lf;
    s:=s+'P1'+lf;
    s:=s+'N'+lf;

    WriteRawDataToPrinter(imp_eti,s);
  end;

  ult_ch_codbulto:=ch_codbulto;
end;

function Tf_main.get_chrono_bulto(cp:integer):string;
var  producto_chrono,cliente_chrono,ch_codbulto:string;    producto_chrono_id,ch_numbulto:integer;
begin
  producto_chrono:='MARITIMO';
  producto_chrono_id:=34;
  cliente_chrono:='400040001';

  with tpfibdataset.create(dm) do                                     //numero de expedicion de ChronoExpress
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select chrono_bulto '+
      'from c_aux '+
      'where id_empresa=1');
    open;

    if not(isempty) then begin
      ch_numbulto:=fieldbyname('chrono_bulto').asinteger;

      dm.q_1.close;
      dm.q_1.sql.clear;
      dm.q_1.SQL.Add('update c_aux set chrono_bulto=chrono_bulto+1 where id_empresa=1');

      dm.t_write.StartTransaction;
      dm.q_1.ExecQuery;
      dm.t_write.CommitRetaining;

    end else ch_numbulto:=1;
  finally
    free;
  end;

  ch_codbulto:=inttostr(producto_chrono_id)+'0720'+FormatFloat('000000000',ch_numbulto)+formatfloat('00',1)+formatfloat('00000',cp);
  ch_codbulto:=ch_codbulto+inttostr(calc_digcon_chrono(ch_codbulto));

  result:=ch_codbulto;
end;

Function Tf_main.calc_digcon_chrono(codbar:string):Integer;
var
  n,l,suma:Integer;
begin
  suma:=0;
  for n := 1 to 22 do begin
     l:=StrToInt(Copy(codbar,n,1));
     if n/2 = Int(n/2) then
       suma:=suma+(l*3)
     else
       suma:=suma+l;
  end;
  codbar:=IntToStr(suma);
  codbar:=Copy(codbar,length(codbar),1);
  result:=10-strtoint(codbar);
  if Result=10 then Result:=0;

end;

function Tf_main.limpiachar(frase: string):string;
var  s:string; i:integer;
begin
  s:='';
  for i:=1 to Length(frase) do
    if (((ord(frase[i])>=40) and (ord(frase[i])<=57)) or
        ((ord(frase[i])>=65) and (ord(frase[i])<=90)) or
        ((ord(frase[i])>=97) and (ord(frase[i])<=122))) then s:=s+frase[i]
    else s:=s+' ';
  result:=s;
end;

function Tf_main.WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
var
  PrinterHandle: THandle;
  DocInfo: TDocInfo1;
  i: Integer;
  B: Byte;
  Escritos: DWORD;
begin
  Result:= FALSE;
  if OpenPrinter(PChar(PrinterName), PrinterHandle, nil) then
  try
    FillChar(DocInfo,Sizeof(DocInfo),#0);
    with DocInfo do
    begin
      pDocName:= PChar('Printer Test');
      pOutputFile:= nil;
      pDataType:= 'RAW';
    end;
    if StartDocPrinter(PrinterHandle, 1, @DocInfo) <> 0 then
    try
      if StartPagePrinter(PrinterHandle) then
      try
        while Length(Str) > 0 do
        begin
          if Copy(Str, 1, 1) = '\' then
          begin
            if Uppercase(Copy(Str, 2, 1)) = 'X' then
              Str[2]:= '$';
            if not TryStrToInt(Copy(Str, 2, 3),i) then
              Exit;
            B:= Byte(i);
            Delete(Str, 1, 3);
          end else B:= Byte(Str[1]);
          Delete(Str,1,1);
          WritePrinter(PrinterHandle, @B, 1, Escritos);
        end;
        Result:= TRUE;
      finally
        EndPagePrinter(PrinterHandle);
      end;
    finally
      EndDocPrinter(PrinterHandle);
    end;
  finally
    ClosePrinter(PrinterHandle);
  end;
end;
{$ENDREGION}

{$REGION 'Send Files Agencias'}
procedure Tf_main.sBitBtn1Click(Sender: TObject);
begin
  lb_st1.Caption:='Enviando....';
  application.ProcessMessages;
  envia_ficheros(true);                   //todos los del día

  lb_st1.Caption:='Finalizado';
  sMessageDlg('Finalizado',mtInformation,[mbok],0);
end;

procedure Tf_main.sButton1Click(Sender: TObject);
begin
  //imprime_bultos;
  //envia_ficheros;
end;

procedure Tf_main.envia_ficheros(todos:Boolean=false);
var ruta:string;         email:Tf_envia_mail;      cuerpo:tstrings;      n:integer;
begin
  u_gen_gl.lee_inis_def;      //lee defs de tablas aux
  u_cam_gl.lee_inis_def;

  n:=0;
                                                                                //Envia fichero ASM
  ruta:=u_gen_gl.sys_path+u_cam_gl.asm_exp_path+'ASM_LGS_'+formatdatetime('yymmdd',Date)+'_'+formatdatetime('hhnnss',time)+'.txt';
  n:=genera_fichero_asm(ruta,todos);

  //CopyFile(PChar(ruta),PChar(IncludeTrailingPathDelimiter(de_folder.text)+extractfilename(ruta)),False);

  if n>0 then begin
    cuerpo:=tstringlist.Create;
    cuerpo.Add('Se Adjunta Archivo de Expediciones de Loginser');

    email:=Tf_envia_mail.create(self);
    email.Show;
    email.envia_email(u_cam_gl.asm_exp_email,'','Fichero Loginser-Muzybar '+formatdatetime('yymmdd',Date)+'_'+formatdatetime('hhnnss',time),
      ruta,cuerpo);
    cuerpo.Free;
    email.close;
    email.Free;
  end;

  n:=0;

  ruta:=u_gen_gl.sys_path+u_cam_gl.chrono_exp_path+get_nombrefichero_chrono(date);
  n:=genera_fichero_chrono(ruta,todos);

  if n>0 then begin
    cuerpo:=tstringlist.Create;
    cuerpo.Add('Se Adjunta Archivo de Expediciones de Loginser');

    email:=Tf_envia_mail.create(Self);
    email.Show;
    email.envia_email(u_cam_gl.chrono_exp_email,'','Fichero Loginser-Muzybar '+formatdatetime('yymmdd',Date)+'_'+formatdatetime('hhnnss',time),
      ruta,cuerpo);
    cuerpo.Free;
    email.close;
    email.Free;
  end;
end;

function Tf_main.genera_fichero_asm(ruta:string; todos:boolean):integer;
var   f:textfile;    linea:string;   n:integer;
begin
  n:=0;

  dm.ds_1.close;                                                 //recoge pedidos de asm
  dm.ds_1.SelectSQL.clear;
  if todos then begin
    dm.ds_1.SelectSQL.Add('select * '+
      'from c_pedidos_muzybar '+
      'where estado in (''G'',''E'') and id_repartidor=28 and not cp between 7000 and 7999 and cast(fecha_gen as date)=:fecha ');
    dm.ds_1.parambyname('fecha').AsDatetime:=de_1.Date;
  end else begin
    dm.ds_1.SelectSQL.Add('select * '+
      'from c_pedidos_muzybar '+
    'where estado=''P'' and id_repartidor=28 and not cp between 7000 and 7999');
    //'where estado=''E'' and id_repartidor=28 and not cp between 7000 and 7999 and cast(fecha_imp as date)=''23.10.2015'' ');
  end;
  dm.ds_1.Open;

  if not(dm.ds_1.isempty) then begin
    try
      AssignFile(f,ruta);
      Rewrite(f);

      dm.ds_1.First;
      while not(dm.ds_1.Eof) do begin
        linea:=linea_asm(dm.ds_1.FieldByName('codalbaran').asinteger);
        Writeln(f,linea);
        dm.ds_1.Next;
        Inc(n);
      end;
    finally
      closefile(f);
    end;
  end;

  result:=n;
end;

function Tf_main.linea_asm(codalbaran:Integer):string;                   //Genera Linea para ASM
var   s,su_linea,tmp:string;  dst_pais,dst_cp,asm_codcli,asm_servicio,asm_horario:integer;
begin
  s:='';

  //asm_codcli:=7078;
  asm_codcli:=17078;  //01-03-18
  asm_servicio:=1;
  asm_horario:=3;

  with tadoquery.create(self) do                                      //Su Linea
  try
    connection:= dm.db_sql;
    sql.Add('select sulinea '+
		  'from servicios_lineas '+
		  'where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value:=codalbaran;
    Open;

    if not(IsEmpty) then su_linea:=FieldByName('sulinea').asstring
      else su_linea:='';
  finally
    free;
  end;

  with tadoquery.create(self) do                         //Genera Linea
  try
    connection:= dm.db_sql;
    sql.Add('select * from albaranes where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value:=codalbaran;
    Open;

    if not(IsEmpty) then begin
      dst_pais:=34;
      if Trim(FieldByName('dst_cp').asstring)='' then begin
        tmp:=get_cp_ext(FieldByName('dst_localidad').asstring);
        if Trim(tmp)='' then dst_cp:=0
          else dst_cp:=strtoint(Trim(tmp));
        dst_pais:=351;
      end else dst_cp:=StrToInt(trim(FieldByName('dst_cp').asstring));

      s:='1|'+                                                                  //Tipo
         '31'+ cli_inf_asm + formatfloat('0000000',codalbaran)+'|'+                       //Cod Barras
         '461|'+                                                                //Cod Plaza Origen
         FormatFloat('000000',codalbaran)+'|'+                                  //Albaran
         Copy(FieldByName('org_nombre').AsString,1,40)+'|'+                     //Org Nombre
         Copy(FieldByName('org_calle').AsString,1,40)+'|'+                      //Org Calle
         Copy(FieldByName('org_localidad').AsString,1,40)+'|'+                  //Org Localidad
         Copy(FieldByName('org_provincia').AsString,1,40)+'|'+                  //Org Provincia
         '34|'+                                                                 //Org Pais
         FormatFloat('00000',FieldByName('org_cp').asinteger)+'|'+              //Org CP
         Copy(FieldByName('org_tfno').AsString,1,10)+'|'+                       //Org Telefono
         Copy(FieldByName('org_coddel').AsString,1,4)+'|'+                      //Org Dpto
         '|'+                                                                   //Org NIF
         '|'+                                                                   //Org Observaciones
         FormatDateTime('dd/mm/yyyy',date)+'|'+                                 //Fecha
         '461|'+                                                                //PlzCli
         formatfloat('000000',asm_codcli)+'|'+                                  //CodCli
         'P|'+                                                                  //Portes
         '0,00|'+                                                               //Deb
         '0,00|'+                                                               //Reem
         Copy(FieldByName('dst_nombre').AsString,1,40)+'|'+                     //Dst Nombre
         Copy(FieldByName('dst_calle').AsString,1,40)+'|'+                      //Dst Direc
         Copy(FieldByName('dst_localidad').AsString,1,40)+'|'+                  //Dst Poblac
         Copy(FieldByName('dst_provincia').AsString,1,40)+'|'+                  //Dst Provin
         '34|'+                                                                 //Dst Pais
         FormatFloat('00000',dst_cp)+'|'+                                       //Dst CP
         Copy(FieldByName('dst_tfno').AsString,1,10)+'|'+                       //Dst Telefono
         '|'+                                                                   //Dst Dpto
         '|'+                                                                   //Dst NIF
         Copy(su_linea+'-'+FieldByName('observaciones').AsString,1,100)+'|'+    //Dst Observaciones
         IntToStr(asm_servicio)+'|'+                                            //Servicio
         IntToStr(asm_horario)+'|'+                                             //Horario
         FormatFloat('0000',FieldByName('bultos').asinteger)+'|'+               //Bultos
         FormatFloat('0.000',FieldByName('kgs').asfloat)+'|'+                   //Kgs
         '0.0000|'+                                                             //m3
         '0|'+                                                                  //CodValija
         '5315||N||||||||||||N|||'+                                             //Agente y varios....
         '31'+ cli_inf_asm + formatfloat('0000000',codalbaran)+'||0|0|||||||';            //Cod Barras Agrupacion y varios...
    end else s:='ERROR LEYENDO ALBARAN '+inttostr(codalbaran);
  finally
    free;
  end;

  result:=s;
end;

function Tf_main.genera_fichero_chrono(ruta:string; todos:boolean):integer;
var   f:textfile;    linea:string;    n:Integer;
begin
  n:=0;

  dm.ds_1.close;                                                 //recoge pedidos de asm
  dm.ds_1.SelectSQL.clear;
  if todos then begin
    dm.ds_1.SelectSQL.Add('select * '+
      'from c_pedidos_muzybar '+
      'where estado in (''G'',''E'') and id_repartidor=28 and cp between 7000 and 7999 and cast(fecha_gen as date)=:fecha ');
    dm.ds_1.parambyname('fecha').AsDatetime:=de_1.Date;
  end else begin
    dm.ds_1.SelectSQL.Add('select * '+
      'from c_pedidos_muzybar '+
    'where estado=''P'' and id_repartidor=28 and cp between 7000 and 7999');
    //'where estado=''E'' and id_repartidor=28 and cp between 7000 and 7999 and cast(fecha_imp as date)=''23.10.2015'' ');
  end;
  dm.ds_1.Open;

  if not(dm.ds_1.isempty) then begin
    try
      AssignFile(f,ruta);
      Rewrite(f);

      dm.ds_1.First;
      while not(dm.ds_1.Eof) do begin
        linea:=linea_chrono(dm.ds_1.FieldByName('codalbaran').asinteger,dm.ds_1.FieldByName('CHRONO_BULTO_1').asstring,dm.ds_1.FieldByName('CHRONO_BULTO_ULT').asstring);
        Writeln(f,linea);
        dm.ds_1.Next;
        Inc(n);
      end;
    finally
      closefile(f);
    end;
  end;

  result:=n;
end;

function Tf_main.linea_chrono(codalbaran:Integer; ch_bulto_ini,ch_bulto_fin:string):string;                   //Genera Linea para chronoexpres
var   bultos:integer; cliente_chrono,producto_chrono:string;
begin
  with tadoquery.create(self) do                         //Genera Linea
  try
    connection:= dm.db_sql;
    sql.Add('select * from albaranes where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value:=codalbaran;
    Open;

    if not(isempty) then begin
        producto_chrono:='66';            //BALEARES
        cliente_chrono:='400040001';

        bultos:=FieldByName('bultos').AsInteger;
        result:=cliente_chrono+     // Numero de cliente crono
          cadLongitudFija('Loginser S.L.',40,False,' ')+   // Nombre del Cliente de Crono
          cadLongitudFija(ch_bulto_ini,23,False,'0')+ // codigo de bulto inicial
          cadLongitudFija(IntToStr(codalbaran),20,False,' ') + //referencia del cliente
          cadLongitudFija(FieldByName('dst_nombre').asstring,40,false,' ') + // nombre del consignatario
          cadLongitudFija(FieldByName('dst_calle').asstring,40,false,' ') + // direccion del consignatario
          cadLongitudFija(FieldByName('dst_persona').asstring,40,false,' ') + // atencion del consignatario
          '  '+//por que piden 7 para el cp... relleno
          cadLongitudFija(FieldByName('dst_cp').asstring,5,true,'0') + // cp del consignatario
          cadLongitudFija(FieldByName('dst_tfno').asstring,15,false,' ') + // tfno del consignatario
          cadLongitudFija(FieldByName('dst_localidad').asstring,40,false,' ') + // poblacion del consignatario
          'P' + // portes pagados
          producto_chrono +   // tipo de producto
          FormatFloat('000000',bultos) +  // numero de bultos
          FormatFloat('000000.000',FieldByName('Kgs').asfloat) + // peso
          '000000000.00' + //importe reembolso
          FormatFloat('0000000000000000',codalbaran) + // envio del cliente
          '    ' + // codigo pais  nacional en blanco
          cadLongitudFija(ch_bulto_fin,23,False,'0')+ // codigo de bulto inicial
          cadLongitudFija(FieldByName('observaciones').AsString,40,false,' ') + // observa 1
          cadLongitudFija(' ',40,false,' ')+   // observa 2
          FormatDateTime('yyyymmdd',FieldByName('fecha').AsDateTime)+ // fecha salida
          '                              '+      //Numero de serie antiguo (Solo para producto Loinex)
          '                    '+       //Modelo de Nuevo (Solo para producto Loinex)
          '                    '+       //Modelo Viejo (Solo para producto Loinex)
          '                '+          //Número de Envío de Retorno Loinex (Debe ser el estandar de ChronoExpres)
          '                              '+      //Numero de serie nuevo (Solo para producto Loinex)
          FormatFloat('000000000.00',FieldByName('asegurado').asfloat); // Valor asegurado de la mercancía
    end;
  finally
    Free;
  end;
end;

function Tf_main.cadLongitudFija (cadena : string; longitud : Integer;
    posicionIzquierda : boolean; valorRelleno : string) : string;
var
  i: integer;
begin
  if length(cadena) > longitud then
    cadena := copy(cadena, 1, longitud)
  else
  begin
    for i := 1 to longitud - Length(cadena) do
      if posicionIzquierda then
        cadena := valorRelleno + cadena
      else
        cadena := cadena + valorRelleno;
  end;
  Result := cadena;
end;

function Tf_main.get_cp_ext(poblacion:string):string;               //Saca CP de la poblacion (para envios al extranjero)
var
 fin:Boolean;
 s:string;
 t:char;
 n,i:Integer;
begin
  s:='';
  fin:=False;
  n:=1;
  while not(fin) do begin
    t:=poblacion[n];
    if ((Ord(t) >= 48) and (Ord(t) <= 57)) then
      s:=s+copy(poblacion,n,1);
    if n = Length(poblacion) then fin:=True;
    if Length(s)=5 then fin:=True;
    inc(n);
  end;
  Result:=s;
end;

function Tf_main.get_nombrefichero_chrono(fecha: TDateTime):string;
var contador:integer;  ano,mes,dia:word;
begin
  with tadoquery.Create(Self) do try
    Connection:=dm.db_sql;
    sql.Clear;
    SQL.Add('select contador from chrono_ficenvalb where fecha = :fecha');
    Parameters.ParamByName('fecha').Value:=fecha;
    Open;
    if RecordCount=0 then begin
      contador:=1;

      sql.Clear;
      sql.Add('insert into chrono_ficenvalb (fecha,contador) values (:fecha,:contador) ');
      Parameters.ParamByName('fecha').Value:=fecha;
      Parameters.ParamByName('contador').value:=contador+1;
      ExecSQL;

    end else begin
      contador:=FieldByName('contador').AsInteger;

      sql.Clear;
      sql.Add('update chrono_ficenvalb set contador = :contador where fecha = :fecha');
      Parameters.ParamByName('fecha').Value:=fecha;
      Parameters.ParamByName('contador').value:=contador+1;
      ExecSQL;
    end;

  finally
    Free;
  end;
  DecodeDate(fecha,ano,mes,dia);
  result:='MEC4004004'+formatfloat('00',dia)+formatfloat('00',mes)+formatfloat('00',ano)+
      formatfloat('00',contador)+'.txt';
end;



{$ENDREGION}

end.
