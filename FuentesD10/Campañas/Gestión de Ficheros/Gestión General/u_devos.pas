unit u_devos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnViewClasses6, Vcl.StdCtrls, pFIBDataSet,
  Vcl.Buttons, sBitBtn, sCheckBox, sEdit, sLabel, sSpeedButton, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit, sRadioButton, sGroupBox, Vcl.ExtCtrls,
  sPanel, NxColumns6, NxCustomGrid6, NxGrid6,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTPCommon,
  IdExplicitTLSClientServerBase, IdFTP,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, system.IOUtils, acImage,
  sButton, Vcl.Imaging.jpeg, Vcl.DBCtrls, JvDBImage, Vcl.ExtDlgs, sDialogs,
  sBevel, Data.DB, sDBNavigator, IdHTTP, sSpinEdit, System.Win.ComObj,
  ScSSHClient, ScSFTPClient, ScBridge, ScDataHandler, ScsFTPUtils, CLRClasses,
  System.StrUtils;

type
  TfrmDevos = class(TForm)
    gb_1: TsGroupBox;
    pnFiltro: TsPanel;
    rg_state: TsRadioGroup;
    gb_date: TsGroupBox;
    rb_alldate: TsRadioButton;
    rb_adate: TsRadioButton;
    ed_ini: TsDateEdit;
    ed_fin: TsDateEdit;
    gb_search: TsGroupBox;
    bt_art1: TsSpeedButton;
    lb_art1: TsLabel;
    ed_search_order: TsEdit;
    ch_order_name: TsCheckBox;
    ed_search_reexp: TsEdit;
    ch_albaran: TsCheckBox;
    ch_articulo: TsCheckBox;
    ed_art: TsEdit;
    rg_order: TsRadioGroup;
    gb2: TsGroupBox;
    gb4: TsGroupBox;
    lbLine: TsLabel;
    lbNomArt: TsLabel;
    lbIdArt: TsLabel;
    lb6: TsLabel;
    lb7: TsLabel;
    lb8: TsLabel;
    lbRefArt: TsLabel;
    lb10: TsLabel;
    gb1: TsGroupBox;
    lbReexpNomArt: TsLabel;
    lbReexpIdArt: TsLabel;
    lb13: TsLabel;
    lb14: TsLabel;
    lbReexpRefArt: TsLabel;
    lb16: TsLabel;
    gb3: TsGroupBox;
    lbFechaImp: TsLabel;
    lbNomFichero: TsLabel;
    lbTipoImp: TsLabel;
    lb20: TsLabel;
    lb21: TsLabel;
    lb22: TsLabel;
    lbLineaFich: TsLabel;
    lb24: TsLabel;
    lb25: TsLabel;
    lb26: TsLabel;
    lb27: TsLabel;
    lbPedido: TsLabel;
    lb29: TsLabel;
    lbReexp: TsLabel;
    lb31: TsLabel;
    lbFechaDevo: TsLabel;
    lb33: TsLabel;
    lbtipoDevo: TsLabel;
    lb35: TsLabel;
    lbEstado: TsLabel;
    lb39: TsLabel;
    lbFechaGen: TsLabel;
    lb41: TsLabel;
    lbTextoFich: TsLabel;
    bt3: TsBitBtn;
    lb_n: TsLabel;
    _ftp: TIdFTP;
    lbftp: TsLabel;
    gr_devs: TJvDBGrid;
    lb: TsLabel;
    lbArtIn: TsLabel;
    lb1: TsLabel;
    lbartOut: TsLabel;
    bv_1: TsBevel;
    dl_open: TsOpenDialog;
    dl_open_picture: TsOpenPictureDialog;
    btProcesar: TsBitBtn;
    gbDetalle: TsGroupBox;
    btEditar: TsBitBtn;
    btCancelar: TsBitBtn;
    btGuardar: TsBitBtn;
    gbcontrol: TsGroupBox;
    rgControl: TsRadioGroup;
    edMotivo: TsEdit;
    btControlImg: TsButton;
    dbi_imagen: TJvDBImage;
    rgTipo: TsRadioGroup;
    btAEnviar: TsSpeedButton;
    edRecibir: TsEdit;
    bt2: TsSpeedButton;
    edEnviar: TsEdit;
    lbEnviar: TsLabel;
    edIdEnviar: TsSpinEdit;
    edObs: TsEdit;
    btBorrarImg: TsButton;
    f: TScSFTPClient;
    cl: TScSSHClient;
    st: TScFileStorage;
    bt1: TsButton;
    procedure bt3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ed_iniChange(Sender: TObject);
    procedure ed_finChange(Sender: TObject);
    procedure ed_search_orderChange(Sender: TObject);
    procedure ed_search_reexpChange(Sender: TObject);
    procedure ed_artChange(Sender: TObject);
    procedure gr_devsCellClick(Column: TColumn);
    procedure rg_orderClick(Sender: TObject);
    procedure rg_stateClick(Sender: TObject);
    procedure btControlImgClick(Sender: TObject);
    procedure bt4Click(Sender: TObject);
    procedure gb_dateClick(Sender: TObject);
    procedure btProcesarClick(Sender: TObject);
    procedure rb_alldateClick(Sender: TObject);
    procedure ch_order_nameClick(Sender: TObject);
    procedure ch_albaranClick(Sender: TObject);
    procedure ch_articuloClick(Sender: TObject);
    procedure rb_adateClick(Sender: TObject);
    procedure btGuardarClick(Sender: TObject);
    procedure bt_art1Click(Sender: TObject);
    procedure btAEnviarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btBorrarImgClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure clServerKeyValidate(Sender: TObject;
      NewServerKey: TScKey; var Accept: Boolean);
    procedure fDirectoryList(Sender: TObject; const Path: string;
      const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo;
      EOF: Boolean);
    procedure pnFiltroDblClick(Sender: TObject);
    procedure bt1Click(Sender: TObject);
  private
    { Private declarations }
    procedure filter;
    function busca_art(codigo:string):integer;
    function ConectaFtp:string;
    procedure ProcesaFicheros;
    function ProcesaFichero(tipo:string;nom_fichero:string): Boolean;
    function DescargaFichero(ClienteFTP : TIdFTP; Nombre : string; out Datos : TStream) : string; overload;
    function DescargaFichero(ClienteFTP : TIdFTP; Nombre:string; out temp : string ) : string; overload;
    procedure CargarDatos;
    procedure EnviarEmail;
    function EnviaDevo(id_devo:integer):Boolean;
    function CreaJsonDevo(id_devo:integer):TStringList;
    function EnviaJsonDevo(json:string): string;
    procedure AbreFichero(ruta:string);
  public
    { Public declarations }
    function BuscaPedido(order:string; cod_cliente:integer):integer;
    function BuscaPedidoLine(id_pedido,id_articulo:integer):integer;
  end;

