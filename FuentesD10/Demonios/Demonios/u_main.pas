unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Vcl.ExtCtrls, System.DateUtils,
  Vcl.StdCtrls, sButton, System.Classes, ScSSLClient, ScSSHClient, ScBridge,
  ScSFTPClient, sComboBox, Vcl.DBCtrls, sDBComboBox, pFIBQuery, system.strUtils,
  pFIBDataSet, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, Vcl.ComCtrls;

type
  TDatosPC   = record
    Nombre, IP, Usuario :String;
  end;

   TDatosUsuario  = record
    id: Integer;
    Nombre :String;
  end;

  t_elemento = record
    id_cliente:Integer;          //cliente
    tipo:integer;                //demonio
    idx:integer;                 //id_demonio
    sig_ejec:TDateTime;          //Dia/Hora de la siguiente ejecucion
    intervalo:integer;           //Intervalo de tiempo entre ejecuciones
  end;

  Tf_main = class(TForm)
    tm_1: TTimer;
    gbDemonios: TGroupBox;
    mm: TMemo;
    btEjecuta: TsButton;
    cbLista: TDBLookupComboBox;
    lbProx: TLabel;
    lbIntervalo: TLabel;
    gb_d10: TGroupBox;
    edFIni: TDateTimePicker;
    edFFin: TDateTimePicker;
    lb1: TLabel;
    lb2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tm_1Timer(Sender: TObject);
    procedure cbListaClick(Sender: TObject);
    procedure btEjecutaClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadConfigCliente(id_cliente:Integer);
    function lanza_envio_lotes(id_cliente:integer):string;
    function lanza_backup(id:integer):string;
    function lanza_estados(id_cliente,qry:integer; f_ini,f_fin:TDateTime):string;
    function lanza_sync(id_cliente:integer):string;
    function lanza_peds_finalizados(id_cliente:integer):string;
    function lanza_arts_c_ont(id_cliente:Integer):string;
    function lanza_ents_c_ont(id_cliente:Integer):string;
    function lanza_stock_c_ont(id_cliente:Integer):string;
    function lanza_fotos_arts_web(id_cliente:Integer):string;
  public
    { Public declarations }
    procedure cargar_fechas;
    procedure guardar_sig_ejec(i:Integer);
  end;

var
  f_main: Tf_main;

  usuario: TDatosUsuario;
  PC: TDatosPC;
  log_app: string;

  ar_elementos:array of t_elemento;   //array de elementos cargados
  idx_elementos:Integer=0;            //Idx de elementos cargados

  //params lotes
  mail_error, cli_api_user, cli_api_pass, cli_api_url:string;
  //params envio estados
  extra_est, extra_ent, ok_est: string;
  lgs_api_estped, lgs_api_user, lgs_api_pass, lgs_api_url:string;
  dias_atras, peds_fin_dias_atras: integer;
  httpweb: string;

  i_manual: Integer;                  //indice del array elegido manualmente de la lista

  alto_inicial: Integer;
  mail_txt: string;
  dem_oldweb_destjpg, dem_oldweb_imgs_down, dem_oldweb_imgs_up, dem_estados:string;
  dem_estados_qry, dem_entregados_qry: integer;
  dem_bkp_alm_db_1,dem_bkp_alm_db_2,dem_bkp_alm_db_3:string;
  dem_bkp_alm_srv_1,dem_bkp_alm_srv_2,dem_bkp_alm_srv_3:string;
  dem_bkp_alm_dirrem_1,dem_bkp_alm_dirrem_2,dem_bkp_alm_dirrem_3:string;
  dem_bkp_alm_dir_1,dem_bkp_alm_dir_2,dem_bkp_alm_dir_3:string;
const
  v = '[4.1.1]';
  //[4.1.1] Modifacion qry envio lotes Pargal
  //[4.1] Envio de estados por parametro de estado. Log de updates sobre c_pedidos.
  //[4] Demonios C.Ont. y actualizar fotos web vieja
  //[3] Nuevo demonio envio estados por fechas
  //[2] Nuevo demonio control pedidos enviados
  //[1.2] Modif mensaje salida envio estados
  //[1.1] Reconectar db gestoras si error de conexion al enviar estados
  //[1.0] Modif email al enviar lotes
  //[1] Nuevo demonio sincro FB/SQL
  //[0.4] Muestra msg error en envio estados.
  //[0.3] Reconnect db. Fecha en extra envio estados.
  //[0.2] Envio estados pedidos. Marca dem en mail envio lotes.
  //[0.1] Envio lotes cambio G->E

  fecha_nula = '01/01/1979';

