unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, sSkinProvider, StdCtrls, sGroupBox,
  Buttons, sSpeedButton, sEdit,pfibdataset, sBitBtn, sLabel,pfibquery, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, ExtCtrls, sBevel,sdialogs, sButton, frxClass,
  frxDBSet, sComboBox, imageenio,jpeg,printers,winspool, 
  Vcl.ComCtrls, EJSON, IPPeerAPI, sStatusBar, sSpinEdit,RestRequest, IdHttp,
  Data.DB, hyieutils, iexBitmaps, hyiedefs, iesettings, iexLayers, iexRulers,
  NxGridView6, NxColumns6, NxControls6, NxCustomGrid6, NxVirtualGrid6, NxDBGrid6;

type
  Tf_main = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sk_manager: TsSkinManager;
    gb_2: TsGroupBox;
    e_uds: TsEdit;
    b_ok_entra: TsBitBtn;
    e_art_entra: TsEdit;
    sb_as_art_entra: TsSpeedButton;
    lb_articulo: TsLabel;
    lb_11: TsLabel;
    lb_mat: TsLabel;
    gb_3: TsGroupBox;
    g_1: TJvDBGrid;
    e_estanteria: TsEdit;
    e_posicion: TsEdit;
    e_altura: TsEdit;
    b_ubica: TsBitBtn;
    bv_1: TsBevel;
    b_imp: TsBitBtn;
    rep_db_1: TfrxDBDataset;
    rep_alm: TfrxReport;
    rep_alm2: TfrxReport;
    gb_11: TsGroupBox;
    g_11: TJvDBGrid;
    b_imp_ubic: TsBitBtn;
    b_1: TsBitBtn;
    b_2: TsBitBtn;
    cb_tipo: TsComboBox;
    b__scan: TsSpeedButton;
    sc_io: TImageEnIO;
    ed_pc: TsEdit;
    cb_situ: TsComboBox;
    ed_obs: TsEdit;
    sb_foto: TsSpeedButton;
    sb_eliminar: TsBitBtn;
    ed_alm: TsEdit;
    sb_as_alm: TsSpeedButton;
    lb_alm: TsLabel;
    ed_mat1: TsEdit;
    ed_mat2: TsEdit;
    bt_busca_ubic: TsBitBtn;
    bv_2: TsBevel;
    e_sub: TsEdit;
    e_ean: TsEdit;
    b_nueva: TsBitBtn;
    sb_as_lote: TsSpeedButton;
    lb_lote: TsLabel;
    e_lote: TsEdit;
    b_new_lote: TsSpeedButton;
    gbImei: TsGroupBox;
    edImei: TsEdit;
    lbImei: TsLabel;
    btDelImei: TsSpeedButton;
    dtpCaducidad: TDateTimePicker;
    lb_1: TLabel;
    btDelAll: TsSpeedButton;
    btIMEI: TsBitBtn;
    bt1: TsButton;
    statusBar1: TsStatusBar;
    lbCon: TLabel;
    ngImei: TNextDBGrid6;
    chFiltrarArt: TCheckBox;
    procedure bt_busca_ubicClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sSkinProvider1TitleButtons1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sSkinProvider1TitleButtons0MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sb_as_art_entraClick(Sender: TObject);
    procedure b_ok_entraClick(Sender: TObject);
    procedure e_udsKeyPress(Sender: TObject; var Key: Char);
    procedure b_nuevaClick(Sender: TObject);
    procedure b_ubicaClick(Sender: TObject);
    procedure imprime_matricula(id_mat:integer);
    procedure FormShow(Sender: TObject);
    procedure b_impClick(Sender: TObject);
    procedure e_art_entraExit(Sender: TObject);
    procedure b_1Click(Sender: TObject);
    procedure b_2Click(Sender: TObject);
    procedure b_imp_ubicClick(Sender: TObject);
    procedure b__scanClick(Sender: TObject);
    procedure sb_fotoClick(Sender: TObject);
    procedure sb_eliminarClick(Sender: TObject);
    procedure sb_as_almClick(Sender: TObject);
    procedure ed_almExit(Sender: TObject);
    procedure e_eanKeyPress(Sender: TObject; var Key: Char);
    function ubic_entrada(id_alm:Integer):Integer;
    function WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
    procedure e_loteExit(Sender: TObject);
    procedure sb_as_loteClick(Sender: TObject);
    procedure b_new_loteClick(Sender: TObject);
    procedure edImeiKeyPress(Sender: TObject; var Key: Char);
    procedure btDelImeiClick(Sender: TObject);
    procedure e_udsChange(Sender: TObject);
    procedure btDelAllClick(Sender: TObject);
    procedure btIMEIClick(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure gb_2DblClick(Sender: TObject);
    procedure chFiltrarArtClick(Sender: TObject);
  private
    function HabilitaImei:Boolean;
    function HabilitaDelImei:Boolean;
    procedure VaciaImei;
    function TieneSalida(imei:string):Boolean;
    function EsOtroArticulo(imei:string):Boolean;
    function ActualizaAttachmentMat(attach, mat:Integer):string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_main: Tf_main;
  frm_width: integer;
  id_articulo: Integer=-1;

const
  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  v = '[1.3]';
  //[1.3] Control de almacen en las queries cuando no es almacen 1. Ubics entrada calculadas por db.
  //[1.2] Control de id_articulo cuando la referencia existe para diferentes artículos.
  //[1.1] Subir escaneo alb ent a Amazon
  //[1.0.2]

implementation

uses u_globals, ubuscapro, u_alm_aux, u_gen_gl, u_webcam, u_lotes, u_dm,
     u_LogoCli, u_functions;

var
  RestReq: TRestRequest;
  RestResp: THttpResponse;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_main.FormCreate(Sender: TObject);
begin
  if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

  u_globals.password:=ParamStr(1);                            //El password llega como primer parametro

  u_globals.leer_ini;                                         //carga ini

  sk_manager.SkinDirectory:=u_globals.resdir+'Skins\';     //Activa el skin
  sk_manager.SkinName:=u_globals.skinname;
  sk_manager.Active:=true;

  u_globals.ini_bd;                                          //inicializa acceso a datos

  sk_manager.HueOffset:=u_globals.hue;                       //aplica colores a la piel
  sk_manager.Saturation:=u_globals.saturation;
                                                             //si no tiene posicion por defecto
  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;
  {if u_globals.w<0 then u_globals.w:=Width;
  if u_globals.h<0 then u_globals.h:=height;   }

  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y;
 { Width:=u_globals.w;
  Height:=u_globals.h;   }

  caption:=u_globals.hint+' - '+u_globals.usuario+' ('+u_globals.permiso+')'+' - '+u_globals.empresa + ' ' + v;

  if u_globals.cent_lect>1 then begin
    ed_alm.ReadOnly:=true;
    sb_as_alm.Enabled:=false;
  end;
  ed_alm.Text:=IntToStr(u_globals.id_almacen_def);
  e_lote.Text:='1';
  e_loteExit(self);

  dm.q_stock_ubic.Close;
  dm.q_stock_ubic.ParamByName('id_almacen').AsInteger:=u_globals.id_almacen_def;
  dm.q_stock_ubic.Open;

  lbCon.Caption := u_globals.dbname;

  api := GetConexion(api);

  if u_globals.cent_lect>1 then begin
    dm.q_stock.Close;
    dm.q_stock.SelectSQL.Clear;
    dm.q_stock.SelectSQL.Add('SELECT ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA '+
      ' FROM A_STOCK '+
      ' where id_ubicacion='+inttostr(f_main.ubic_entrada(u_globals.id_almacen_def))+
      ' order by id_matricula');
    dm.q_stock.Open;
  end else begin
    dm.q_stock.Close;
    dm.q_stock.SelectSQL.Clear;
    dm.q_stock.SelectSQL.Add('SELECT ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA '+
      'FROM A_STOCK '+
      'where id_ubicacion in (select distinct ubic_entrada from a_almacenes where ubic_entrada is not null) '+
      'order by id_matricula');
    dm.q_stock.Open;
  end;

  dm.q_stock_ubic.Close;
  dm.q_stock_ubic.ParamByName('id_art').AsInteger := 1;
  dm.q_stock_ubic.ParamByName('todo').AsInteger := 1;
  dm.q_stock_ubic.Open;

  dm.q_lotes_filter.Close;
  dm.q_lotes_filter.SelectSQL.Clear;
  dm.q_lotes_filter.SelectSQL.Add(
      'SELECT * '+
      'FROM A_LOTES WHERE ESTADO=''A''');
  dm.q_lotes_filter.Open;

  ed_almExit(self);
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                        //guardar tamaño (si procede)
  u_globals.h:=Height; }
  u_globals.guardar_pos;
