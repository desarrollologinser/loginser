unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Buttons, sSkinManager, sSkinProvider,ComCtrls,
  ExtCtrls, sPanel, sDBNavigator, StdCtrls, sLabel, sDBText, sSpeedButton, Mask,
  DBCtrls, sDBEdit, sGroupBox, sDBRadioGroup,db, sBitBtn, Grids, DBGrids,
  acDBGrid, JvExDBGrids, JvDBGrid, sBevel, sEdit,pfibquery, sMaskEdit,
  sCustomComboEdit, sTooledit, sDBDateEdit, JvDBImage,sdialogs,pFIBDataSet,
  Vcl.ExtDlgs,Vcl.Imaging.jpeg, sCheckBox, sDBCheckBox, System.Win.ComObj,
  Vcl.Menus, acImage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, frxClass, frxBarcode,
  dxGDIPlusClasses;

type
  Tf_main = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sk_manager: TsSkinManager;
    dbn_1: TsDBNavigator;
    dbe_nombre: TsDBEdit;
    dbr_estado: TsDBRadioGroup;
    sb_bu_idserv: TsSpeedButton;
    dbe_idart: TsDBEdit;
    dbe_codigo: TsDBEdit;
    sb_bu_ref: TsSpeedButton;
    sb_bu_nombre: TsSpeedButton;
    gb_1: TsGroupBox;
    dbn_2: TsDBNavigator;
    dbe_falta: TsDBDateEdit;
    dbe_fbaja: TsDBDateEdit;
    dbe_kgs: TsDBEdit;
    dbe_kgsvol: TsDBEdit;
    dbe_largo: TsDBEdit;
    dbe_ancho: TsDBEdit;
    dbe_alto: TsDBEdit;
    dbe_uni_emb: TsDBEdit;
    dbe_uni_palet: TsDBEdit;
    dbe_cliente: TsDBEdit;
    bt_ba_cliente: TsSpeedButton;
    dbe_familia: TsDBEdit;
    bt_ba_familia: TsSpeedButton;
    dbe_codigo_cli: TsDBEdit;
    dbe_nom_cli: TsDBEdit;
    dbe_cubic: TsDBEdit;
    dbe_precio: TsDBEdit;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    dblb_cliente: TsDBText;
    dblb_familia: TsDBText;
    bt_clear_image: TsSpeedButton;
    bt_load_image: TsSpeedButton;
    bv_1: TsBevel;
    dbg_ean: TsDBGrid;
    bt_search_ean: TsSpeedButton;
    ed_ean: TsEdit;
    bv_2: TsBevel;
    bv_3: TsBevel;
    bv_4: TsBevel;
    dl_open: TsOpenDialog;
    lb_st: TsLabel;
    dl_open_picture: TsOpenPictureDialog;
    cb_loteTIENE_LOTE: TsDBCheckBox;
    cb_loteTIENE_IMEI: TsDBCheckBox;
    stat: TStatusBar;
    mm1: TMainMenu;
    H1: TMenuItem;
    S1: TMenuItem;
    btn1: TButton;
    sImage1: TsImage;
    ftp_1: TIdFTP;
    edTalla: TsDBEdit;
    sSpeedButton3: TsSpeedButton;
    edIdioma: TsDBEdit;
    sSpeedButton4: TsSpeedButton;
    sDBText1: TsDBText;
    sdbtxtIDIOMA_NOM: TsDBText;
    btImpEan: TsSpeedButton;
    eti_ean: TfrxReport;
    I1: TMenuItem;
    sDBCheckBox1: TsDBCheckBox;
    imgArtDeshabilitado: TImage;
    imgArtHabilitado: TImage;
    img1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sb_bu_idservClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbn_1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure dbr_estadoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbn_2Click(Sender: TObject; Button: TNavigateBtn);
    procedure dbg_1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bt_ba_clienteClick(Sender: TObject);
    procedure bt_ba_familiaClick(Sender: TObject);
    procedure bt_search_eanClick(Sender: TObject);
    procedure bt_clear_imageClick(Sender: TObject);
    procedure bt_load_imageClick(Sender: TObject);
    procedure AbreFichero;
    procedure dbn_1Click(Sender: TObject; Button: TNavigateBtn);
    procedure S1Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure btImpEanClick(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure imgArtHabilitadoContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure imgArtDeshabilitadoDblClick(Sender: TObject);
    procedure imgArtHabilitadoDblClick(Sender: TObject);
    procedure dbe_codigoChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure dbe_idartChange(Sender: TObject);
  private
    { Private declarations }
     procedure BorrarArchivos(Ruta: string);
     function ActualizaAttachmentArt(attach, art:Integer):string;
     procedure ImportarGameStop;
     procedure ImprimeEAN;
     function CrearEAN:string;
     procedure MostrarHabilitado;
     procedure carga_imagen(Sender: TObject);

  public
    { Public declarations }
  end;

var
  f_main: Tf_main;

  xls_1, libro: Variant;
  hoja:OleVariant;

const
  ruta_tmp = 'c:\tmp';

  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

   v = '[2.6]';
   //[2.6] No se carga la imagen del artículo
   //[2.5] 25.05.21 Habilitar/deshabilitar artículo (campo locked)
   //[2.4] Pregunta antes de subir o eliminar imágen a la web.
   //[2.3] tiene_n_serie
   //[2.2] Impresión de EAN. Insertar icono.
   //[2.1] Subida de imágenes a Amazon (individual y todas las pendientes).
   //[2.0] Nuevo proyecto en D10

implementation

uses u_globals, u_dm, ubuscapro, u_alm_aux, u_LogoCli, u_functions, u_gen_gl;

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

  //caption:=u_globals.hint+' - '+u_globals.usuario+' ('+u_globals.permiso+')'+' - '+u_globals.empresa;

  caption := u_globals.hint + ' - '+ u_globals.empresa + ' - ' + v;

  stat.Panels[0].Text := u_globals.usuario+' ('+u_globals.permiso+')'+' - '+u_globals.empresa;
  stat.Panels[2].Text := u_globals.dbname;

  stat.Panels[1].Text := '';

  api := GetConexion(api);

end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                        //guardar tamaño (si procede)
  u_globals.h:=Height; }
  u_globals.guardar_pos;