implementation

uses
  u_globals, u_dm, MidasLib, u_functions, u_env_lotes, u_backup, u_env_estados, u_sync,
  u_envia_mail, u_peds_finalizados, u_c_ontinyent, u_old_web;

{$R *.dfm}

procedure Tf_main.FormShow(Sender: TObject);
begin
  u_globals.leer_ini;
  u_globals.leer_ini_bbdd(u_globals.id_usuario);

  if dm.db.Connected then dm.db.Connected:=false;
  if dm.db_gestoras.Connected then dm.db_gestoras.Connected:=false;

  dm.db.DBName := u_globals.db_name;
  dm.db_gestoras.DBName := u_globals.db_gestoras;

  dm.db.Connected:=true;
  dm.db_gestoras.Connected:=true;

  Caption := 'Demonios ' + v;
  mm.Lines.Clear;
  cargar_fechas;
  tm_1.Enabled:=true;

  PC.Nombre := ComputerName;
  PC.IP := LocalIP;
  PC.Usuario := obtenerUsuarioRed;
  usuario.id := u_globals.id_usuario;
  usuario.Nombre := 'Demonio';

   lbProx.Caption := 'Siguiente ejecución: -';
   lbIntervalo.Caption := 'Intervalo (minutos): -';

   alto_inicial := Height;
end;

procedure Tf_main.guardar_sig_ejec(i:Integer);

begin                     //Guarda datos al ini

   dm.t_write.StartTransaction;

   with TpFIBQuery.Create(dm) do
   begin
     try
      Close;
      Database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      SQL.Add('update s_demonios set sig_ejec=:sig_ejec where id_demonio=:id_demonio');
      ParamByName('sig_ejec').AsDateTime := ar_elementos[i].sig_ejec;
      ParamByName('id_demonio').AsInteger := ar_elementos[i].idx;
      try
       ExecQuery;
       dm.t_write.Commit;
      except
       dm.t_write.Rollback;
      end;
     finally
       free;
     end;
   end;

end;

procedure Tf_main.tm_1Timer(Sender: TObject);
var i:integer;   s:string;   f:TextFile;
begin

  //if not dm.db.Connected then
      dm.db.Connected := True;

  for i:=0 to idx_elementos-1 do begin
    if ar_elementos[i].sig_ejec<=now then begin        //ha pasado la hora
      tm_1.Enabled:=false;
      try
        LoadConfigCliente(ar_elementos[i_manual].id_cliente);
        s:='';

        case ar_elementos[i].tipo of
          1:begin
            s := FormatDateTime('dd.mm.yy hh:mm',now) +  ' Envio Lotes - '+inttostr(ar_elementos[i].id_cliente) + ln;
            s := s + lanza_envio_lotes(ar_elementos[i].id_cliente);
          end;

          2:begin
            s := FormatDateTime('dd.mm.yy hh:mm',now) +  ' Backup - '+inttostr(ar_elementos[i].idx) + ln;
            s := s + lanza_backup(ar_elementos[i].idx);
          end;

          3:begin
           try
             Screen.Cursor := crHourGlass;
             s := FormatDateTime('dd.mm.yy hh:mm',now) +  ' Envio Estados - '+inttostr(ar_elementos[i].id_cliente);
             mm.Lines.Add(s);
             mm.Lines.Add(lanza_estados(ar_elementos[i].id_cliente,dem_entregados_qry,StrToDate(fecha_nula),StrToDate(fecha_nula)));
             s := FormatDateTime('dd.mm.yy hh:mm',now) +  ' Fin Envio Estados - '+inttostr(ar_elementos[i].id_cliente) + ln;
             Screen.Cursor := crDefault;
           except on e:exception do begin
                    envia_email(1,'desarrollo@loginser.com',e.message,'ERROR DEMONIO lanza_estados',True);
                  end;
           end;
          end;

          4:begin
            s := FormatDateTime('dd.mm.yy hh:mm',now) +  ' Sincronización FB/SQL - ' + inttostr(ar_elementos[i].idx) + ln;
            s := s + lanza_sync(-1000);
          end;

          5:begin
           try
             Screen.Cursor := crHourGlass;
             s := FormatDateTime('dd.mm.yy hh:mm',now) +  ' Control Peds Finalizados - ' + inttostr(ar_elementos[i].idx);
             mm.Lines.Add(s);
             s := lanza_peds_finalizados(ar_elementos[i].id_cliente) + ln;
             s := s + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Fin Control Peds Finalizados - '+inttostr(ar_elementos[i].idx) + ln;
             Screen.Cursor := crDefault;
           except on e:exception do begin
                    envia_email(1,'desarrollo@loginser.com',e.message,'ERROR DEMONIO ControlFinalizados',True);
                  end;
           end;
          end;

          8:begin
           try
             Screen.Cursor := crHourGlass;
             s := FormatDateTime('dd.mm.yy hh:mm',now) + ' Stock C.Ont. Web - ' + inttostr(ar_elementos[i].id_cliente);
             mm.Lines.Add(s);
             s := lanza_stock_c_ont(ar_elementos[i].id_cliente) + ln;
             s := s + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Fin Stock C.Ont. Web - '+inttostr(ar_elementos[i].id_cliente) + ln;
             Screen.Cursor := crDefault;
           except on e:exception do begin
                    envia_email(1,'desarrollo@loginser.com',e.message,'ERROR DEMONIO ControlFinalizados',True);
                  end;
           end;
          end;

        end;
        repeat
          ar_elementos[i].sig_ejec:=incminute(ar_elementos[i].sig_ejec,ar_elementos[i].intervalo);    //nueva ejecucion
        until (ar_elementos[i].sig_ejec>now);

        guardar_sig_ejec(i);

        if ar_elementos[i].idx=cbLista.KeyValue then
        begin
          lbProx.Caption := 'Siguiente ejecución: ' + FormatDateTime('dd.mm.yyyy hh:nn:ss',ar_elementos[i].sig_ejec);
          Application.ProcessMessages;
        end;

        mm.Lines.Add(s);

      except
        on e:exception do begin                               //guarda log de errores
          AssignFile(f,ExtractFilePath(ParamStr(0))+'log_errores_'+formatdatetime('yymmdd',Date)+'_'+formatdatetime('hhnnss',time)+'.txt');
          Rewrite(f);
          Writeln(f,formatdatetime('dd/mm/yy',Date)+' - '+formatdatetime('hhnnss',time)+' - '+e.Message);
          CloseFile(f);
        end;
      end;
      tm_1.Enabled:=true;
    end;
  end;