end;

procedure Tf_main.FormShow(Sender: TObject);
begin
  //e_mat.SetFocus;

  frm_width := Width;

  e_art_entra.setfocus;
end;

procedure Tf_main.gb_2DblClick(Sender: TObject);
begin
   if HiWord(GetKeyState(VK_CONTROL)) <> 0 then
    bt1.Visible := not bt1.Visible;
end;

procedure Tf_main.sSkinProvider1TitleButtons0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  application.terminate;                     //cerrar
end;

procedure Tf_main.sSkinProvider1TitleButtons1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Application.Minimize;               //minimizar
end;


{$ENDREGION}

{$REGION 'Busquedas-Edits}
procedure Tf_main.sb_as_almClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_almacen,nombre';
    titulos.commatext:='Id,Nombre';
    from:='a_almacenes';
    where:='';
    group:='';
    orden[1]:=1;  busca:=1;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_alm.text:=valor[1];
      lb_alm.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_main.sb_as_art_entraClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_articulo,codigo,codigo_cli,nombre';
    titulos.commatext:='Id,Referencia,CodCli,Articulo';
    from:='g_articulos';
    where:='';
    group:='';
    orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      id_articulo := StrToInt(valor[1]);
      e_art_entra.text:=valor[2];
      lb_articulo.Caption:=valor[4];
    end;
  end;

  e_uds.SetFocus;
end;

procedure Tf_main.sb_as_loteClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_lote,nombre,caducidad';
    titulos.commatext:='Id,Nombre,Caducidad';
    from:='a_lotes';
    where:='';
    group:='';
    orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      e_lote.text:=valor[1];
      lb_lote.Caption:=valor[2] + formatdatetime('dd.mm.yyyy', VarToDateTime(valor[3]));
    end;
  end;
end;

procedure Tf_main.bt1Click(Sender: TObject);
  var RestReq: TRestRequest;
    RestResp: THttpResponse;
    putParams: TStringList;

    HTTP: TIdHTTP;
    RequestBody: TStream;
  ResponseBody, url: string;
  id:integer;

begin

  SubeLogo('\\seth\SysFiles\AlbsEntrada\437120.jpg','','articulos','image/jpeg',id,url);
    ActualizaAttachmentMat(id,437120);



 { try
    HTTP := TIdHTTP.Create;
    RestReq := nil;                                  try

      try
        RequestBody := TStringStream.Create(nil);
        try
          HTTP.Request.Accept := 'application/json';
          HTTP.Request.ContentType := 'application/json';

          ResponseBody := HTTP.Get('https://servertest.loginser.com:5443/loginser-bak/api/articulo?cliente-id=5100');

        finally
          RequestBody.Free;
        end;
      finally
        RequestBody.Free;
      end;

      putParams := TStringList.Create();
      putParams.Add('cliente-id=5100');
      //putParams.Add('path=ruta_scan');
      RestReq := TRestRequest.Create;
      //RestReq.Domain('servertest.loginser.com:5443/loginser-bak/api/articulo');
      RestReq.Domain('jsonplaceholder.typicode.com');
      RestReq.Path('todos');
      RestReq.Path('1');
      //RestReq.WithCredentials('admin@belike.com','password');
      //RestReq.Param('cliente-id','5100');
      //RestReq := TRestRequest.Create().Domain('https://servertest.loginser.com:5443/loginser-bak/api/articulo?cliente-id=5100').WithCredentials('admin@belike.com','password');
      //ShowMessage(RestReq.FullUrl);

      RestResp := RestReq.Get();
      if RestResp.ResponseCode = 201 then ShowMessage('Your todo was added!') else ShowMessage('Failed to add your todo.');
       showmessage(RestResp.ResponseStr);
    finally
      RestReq.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;  }
end;

procedure Tf_main.btDelAllClick(Sender: TObject);
begin
  //ngImei.ClearRows;

end;

procedure Tf_main.btDelImeiClick(Sender: TObject);
begin
  if ngImei.SelectedRow>=0 then
      ngImei.DeleteRow(ngImei.SelectedRow);

  lbImei.Caption := IntToStr(ngImei.RowCount) + '/' + e_uds.Text;
  edImei.Enabled := HabilitaImei;
  btDelImei.Enabled := HabilitaDelImei;

end;

procedure Tf_main.btIMEIClick(Sender: TObject);
begin
  dm.t_write.StartTransaction;
    try
      with TpFIBQuery.Create(dm) do
      try                                                            //actualiza ruta scaneo
        database:=dm.db;
        Transaction:=dm.t_write;
        sql.add('update g_articulos set tiene_imei=:tiene_imei where id_articulo=:id_articulo');
        ParamByName('id_articulo').AsInteger:=u_alm_aux.busca_art_id(e_art_entra.text);
        ParamByName('tiene_imei').asinteger:=1;

        ExecQuery;
      finally
        free;
      end;
    except
      dm.t_write.Rollback;
      raise exception.Create('Error Actualizando');
    end;
    dm.t_write.Commit;

    btIMEI.Visible := False;
    VaciaImei;
    Width := frm_width + 366;
    gbImei.Enabled := True;
    btIMEI.Visible := False;
end;

function Tf_main.HabilitaImei:Boolean;
begin
  result := (StrToInt(e_uds.Text) > ngImei.RowCount);
end;

function Tf_main.HabilitaDelImei:Boolean;
begin
  result := (ngImei.RowCount>0);
end;

procedure Tf_main.bt_busca_ubicClick(Sender: TObject);          //Buscar ubicacion
var id_alm,id_art:Integer;
begin
  id_alm:=dm.q_stock.FieldByName('id_almacen').asinteger;
  id_art:=dm.q_stock.FieldByName('id_articulo').AsInteger;
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='u.id_estanteria,u.id_posicion,u.id_altura,u.id_sub1,sum(a.cantidad)';
    titulos.commatext:='Estanteria,Posicion,Altura,Sub,Unidades';
    from:='a_stock a '+
      'inner join a_ubicaciones u on (a.id_ubicacion=u.id_ubicacion)';
    where:='a.id_articulo='+inttostr(id_art)+' and u.id_almacen='+inttostr(id_alm)+' and u.id_ubicacion<>'+inttostr(ubic_entrada(id_alm));
    group:='1,2,3,4';
    orden[1]:=1;  busca:=1;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      e_estanteria.text:=valor[1];
      e_posicion.text:=valor[2];
      e_altura.text:=valor[3];
      e_sub.Text:=valor[4];
    end;
  end;
end;

procedure Tf_main.edImeiKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
begin

  if key=Char(13) then
  begin
     if edImei.Text<>'' then
     begin
        if Length(edImei.Text)<>15 then
            raise Exception.Create('Longitud incorrecta.');

         with tpfibdataset.Create(dm) do begin
            database:=dm.db;
            SQLs.SelectSQL.Clear;
            SQLs.SelectSQL.Add('SELECT * FROM A_IMEIS WHERE IMEI=:imei ');
            Params.ParamByName('imei').asString := edImei.Text;
            Open;

            if not IsEmpty then
            begin
               If EsOtroArticulo(edImei.Text) then
               begin
                  ShowMessage('IMEI insertado para otro artículo anteriormente.');
                  edImei.SelectAll;
                  Exit;
               end;

               If not TieneSalida(edImei.Text) then
               begin
                  ShowMessage('IMEI insertado en una matrícula anterior.');
                  edImei.SelectAll;
                  Exit;
               end;
            end;
            Free;
         end;

         for I := 0 to ngImei.RowCount-1 do
            if ngImei.cell[0,i].AsString = edImei.Text then
                  raise Exception.Create('IMEI ya pistoleado.');

         lbImei.Caption := '';

         ngImei.AddRow(1);
         ngImei.cell[0,ngImei.rowCount-1].AsString := edImei.Text;

         lbImei.Caption := IntToStr(ngImei.RowCount) + '/' + e_uds.Text;

         edImei.Text := '';

         edImei.Enabled := HabilitaImei;
         btDelImei.Enabled := HabilitaDelImei;

     end;
  end;
end;

function Tf_main.TieneSalida(imei:string):Boolean;
var
  f_ultima_matricula: tdatetime;
begin
  with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT max(m.fecha) as fecha FROM A_MATRICULAS M ' +
                         'INNER JOIN A_IMEIS I ON I.ID_MATRICULA=M.ID_MATRICULA ' +
                         'WHERE I.IMEI=:imei');
      Params.ParamByName('imei').asString := imei;
      Open;

      f_ultima_matricula := FieldByName('fecha').AsDateTime;

      Free;
   end;

   with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT * FROM C_PEDIDOS_LINES L ' +
                         'INNER JOIN C_PEDIDOS P ON P.ID_PEDIDO=L.ID_PEDIDO ' +
                         'WHERE L.IMEI=:imei AND P.FECHA_GEN<=CURRENT_TIMESTAMP ' +
                         'AND P.FECHA_GEN>=:f_ult_matricula AND P.ESTADO=:estado');
      Params.ParamByName('imei').asString := imei;
      Params.ParamByName('f_ult_matricula').AsDateTime := f_ultima_matricula;
      Params.ParamByName('estado').asString := 'G';

      Open;

      Result := not IsEmpty;

      Free;
   end;