var
  frmDevos: TfrmDevos;
  cod_cli:Integer;
  pedidos_det: string;
  dir_temp: string;
  devos_imp: TStringList;

implementation

uses
  u_dm, u_main, u_orders, u_envia_mail, u_gen_gl, ubuscapro, u_functions, u_CreateExpedicion;

{$R *.dfm}



procedure TfrmDevos.fDirectoryList(Sender: TObject; const Path: string;
  const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo; EOF: Boolean);
begin
   if (FileInfo = nil) or (FileInfo.Filename = '.') or (FileInfo.Filename = '..') then
    Exit;

  if  FileExists(dir_temp+fileinfo.Filename) then
      DeleteFile(dir_temp+fileinfo.Filename);

  if Pos(ftp_devo_prefijo,fileinfo.Filename)>0 then
       f.DownloadFile(path+'/'+FileInfo.Filename,dir_temp+fileinfo.Filename,False,0);


end;

procedure TfrmDevos.filter;
var s:string;
begin
  dm.q_devs.Close;
  dm.q_devs.SelectSQL.Clear;
  dm.q_devs.SelectSQL.Add('select d.*, p.order_name, ar.id_articulo as id_articulo ');
  dm.q_devs.SelectSQL.Add(' from c_pedidos_devos d ');
  dm.q_devs.SelectSQL.Add(' left outer join c_pedidos p on p.id_pedido=d.id_pedido ');
  dm.q_devs.SelectSQL.Add(' left outer join c_pedidos_lines l on l.id_pedido=d.id_pedido and l.id_line=d.id_pedido_line ');
  dm.q_devs.SelectSQL.Add(' left outer join g_clientes cl on cl.id_cliente=p.id_cliente ');
  dm.q_devs.SelectSQL.Add(' left outer join g_articulos ar on ar.id_articulo=l.id_articulo ');

  dm.q_devs_count.Close;
  dm.q_devs_count.SelectSQL.Clear;
  dm.q_devs_count.SelectSQL.Add('select count(*) as tot ');
  dm.q_devs_count.SelectSQL.Add(' from c_pedidos_devos d ');
  dm.q_devs_count.SelectSQL.Add(' left outer join c_pedidos p on p.id_pedido=d.id_pedido ');
  dm.q_devs_count.SelectSQL.Add(' left outer join c_pedidos_lines l on l.id_pedido=d.id_pedido and l.id_line=d.id_pedido_line ');
  dm.q_devs_count.SelectSQL.Add(' left outer join g_clientes cl on cl.id_cliente=p.id_cliente ');
  dm.q_devs_count.SelectSQL.Add(' left outer join g_articulos ar on ar.id_articulo=l.id_articulo ');

  if rb_alldate.checked then begin
    dm.q_devs.SelectSQL.Add('where 1=1 ');

    dm.q_devs_count.SelectSQL.Add('where 1=1 ');
  end else begin
    dm.q_devs.SelectSQL.Add('where cast(file_date_imp as date) between :f1 and :f2 ');
    dm.q_devs.ParamByName('f1').AsDate:=ed_ini.Date;
    dm.q_devs.ParamByName('f2').AsDate:=ed_fin.Date;

    dm.q_devs_count.SelectSQL.Add('where cast(file_date_imp as date) between :f1 and :f2 ');
    dm.q_devs_count.ParamByName('f1').AsDate:=ed_ini.Date;
    dm.q_devs_count.ParamByName('f2').AsDate:=ed_fin.Date;
  end;

  dm.q_devs.SelectSQL.Add(' and d.id_cliente=:cli ');
  dm.q_devs.ParamByName('cli').AsString := f_main.edCliente.Text;
  dm.q_devs_count.SelectSQL.Add(' and d.id_cliente=:cli ');
  dm.q_devs_count.ParamByName('cli').AsString := f_main.edCliente.Text;

  s:='';
  case (rg_state.ItemIndex) of
    0: s:='and d.estado_devo=''P'' ';          //Pendientes
    1: s:='and d.estado_devo=''R'' ';          //Revisados
    2: s:='and d.estado_devo=''G'' ';          //Procesados
    3: s:='and d.estado_devo=''A'' ';          //Anulados
    4: s:='and d.estado_devo=''E'' ';          //Error
//    4: s:='and d.estado_devo=''A'' ';          //anulados
//    5: s:='and d.estado_devo=''C'' ';          //cancelados por cliente
//    6: s:='and d.estado_devo=''D'' ';          //devoluciones
  end;

  if ch_order_name.Checked then begin
    dm.q_devs.SelectSQL.Add('and p.order_name like :busc ');
    dm.q_devs.ParamByName('busc').AsString:='%'+ed_search_order.Text+'%';

    dm.q_devs_count.SelectSQL.Add('and p.order_name like :busc ');
    dm.q_devs_count.ParamByName('busc').AsString:='%'+ed_search_order.Text+'%';
  end;

  if ch_albaran.Checked and (StrToIntDef(ed_search_reexp.Text,-1)<>-1) then begin
    dm.q_devs.SelectSQL.Add('and =:busc2 ');
    dm.q_devs.ParamByName('busc2').asinteger:=StrToInt(ed_search_reexp.Text);

    dm.q_devs_count.SelectSQL.Add('and p.codalbaran=:busc2 ');
    dm.q_devs_count.ParamByName('busc2').asinteger:=StrToInt(ed_search_reexp.Text);
  end;

  if ch_articulo.Checked then begin
    dm.q_devs.SelectSQL.Add('and d.id_articulo_out=:id_art) ');
    dm.q_devs.ParamByName('id_art').asinteger:=busca_art(ed_art.Text);

    dm.q_devs_count.SelectSQL.Add('and d.id_articulo_out=:id_art) ');
    dm.q_devs_count.ParamByName('id_art').asinteger:=busca_art(ed_art.Text);
  end;

  dm.q_devs.SelectSQL.Add(s);

  dm.q_devs_count.SelectSQL.Add(s);
  dm.q_devs_count.Open;

  s := '';
  case (rg_order.ItemIndex) of
    0: s:='order by d.file_date_imp ';
    1: s:='order by p.order_name ';
    2: s:='order by d.id_pedido_nuevo ';
//    3: s:='order by fecha_ped ';
//    4: s:='order by nombre ';
//    5: s:='order by id_repartidor ';
  end;

  dm.q_devs.SelectSQL.Add(s);
  dm.q_devs.Open;

  lb_n.Caption:=IntToStr(dm.q_devs_count.FieldByName('tot').asinteger)+' lineas';

  CargarDatos;
end;

procedure TfrmDevos.FormShow(Sender: TObject);
begin
  lbftp.Caption := '';

  ed_ini.Date:=now;
  ed_fin.Date:=now;

  dir_temp := u_main.dir_temp + u_main.dir_temp_devo;

  filter;

end;