end;

procedure Tf_main.btEjecutaClick(Sender: TObject);
var
  s: string;
begin
    Screen.Cursor := crHourGlass;

    LoadConfigCliente(ar_elementos[i_manual].id_cliente);

    s := '';
    case ar_elementos[i_manual].tipo of
      1:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Envio Lotes - ' + inttostr(ar_elementos[i_manual].id_cliente) + ln;
        s := s + lanza_envio_lotes(ar_elementos[i_manual].id_cliente);
      end;

      2:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Backup - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_backup(ar_elementos[i_manual].idx);
      end;

      3:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Envio Estados - ' + inttostr(ar_elementos[i_manual].id_cliente) + ln;
        s := s + lanza_estados(ar_elementos[i_manual].id_cliente,dem_entregados_qry,StrToDate(fecha_nula),StrToDate(fecha_nula));
      end;

      4:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Sync - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_sync(ar_elementos[i_manual].id_cliente);
      end;

      5:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Peds Fin - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_peds_finalizados(ar_elementos[i_manual].id_cliente);
      end;

      6:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Articulos C.Ont. - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_arts_c_ont(ar_elementos[i_manual].id_cliente);
      end;

      7:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Entradas C.Ont. - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_ents_c_ont(ar_elementos[i_manual].id_cliente);
      end;

      8:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Stocks C.Ont. - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_stock_c_ont(ar_elementos[i_manual].id_cliente);
      end;

      9:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Fotos Arts. Web - ' + inttostr(ar_elementos[i_manual].idx) + ln;
        s := s + lanza_fotos_arts_web(ar_elementos[i_manual].id_cliente);
      end;

      10:begin
        s := 'Bt.' + FormatDateTime('dd.mm.yy hh:mm',now) +  ' Envio Estados Fechas - ' + inttostr(ar_elementos[i_manual].id_cliente) + ln;
        s := s + lanza_estados(ar_elementos[i_manual].id_cliente,164,edFIni.Date,edFFin.Date);
      end;

    end;
    mm.Lines.Add(s);

    Screen.Cursor := crDefault;
end;

procedure Tf_main.cargar_fechas;
var
   ini: TiniFile;
   nombre_aux: string;