end;

function Tf_main.EsOtroArticulo(imei:string):Boolean;
var
  f_ultima_matricula: tdatetime;
begin
  with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT * FROM A_MATRICULAS M ' +
                         'INNER JOIN A_IMEIS I ON I.ID_MATRICULA=M.ID_MATRICULA ' +
                         'INNER JOIN G_ARTICULOS A ON A.ID_ARTICULO=M.ID_ARTICULO ' +
                         'WHERE I.IMEI=:imei and m.id_articulo<>:id_articulo');
      Params.ParamByName('imei').asString := imei;
      Params.ParamByName('id_articulo').AsInteger := u_alm_aux.busca_art_id(e_art_entra.text);
      Open;

      result := not IsEmpty;

      Free;
   end;
end;

procedure Tf_main.ed_almExit(Sender: TObject);
begin
  lb_alm.Caption:=u_alm_aux.busca_alm(StrToInt(ed_alm.text));
end;

procedure Tf_main.e_art_entraExit(Sender: TObject);
var
  id_art: Integer;
begin
  if (id_articulo=busca_art_id(e_art_entra.text)) then
      exit;

  If (u_alm_aux.cuenta_refs_x_codigo(e_art_entra.text)>1) then
  begin

    with fbuscapro do begin
      limpia_fields;     multiselect:=false;    livekey:=false;
      fields.commatext:='id_articulo,codigo,codigo_cli,nombre';
      titulos.commatext:='Id,Referencia,CodCli,Articulo';
      from:='g_articulos';
      where:='codigo='+quotedStr(e_art_entra.Text);
      group:='';
      orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;
      showmodal;

      if resultado then begin
        id_articulo := StrToInt(valor[1]);
        e_art_entra.text:=valor[2];
        lb_articulo.Caption:=valor[4];
      end;
    end;

    e_uds.SetFocus;
  end else
      begin
        id_articulo := u_alm_aux.busca_art_id(e_art_entra.Text);
        lb_articulo.Caption:=u_alm_aux.busca_art_nom(e_art_entra.text);
      end;

  if e_art_entra.Text<>'' then
  begin
    id_art:=u_alm_aux.busca_art_id(e_art_entra.text);
    if id_art=0 then raise Exception.Create('Artículo No Existe En El Sistema');

    if tiene_imei(id_art) then
    begin
          Width := frm_width + 366;
          gbImei.Enabled := True;
          btIMEI.Visible := False;
    end
    else begin
          Width := frm_width;
          gbImei.Enabled := False;
          btIMEI.Visible := True;
    end;
  end;

  dm.q_stock_ubic.Close;
  if chFiltrarArt.Checked then
  begin
    dm.q_stock_ubic.ParamByName('id_art').AsInteger := id_articulo;
    dm.q_stock_ubic.ParamByName('todo').AsInteger := 0;
  end else  begin
              dm.q_stock_ubic.ParamByName('id_art').AsInteger := 0;
              dm.q_stock_ubic.ParamByName('todo').AsInteger := 1;
            end;
  dm.q_stock_ubic.Open;

  if ngImei.RowCount>0 then
      if smessagedlg('Existen IMEIs pistoleados, ¿desea borrarlos?',mtConfirmation,[mbyes,mbno],0)=mryes then
        VaciaImei;