procedure TfrmDevos.gb_dateClick(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.gr_devsCellClick(Column: TColumn);
begin
  CargarDatos;
end;

procedure TfrmDevos.pnFiltroDblClick(Sender: TObject);
begin
    if HiWord(GetKeyState(VK_CONTROL)) <> 0 then
     bt1.Visible := not bt1.Visible;
end;

procedure TfrmDevos.bt1Click(Sender: TObject);
var
  texto: string;
begin
     dmCreateExpedicion.CreaExpedicion('0',dm.q_peds.FieldByName('id_pedido').AsInteger,u_main.dir_cliente_reco,texto);
end;

procedure TfrmDevos.bt3Click(Sender: TObject);
var
  ftp: string;
begin
  lbftp.Caption := 'Conectando ftp ...';
  ftp := Conectaftp;
  If ftp <> '' then
  begin
    //ShowMessage(ftp);
    Exit;
  end;

  ProcesaFicheros;
  filter;
end;

function Tfrmdevos.busca_art(codigo:string):integer;
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


function TfrmDevos.ConectaFtp:string;
begin
   { _ftp.Passive := True;
    _ftp.TransferType := ftBinary;
    _ftp.Host := ftp_host;
    _ftp.Username := ftp_username;
    _ftp.Password := ftp_password;
    if (_ftp.Username = '') or (_ftp.Password = '') then
    begin
    	Result := 'No se han encontrado los datos de acceso al ftp.';
      Exit;
    end;      }
  end;


function TfrmDevos.DescargaFichero(ClienteFTP : TIdFTP; Nombre : string; out Datos : TStream) : string;
  var
    NombreNuevo : string;

  begin
    NombreNuevo := FormatDateTime('yyyymmddhhnn',Now) + '_' + Nombre;
    Result := '';

    try
      //ClienteFTP.Rename(Nombre, NombreNuevo);
      //ClienteFTP.Get(NombreNuevo, Datos, False);
      ClienteFTP.Get(Nombre, Datos, False);
      //Result := NombreNuevo;
      Result := Nombre;
    except
      on e: Exception do
        showmessage('ERROR: ' + e.Message);
    end;
  end;

function TfrmDevos.DescargaFichero(ClienteFTP : TIdFTP; Nombre:string; out temp : string) : string;
var
  NombreNuevo : string;

begin
  NombreNuevo := FormatDateTime('yyyymmddhhnn',Now) + '_' + Nombre;
  Result := '';
  temp := 'C:\temp\' + nombre;
  try
    //ClienteFTP.Rename(Nombre, NombreNuevo);
    //ClienteFTP.Get(NombreNuevo, Datos, False);
    ClienteFTP.Get(Nombre, temp, True);
    //Result := NombreNuevo;
    Result := temp;
  except
    on e: Exception do
      showmessage('ERROR: ' + e.Message);
  end;
end;

procedure TfrmDevos.ed_artChange(Sender: TObject);
begin
  //filter;
end;

procedure TfrmDevos.ed_finChange(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.ed_iniChange(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.ed_search_orderChange(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.ed_search_reexpChange(Sender: TObject);
begin
  filter;
end;


procedure TfrmDevos.ProcesaFicheros;
var
  i,j: integer;
  Nombre, NombreFichero, temp, str_procesado: string;
  Lista: TStringList;
  Handle:  TScSFTPFileHandle;

begin
  if not DirectoryExists(dir_temp) then
      ForceDirectories(dir_temp);

  try
    str_procesado := 'Procesado:' + #13#10;

    //Conectamos al FTP y obtenemos la lista de ficheros pendientes
    // ...Descargamos el archivo del servidor a una carpeta local

    lbftp.Caption :=  'ConectaNdo al servidor FTP';
    cl.Connect;
    lbftp.Caption :=  'Conectado al servidor FTP';

    f.Initialize;
    Handle := f.OpenDirectory(u_main.ftp_devo_dir);

    lbftp.Caption := 'Recuperando la lista de archivos a procesar';

    try
      while not f.EOF do
      begin
        f.ReadDirectory(handle);
      end;

      Lista := TSTringList.Create;
      devos_imp := TStringList.Create;

      Lista := ListaArchivos(dir_temp);

      if Lista.Count>0 then
      begin
        //Datos := TMemoryStream.Create;

        // Por cada fichero...
        for i := 0 to lista.Count - 1 do
        begin
          lbftp.Caption := 'Procesando fichero ' + lista[i] + ' ...';

          if lista[i] <> '' then
          begin
            lbftp.Caption := Lista[i];
            // ...Leemos las filas del archivo de estados:
            dm.t_write.StartTransaction;
            if ProcesaFichero('xls',Lista[i]) then
              try
                dm.t_write.CommitRetaining;

                lbftp.Caption := 'Enviando a web ... ';

                for j := 0 to devos_imp.Count-1 do
                begin
                   EnviaDevo(StrToInt(devos_imp[j]));
                end;

                f.RenameFile(u_main.ftp_devo_dir + '/' + lista[i],u_main.ftp_devo_dir + '/' + TPath.GetFileNameWithoutExtension(lista[i]) + '_' + FormatDateTime('yyyymmddhhnn',Now) + ExtractFileExt(lista[i]));

                if FileExists(dir_temp+lista[i]) then DeleteFile(dir_temp+lista[i]);
              except
                on e: Exception do
                begin
                  ShowMessage('ERROR: ' + e.Message);
                  if dm.t_write.InTransaction then dm.t_write.RollbackRetaining;
                end;
              end
            else
              if dm.t_write.InTransaction then dm.t_write.RollbackRetaining;

            str_procesado := str_procesado + lista[i] + #13#10;
            lbftp.Caption := 'Procesado ' + lista[i];
          end;

          //if Datos.Size > 0 then
          //  TMemoryStream(Datos).Clear;
        end;
      end;

    finally
      Lista.Free;
      devos_imp.Free;
      f.CloseHandle(Handle);
      f.Disconnect;
    end;

  finally
    _ftp.Disconnect;
    ShowMessage(str_procesado);
    lbftp.Caption := 'Proceso finalizado.';
  end;
end;

procedure TfrmDevos.rb_adateClick(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.rb_alldateClick(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.rg_orderClick(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.rg_stateClick(Sender: TObject);
begin
  filter;

  gbDetalle.Enabled := not (rg_state.ItemIndex=2);

end;


procedure TfrmDevos.clServerKeyValidate(Sender: TObject;
  NewServerKey: TScKey; var Accept: Boolean);
begin
     Accept:=True;
end;

function TfrmDevos.ProcesaFichero(tipo:string;nom_fichero:string): Boolean;
  var
    error, texto, tipo_devo: string;
    i, id_pedido, id_ped_line, id_art_in, id_art_out, id_devo, dir_dest:integer;
begin
    Result := False;

    try
        if tipo='xls' then  //excel
        begin
          AbreFichero(dir_temp+nom_fichero);
          Hoja := excel.Worksheets.Item[1];

          i := 2;

          while Trim(hoja.cells[i,1])<>'' do
          begin
              with TpFIBDataSet.Create(self) do
              try
                Database:=dm.db;
                sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_DEVOS_ID,1) FROM RDB$DATABASE');
                Open;
                id_devo:=FieldByName('gen_id').AsInteger;
              finally
                free;
              end;

              id_pedido := BuscaPedido(Trim(hoja.cells[i,1]),cod_cli);
              id_art_in := f_main.busca_art(Trim(hoja.cells[i,10]),cod_cli);
              id_ped_line := BuscaPedidoLine(id_pedido,id_art_in);

              if Trim(hoja.cells[i,11])='' then
                id_art_out := -1
              else
                id_art_out := f_main.busca_art(Trim(hoja.cells[i,11]),cod_cli);

              dm.q_1.Close;
              dm.q_1.sql.Clear;
              dm.q_1.sql.Add('insert into c_pedidos_devos '+
                '(id_pedido_devo,id_cliente, id_pedido, id_pedido_line, order_name, fecha_devo, tipo, ' +
                'estado_devo, id_articulo_out, tipo_import, error_import, ' +
                'file_name, file_line, observaciones,linea_datos,file_date_imp, ' +
                'art_in, art_out) '+
                'values (:id_pedido_devo,:id_cliente, :id_pedido, :id_pedido_line, :order_name, :fecha_devo, :tipo, ' +
                ':estado_devo, :id_articulo_out, :tipo_import, :error_import, ' +
                ':file_name, :file_line, :observaciones,:linea_datos,:file_date_imp, '+
                ':art_in, :art_out)');

              dm.q_1.ParamByName('id_pedido_devo').AsInteger:=id_devo;
              dm.q_1.ParamByName('id_cliente').AsInteger:=cod_cli;
              dm.q_1.ParamByName('id_pedido').AsInteger:=id_pedido;
              dm.q_1.ParamByName('id_pedido_line').AsInteger:=id_ped_line;
              dm.q_1.ParamByName('order_name').AsString :=Trim(hoja.cells[i,1]);
              dm.q_1.ParamByName('fecha_devo').AsDateTime:=StrToDate(Trim(hoja.cells[i,2]));
              if Pos(UpperCase('Cambio'),UpperCase(Trim(hoja.cells[i,5])))>0 then
              begin
                dm.q_1.ParamByName('tipo').AsString := 'C';
                tipo_devo := 'C';
              end
              else if ((Pos(UpperCase('Devolución'),UpperCase(Trim(hoja.cells[i,5])))>0) or
                       (Pos(UpperCase('Devolucion'),UpperCase(Trim(hoja.cells[i,5])))>0)) then
                   begin
                        dm.q_1.ParamByName('tipo').AsString := 'D';
                        tipo_devo := 'D';
                   end else begin
                          dm.q_1.ParamByName('tipo').AsString := 'I';
                          tipo_devo := 'I';
                       end;
              dm.q_1.ParamByName('estado_devo').AsString := 'P';

              if id_art_out>0 then
                dm.q_1.ParamByName('id_articulo_out').asinteger:=id_art_out
              else
                dm.q_1.ParamByName('id_articulo_out').AsVariant := null;

              dm.q_1.ParamByName('art_in').AsString := Trim(hoja.cells[i,10]);
              dm.q_1.ParamByName('art_out').AsString := Trim(hoja.cells[i,11]);
              dm.q_1.ParamByName('tipo_import').AsString := 'F';
              dm.q_1.ParamByName('error_import').AsString := '';
              dm.q_1.ParamByName('file_name').AsString := ExtractFileName(nom_fichero);
              dm.q_1.ParamByName('file_line').asinteger:=i;
              dm.q_1.ParamByName('observaciones').AsString := Trim(hoja.cells[i,5]);
              dm.q_1.ParamByName('linea_datos').AsString :=
                Trim(hoja.cells[i,1]) + '|' +
                Trim(hoja.cells[i,2]) + '|' +
                Trim(hoja.cells[i,3]) + '|' +
                Trim(hoja.cells[i,4]) + '|' +
                Trim(hoja.cells[i,5]) + '|' +
                Trim(hoja.cells[i,6]) + '|' +
                Trim(hoja.cells[i,7]) + '|' +
                Trim(hoja.cells[i,8]) + '|' +
                Trim(hoja.cells[i,9]) + '|' +
                Trim(hoja.cells[i,10]) + '|' +
                Trim(hoja.cells[i,11]);
              dm.q_1.ParamByName('file_date_imp').AsDateTime := Now;
              dm.q_1.ExecQuery;

              devos_imp.Add(IntToStr(id_devo));

              if ((IndexStr(tipo_devo,[u_main.tipo_devo_reco])>=0) and
                  (IndexStr(GetPaisCodePedido(id_pedido),['ES','AD','PT'])<0)) then
              begin
                    if tipo_devo=u_main.tipo_devo_reco_cli then
                        dmCreateExpedicion.CreaExpedicion('0',id_pedido,u_main.dir_cliente_reco,texto)
                    else
                        dmCreateExpedicion.CreaExpedicion('0',id_pedido,'',texto);
              end;

              Inc(i);
          end;

          Excel.Quit ;
          Excel := Unassigned;

          result := True;
        end else if tipo='txt' then  //texto
                 begin

                 end;

        Result := True;
    except
        Result := False;
    end;

    lbftp.Caption := 'Proceso finalizado.';
end;


procedure TfrmDevos.bt4Click(Sender: TObject);
begin
  if dm.q_devs.state in [dsedit,dsinsert] then dm.q_devs.post;
  try
  dm.t_write.StartTransaction;
  dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos_devos set '+
            'control=:control, motivo_ko=:motivo_ko, foto=:foto '+
            'where id_pedido_devo=:id_pedido_devo');

          case rgControl.ItemIndex of
             0: dm.q_1.ParamByName('control').asstring := 'OK';
             1: dm.q_1.ParamByName('control').asstring := 'NA';   //No apto
          end;
          dm.q_1.ParamByName('motivo_ko').asstring := edMotivo.Text;
          dm.q_1.ParamByName('foto').AsVariant :=  dm.q_devs.FieldByName('foto').AsVariant;
          dm.q_1.ParamByName('id_pedido_devo').asinteger:=dm.q_devs.FieldByName('id_pedido_devo').asinteger;
          dm.q_1.ExecQuery;

          dm.t_write.CommitRetaining;
          ShowMessage('Control de calidad guardado correctamente.');

  except
          dm.t_write.RollbackRetaining;
          ShowMessage('Error al guardar control de calidad.');
  end;

end;

procedure TfrmDevos.btAEnviarClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='a.id_articulo,a.codigo,a.nombre';
    titulos.commatext:='Artículo,Referencia,Nombre';
    from:='g_articulos a ';
    where:='a.id_cliente=' + f_main.edCliente.Text + ' and a.estado<''B''';
    orden[1]:=2;  busca:=3;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edEnviar.Text:=valor[2];
        lbEnviar.caption:=valor[3];
        edIdEnviar.Value := StrToInt(valor[1]);
      end;
    end;
  end;
end;

procedure TfrmDevos.btBorrarImgClick(Sender: TObject);
begin
  if not(dm.q_devs.State in [dsedit,dsinsert]) then dm.q_devs.Edit;
  dm.q_devs.fieldbyname('foto').AsVariant := null;
  dm.q_devs.post;
end;

procedure TfrmDevos.btProcesarClick(Sender: TObject);
var
  id_pedido, actual, c_linea, i: Integer;
  procesados: string;
  pedidos_gen: TStringList;
begin

   lbftp.Caption := 'Procesando devoluciones...';

   if dm.q_devs.state in [dsedit,dsinsert] then dm.q_devs.post;

   with tpfibdataset.Create(dm) do
   begin
        database:=dm.db;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select * from c_pedidos_devos d ' +
                          'where d.estado_devo=:estado ' +
                          //' where id_pedido in (164604,156273,160106,160594,161016) ' +   ////////////////
                           //'and d.control=:control ' +
                           //'and d.file_date_gen>=''01.10.2020''' +
                           'order by d.id_pedido');
        ParambyName('estado').AsString := 'R';
        //ParambyName('estado').AsString := 'G';

        Open;

        if not(IsEmpty) then begin

          try
            First;
            dm.t_write.StartTransaction;

            actual := -1;
            procesados := '';
            pedidos_gen := TStringList.Create;

            pedidos_det := '';

            while not Eof do
            begin
              if actual<>fieldByName('id_pedido').AsInteger then
              begin
                  c_linea := 1;
                  actual := fieldByName('id_pedido').AsInteger;


                    dm.ds_1.Close;
                    dm.ds_1.SelectSQL.Clear;
                    dm.ds_1.SelectSQL.Add('select * from c_pedidos where id_pedido=:id_pedido');
                    dm.ds_1.ParamByName('id_pedido').AsInteger:= actual;
                    dm.ds_1.Open;

                    lbftp.Caption := 'Procesando ' + dm.ds_1.FieldByName('order_name').AsString + '-R';

                  if fieldByName('CONTROL').asstring='NA' then
                  begin
                     pedidos_det := pedidos_det + '<br><b>' + dm.ds_1.FieldByName('order_name').AsString + '</b><br>' +
                                    dm.ds_1.FieldByName('nombre').AsString + '<br>No apto. ' + FieldByName('motivo_ko').AsString + '.<br>';
                  end
                  else if fieldByName('CONTROL').asstring='OK' then
                  begin
                    //Solo se genera un nuevo pedido si es un cambio, las devoluciones no generan nuevo pedido
                    if FieldByName('tipo').AsString = 'C' then
                    begin

                      with tpfibdataset.Create(dm) do begin
                        database:=dm.db;
                        SQLs.SelectSQL.Clear;
                        SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID, 1) from RDB$DATABASE');
                        Open;

                        id_pedido:=FieldByName('gen_id').AsInteger;

                        Free;
                      end;

                      pedidos_gen.Add(IntToStr(id_pedido));

                      dm.q_1.Close;
                      dm.q_1.sql.Clear;
                      dm.q_1.sql.Add('insert into c_pedidos (id_pedido, id_cliente, id_order,order_name,nombre,dir_1,poblacion, '+
                        'provincia,cp,fecha_ped,estado,telefono,email,text,observaciones,delivery_time,tracking_number, ' +
                        'id_repartidor,bultos, pais, pais_code, transporte, es_devo, company, note) values '+
                        '(:id_pedido,:id_cliente,:id_order,:order_name,:nombre,:dir_1,:poblacion, '+
                        ':provincia,:cp,:fecha_ped,:estado,:telefono,:email,:text,:observaciones,:delivery_time,:tracking, ' +
                        ':id_repartidor,:bultos, :pais, :pais_code, :transporte, 1, :company, :note)');
                      dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
                      dm.q_1.ParamByName('id_order').AsString := dm.ds_1.FieldByName('id_order').AsString + '-R';
                      dm.q_1.ParamByName('id_cliente').AsInteger := cod_cli;
                      dm.q_1.ParamByName('order_name').asstring := dm.ds_1.FieldByName('order_name').AsString + '-R';
                      dm.q_1.ParamByName('nombre').asstring := dm.ds_1.FieldByName('nombre').AsString;
                      dm.q_1.ParamByName('dir_1').asstring := dm.ds_1.FieldByName('dir_1').AsString;
                      dm.q_1.ParamByName('poblacion').asstring := dm.ds_1.FieldByName('poblacion').AsString;
                      dm.q_1.ParamByName('provincia').asstring := dm.ds_1.FieldByName('provincia').AsString;
                      dm.q_1.ParamByName('cp').asstring := dm.ds_1.FieldByName('cp').AsString;
                      dm.q_1.ParamByName('pais').asstring := dm.ds_1.FieldByName('pais').AsString;
                      dm.q_1.ParamByName('pais_code').asstring := dm.ds_1.FieldByName('pais_code').AsString;
                      dm.q_1.ParamByName('fecha_ped').asdate := Now;
                      dm.q_1.ParamByName('estado').AsString:='P';
                      dm.q_1.ParamByName('telefono').asstring := dm.ds_1.FieldByName('telefono').AsString;
                      dm.q_1.ParamByName('email').asstring := dm.ds_1.FieldByName('email').AsString;
                      dm.q_1.ParamByName('text').asstring := dm.ds_1.FieldByName('text').AsString;
                      dm.q_1.ParamByName('observaciones').asstring := dm.ds_1.FieldByName('observaciones').AsString;
                      dm.q_1.ParamByName('tracking').asstring := dm.ds_1.FieldByName('tracking_number').AsString;
                      dm.q_1.ParamByName('id_repartidor').asinteger := dm.ds_1.FieldByName('id_repartidor').AsInteger;
                      dm.q_1.ParamByName('bultos').AsInteger := 1;
                      dm.q_1.ParamByName('delivery_time').asinteger := dm.ds_1.FieldByName('delivery_time').AsInteger;
                      dm.q_1.ParamByName('transporte').asinteger := dm.ds_1.FieldByName('transporte').AsInteger;
                      dm.q_1.ParamByName('company').asstring := dm.ds_1.FieldByName('company').AsString;
                      dm.q_1.ParamByName('note').asstring := dm.ds_1.FieldByName('note').AsString;

                      dm.q_1.ExecQuery;

                      pedidos_det := pedidos_det + '<br><b>' + dm.ds_1.FieldByName('order_name').AsString + '-R</b><br>' +
                                      dm.ds_1.FieldByName('nombre').AsString + '<br>' + FieldByName('observaciones').AsString + '<br>Detalle de salida:<br>';
                    end else
                           pedidos_det := pedidos_det + '<br><b>' + dm.ds_1.FieldByName('order_name').AsString + '</b><br>' +
                                      dm.ds_1.FieldByName('nombre').AsString + '<br>' + FieldByName('observaciones').AsString + '<br>No genera nuevo pedido.<br>';
                  end;

                  procesados := procesados + FieldByName('id_pedido_devo').AsString + ',';
              end;

                  if (FieldByName('tipo').AsString = 'C') and (FieldByName('control').AsString = 'OK')  then
                  begin
                      dm.q_1.Close;
                      dm.q_1.sql.Clear;
                      dm.q_1.sql.Add('insert into c_pedidos_lines (id_pedido,id_line,id_articulo,cantidad,sku,nombre_art) '+
                                     'values (:id_pedido,:id_line,:id_articulo,:cantidad,:sku,:nombre_art)');
                      dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
                      dm.q_1.ParamByName('id_line').AsInteger := c_linea;
                      dm.q_1.ParamByName('id_articulo').asinteger := FieldByName('id_articulo_out').AsInteger;
                      dm.q_1.ParamByName('cantidad').asinteger := 1;
                      dm.q_1.ParamByName('sku').asstring:= f_main.busca_art_ref(FieldByName('id_articulo_out').AsInteger);
                      dm.q_1.ParamByName('nombre_art').asstring := f_main.busca_art_nom(FieldByName('id_articulo_out').AsInteger);
                      dm.q_1.ExecQuery;

                      pedidos_det := pedidos_det + FieldByName('art_out').AsString + '<br>';

                      Inc(c_linea);
                  end;

              Next;
            end;

            dm.q_1.Close;
            dm.q_1.sql.Clear;
            dm.q_1.sql.Add('update c_pedidos_devos set estado_devo=' + QuotedStr('G') + ', file_date_gen=:fecha ' +
                           ' where id_pedido_devo in (' + Copy(procesados, 0, Length(procesados)-1) + ')');
            dm.q_1.ParamByName('fecha').AsDateTime := Now;
            dm.q_1.ExecQuery;

            dm.t_write.CommitRetaining;

            lbftp.Caption := 'Subiendo a la web...';
            for i := 0 to pedidos_gen.Count-1 do
            begin
             EnviaReexp(StrToInt(pedidos_gen[i]));
            end;

            if procesados<>'' then
            begin
               dm.ds_1.Close;
               dm.ds_1.SelectSQL.Clear;
               dm.ds_1.SelectSQL.Add('select * from c_pedidos_devos where id_pedido_devo in (' + Copy(procesados, 0, Length(procesados)-1) + ')');
               dm.ds_1.Open;
               dm.ds_1.First;

               while not dm.ds_1.Eof do
               begin
                  EnviaDevo(dm.ds_1.FieldByName('id_pedido_devo').AsInteger);
                  dm.ds_1.Next;
               end;

            end;

            lbftp.Caption := 'Enviando email...';
            EnviarEmail;

            lbftp.Caption := 'Proceso finalizado.';
            ShowMessage('Pedidos guardados correctamente.');
          except
                  dm.t_write.RollbackRetaining;
                  lbftp.Caption := 'Error al procesar.';
                  ShowMessage('Error al guardar pedidos.');
          end;

          pedidos_gen.Free;

        end else begin
                    lbftp.Caption := 'Sin devoluciones pendientes.';
                    ShowMessage('No existen devoluciones pendientes.');
                 end;
        Free;

   end;
end;


procedure TfrmDevos.bt_art1Click(Sender: TObject);
begin
    with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='a.id_articulo,a.codigo,a.nombre';
    titulos.commatext:='Artículo,Referencia,Nombre';
    from:='g_articulos a ';
    where:='a.id_cliente=' + f_main.edCliente.Text + ' and a.estado<''B''';
    orden[1]:=2;  busca:=3;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        ed_art.text:=valor[2];
        lb_art1.caption:=valor[3];
      end;
    end;
  end;
end;

procedure TfrmDevos.btCancelarClick(Sender: TObject);
begin
  CargarDatos;
end;

procedure TfrmDevos.btControlImgClick(Sender: TObject);            //Add Image
var Jpeg: TJpegImage;
begin
  if dl_open_picture.Execute then begin
    if FileExists(dl_open_picture.filename) then begin

      Jpeg := TJpegImage.Create;
      try
        Jpeg.LoadFromFile(dl_open_picture.filename);

        //if ((jpeg.Width>530) or (jpeg.Height>330)) then raise Exception.Create('Máximo W=530 x H=330');
        if not(dm.q_devs.State in [dsedit,dsinsert]) then dm.q_devs.Edit;
        dm.q_devs.fieldbyname('foto').Assign(jpeg);
        dm.q_devs.Post;

      finally
        Jpeg.Free;
      end;
    end else raise exception.Create('Fichero No Encontrado');
  end;
end;



procedure TfrmDevos.btEditarClick(Sender: TObject);
begin
  if not(dm.q_devs.State in [dsedit,dsinsert]) then dm.q_devs.Edit;
end;

procedure TfrmDevos.btGuardarClick(Sender: TObject);
var
  id: integer;
begin

  If rgControl.ItemIndex=-1 then
  begin
      if  MessageDlg('Control de Calidad Pendiente. ¿Desea continuar?',mtWarning,mbYesNo,1)=mrNo then
           Exit;
  end;


  if dm.q_devs.state in [dsedit,dsinsert] then dm.q_devs.post;

//  try
//      case rgTipo.ItemIndex of
//             0: begin
//                  dm.q_devs.FieldByName('tipo').AsString := 'C';   //Cambio
//                  dm.q_devs.FieldByName('id_articulo_out').AsInteger:= edIdEnviar.Value;   //Cambio: sale otro artículo
//                end;
//             1: begin
//                  dm.q_devs.FieldByName('tipo').AsString := 'D';   //Devolución
//                  dm.q_devs.FieldByName('observaciones').AsVariant := null;               //Devolución: no sale otro artículo
//                end;
//      end;
//
//      case rgControl.ItemIndex of
//         0: dm.q_devs.FieldByName('control').AsString := 'OK';
//         1: dm.q_devs.FieldByName('control').AsString := 'NA';   //No apto
//      end;
//
//     dm.q_devs.FieldByName('motivo_ko').AsString := edMotivo.Text;
//     dm.q_devs.FieldByName('art_in').AsString := edRecibir.Text;
//     dm.q_devs.FieldByName('art_out').AsString := edEnviar.Text;
//     dm.q_devs.FieldByName('observaciones').AsString := edObs.Text;
//
//     dm.q_devs.Post;
//     ShowMessage('Control de calidad guardado correctamente.');
//  except
//      ShowMessage('Error al guardar.');
//  end;

  try
    dm.t_write.StartTransaction;
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos_devos set '+
      'estado_devo=:estado, control=:control, motivo_ko=:motivo_ko, foto=:foto, ' +
      ' art_in=:art_in, art_out=:art_out, id_articulo_out=:id_out, tipo=:tipo, observaciones=:obs, '+
      ' file_date_revisado=:fecha_revisado ' +
      'where id_pedido_devo=:id_pedido_devo');

    If rgControl.ItemIndex>=0 then
      dm.q_1.ParamByName('estado').asstring := 'R' //Revisado
    else
      dm.q_1.ParamByName('estado').asstring := dm.q_devs.FieldByName('estado_devo').AsString;

    case rgTipo.ItemIndex of
       0: begin
            dm.q_1.ParamByName('tipo').asstring := 'C';   //Cambio
            dm.q_1.ParamByName('id_out').AsInteger := edIdEnviar.Value;   //Cambio: sale otro artículo
          end;
       1: begin
            dm.q_1.ParamByName('tipo').asstring := 'D';   //Devolución
            dm.q_1.ParamByName('id_out').AsVariant := null;               //Devolución: no sale otro artículo
          end;
    end;

    case rgControl.ItemIndex of
       0: dm.q_1.ParamByName('control').asstring := 'OK';
       1: dm.q_1.ParamByName('control').asstring := 'NA';   //No apto
    end;
    dm.q_1.ParamByName('motivo_ko').asstring := edMotivo.Text;
    dm.q_1.ParamByName('foto').AsVariant :=  dm.q_devs.FieldByName('foto').AsVariant;
    dm.q_1.ParamByName('id_pedido_devo').asinteger:=dm.q_devs.FieldByName('id_pedido_devo').asinteger;
    dm.q_1.ParamByName('art_in').asstring := edRecibir.Text;
    dm.q_1.ParamByName('art_out').asstring := edEnviar.Text;
    dm.q_1.ParamByName('obs').asstring := edObs.Text;
    dm.q_1.ParamByName('fecha_revisado').asDateTime := Now;

    dm.q_1.ExecQuery;

    dm.t_write.CommitRetaining;
    EnviaDevo(dm.q_devs.FieldByName('id_pedido_devo').asinteger);
    id := dm.q_devs.FieldByName('id_pedido_devo').asinteger;
    dm.q_devs.Close;
    dm.q_devs.Open;
    dm.q_devs.Locate('id_pedido_devo',id,[]);
    CargarDatos;
    ShowMessage('Datos guardados correctamente.');

  except
          dm.t_write.RollbackRetaining;
          ShowMessage('Error al guardar datos.');
  end;
end;

function TfrmDevos.BuscaPedido(order:string; cod_cliente:integer):integer;
begin                                       //devuelve id de pedido a partir de codigo de pedido y cliente
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from c_pedidos p ' +
                       'where p.order_name=:order and p.id_cliente=:cod_cliente');
    ParambyName('order').asstring := order;
    ParambyName('cod_cliente').asinteger := cod_cliente;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_pedido').asinteger
    else result:=-1;

    Free;
  end;
end;

function TfrmDevos.BuscaPedidoLine(id_pedido,id_articulo:integer):integer;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from c_pedidos_lines l ' +
                       'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo');
    ParambyName('id_pedido').AsInteger := id_pedido;
    ParambyName('id_articulo').asinteger := id_articulo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_line').asinteger
    else result:=-1;

    Free;
  end;
