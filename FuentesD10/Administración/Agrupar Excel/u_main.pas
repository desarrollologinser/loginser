unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton, Vcl.StdCtrls,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, Vcl.ComCtrls, sLabel, System.Win.ComObj,
  Types, System.StrUtils, Data.DB, Datasnap.DBClient, pFIBDataSet;

type
  Tf_main = class(TForm)
    pb1: TProgressBar;
    edFile: TsFilenameEdit;
    btProcesa: TsSpeedButton;
    lbEstado: TsLabel;
    lbDestino: TsLabel;
    dlg: TOpenDialog;
    stat: TStatusBar;
    cds: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure btProcesaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AbreFichero(ruta: string);
    procedure CreaExcel;
    procedure CargarInterfaz;
    procedure LoadConfigCliente(items: string);
  public
    { Public declarations }
  end;

var
  f_main: Tf_main;
  excel, xls_dst, libro: Variant;
  hoja: OleVariant;
  fmt_xls_fact: string;

const
  v = '[-1]';
  main_cli = 20;

implementation

{$R *.dfm}

uses
  u_globals, u_dm;

procedure Tf_main.btProcesaClick(Sender: TObject);
var
  file_dst: string;
  config_file,columnas, totales, totales_gr: TStringDynArray;
  agrupado_por, i, j, fila, cds_idx, serv_col, cds_serv:integer;
  servicios_gr: tstringlist;
  enc_serv: Boolean;

begin
    if not FileExists(edFile.FileName) then
    begin
      ShowMessage('No existe el fichero indicado.');
      Exit
    end;

    if fmt_xls_fact='' then
    begin
      ShowMessage('No existe configuración de fichero válida.');
      Exit
    end;

    dlg.FileName := FormatDateTime('yyyymmdd_',Now) + ExtractFileName(edFile.FileName);

    if lbDestino.Caption<>'' then
    begin
       If MessageDlg('Se va a crear el fichero en la siguiente ruta:' + #13#10 +
                      lbDestino.Caption + #13#10 +
                    '¿Desea cambiarla?',mtConfirmation,[mbYes,mbNo],0,mbYes)=mrYes then
       begin
         If dlg.Execute then
          file_dst := dlg.FileName
         else begin
                lbDestino.Caption := 'Proceso cancelado.';
                ShowMessage('Proceso cancelado.');
                Exit;
             end;
       end else file_dst := lbDestino.Caption;
    end else
         If dlg.Execute then
          file_dst := dlg.FileName
         else begin
                lbEstado.Caption := 'Proceso cancelado.';
                ShowMessage('Proceso cancelado.');
                Exit;
             end;

   if UpperCase(file_dst)=UpperCase(edFile.FileName) then
   begin
     ShowMessage('Los ficheros origen y destino no pueden coincidir.');
     lbEstado.Caption := 'Proceso cancelado.';
     Exit;
   end;

      lbEstado.Caption := 'Leyendo fichero origen ...';

      lbDestino.Caption := file_dst;

      config_file := splitstring(fmt_xls_fact,'*');
      columnas := splitstring(config_file[0],',');
      agrupado_por := StrToInt(config_file[1]);
      serv_col := StrToInt(config_file[2]);
      totales_gr := splitstring(config_file[3],',');
      totales := splitstring(config_file[4],',');

      servicios_gr := TStringList.Create;

      AbreFichero(edFile.FileName);

      with cds do
      begin
        for I := 0 to High(columnas) do
        begin
            FieldDefs.Add('col'+IntToStr(i),ftString,200);
            if StrToIntDef(columnas[i],-1)=agrupado_por then
                cds_idx := i;

            if StrToIntDef(columnas[i],-1)=serv_col then
                cds_serv := i;
        end;

        IndexFieldNames := 'col' + IntToStr(cds_idx);

        CreateDataSet;
        Open;

        fila := 2;

        //Rellenar cds
        while not (Trim(excel.cells[fila, 1]) = '') do
        begin
            Insert;
            for I := 0 to High(columnas) do
            begin
              FieldByName('col'+IntToStr(i)).AsString := excel.cells[fila, StrToInt(columnas[i])];

              //Si estamos en la columna del servicio, lo contamos
              if i=cds_serv then
              begin
                enc_serv := false;
                j := 0;

                while not enc_serv and (j<=servicios_gr.Count-1) do
                   if servicios_gr[j]=excel.cells[fila, StrToInt(columnas[i])] then
                   begin
                      servicios_gr[j+1] := (InttoStr(StrToInt(servicios_gr[j+1])+1));
                      enc_serv := True;
                   end;

                if not enc_serv then
                begin
                  servicios_gr.Add(excel.cells[fila, StrToInt(columnas[i])]);;
                  servicios_gr.Add('1');
                end;

              end;

             { If StrToIntDef(excel.cells[fila, StrToInt(columnas[i])],-1)>=0 then
                    FieldByName('col'+IntToStr(i)).AsInteger := excel.cells[fila, StrToInt(columnas[i])]
              else If StrToFloatDef(excel.cells[fila, StrToInt(columnas[i])],-1)>=0 then
                       FieldByName('col'+IntToStr(i)).AsFloat := excel.cells[fila, StrToInt(columnas[i])]
                   else
                       FieldByName('col'+IntToStr(i)).AsString;   }
            end;
            Post;
            Inc(fila);
        end;

        lbEstado.Caption := 'Creando fichero destino ...';
        CreaExcel;

        First;
        fila := 1;

        //Insertar cabeceras en fichero destino
        for I := 0 to High(columnas) do
        begin
            xls_dst.cells[fila,i+1] := excel.cells[1, StrToInt(columnas[i])];
        end;

        Inc(fila);

        //Insertar registros en fichero destino
        while not cds.Eof do
        begin
          for I := 0 to High(columnas) do
          begin
            xls_dst.cells[fila,i+1] := FieldByName('col'+IntToStr(i)).AsString;
          end;
          Inc(fila);
          Next;
        end;

        for i := 0 to servicios_gr.count - 1 do
        begin
          if (i mod 2)=0 then
          begin
          xls_dst.cells[fila,serv_col] := servicios_gr[i];
           xls_dst.cells[fila,serv_col+1] := servicios_gr[i+1];
           Inc(fila);
          end;
        end;



			  end;

      xls_dst.activeworkbook.saveas(file_dst);

      //hoja.cells[r, col_destino_contacto]  leer una celda

      cds.FieldDefs.Clear;
      cds.Close;

      FreeAndNil(servicios_gr);

      Excel.Quit;
      Excel := Unassigned;
      xls_dst.quit;
      xls_dst := Unassigned;

      lbEstado.Caption := 'Proceso finalizado.';
      ShowMessage('Proceso finalizado.');