end;

procedure Tf_main.VaciaImei;
begin
    edImei.Text := '';
    //ngImei.ClearRows;
    lbImei.Caption := IntToStr(ngImei.RowCount) + '/' + e_uds.Text;
    dtpCaducidad.Date := Now + 180;
    edImei.Enabled := HabilitaImei;

end;

procedure Tf_main.e_loteExit(Sender: TObject);
begin
  lb_lote.Caption:=u_alm_aux.busca_lote_nom(StrToInt(e_lote.text));
end;
{$ENDREGION}

procedure Tf_main.e_udsChange(Sender: TObject);
begin
    if e_uds.Text<>'' then
    begin
          edImei.Enabled := HabilitaImei;
          //if ngImei.RowCount>StrToInt(e_uds.Text) then ngImei.ClearRows;

          lbImei.Caption := IntToStr(ngImei.RowCount) + '/' + e_uds.Text;
    end;
end;

procedure Tf_main.e_udsKeyPress(Sender: TObject; var Key: Char);
begin
    if Key=chr(13) then b_ok_entraClick(self);
end;

procedure Tf_main.b_new_loteClick(Sender: TObject);
begin
  dm.q_lotes.Open;
  f_lotes.ShowModal;
  e_lote.Text := dm.q_lotes.FieldByName('id_lote').AsString;
  e_loteExit(self);
end;

procedure Tf_main.b_nuevaClick(Sender: TObject);               //nueva matricula
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE');
    Open;

    lb_mat.Caption:=IntToStr(FieldByName('gen_id').AsInteger);

    Free;
  end;

  e_uds.Text:='0';
  ed_obs.Text:='';
end;