end;

procedure TfrmDevos.CargarDatos;
var
  cod_art: string;
begin
  lbPedido.caption := dm.q_devs.FieldByName('id_pedido').AsString;
  edObs.Text := dm.q_devs.FieldByName('observaciones').AsString;
  cod_art := '';
  lbIdArt.caption := dm.q_devs.FieldByName('id_articulo').AsString;
  if dm.q_devs.FieldByName('id_articulo').AsString<>'' then
  begin
    lbNomArt.Caption := BuscaArticulo(dm.q_devs.FieldByName('id_articulo').AsInteger,cod_art);
    lbRefArt.Caption := cod_art;
  end else begin
             lbNomArt.Caption := '';
             lbRefArt.Caption := '';
      end;
  lbArtIn.Caption := dm.q_devs.FieldByName('art_in').AsString;
  lbArtOut.Caption := dm.q_devs.FieldByName('art_out').AsString;
  if dm.q_devs.FieldByName('id_articulo_out').AsString<>'' then
  begin
    lbReexpNomArt.Caption := BuscaArticulo(dm.q_devs.FieldByName('id_articulo_out').AsInteger,cod_art);
    lbReexpRefArt.Caption := cod_art;
  end else begin
             lbReexpNomArt.Caption := '';
             lbReexpRefArt.Caption := '';
      end;
  lbtipoDevo.Caption := dm.q_devs.FieldByName('tipo').AsString;
  lbLine.Caption := dm.q_devs.FieldByName('id_pedido_line').AsString;
  lbEstado.Caption := dm.q_devs.FieldByName('estado_devo').AsString;

  if dm.q_devs.FieldByName('tipo').AsString = 'C' then
    rgTipo.ItemIndex := 0
  else if dm.q_devs.FieldByName('tipo').AsString = 'D' then
    rgTipo.ItemIndex := 1
  else
    rgTipo.ItemIndex := -1;

  lbFechaDevo.Caption := dm.q_devs.FieldByName('fecha_devo').AsString;
  lbArtIn.Caption := dm.q_devs.FieldByName('art_in').AsString;
  lbTextoFich.Caption := dm.q_devs.FieldByName('linea_datos').AsString;
  lbReexp.Caption := dm.q_devs.FieldByName('id_pedido_nuevo').AsString;
  lbReexpIdArt.Caption := dm.q_devs.FieldByName('id_articulo_out').AsString;
  lbFechaImp.Caption := dm.q_devs.FieldByName('file_date_imp').AsString;
  lbtipoImp.Caption := dm.q_devs.FieldByName('tipo_import').AsString;
  lbNomFichero.Caption := dm.q_devs.FieldByName('file_name').AsString;
  if dm.q_devs.FieldByName('control').AsString = 'OK' then
    rgControl.ItemIndex := 0
  else if dm.q_devs.FieldByName('control').AsString = 'NA' then
    rgControl.ItemIndex := 1
  else
    rgControl.ItemIndex := -1;
  edMotivo.Text := dm.q_devs.FieldByName('motivo_ko').AsString;
  edRecibir.Text := dm.q_devs.FieldByName('art_in').AsString;
  edEnviar.Text := dm.q_devs.FieldByName('art_out').AsString;
  lbEnviar.Caption := '';
  edIdEnviar.Value := dm.q_devs.FieldByName('id_articulo_out').AsInteger;