begin

  with dm.qDemonios do
  begin
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('select * from s_demonios where estado=:estado and tipo is not null');
    ParamByName('estado').AsString := 'A';
    Open;

    if not IsEmpty then
    begin
       setlength(ar_elementos,0);           //limpia array
       idx_elementos:=1;

       first;
       while not Eof do
       begin
          SetLength(ar_elementos,idx_elementos);
          ar_elementos[idx_elementos-1].id_cliente:=FieldByName('id_cliente').AsInteger;
          ar_elementos[idx_elementos-1].tipo:=FieldByName('tipo').AsInteger;
          ar_elementos[idx_elementos-1].idx:=FieldByName('id_demonio').AsInteger;
          ar_elementos[idx_elementos-1].sig_ejec:= FieldByName('sig_ejec').AsDateTime;
          ar_elementos[idx_elementos-1].intervalo:=FieldByName('intervalo').AsInteger;

          inc(idx_elementos);

          Next;
       end;
       dec(idx_elementos);
    end;
  end;

end;

procedure Tf_main.cbListaClick(Sender: TObject);
var
  i: Integer;
begin
   btEjecuta.Enabled := (cbLista.Text<>'');

   for I := Low(ar_elementos) to High(ar_elementos) do
   begin
     if ar_elementos[i].idx=cbLista.KeyValue then
        i_manual := i;
   end;

   lbProx.Caption := 'Siguiente ejecución: ' + FormatDateTime('dd.mm.yyyy hh:nn:ss',ar_elementos[i_manual].sig_ejec);
   lbIntervalo.Caption := 'Intervalo (minutos): ' + IntToStr(ar_elementos[i_manual].intervalo);
   Application.ProcessMessages;

   case cbLista.KeyValue of
      17: Height := Height + 83 ;
      else Height := Height - 83;
   end;

   if Height<alto_inicial then
        Height := alto_inicial
   else if Height>alto_inicial + 83 then
              Height := alto_inicial + 83;


end;

procedure Tf_main.LoadConfigCliente(id_cliente:Integer);
var
  i: integer;
  item_list, par: TStringList;
begin

  with TpFIBDataSet.Create(self) do
  try
    try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
    ParamByName('id_cliente').AsInteger := id_cliente;
    Open;
    First;

    if not IsEmpty then
    begin
      item_list := TStringList.Create;
      item_list.Delimiter := '$';
      item_list.DelimitedText := fieldbyname('items').AsString;

      if item_list.Count > 0 then
      begin
        par := TStringList.Create;
        par.Delimiter := '|';

        for i := 0 to item_list.Count - 1 do
        begin
          par.DelimitedText := item_list[i];

          if UpperCase(par[0]) = 'LOG_DM' then
            log_app := par[1];
          if UpperCase(par[0]) = 'MAIL_ERROR' then
            mail_error := par[1];
          if UpperCase(par[0]) = 'API_USER' then
            cli_api_user := par[1];
          if UpperCase(par[0]) = 'API_PASS' then
            cli_api_pass := par[1];
          if UpperCase(par[0]) = 'API_URL' then
            cli_api_url := par[1];
          if UpperCase(par[0]) = 'ENV_EST_EXTRA_EST' then
            extra_est := par[1];
          If UpperCase(par[0]) = 'ENV_EST_EXTRA_ENT' then
            extra_ent := par[1];
          if UpperCase(par[0]) = 'ENV_EST_OK_EST' then
            ok_est := par[1];
          if UpperCase(par[0]) = 'ENV_EST_DIAS_ATRAS' then
            dias_atras := StrToInt(par[1]);
          if UpperCase(par[0]) = 'LGS_API_USER' then
            lgs_api_user := par[1];
          if UpperCase(par[0]) = 'LGS_API_PASS' then
            lgs_api_pass := par[1];
          if UpperCase(par[0]) = 'LGS_API_URL' then
            lgs_api_url := par[1];
          if UpperCase(par[0]) = 'LGS_API_ESTPED' then
            lgs_api_estped := par[1];
          if UpperCase(par[0]) = 'PEDS_FIN_DIAS_ATRAS' then
            peds_fin_dias_atras := StrToInt(par[1]);
          if UpperCase(par[0]) = 'HTTPWEB' then
            httpweb := par[1];
          if UpperCase(par[0]) = 'DEM_OLDWEB_DESTJPG' then
            dem_oldweb_destjpg := par[1];
          if UpperCase(par[0]) = 'DEM_OLDWEB_IMGS_DOWN' then
            dem_oldweb_imgs_down := par[1];
          if UpperCase(par[0]) = 'DEM_OLDWEB_IMGS_UP' then
            dem_oldweb_imgs_up := par[1];
          if UpperCase(par[0]) = 'DEM_ESTADOS' then
            dem_estados := par[1];
          if UpperCase(par[0]) = 'DEM_ESTADOS_QRY' then
            dem_estados_qry := StrToInt(par[1]);
          if UpperCase(par[0]) = 'DEM_ENTREGADOS_QRY' then
            dem_entregados_qry := StrToInt(par[1]);
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DB_1' then
            dem_bkp_alm_db_1 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DB_2' then
            dem_bkp_alm_db_2 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DB_3' then
            dem_bkp_alm_db_3 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DIR_1' then
            dem_bkp_alm_dir_1 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DIR_2' then
            dem_bkp_alm_dir_2 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DIR_3' then
            dem_bkp_alm_dir_3 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_SRV_1' then
            dem_bkp_alm_srv_1 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_SRV_2' then
            dem_bkp_alm_srv_2 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_SRV_3' then
            dem_bkp_alm_srv_3 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DIRREM_1' then
            dem_bkp_alm_dirrem_1 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DIRREM_2' then
            dem_bkp_alm_dirrem_2 := par[1];
          if UpperCase(par[0]) = 'DEM_BKP_ALM_DIRREM_3' then
            dem_bkp_alm_dirrem_3 := par[1];
        end;
      end;
    end;
    except on e:exception do begin
            envia_email(1,'desarrollo@loginser.com',e.message,'DEMONIO loadconfigcliente',True);
         end;
    end;

  finally
    free;
  end;
