unit u_flams;

interface

uses
  System.SysUtils, System.Classes, ScsFTPUtils, ScSFTPClient, ScBridge,
  ScSSHClient, ScDataHandler, system.IOUtils, System.Win.ComObj,
  pFIBDataSet, System.Variants;

type
  Tdm_flam = class(TDataModule)
    cl: TScSSHClient;
    st: TScFileStorage;
    f: TScSFTPClient;
    procedure clServerKeyValidate(Sender: TObject; NewServerKey: TScKey;
      var Accept: Boolean);
    procedure fDirectoryList(Sender: TObject; const Path: string;
      const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo;
      EOF: Boolean);
  private
    { Private declarations }
    function ficheroEnUso (fichero : string) : boolean;
  public
    { Public declarations }
    cod_cli: integer;
    procedure ProcesaFicheros;
    function ProcesaFichero(tipo:string;nom_fichero:string): string;
    procedure AbreFichero(ruta:string);
  end;

var
  dm_flam: Tdm_flam;
  devos_imp: TStringList;


implementation

uses
  u_main, u_dm, u_functions, u_pedidos, u_DescargaAttach, u_globals_gestoras, u_dmlabels;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm_flam.ProcesaFicheros;
var
  i,j: integer;
  NombreFichero: string;
  Lista: TStringList;
  Handle:  TScSFTPFileHandle;

begin
  if not DirectoryExists(dir_temp + '\' + IntToStr(u_main.main_cli)) then
      ForceDirectories(dir_temp + '\' + IntToStr(u_main.main_cli));

    try
      //Conectamos al FTP y obtenemos la lista de ficheros pendientes
      // ...Descargamos el archivo del servidor a una carpeta local

      cl.Connect;

      f.Initialize;
      Handle := f.OpenDirectory(u_main.ftp_dir_ups);


      while not f.EOF do
      begin
        f.ReadDirectory(handle);
      end;

      Lista := TSTringList.Create;
      devos_imp := TStringList.Create;

      Lista := ListaArchivos(dir_temp + IntToStr(u_main.main_cli)+'\');

      if Lista.Count>0 then
      begin
        //Datos := TMemoryStream.Create;

        // Por cada fichero...
        for i := 0 to lista.Count - 1 do
        begin
          if lista[i] <> '' then
          begin
            // ...Leemos las filas del archivo de estados:
            dm.t_write.StartTransaction;

            NombreFichero := ProcesaFichero('xls',Lista[i]);

            if NombreFichero<>'' then
              try
                dm.t_write.CommitRetaining;

                f.RenameFile(u_main.ftp_dir_ups + '/' + lista[i],u_main.ftp_dir_ups + '/' + NombreFichero);

                if FileExists(dir_temp + IntToStr(u_main.main_cli) + '\' + lista[i]) then DeleteFile(dir_temp + IntToStr(u_main.main_cli)+'\'+lista[i]);
              except
                on e: Exception do
                begin
                  if dm.t_write.InTransaction then dm.t_write.RollbackRetaining;
                end;
              end
            else
              if dm.t_write.InTransaction then dm.t_write.RollbackRetaining;
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
end;

procedure Tdm_flam.clServerKeyValidate(Sender: TObject; NewServerKey: TScKey;
  var Accept: Boolean);
begin
  Accept:=True;
end;

procedure Tdm_flam.fDirectoryList(Sender: TObject; const Path: string;
  const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo; EOF: Boolean);
begin
     if (FileInfo = nil) or (FileInfo.Filename = '.') or (FileInfo.Filename = '..') then
    Exit;

  if FileExists(dir_temp + IntToStr(u_main.main_cli)+'\' + fileinfo.Filename) then
      DeleteFile(dir_temp + IntToStr(u_main.main_cli)+'\'+fileinfo.Filename);

  if Pos(tit_file_ups,fileinfo.Filename)=u_main.pos_tit_ups then
       f.DownloadFile(path+'/'+FileInfo.Filename,dir_temp+ IntToStr(u_main.main_cli)+'\'+fileinfo.Filename,False,0);
end;

function Tdm_flam.ProcesaFichero(tipo:string;nom_fichero:string): string;
  var
    error, texto, cod_envio, ruta_pdf: string;
    i, id_pedido, id_ped_line, id_art_in,
    id_art_out, id_etiq, dir_dest, id_albaran, lineas_fichero, lineas_procesadas:integer;
begin
    Result := '';

    lineas_fichero := 0;
    lineas_procesadas := 0;

    try
        if tipo='xls' then  //excel
        begin

          AbreFichero(dir_temp + IntToStr(u_main.main_cli)+'\'+nom_fichero);
          Hoja := excel.Worksheets.Item[1];

          i := 2;

          while Trim(hoja.cells[i,3])<>'' do
          begin
              Inc(lineas_fichero);

              id_pedido := u_pedidos.GetIdPedido(Trim(hoja.cells[i,3]),cod_cli);

              if (id_pedido>0) then
              begin
                if not dmLabels.pedidoTieneEtiqueta(id_pedido) then
                begin
                  id_albaran := GetAlbaranPedido(id_pedido);
                  cod_envio := Trim(hoja.cells[i,5]);

                  if (cod_envio<>'') and (id_albaran>0) then
                  begin
                    ruta_pdf  := u_main.ftp_dir_ups + '/' + nom_fichero;

                    with TpFIBDataSet.Create(self) do
                    try
                      Database:=dm.db;
                      sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ETIQUETAS_ID,1) FROM RDB$DATABASE');
                      Open;
                      id_etiq:=FieldByName('gen_id').AsInteger;
                    finally
                      free;
                    end;

                    dm.q_1.Close;
                    dm.q_1.sql.Clear;
                    dm.q_1.sql.Add('insert into c_pedidos_etiquetas '+
                      '(id_pedido_etiqueta, id_pedido, num_bulto, cod_envio, ruta_pdf) ' +
                      'values (:id_pedido_etiqueta,:id_pedido, :num_bulto, :cod_envio, :ruta_pdf)');

                    dm.q_1.ParamByName('id_pedido_etiqueta').AsInteger := id_etiq;
                    dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
                    dm.q_1.ParamByName('num_bulto').AsInteger := 1;
                    dm.q_1.ParamByName('cod_envio').AsString :=  cod_envio;
                    dm.q_1.ParamByName('ruta_pdf').AsString := '/sync/public/flamingos' + ruta_pdf;

                    dm.q_1.ExecQuery;

                    u_globals_gestoras.update_exp_age_albaran(id_albaran,cod_envio);

                    if u_main.envia_correo_a_dst then
                           f_main.enviar_email_pedidos(id_pedido);
                  end;
                end;
                Inc(lineas_procesadas)
              end;

              devos_imp.Add(IntToStr(id_etiq));

              Inc(i);
          end;

          Excel.Quit ;
          Excel := Unassigned;

          if lineas_fichero=lineas_procesadas then
                  Result := FormatDateTime('yyyymmddhhnn',Now) + '_' + nom_fichero;

        end else if tipo='txt' then  //texto
                 begin

                 end;
    except
        Result := '';
        Excel.Quit ;
        Excel := Unassigned;
    end;

end;

procedure Tdm_flam.AbreFichero(ruta:string);
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

function Tdm_flam.ficheroEnUso (fichero : string) : boolean;
var
 // HFileRes : HFILE;
  Res : string[6];
begin
 { Result := False;

  HFileRes := CreateFile (pchar (fichero),
      GENERIC_READ or GENERIC_WRITE, 0,
      nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle (HFileRes);  }
end;

end.