end;


procedure TfrmDevos.ch_albaranClick(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.ch_articuloClick(Sender: TObject);
begin
  filter;
end;

procedure TfrmDevos.ch_order_nameClick(Sender: TObject);
begin
  filter;
end;


procedure TfrmDevos.EnviarEmail;
var
  ruta, dest, asunto:string;      cuerpo:tstrings;
begin
    try
        //u_gen_gl.lee_inis_def;      //lee defs de tablas aux

        cuerpo:=tstringlist.Create;
        cuerpo.add('<head><meta charset="UTF-8">' +
                     '<style>' +
                       'table {font-family: "Quicksand", "Trebuchet MS";}' +
                       //'tbody th {color: #0B2161;font-family: "Quicksand", "Trebuchet MS";font-size: 18px;}' +
                       //'tbody td {color: #0B0B61; font-family: "Quicksand", "Trebuchet MS";font-size: 14px;}' +
                       'h5 {color: black;font-family: "Quicksand", "Trebuchet MS";font-size: 10px;} ' +
                     '</style>' +
                   '</head>' +
                   '<table width=720 border=0>'
                   );

        ruta := '';
        dest := u_main.email_reexp;

        asunto := 'Cambios y devoluciones procesados.';
       { cuerpo.Add( '<tbody width=200>' +
                    '<tr>' +
                     '<th align=left><br>Hola ' + dm.q_peds.FieldByName('nombre').AsString + '!</th>' +
                    '</tr>' +
                    '<tr>' +
                     '<td><br>Tu pedido <b>' + dm.q_peds.FieldByName('order_name').AsString + '</b> ya está de camino a la siguiente dirección:</td>' +
                    '</tr>' +
                    '<tr>' +
                     '<th align=left><br>Dirección de envío:<br><br></th>' +
                    '</tr>' +
                    '<tr>' +
                     '<td>' + dm.q_peds.FieldByName('dir_1').AsString + '<br>' +
                              dm.q_peds.FieldByName('cp').AsString + ' ' + dm.q_peds.FieldByName('poblacion').AsString + '<br>' +
                              dm.q_peds.FieldByName('provincia').AsString + '<br>' +
                              dm.q_peds.FieldByName('pais').AsString + ' </td>' +
                    '</tr>' +
                    '<tr>' +
                     '<th align=left><br>Detalles del pedido: </th>' +
                    '</tr>' +
                    '<tr>' +
                      '<td width=720><br>' + rellena_detalle_pedido + '<br></td>' +
                    '</tr>' +
                    '</tbody></table>'

                   );  }
         cuerpo.Add(pedidos_det);

         f_envia_mail.envia_email(dest,'',asunto,ruta,mail_from,cuerpo);
    finally
        cuerpo.Free;
    end;
end;


function TfrmDevos.EnviaDevo(id_devo:integer):Boolean;
var
  json: TStringList;
  i: integer;
  str_js: string;
begin
   try
      json := CreaJsonDevo(id_devo);

      for I := 0 to json.Count - 1 do
        str_js := str_js + json[i];

      EnviaJsonDevo(str_js);

      result := true;
   except
      Result := false;
   end;
end;


function TfrmDevos.CreaJsonDevo(id_devo:integer):TStringList;
var
  json: TStringList;
  items: string;
begin
      with TpFIBDataSet.Create(dm) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos_devos where id_pedido_devo=:devo');
        ParamByName('devo').AsInteger := id_devo;
        Open;
        First;

        if not isEmpty then
        begin
            json := TStringlist.Create;

            json.Text := '{';

            json.Append('"id_order_devo" : "' + FieldByName('id_pedido_devo').AsString + '",');
            json.Append('"fecha" : "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',FieldByName('fecha_devo').AsDateTime) + '",');
            json.Append('"id_cliente" : "' + FieldByName('id_cliente').AsString + '",');
            json.Append('"tipo_devo" : "' + FieldByName('tipo').AsString + '",');
            json.Append('"observaciones" : "' + FieldByName('observaciones').AsString + '",');
            json.Append('"order_name" : "' + FieldByName('order_name').AsString + '",');
            json.Append('"id_order_new" : "' + FieldByName('id_pedido_nuevo').AsString + '",');
            json.Append('"order_name_new" : "' + FieldByName('order_name_nuevo').AsString + '",');
            json.Append('"estado_devo" : "' + FieldByName('estado_devo').AsString + '",');
            json.Append('"control" : "' + FieldByName('control').AsString + '",');
            json.Append('"motivo_ko" : "' + FieldByName('motivo_ko').AsString + '",');
            json.Append('"sku_recibir" : "' + FieldByName('art_in').AsString + '",');
            json.Append('"sku_enviar" : "' + FieldByName('art_out').AsString + '",');
            json.Append('"file_name" : "' + FieldByName('file_name').AsString + '",');
            json.Append('"file_line" : "' + FieldByName('file_line').AsString + '",');

            if FieldByName('file_date_imp').AsString = '' then
              json.Append('"file_date_imp" : "",')
            else
              json.Append('"file_date_imp" : "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',FieldByName('file_date_imp').asdatetime) + '",');

            if FieldByName('file_date_gen').AsString = '' then
              json.Append('"file_date_gen" : ""')
            else
              json.Append('"file_date_gen" : "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',FieldByName('file_date_gen').Asdatetime) + '"');

            json.Append('}'); //end json

            Result := json;
        end;

      finally
        free;
      end;