procedure Tf_main.b_ok_entraClick(Sender: TObject);     //acepta entrada
var id_art,id_alm,id_lote, i:Integer;    tipo,situa,cod_art_cli:string;
begin

  if StrToInt(e_uds.text)>0 then begin

    if lb_mat.Caption = '' then
          raise Exception.Create('No ha creado la matrícula. Pulse Nueva Matricula');

    //id_art:=u_alm_aux.busca_art_id(e_art_entra.text);
    id_art := id_articulo;

    if id_art<=0 then raise Exception.Create('Artículo No Existe En El Sistema');

    if (tiene_imei(id_art) and (StrToInt(e_uds.Text)>ngImei.RowCount)) then
          raise Exception.Create('Faltan Códigos IMEI por introducir.');

    with tpfibdataset.Create(dm) do begin                          //ya se ha dado de entrada antes en el nuevo sistema
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * from a_stock where id_matricula='+lb_mat.Caption);
      Open;
      if not(IsEmpty) then raise exception.Create('Matrícula Ya Existe En Sistema');

      Free;
    end;

    id_alm:=strtoint(ed_alm.Text);
    if (busca_alm(id_alm)='ERR') then raise Exception.Create('Almacén No Existe En El Sistema');

    id_lote:=strtoint(e_lote.Text);
    if (busca_lote_nom(id_lote)='ERR') then raise Exception.Create('Lote No Existe En El Sistema');

    if (u_alm_aux.tiene_lote(id_art) and (id_lote=1)) then raise Exception.Create('Artículo Necesita Lote');

    dm.t_write.StartTransaction;
    try
      with TpFIBQuery.Create(dm) do
      try
        database:=dm.db;
        Transaction:=dm.t_write;

        sql.Clear;
        sql.Add('insert into a_stock (id_almacen,id_ubicacion,id_articulo,id_matricula,id_lote,cantidad,id_empresa) '+
          ' values (:id_almacen,:id_ubicacion,:id_articulo,:id_matricula,:id_lote,:cantidad,:id_empresa)');

        ParamByName('id_almacen').AsInteger:=id_alm;
        ParamByName('id_ubicacion').AsInteger:=ubic_entrada(id_alm);          //W-1-1 en alm
        ParamByName('id_articulo').AsInteger:=id_art;
        ParamByName('id_matricula').AsInteger:=StrToInt(lb_mat.Caption);
        ParamByName('id_lote').AsInteger:=id_lote;
        ParamByName('cantidad').AsInteger:=StrToInt(e_uds.text);
        ParamByName('id_empresa').AsInteger:=u_globals.id_empresa;

        ExecQuery;

        tipo:='E';
        if cb_tipo.ItemIndex=0 then tipo:='E';
        if cb_tipo.ItemIndex=1 then tipo:='R';
        if cb_tipo.ItemIndex=2 then tipo:='O';

        situa:='O';
        if cb_situ.ItemIndex=0 then situa:='O';
        if cb_situ.ItemIndex=1 then situa:='R';
        if cb_situ.ItemIndex=2 then situa:='B';

        sql.Clear;
        sql.Add('insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,situacion,observaciones,id_almacen, id_lote) '+
          ' values (:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:situacion,:observaciones,:id_almacen, :id_lote)');
        ParamByName('id_matricula').AsInteger:=StrToInt(lb_mat.Caption);
        ParamByName('id_articulo').AsInteger:=id_art;
        ParamByName('uds_ini').AsInteger:=StrToInt(e_uds.text);
        ParamByName('tipo').asstring:=tipo;
        ParamByName('alb_cliente').asstring:=ed_pc.text;
        ParamByName('situacion').AsString:=situa;
        ParamByName('observaciones').AsString:=ed_obs.Text;
        ParamByName('id_almacen').asinteger:=StrToInt(ed_alm.Text);
        ParamByName('id_lote').AsInteger:=StrToInt(e_lote.text);

        ExecQuery;

        sql.Clear;
        sql.Add('insert into a_imeis(imei,id_matricula,caducidad) '+
          ' values (:imei,:id_matricula,:caducidad)');

        for i := 0 to ngImei.RowCount-1 do
        begin
          ParamByName('imei').AsString := ngImei.Cell[0,i].AsString;
          ParamByName('caducidad').AsDate := dtpCaducidad.Date;
          ParamByName('id_matricula').AsInteger:=StrToInt(lb_mat.Caption);
          ExecQuery;
        end;

      finally
        free;
      end;

      if ((busca_art_cli(id_art)=7004) and             //Es artículo del 7004 Bankia
          ((tipo='E') or (tipo='R')) and               //Entrada o Recogida
          (situa='O') and                              //Esta OK (No Roturas)
          (id_alm=1))                                  //En Almacen 1 (Principal Valencia)
      then begin                                       //Gestionar reposiciones para SLA

        cod_art_cli:=busca_art_cod_cli(id_art);        //codigo articulo bankia
        if (cod_art_cli='ERR') then raise exception.Create('Codígo Bankia No Encontrado');

        with TpFIBQuery.Create(dm) do
        try
          database:=dm.db;
          Transaction:=dm.t_write;

          sql.Clear;
          sql.Add('update c_pedidos_bankia set fecha_repo=:fecha_repo, id_matricula_repo=:id_matricula_repo '+
            'where fecha_repo is null and cod_art=:cod_art and '+
            'not((cp_ent between 35000 and 35999) or (cp_ent between 38000 and 38999)) '+
            'order by fecha_imp asc '+
            'rows '+e_uds.text);
          ParamByName('fecha_repo').asdatetime:=now;
          ParamByName('id_matricula_repo').AsInteger:=StrToInt(lb_mat.Caption);
          ParamByName('cod_art').Asstring:=cod_art_cli;

          ExecQuery;
        finally
          free;
        end;
      end;

    except
      dm.t_write.Rollback;
      sMessageDlg('Operación No Completada',mtError,[mbok],0);
    end;
    dm.t_write.Commit;

    dm.q_stock.Close;
    dm.q_stock.Open;

    dm.q_stock.Locate('id_matricula',strtoint(lb_mat.Caption),[]);

    if smessagedlg('Imprimir Etiqueta Para Matrícula '+lb_mat.Caption+' ?',mtConfirmation,[mbyes,mbno],0)=mryes then
      imprime_matricula(StrToInt(lb_mat.Caption));

    if sMessageDlg('Scanear Albaran',mtWarning,[mbYes,mbno],0)=mryes then b__scanClick(self);

  end else raise Exception.Create('Cantidad Inválida');
end;