end;


function Tf_main.lanza_envio_lotes(id_cliente:integer):string;
begin
   LoadConfigCliente(id_cliente);
   result := EnviaLotes(id_cliente,cli_api_url,cli_api_user,cli_api_pass,mail_error,log_app,pc.ip,pc.Nombre,usuario.id);
end;

function Tf_main.lanza_backup(id:integer):string;
var
  server, db, remoto, dir: string;
begin
   LoadConfigCliente(-1000);

   result := backup(id,'dem_bkp_alm_srv_' + IntTosTr(id),
                       'dem_bkp_alm_db_' + IntTosTr(id),
                       'dem_bkp_alm_dir_' + IntTosTr(id),
                       'dem_bkp_alm_dirrem_' + IntTosTr(id), false); //(id_cliente,cli_api_url,cli_api_user,cli_api_pass,mail_error,log_app,pc.ip,pc.Nombre,usuario.id);
end;

function Tf_main.lanza_estados(id_cliente, qry:integer; f_ini,f_fin:TDateTime):string;
begin
   LoadConfigCliente(id_cliente);

   u_env_estados.qry_est := dem_estados_qry;
   u_env_estados.qry_ent := dem_entregados_qry;
   u_env_estados.lanzar_todo := (qry=dem_entregados_qry);
   result := EnviaEstados(qry, id_cliente,dias_atras,
                          lgs_api_url,lgs_api_user,lgs_api_pass, lgs_api_estped,
                          extra_est, extra_ent, ok_est, dem_estados,
                          log_app,pc.ip,pc.Nombre,usuario.id,f_ini,f_fin,
                          cli_api_url,cli_api_user,cli_api_pass);

  //envia_email(1,'desarrollo@loginser.com',result,'DEMONIO lanza_estados',True);
  if Pos('connection',LowerCase(Result))>0 then
  begin
    dm.db_gestoras.Connected := False;
    dm.db_gestoras.Connected := true;
  end;
end;

function Tf_main.lanza_sync(id_cliente:integer):string;
begin
   result := Sincronizar;
end;

function Tf_main.lanza_peds_finalizados(id_cliente:Integer):string;
begin
   Result := ControlFinalizados(id_cliente,peds_fin_dias_atras,log_app,pc.ip,pc.Nombre,usuario.id);
end;

function Tf_main.lanza_arts_c_ont(id_cliente:Integer):string;
begin
   Result := ActualizaArtsCOnt(id_cliente,usuario.id,httpweb,log_app,pc.ip,pc.Nombre, mail_txt);
end;

function Tf_main.lanza_ents_c_ont(id_cliente:Integer):string;
begin
   Result := ActualizaEntsCOnt(id_cliente,usuario.id,httpweb,log_app,pc.ip,pc.Nombre, mail_txt);
end;

function Tf_main.lanza_stock_c_ont(id_cliente:Integer):string;
begin
   Result := ActualizaStockCOnt(id_cliente,usuario.id,httpweb,log_app,pc.ip,pc.Nombre, mail_txt);
end;

function Tf_main.lanza_fotos_arts_web(id_cliente:Integer):string;
begin
   Result := ActualizaFotosArtsWeb(id_cliente,usuario.id,httpweb,dem_oldweb_destjpg, dem_oldweb_imgs_down, dem_oldweb_imgs_up,log_app,pc.ip,pc.Nombre, mail_txt);
end;


end.