end;

procedure Tf_main.FormCreate(Sender: TObject);
begin
  leer_ini;

  stat.panels[0].Text := u_globals.dbname;


end;

procedure Tf_main.FormShow(Sender: TObject);
begin
    Caption := 'Agrupar Excel ' + v;
    lbEstado.Caption := '';
    lbDestino.Caption := '';

    CargarInterfaz;
end;

procedure Tf_main.AbreFichero(ruta: string);
begin
  Excel := CreateOleObject('Excel.Application');
  try
    Excel.Visible := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(ruta); //fichero que queremos leer
  except
    Excel.Quit;
    Excel := Unassigned;
  end;
end;

procedure Tf_main.CreaExcel;
begin
  xls_dst := CreateOleObject('Excel.Application');
  try
    xls_dst.Visible := False;
    xls_dst.DisplayAlerts := False;
    xls_dst.WorkBooks.add;
  except
    xls_dst.Quit;
    xls_dst := Unassigned;
  end;
end;


procedure Tf_main.CargarInterfaz;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
    ParamByName('id_cliente').AsInteger := main_cli;
    Open;
    First;

    if not IsEmpty then
    begin
       LoadConfigCliente(FieldByName('items').AsString);
	  end;
  finally
    free;
  end;
end;

procedure Tf_main.LoadConfigCliente(items: string);
var
  f_type, order_ok, datos_ag: string;
  i: integer;
  stream: TStream;
  str_agencia: TStringDynArray;
  item_list, par: TStringList;
  item_name, item_value: string;
begin

  item_list := TStringList.Create;
  item_list.Delimiter := '$';
  item_list.DelimitedText := items;

  if item_list.Count > 0 then
  begin
    par := TStringList.Create;
    par.Delimiter := '|';

    for i := 0 to item_list.Count - 1 do
    begin
      par.DelimitedText := item_list[i];

      if UpperCase(par[0]) = 'FMT_XLS_FACT' then
        fmt_xls_fact := par[1];
    end;
  end;
end;
end.