procedure Tf_main.b_ubicaClick(Sender: TObject);             //ubicar matrícula
var id_ubic,id_alm,id_mat:integer;
begin
  id_alm:=dm.q_stock.FieldByName('id_almacen').asinteger;
  id_ubic:=u_alm_aux.busca_ubic(id_alm,0,e_estanteria.Text,StrToInt(e_posicion.text),StrToInt(e_altura.text),e_sub.text,'0');
  id_mat:=dm.q_stock.FieldByName('id_matricula').asinteger;
  if id_ubic<>-1 then begin
    if not(dm.q_stock.isempty) then begin
      dm.t_write.StartTransaction;
      try
        with TpFIBQuery.Create(dm) do
        try                                                            //actualiza unidades en rumbo
          database:=dm.db;
          Transaction:=dm.t_write;
          sql.add('update a_stock set id_ubicacion=:id_ubicacion where id_matricula=:id_matricula');
          ParamByName('id_ubicacion').AsInteger:=id_ubic;
          ParamByName('id_matricula').asinteger:=id_mat;

          ExecQuery;
        finally
          free;
        end;
      except
        dm.t_write.Rollback;
        raise exception.Create('Error En El Proceso');
      end;
      dm.t_write.Commit;
      dm.q_stock.Close;
      dm.q_stock.Open;
      dm.q_stock_ubic.Close;
      dm.q_stock_ubic.Open;

      if smessagedlg('Imprimir Etiqueta Para Matrícula '+inttostr(id_mat)+' ?',mtConfirmation,[mbyes,mbno],0)=mryes then
      imprime_matricula(id_mat);
    end;
  end else raise exception.Create('Ubicación No Encontrada');
end;

procedure Tf_main.sb_eliminarClick(Sender: TObject);    //Eliminar matricula
begin
  if not(dm.q_stock.isempty) then begin
    if sMessageDlg('¿Borrar La Matrícula '+dm.q_stock.FieldByName('id_matricula').asstring+'?',mtConfirmation,[mbYes,mbno],0)=mryes then
    begin

      dm.t_write.StartTransaction;
      try
        with TpFIBQuery.Create(dm) do
        try
          database:=dm.db;
          Transaction:=dm.t_write;
          sql.Clear;
          sql.add('update c_pedidos_bankia set fecha_repo = null, id_matricula_repo = null where id_matricula_repo=:id_matricula');
          ParamByName('id_matricula').asinteger:=dm.q_stock.FieldByName('id_matricula').asinteger;

          ExecQuery;
        finally
          free;
        end;

        with TpFIBQuery.Create(dm) do
        try
          database:=dm.db;
          Transaction:=dm.t_write;
          sql.Clear;
          sql.add('delete from a_stock where id_matricula=:id_matricula');
          ParamByName('id_matricula').asinteger:=dm.q_stock.FieldByName('id_matricula').asinteger;

          ExecQuery;
        finally
          free;
        end;

        with tpfibdataset.Create(dm) do begin
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select ruta_scan,ruta_foto from a_matriculas where id_matricula=:id_matricula');
          ParamByName('id_matricula').asinteger:=dm.q_stock.FieldByName('id_matricula').asinteger;
          Open;

          if FileExists(FieldByName('ruta_scan').asstring) then DeleteFile(FieldByName('ruta_scan').asstring);
          if FileExists(FieldByName('ruta_foto').asstring) then DeleteFile(FieldByName('ruta_foto').asstring);

          Free;
        end;

        with TpFIBQuery.Create(dm) do
        try
          database:=dm.db;
          Transaction:=dm.t_write;
          sql.Clear;
          sql.add('delete from a_matriculas where id_matricula=:id_matricula');
          ParamByName('id_matricula').asinteger:=dm.q_stock.FieldByName('id_matricula').asinteger;

          ExecQuery;
        finally
          free;
        end;
      except
        dm.t_write.Rollback;
        raise exception.Create('Error En El Proceso');
      end;
      dm.t_write.Commit;
      dm.q_stock.Close;
      dm.q_stock.Open;
      dm.q_stock_ubic.Close;
      dm.q_stock_ubic.Open;
    end;
  end;
end;

procedure Tf_main.b_impClick(Sender: TObject);      //Imprime Matricula
var i:integer;
begin
  if (ed_mat1.Text=ed_mat2.text) then imprime_matricula(dm.q_stock.FieldByName('id_matricula').asinteger)
  else  for i:=StrToInt(ed_mat1.text) to strtoint(ed_mat2.Text) do  imprime_matricula(i);
end;

procedure Tf_main.b_imp_ubicClick(Sender: TObject);
begin
  imprime_matricula(dm.q_stock_ubic.FieldByName('id_matricula').asinteger);
end;

procedure Tf_main.imprime_matricula(id_mat:integer);
const cr=Chr(13);   lr=Chr(10);
var    f:textfile;    ref_art,nom_art,alb_cli,s, lote:string;    id_ubic,ctdad:Integer;
begin                                       //Imprime Matricula
  with TpFIBDataSet.Create(dm) do
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sqls.SelectSQL.Clear;
    sqls.SelectSQL.add('select a.codigo,a.nombre,s.id_ubicacion,s.cantidad,l.id_lote, l.nombre as lote, l.caducidad '+
      'from a_stock s '+
      'inner join g_articulos a on (a.id_articulo=s.id_articulo) '+
      'inner join a_lotes l on (l.id_lote=s.id_lote) '+
      'where s.id_matricula=:id_matricula');
    ParamByName('id_matricula').asinteger:=id_mat;
    open;

    if not(isempty) then begin
      ref_art:=FieldByName('codigo').AsString;
      nom_art:=FieldByName('nombre').AsString;
      id_ubic:=FieldByName('id_ubicacion').AsInteger;
      ctdad:=FieldByName('cantidad').AsInteger;
      if FieldByName('id_lote').AsInteger>1 then
          lote:= FieldByName('lote').AsString + ' ' + FormatDateTime('dd/mm/yy',FieldByName('caducidad').AsDateTime)
      else
          lote := '';
    end else begin
      ref_art:='';
      nom_art:='';
      id_ubic:=0;
      ctdad:=0;
      lote :='';
    end;
  finally
    free;
  end;

  with TpFIBDataSet.Create(dm) do
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sqls.SelectSQL.Clear;
    sqls.SelectSQL.add('select alb_cliente from a_matriculas where id_matricula=:id_matricula');
    ParamByName('id_matricula').asinteger:=id_mat;
    open;

    if not(isempty) then alb_cli:=FieldByName('alb_cliente').AsString
    else alb_cli:='';
  finally
    free;
  end;

  //ZEBRA
 s:='';
  s:=s+'^XA'+cr+lr;           //start document
  s:=s+'^PW1000'+cr+lr;        //printer width
  s:=s+'^CI27'+cr+lr;         // Cambia el banco de caracteres a un banco con tildes y letras Ñ ñ
  s:=s+'^FO250,300^BY3';
  s:=s+'^B2N,220,Y,N,N ^FD'+formatfloat('000000000000',id_mat)+'^FS';
  s:=s+'^FO50,600 ^A0N,60,80^FDMATRICULA - '+inttostr(id_mat)+'^FS'+cr+lr;
  s:=s+'^FO50,680 ^A0N,60,80^FDART '+ref_art+'^FS'+cr+lr;
  s:=s+'^FO50,760 ^A0N,50,60^FD'+nom_art+'^FS'+cr+lr;
  s:=s+'^FO50,900 ^A0N,30,30^FDFecha - '+formatdatetime('dd/mm/yy',date)+'^FS'+cr+lr;
  s:=s+'^FO50,940 ^A0N,50,60^FDUbic - '+format_ubic_id(id_ubic)+'^FS'+cr+lr;
  s:=s+'^FO50,1000 ^A0N,50,60^FDUds - '+inttostr(ctdad)+'^FS'+cr+lr;
  s:=s+'^FO50,1060 ^A0N,50,60^FDAlbCli - '+alb_cli+'^FS'+cr+lr;
  if lote<>'' then
      s:=s+'^FO50,1120 ^A0N,50,60^FDLote - '+lote+'^FS'+cr+lr;

  s:=s+'^XZ'+cr+lr;

  WriteRawDataToPrinter(imp_eti,s);
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