end;

procedure Tf_main.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin                         { if it's an enter key }
       Key := #0;                                 { eat enter key }
       Perform(WM_NEXTDLGCTL, 0, 0);              { move to next control }
  end
end;

procedure Tf_main.FormShow(Sender: TObject);
begin
  if dbr_estado.ItemIndex>=0 then
    u_globals.check_color_estado(dbr_estado.items[dbr_estado.ItemIndex][1],f_main);

  f_main.Caption := 'Mantenimiento de Artículos ' + v;

  MostrarHabilitado;
end;

procedure Tf_main.S1Click(Sender: TObject);
var
  tot, cont: integer;
  Jpeg: TJpegImage;

  Stream: TStream;
  id: integer;
  url, path_img: string;
begin
  with TpFIBDataSet.Create(dm) do
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sqls.SelectSQL.Clear;
    sqls.SelectSQL.add('select count(*) as tot '+
      'from g_articulos '+
      'where imagen is not null and attachment_id is null');
    open;

    if not(isempty) then tot:=FieldByName('tot').asinteger
    else tot:=0;

    if tot>0 then
    begin
        if not DirectoryExists(ruta_tmp) then
            CreateDirectory(ruta_tmp,0);

        Screen.Cursor := crHourGlass;
        Jpeg := TJPEGImage.Create;

        Close;
        sqls.SelectSQL.Clear;
        sqls.SelectSQL.add('select * '+
                           'from g_articulos '+
                           'where imagen is not null and attachment_id is null');
        Open;
        First;

        dm.t_write.StartTransaction;
        cont := 1;
        path_img := '';

        try
          while not Eof do
          begin
             stat.Panels[1].Text := 'Subiendo ' + IntToStr(cont) + ' de ' + IntToStr(tot);
             path_img := ruta_tmp + '\' + FieldByName('id_articulo').AsString + '.jpg';

             Stream := CreateBlobStream(FieldByName('imagen'), bmRead);
             jpeg.LoadFromStream(Stream);
             Stream.Destroy;
             Jpeg.SaveToFile(path_img);
             SubeLogo(path_img,path_img,'articulos','image/jpeg',id,url);
             ActualizaAttachmentArt(id,FieldByName('id_articulo').AsInteger);

             DeleteFile(path_img);

             Inc(cont);
             Next;
          end;

          dm.t_write.Commit;
        except
           dm.t_write.Rollback;
        end;

        Screen.Cursor := crDefault;
        Jpeg.Free;

        BorrarArchivos(ruta_tmp);
        RemoveDir(ruta_tmp);

        ShowMessage('Proceso finalizado.');
    end else
        begin
          ShowMessage('No existen imágenes pendientes de subir.');
          stat.Panels[1].Text := '';
        end;

  finally
    free;
  end;

end;

procedure Tf_main.BorrarArchivos(Ruta: string);
var
  SR: TSearchRec;
begin
  if FindFirst(Ruta + '\*.*', 0, SR)= 0 then
   repeat
     DeleteFile(Ruta+'\'+SR.Name);
   until FindNext(SR) <> 0;
end;

function Tf_main.ActualizaAttachmentArt(attach, art:Integer):string;
begin
   with dm.qry1 do begin
     try
      database:=dm.db;
      Transaction := dm.t_write;
      sql.Clear;
      sql.add('update g_articulos set attachment_id=:attach ' +
              ' where id_articulo=:art ');
      ParamByName('attach').asinteger := attach;
      ParamByName('art').asinteger := art;

      ExecQuery;
     except on E:Exception do
            begin
             result := e.Message;
             raise;
            end;
     end;
   end;
end;

procedure Tf_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ver_estado_actualizacion(dm.q_art,dm.q_ean);
end;
{$ENDREGION}

{$REGION 'Busquedas'}
procedure Tf_main.sb_bu_idservClick(Sender: TObject);           //Busca Artículos
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_articulo,codigo,nombre,id_cliente,codigo_cli,nom_cli';
    titulos.commatext:='Articulo,Codigo,Nombre,Cliente,CodigoCli,NombreCli';
    from:='g_articulos ';
    where:='';
    orden[1]:=1;
    {busca:=0;}   distinct:=0;   fillimpio:=True;

    with Sender as TsSpeedButton do busca:=tag;

    showmodal;

    if resultado then
      if not(dm.q_art.locate('id_articulo',valor[1],[])) then raise exception.create('Artículo No Encontrado');

    MostrarHabilitado;
  end;
end;

procedure Tf_main.sSpeedButton3Click(Sender: TObject);
begin
     with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_talla,descripcion';
    titulos.commatext:='Talla,Descripcion';
    from:='a_tallas ';
    where:='';
    orden[1]:=0;
    busca:=2;   distinct:=0;   fillimpio:=True;

    //with Sender as TsSpeedButton do busca:=tag;

    showmodal;

    if resultado then
    begin
      if not(dm.q_art.state in [dsedit,dsinsert]) then dm.q_art.Edit;
      dm.q_art.FieldByName('talla').AsInteger:=valor[1];
    end;
  end;
end;

procedure Tf_main.sSpeedButton4Click(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_idioma,descripcion';
    titulos.commatext:='Idioma,Descripcion';
    from:='g_idiomas';
    where:='';
    group:='';
    orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      if not(dm.q_art.state in [dsedit,dsinsert]) then dm.q_art.Edit;
      dm.q_art.FieldByName('idioma').AsInteger:=valor[1];
    end;
  end;
end;

procedure Tf_main.btImpEanClick(Sender: TObject);
begin
   ImprimeEAN;
end;

procedure Tf_main.btn1Click(Sender: TObject);
var
  url:string;
  Jpeg: TJpegImage;
  Stream: TStream;
begin
   url := DescargaUrlImagen(dm.q_art.FieldByName('attachment_id').AsString);

   Jpeg := TJPEGImage.Create;

   Stream := dm.q_art.CreateBlobStream(dm.q_art.FieldByName('imagen'), bmRead);
   jpeg.LoadFromStream(Stream);
   Stream.Destroy;
   Jpeg.SaveToFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');
   img1.Picture.LoadFromFile('c:\lgs\imgprueba.jpg');

   DeleteFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');

   Jpeg.Free;
end;

procedure Tf_main.bt_ba_clienteClick(Sender: TObject);        //Busca Clientes
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_cliente,nombre';
    titulos.commatext:='Cliente,Nombre';
    from:='g_clientes';
    where:='';
    group:='';
    orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      if not(dm.q_art.state in [dsedit,dsinsert]) then dm.q_art.Edit;
      dm.q_art.FieldByName('id_cliente').AsInteger:=valor[1];
    end;
  end;
end;

procedure Tf_main.bt_ba_familiaClick(Sender: TObject);       //Busca Familias
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_familia,nombre';
    titulos.commatext:='Familia,Nombre';
    from:='g_familias';
    where:='';
    group:='';
    orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      if not(dm.q_art.state in [dsedit,dsinsert]) then dm.q_art.Edit;
      dm.q_art.FieldByName('id_familia').AsInteger:=valor[1];
    end;
  end;
end;

procedure Tf_main.bt_search_eanClick(Sender: TObject);            //Busca por EAN
var tot:integer;
begin
  with TpFIBDataSet.Create(dm) do
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sqls.SelectSQL.Clear;
    sqls.SelectSQL.add('select count(*) as tot '+
      'from g_articulos_bc b '+
      'where b.bc=:ean');
    ParamByName('ean').asstring:=ed_ean.text;

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
        where:='b.bc='+quotedstr(ed_ean.Text);
        group:='';
        orden[1]:=2;  busca:=2;   distinct:=0;   fillimpio:=True;

        showmodal;

        if resultado then dm.q_art.locate('id_articulo',valor[1],[]);
      end;
    end else begin                                //Hay solo un EAN
      with TpFIBDataSet.Create(dm) do
      try
        database:=dm.db;
        Transaction:=dm.t_write;
        sqls.SelectSQL.Clear;
        sqls.SelectSQL.add('select id_articulo '+
          'from g_articulos_bc '+
          'where bc=:ean');
        ParamByName('ean').asstring:=ed_ean.text;

        open;

        if not(isempty) then dm.q_art.locate('id_articulo',FieldByName('id_articulo').Asinteger,[]);
      finally
        free;
      end;
    end;
  end else sMessageDlg('EAN No Encontrado',mtError,[mbok],0);     //No EANS
end;

{$ENDREGION}

procedure Tf_main.dbe_codigoChange(Sender: TObject);
begin
  {If not dm.q_art.FieldByName('IMAGEN').IsNull then
    carga_imagen(self);}
end;

procedure Tf_main.dbe_idartChange(Sender: TObject);
var
  url:string;
  Jpeg: TJpegImage;
  Stream: TStream;
begin
   //url := DescargaUrlImagen(dm.q_art.FieldByName('attachment_id').AsString);

   if dm.q_art.FieldByName('imagen').AsString<>'I' then
   begin
     Jpeg := TJPEGImage.Create;

     Stream := dm.q_art.CreateBlobStream(dm.q_art.FieldByName('imagen'), bmRead);
     jpeg.LoadFromStream(Stream);
     Stream.Destroy;
     Jpeg.SaveToFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');
     img1.Picture.LoadFromFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');

     DeleteFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');

     Jpeg.Free;
   end;
end;

procedure Tf_main.carga_imagen(Sender: TObject);
var  Stream: TStream;
jpg: TJPEGImage;
begin
  jpg := TJPEGImage.Create;
 Stream := dm.q_art.CreateBlobStream(dm.q_art.FieldByName('IMAGEN'), bmRead); // Lo mismo que el anterior caso pero ahora en modo de escritura.
 jpg.LoadFromStream(Stream);     // Cargamos el BLOB al objeto JPEG
 Stream.Destroy;                 // liberamos...
 img1.Picture.Assign(jpg);     // y asignamos la imagen al TPicture.

 end;

procedure Tf_main.dbg_1KeyDown(Sender: TObject; var Key: Word;       //evitar que le den pabajo al grid
  Shift: TShiftState);
begin
  with (Sender as TsDbGrid) do
    if (Key = VK_DOWN) or ((Key = VK_TAB) and (SelectedIndex = Columns.Count-1)) then
      begin
       // DataSource.DataSet.DisableControls;
        DataSource.DataSet.Next;
        if DataSource.DataSet.EOF then Key := 0
        else DataSource.DataSet.Prior;
       // DataSource.DataSet.EnableControls;
      end;
end;

procedure Tf_main.dbn_1BeforeAction(Sender: TObject; Button: TNavigateBtn);
var
  url:string;
  Jpeg: TJpegImage;
  Stream: TStream;
begin
  if not(button in [nbpost,nbcancel]) then u_globals.ver_estado_actualizacion(dm.q_art,dm.q_ean);

     if dm.q_art.FieldByName('imagen').AsString<>'I' then
   begin
     Jpeg := TJPEGImage.Create;

     Stream := dm.q_art.CreateBlobStream(dm.q_art.FieldByName('imagen'), bmRead);
     jpeg.LoadFromStream(Stream);
     Stream.Destroy;
     Jpeg.SaveToFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');
     img1.Picture.LoadFromFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');

     DeleteFile('c:\lgs\' + dm.q_art.FieldByName('id_articulo').AsString + '.jpg');

     Jpeg.Free;
   end;
end;

procedure Tf_main.dbn_1Click(Sender: TObject; Button: TNavigateBtn);
var
  id, attach: integer;
  url: string;
  ejecuta: Boolean;
begin
   if (button in [nbpost,nbcancel]) then
   begin
      ejecuta := true;
      attach := busca_attach_id(dm.q_art.FieldByName('id_articulo').AsInteger);

      if dl_open_picture.filename<>'' then
      begin
           if attach>0 then
              ejecuta := (MessageDlg('El artículo ya tiene imágen en la web. ¿Desea sobreescribirla?',mtWarning,mbYesNo,0)=mrYes);

           if ejecuta then
           begin
            SubeLogo(dl_open_picture.filename,dl_open_picture.filename,'articulos','image/jpeg',id,url);
            ActualizaAttachmentArt(id,dm.q_art.FieldByName('id_articulo').AsInteger)
           end;
      end else begin
           if attach>0 then
              ejecuta := (MessageDlg('El artículo tiene imágen en la web. ¿Desea eliminarla?',mtWarning,mbYesNo,0)=mrYes);

           if ejecuta then
               UpdateDatosTabla('g_articulos','attachment_id=null ','id_articulo='+dm.q_art.FieldByName('id_articulo').AsString);
      end;
   end;

   MostrarHabilitado;
end;

procedure Tf_main.dbn_2Click(Sender: TObject; Button: TNavigateBtn);
var s:string;
    tot: Integer;
    crear: Boolean;
begin
  if Button=nbinsert then begin

    s := CrearEAN;
                                                //Añadir un solo ean
    sinputquery('Introducir Nuevo EAN Para Artículo','EAN',s);

    //Compobar si ya existe el EAN en la bbdd
    with TpFIBDataSet.Create(dm) do
    try
      database:=dm.db;
      Transaction:=dm.t_write;
      sqls.SelectSQL.Clear;
      sqls.SelectSQL.add('select count(*) as tot '+
        'from g_articulos_bc b '+
        'where b.bc=:ean');
      ParamByName('ean').asstring:=s;

      open;

      if not(isempty) then tot:=FieldByName('tot').asinteger
      else tot:=0;
    finally
      free;
    end;

    if tot>0 then
    begin
       ShowMessage('EAN existente.');
       Exit;
    end;

    //Comprobar si ya existe EAN para el artículo. Si existe, preguntar si se crea otro.
    with TpFIBDataSet.Create(dm) do
    try
      database:=dm.db;
      Transaction:=dm.t_write;
      sqls.SelectSQL.Clear;
      sqls.SelectSQL.add('select count(*) as tot '+
        'from g_articulos_bc b '+
        'where b.id_articulo=:art');
      ParamByName('art').AsInteger:=dm.q_art.FieldByName('id_articulo').asinteger;

      open;

      if not(isempty) then tot:=FieldByName('tot').asinteger
      else tot:=0;
    finally
      free;
    end;

    if tot>0 then
      crear := MessageDlg('El artículo ya tiene EAN/s asociado/s. ¿Desea crearlo igualmente?',mtWarning,mbYesNo,0)=mrYes
    else crear := true;

    if crear and (s<>'') then begin
      dm.q_ean.Insert;
      dm.q_ean.FieldByName('id_articulo').AsInteger:=dm.q_art.FieldByName('id_articulo').asinteger;
      dm.q_ean.FieldByName('bc').AsString:=s;
      dm.q_ean.Post;

      dm.q_ean.Close;
      dm.q_ean.Open;
    end;
  end;
end;

function Tf_main.CrearEAN:string;
var
   ean, ean_aux:string;
   existe, i:Integer;
begin
   existe := 1;
   i := 0;
   ean:=dbe_cliente.Text+dbe_idart.Text;
   ean_aux := ean;

   try
      while existe>0 do
      begin
        with TpFIBDataSet.Create(dm) do
        begin
          try
              database:=dm.db;
              sqls.SelectSQL.Clear;
              SQLs.SelectSQL.Text:='Select count(*) as contador from g_articulos_bc where id_articulo='+quotedstr(dbe_idart.Text)+' and bc='+quotedstr(ean_aux);
              Open;
              existe:=FieldByName('contador').AsInteger;

              if existe>0 then
              begin
                  ean_aux := ean + IntToStr(i);
                  Inc(i);
              end;
          finally
            Free;
           end;
        end;
      end;

     Result := ean_aux;
   except
      ShowMessage('Ocurrió un error. NO se ha creado el código de barras');
   end;

end;

procedure Tf_main.dbr_estadoChange(Sender: TObject);
begin
  if dbr_estado.ItemIndex>=0 then
    u_globals.check_color_estado(dbr_estado.items[dbr_estado.ItemIndex][1],f_main);
end;

procedure Tf_main.I1Click(Sender: TObject);
begin
  ImprimeEAN;
end;

procedure Tf_main.imgArtDeshabilitadoDblClick(Sender: TObject);
var
  id: integer;
begin
     id := dm.q_art.FieldByName('id_articulo').AsInteger;

     if (MessageDlg('Va a habilitar el uso del artículo. ¿Desea continuar?',mtWarning,mbYesNo,0)=mrYes) then
      if UpdateArtBloqueado(dm.q_art.FieldByName('id_articulo').AsInteger,0)=1 then
          sShowMessage('Artículo habilitado correctamente.')
      else
          sShowMessage('Ha ocurrido un error en el proceso.');

     dm.q_art.Close;
     dm.q_art.Open;
     dm.q_art.locate('id_articulo',id,[]);

     MostrarHabilitado;
end;

procedure Tf_main.imgArtHabilitadoContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
   if (MessageDlg('Va a deshabilitar el uso del artículo. ¿Desea continuar?',mtWarning,mbYesNo,0)=mrYes) then
      if UpdateArtBloqueado(dm.q_art.FieldByName('id_articulo').AsInteger,1)=1 then
      begin
          sShowMessage('Artículo deshabilitado correctamente.');

      end
      else
          sShowMessage('Ha ocurrido un error en el proceso.');

      MostrarHabilitado;

end;

procedure Tf_main.imgArtHabilitadoDblClick(Sender: TObject);
var
  id:Integer;
begin
      id := dm.q_art.FieldByName('id_articulo').AsInteger;
     if (MessageDlg('Va a deshabilitar el uso del artículo. ¿Desea continuar?',mtWarning,mbYesNo,0)=mrYes) then
      if UpdateArtBloqueado(dm.q_art.FieldByName('id_articulo').AsInteger,1)=1 then
      begin
          sShowMessage('Artículo deshabilitado correctamente.');

      end
      else
          sShowMessage('Ha ocurrido un error en el proceso.');

      dm.q_art.Close;
      dm.q_art.Open;
      dm.q_art.locate('id_articulo',id,[]);

      MostrarHabilitado;
end;

procedure Tf_main.ImportarGameStop;            //Importar archivo de GameStop
var fila,uni_emb,id_articulo,rec,new:integer;  fin:boolean;   nom_cli,bc,codigo,nombre,cod_cli:string;    kgs,largo,ancho,alto,cubic:Real;
begin
  u_globals.ver_estado_actualizacion(dm.q_art,dm.q_ean);

  if (dl_open.Execute) then begin
    if FileExists(dl_open.FileName) then begin

      AbreFichero;
      Hoja := xls_1.Worksheets.Item[1];

      //xls_1.Filename:=dl_open.FileName;
      //xls_1.Read;

      fila:=6;
      fin:=false;

      rec:=0;
      new:=0;

      try
        dm.t_write.StartTransaction;

        while not(fin) do begin
          if hoja.cells[fila,1]='' then fin:=true
          else begin
            Inc(rec);
            cod_cli:=hoja.cells[1,fila];
            nom_cli:=hoja.cells[fila,2];
            bc:=hoja.cells[fila,3];
            codigo:=hoja.cells[fila,4];
            nombre:=hoja.cells[fila,5];
            kgs:=StrToFloatDef(hoja.cells[fila,6],1);
            largo:=StrToFloatDef(hoja.cells[fila,7],1);
            ancho:=StrToFloatDef(hoja.cells[fila,8],1);
            alto:=StrToFloatDef(hoja.cells[fila,9],1);
            cubic:=StrToFloatDef(hoja.cells[fila,10],0);
            uni_emb:=StrToIntdef(hoja.cells[fila,11],1);

            if (busca_art_id(codigo)=0) then begin      //codigo nuevo
              if (busca_art_ref_cod_cli(cod_cli,6122)='ERR') then begin   //SKU no existe previamente
                Inc(new);
                with tpfibdataset.Create(dm) do begin
                  database:=dm.db;
                  SQLs.SelectSQL.Clear;
                  SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
                  Open;
                  id_articulo:=FieldByName('gen_id').AsInteger;
                  Free;
                end;

                with TpFIBQuery.Create(dm) do begin
                  Database:=dm.db;
                  Transaction:=dm.t_write;
                  Close;
                  SQL.Clear;
                  SQL.Add('insert into g_articulos (id_articulo,codigo,nombre,kgs,largo,ancho,alto,uni_embalaje,id_cliente,codigo_cli,nom_cli,cubic) '+
                    ' values (:id_articulo,:codigo,:nombre,:kgs,:largo,:ancho,:alto,:uni_embalaje,:id_cliente,:codigo_cli,:nom_cli,:cubic)');
                  ParamByName('id_articulo').asinteger:=id_articulo;
                  ParamByName('codigo').AsString:=codigo;
                  ParamByName('nombre').AsString:=nombre;
                  ParamByName('kgs').asfloat:=kgs;
                  ParamByName('largo').asfloat:=largo;
                  ParamByName('ancho').asfloat:=ancho;
                  ParamByName('alto').asfloat:=alto;
                  ParamByName('uni_embalaje').asinteger:=uni_emb;
                  ParamByName('id_cliente').asinteger:=6122;
                  ParamByName('codigo_cli').AsString:=cod_cli;
                  ParamByName('nom_cli').AsString:=nom_cli;
                  ParamByName('cubic').asfloat:=cubic;
                  ExecQuery;

                  Close;
                  SQL.Clear;
                  SQL.Add('insert into g_articulos_bc (id_articulo,bc) values (:id_articulo,:bc)');
                  ParamByName('id_articulo').asinteger:=id_articulo;
                  ParamByName('bc').AsString:=bc;
                  ExecQuery;

                  Free;
                end;
              end;
            end;

            Inc(fila);

            lb_st.Caption:='R='+inttostr(rec)+' New='+inttostr(new);
            Application.ProcessMessages;
          end;
        end;

        dm.t_write.Commit;
      except
        dm.t_write.Rollback;
      end;

      id_articulo:=dm.q_art.FieldByName('id_articulo').AsInteger;
      dm.q_art.DisableControls;
      dm.q_art.Close;
      dm.q_art.Open;
      dm.q_art.locate('id_articulo',id_articulo,[]);
      dm.q_art.EnableControls;

      sMessageDlg('Hecho, '+inttostr(new)+' Artículos Nuevos Creados',mtInformation,[mbok],0);

    end else raise Exception.Create('Fichero No Encontrado');
  end;
end;

procedure Tf_main.bt_load_imageClick(Sender: TObject);            //Add Image
var Jpeg: TJpegImage;
begin
  if dl_open_picture.Execute then begin
    if FileExists(dl_open_picture.filename) then begin

      Jpeg := TJpegImage.Create;
      try
        Jpeg.LoadFromFile(dl_open_picture.filename);

        if ((jpeg.Width>530) or (jpeg.Height>330)) then raise Exception.Create('Máximo W=530 x H=330');
        if not(dm.q_art.State in [dsedit,dsinsert]) then dm.q_art.Edit;
        dm.q_art.fieldbyname('imagen').Assign(jpeg);
      finally
        Jpeg.Free;
      end;
    end else raise exception.Create('Fichero No Encontrado');
  end;
end;

procedure Tf_main.bt_clear_imageClick(Sender: TObject);           //Clear Image
begin
  if not(dm.q_art.State in [dsedit,dsinsert]) then dm.q_art.Edit;

  dm.q_art.FieldByName('imagen').AsVariant:=null;

  dl_open_picture.FileName := '';
end;

procedure Tf_Main.AbreFichero;
begin
   xls_1:=CreateOleObject('Excel.Application');
   try
     xls_1.Visible := False;
     xls_1.DisplayAlerts:= False;
     xls_1.WorkBooks.Open(dl_open.FileName);//fichero que queremos leer
   except
     xls_1.Quit ;
     xls_1 := Unassigned;
   end;
end;


procedure Tf_main.ImprimeEan;
var
  barcode: TfrxBarcodeView;
  stock, cant: integer;
begin
   barcode:=eti_ean.FindObject('BarCode1') as TfrxBarcodeView;

   barcode.Visible:=True;
   barcode.Text :=  dm.q_ean.FieldByName('bc').AsString;

   //Comprobar stock del artículo. Si existe, preguntar si se crea otro.
    with TpFIBDataSet.Create(dm) do
    try
      database:=dm.db;
      Transaction:=dm.t_write;
      sqls.SelectSQL.Clear;
      sqls.SelectSQL.add('select sum(cantidad) as tot '+
        'from a_stock '+
        'where id_articulo=:art');
      ParamByName('art').AsInteger:=dm.q_art.FieldByName('id_articulo').asinteger;

      open;

      if not(isempty) then stock:=FieldByName('tot').asinteger
      else stock:=0;
    finally
      free;
    end;

    cant := StrToInt(InputBox('Imprimir EAN','Existe/n ' + IntToStr(stock) + ' ud/s. en stock. Indique la cantidad de etiquetas a imprimir.','0'));

    if cant>0 then
    begin
      eti_ean.PrintOptions.Copies := cant;
      eti_ean.PrintOptions.Printer := u_globals.imp_eti;
      eti_ean.PrintOptions.ShowDialog := False;
      if eti_ean.PrepareReport(true) then eti_ean.print;
    end;
end;

procedure Tf_main.MostrarHabilitado;
begin
  imgArtHabilitado.Visible := (dm.q_art.FieldByName('locked').asinteger=0);
  imgArtDeshabilitado.Visible := (dm.q_art.FieldByName('locked').asinteger=1);
end;
end.