end;


function TfrmDevos.EnviaJsonDevo(json:string): string;
    var
    HTTP: TIdHTTP;
    RequestBody: TStream;
    ResponseBody: string;
begin
    HTTP := TIdHTTP.Create;
    try
      try
        //RequestBody := TStringStream.Create('{"FechaOperacion":'25-09-2017 12:00'}', TEncoding.UTF8);
        RequestBody := TStringStream.Create(json, TEncoding.UTF8);
        try
          HTTP.Request.Accept := 'application/json';
          HTTP.Request.ContentType := 'application/json';
          ResponseBody := HTTP.Post('http://www.loginser.com/sync/sync_order_return_webhook.php', RequestBody);
          result:= ResponseBody;
        finally
          RequestBody.Free;
        end;
      except
        on E: EIdHTTPProtocolException do
        begin
          showmessage(E.Message);
          showmessage(E.ErrorMessage);
        end;
        on E: Exception do
        begin
          showmessage(E.Message);
        end;
      end;
    finally
      HTTP.Free;
    end;
    //ReadLn;
    ReportMemoryLeaksOnShutdown := True;
end;

procedure TfrmDevos.AbreFichero(ruta:string);
begin
   Excel:=CreateOleObject('Excel.Application');
   try
     Excel.Visible := False;
     Excel.DisplayAlerts:= False;
     Excel.WorkBooks.Open(ruta);//fichero que queremos leer
   except
     Excel.Quit ;
     Excel := Unassigned;
   end;
end;

end.