procedure Tf_main.b_1Click(Sender: TObject);
begin                                           //Informe de matriculas ya ubicadas
  dm.q_rep.Close;
  dm.q_rep.SQLs.SelectSQL.Clear;
  dm.q_rep.SQLs.SelectSQL.Add('select s.id_matricula,a.codigo,a.nombre,u.id_estanteria,u.id_posicion,u.id_altura,s.cantidad '+
    'from a_stock s '+
    'left outer join a_ubicaciones u on (u.id_ubicacion=s.id_ubicacion) '+
    'left outer join g_articulos a on (a.id_articulo=s.id_articulo) '+
    'where s.id_ubicacion not in (' + inttostr(ubic_entrada(id_almacen_def)) + ') '+

    'order by u.id_estanteria,u.id_posicion,u.id_altura');
  dm.q_rep.Open;

  if rep_alm.prepareReport(true) then rep_alm.ShowPreparedReport;
end;

procedure Tf_main.b_2Click(Sender: TObject);
begin                                           //Informe de matriculas pendientes de ubicar
  dm.q_rep.Close;
  dm.q_rep.SQLs.SelectSQL.Clear;
  dm.q_rep.SQLs.SelectSQL.Add('select s.id_matricula,a.codigo,a.nombre,u.id_estanteria,u.id_posicion,u.id_altura,s.cantidad '+
    'from a_stock s '+
    'left outer join a_ubicaciones u on (u.id_ubicacion=s.id_ubicacion) '+
    'left outer join g_articulos a on (a.id_articulo=s.id_articulo) '+
    'where s.id_ubicacion in (' + inttostr(ubic_entrada(id_almacen_def)) + ') '+
    'order by s.id_matricula');
  dm.q_rep.Open;

  if rep_alm2.prepareReport(true) then rep_alm2.ShowPreparedReport;
end;

procedure Tf_main.b__scanClick(Sender: TObject);
var
    ruta, url:string;
    id: Integer;
begin                                               //Scanea alb entrada
  if not(dm.q_stock.isempty) then begin
    sc_io.TWainParams.SelectedSource:=u_globals.scanner_id;
    sc_io.TWainParams.AppVersionInfo:='1.0';
    sc_io.TWainParams.AppManufacturer:='LGS';
    sc_io.TWainParams.AppProductFamily:='LGS App';
    sc_io.TWainParams.AppProductName:='Entrada Almacen';

    sc_io.TWainParams.VisibleDialog:=false;                               //Dialogo del scanner
    sc_io.TWainParams.ProgressIndicators:=true;                           //Progreso del scanner
    sc_io.TWainParams.AcquireFrameEnabled:=false;                         //Scanear Marco
    sc_io.TWainParams.PixelType.CurrentValue:=2;                          //RGB
    sc_io.TWainParams.YResolution.CurrentValue:=75;                      //DPI Vertical
    sc_io.TWainParams.XResolution.CurrentValue:=75;                      //DPI Horizontal
    sc_io.TWainParams.BufferedTransfer:=true;                             //Buffered Transfer

    try
      //sc_io.Acquire(ieaTWain);
      sc_io.Acquire();

      u_gen_gl.lee_inis_def;
      ruta:=u_gen_gl.sys_path+'\AlbsEntrada\'+dm.q_stock.FieldByName('id_matricula').asstring+'.jpg';
      sc_io.SaveToFileJpeg(ruta);
    except
      raise Exception.Create('Error Scaneando Albarán De Entrada');
    end;

    dm.t_write.StartTransaction;
    try
      with TpFIBQuery.Create(dm) do
      try                                                            //actualiza ruta scaneo
        database:=dm.db;
        Transaction:=dm.t_write;
        sql.add('update a_matriculas set ruta_scan=:ruta_scan where id_matricula=:id_matricula');
        ParamByName('ruta_scan').Asstring:=ruta;
        ParamByName('id_matricula').asinteger:=dm.q_stock.FieldByName('id_matricula').asinteger;

        ExecQuery;
      finally
        free;
      end;
    except
      dm.t_write.Rollback;
      raise exception.Create('Error Actualizando');
    end;
    dm.t_write.Commit;

    SubeLogo(ruta,'','matriculas','image/jpeg',id,url);
    ActualizaAttachmentMat(id,dm.q_stock.FieldByName('id_matricula').asinteger);

    sMessageDlg('Albarán De Entrada Scaneado Correctamente',mtInformation,[mbok],0);
  end;

end;


procedure Tf_main.chFiltrarArtClick(Sender: TObject);
begin
  if chFiltrarArt.Checked then
  begin
    dm.q_stock_ubic.Close;
    dm.q_stock_ubic.ParamByName('id_art').AsInteger := id_articulo;
    dm.q_stock_ubic.ParamByName('todo').AsInteger := 0;
    dm.q_stock_ubic.Open;
  end else  begin
              dm.q_stock_ubic.Close;
              dm.q_stock_ubic.ParamByName('id_art').AsInteger := 0;
              dm.q_stock_ubic.ParamByName('todo').AsInteger := 1;
              dm.q_stock_ubic.Open;
            end;
end;

function Tf_main.ActualizaAttachmentMat(attach, mat:Integer):string;
begin
   with TpFIBQuery.Create(dm) do begin

     dm.t_write.StartTransaction;
     try
      database:=dm.db;
      Transaction := dm.t_write;
      sql.Clear;
      sql.add('update a_matriculas set attachment_id=:attach ' +
              ' where id_matricula=:mat ');
      ParamByName('attach').asinteger := attach;
      ParamByName('mat').asinteger := mat;

      ExecQuery;
      dm.t_write.Commit;
     except on E:Exception do
            begin
             dm.t_write.Rollback;
             result := e.Message;
             raise;
            end;
     end;
   end;
end;


procedure Tf_main.e_eanKeyPress(Sender: TObject; var Key: Char);       //EAN
var tot:integer;
begin
  if Key=chr(13) then begin
    with TpFIBDataSet.Create(dm) do
    try
      database:=dm.db;
      Transaction:=dm.t_write;
      sqls.SelectSQL.Clear;
      sqls.SelectSQL.add('select count(*) as tot '+
        'from g_articulos_bc b '+
        'where b.bc=:ean');
      ParamByName('ean').asstring:=e_ean.text;

      open;

      if not(isempty) then tot:=FieldByName('tot').asinteger
      else tot:=0;
    finally
      free;
    end;

    if (tot>0) then begin                    //Hay EANS
      if (tot>1) then begin                            //Hay más de un EAN
        with fbuscapro do begin
          limpia_fields;     multiselect:=false;    livekey:=false;
          fields.commatext:='a.id_articulo,a.codigo,a.codigo_cli,a.nombre';
          titulos.commatext:='Id,Referencia,CodCli,Articulo';
          from:='g_articulos_bc b '+
            'inner join g_articulos a on (b.id_articulo=a.id_articulo) ';
          where:='b.bc='+quotedstr(e_ean.Text);
          group:='';
          orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

          showmodal;

          if resultado then begin
            id_articulo := StrToInt(valor[1]);
            e_art_entra.text:=valor[2];
            lb_articulo.Caption:=valor[4];
          end;
        end;
      end else begin                                //Hay solo un EAN
        with TpFIBDataSet.Create(dm) do
        try
          database:=dm.db;
          Transaction:=dm.t_write;
          sqls.SelectSQL.Clear;
          sqls.SelectSQL.add('select a.id_articulo, a.codigo,a.nombre '+
            'from g_articulos_bc b '+
            'inner join g_articulos a on (b.id_articulo=a.id_articulo) '+
            'where b.bc=:ean');
          ParamByName('ean').asstring:=e_ean.text;

          open;

          if not(isempty) then begin
            id_articulo := FieldByName('id_articulo').asinteger;
            e_art_entra.Text:=FieldByName('codigo').AsString;
            lb_articulo.Caption:=FieldByName('nombre').AsString;
          end;
        finally
          free;
        end;
      end;
    end else sMessageDlg('EAN No Encontrado',mtError,[mbok],0);     //No EANS
  end;
end;

procedure Tf_main.sb_fotoClick(Sender: TObject);
var  ruta:string;     jp:tjpegimage;
begin                                               //Foto Art Entrada
  if not(dm.q_stock.isempty) then begin
    f_webcam.im_vid.Picture:=nil;
    f_webcam.capturado:=false;
    f_webcam.ShowModal;
    if f_webcam.capturado then begin
      u_gen_gl.lee_inis_def;
      ruta:=u_gen_gl.sys_path+'\FotosEntrada\'+dm.q_stock.FieldByName('id_matricula').asstring+'.jpg';

      jp:=tjpegimage.Create;
      jp.Assign(f_webcam.im_vid.picture.bitmap);
      jp.SaveToFile(ruta);
      jp.Free;

      dm.t_write.StartTransaction;
      try
        with TpFIBQuery.Create(dm) do
        try                                                            //actualiza ruta scaneo
          database:=dm.db;
          Transaction:=dm.t_write;
          sql.add('update a_matriculas set ruta_foto=:ruta_foto where id_matricula=:id_matricula');
          ParamByName('ruta_foto').Asstring:=ruta;
          ParamByName('id_matricula').asinteger:=dm.q_stock.FieldByName('id_matricula').asinteger;

          ExecQuery;
        finally
          free;
        end;
      except
        dm.t_write.Rollback;
        raise exception.Create('Error Actualizando');
      end;
      dm.t_write.Commit;

      sMessageDlg('Foto De Entrada Guardada Correctamente',mtInformation,[mbok],0);
    end;
  end;
end;

function Tf_main.ubic_entrada(id_alm:Integer):Integer;
begin
 { case id_alm of
    1:Result:=361;          //W-1-1 en alm1
    2:result:=3758;          //W-1-1 en alm2
    3:result:=4802;          //W-1-1 en alm2
    4:Result:=3778;          //W-1-1 en alm4
    5:result:=3776;          //W-1-1 en alm5
    6:result:=5532;          //W-1-1 en alm6
    7:result:=9579;          //W-1-1 en alm7
  end;        }

  with tpfibdataset.Create(dm) do begin
            database:=dm.db;
            SQLs.SelectSQL.Clear;
            SQLs.SelectSQL.Add('SELECT ubic_entrada FROM A_almacenes WHERE id_almacen=:id_alm ');
            Params.ParamByName('id_alm').asinteger := id_alm;
            Open;

            if not IsEmpty then
            begin
              result := fieldbyname('ubic_entrada').AsInteger;
            end;
  end;
end;

end.
