unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Vcl.ExtCtrls, System.DateUtils,
  Vcl.StdCtrls, sButton, System.Classes, ScSSLClient, ScSSHClient, ScBridge,
  ScSFTPClient, sComboBox;

type
  t_elemento = record
    tipo:integer;                //1-bakup 2-script 3-sync 4-pick
    idx:integer;                 //Idx dentro de su tipo
    sig_ejec:tdate;              //Dia/Hora de la siguiente ejecucion
    intervalo:integer;           //Intervalo de tiempo entre ejecuciones
  end;

  t_demonio = record
     nombre: string;
     repeticiones:Integer;
  end;

  Tf_main = class(TForm)
    tm_1: TTimer;
    grp1: TGroupBox;
    mm1: TMemo;
    btEstados: TsButton;
    btAdjuntos: TsButton;
    bt_2: TsButton;
    grp2: TGroupBox;
    mm2: TMemo;
    sButton2: TsButton;
    sButton3: TsButton;
    grp3: TGroupBox;
    mm3: TMemo;
    sButton4: TsButton;
    grp4: TGroupBox;
    mm4: TMemo;
    sButton1: TsButton;
    sButton5: TsButton;
    gbDemonios: TGroupBox;
    mmClientes: TMemo;
    sButton6: TsButton;
    sComboBox1: TsComboBox;
    procedure FormShow(Sender: TObject);
    procedure tm_1Timer(Sender: TObject);
    procedure bt_2Click(Sender: TObject);
    procedure btEstadosClick(Sender: TObject);
    procedure btAdjuntosClick(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure cargar_fechas;
    procedure guardar_ini(idx:Integer);
  end;

var
  f_main: Tf_main;

  ar_elementos:array of t_elemento;   //array de elementos cargados
  idx_elementos:Integer=0;            //Idx de elementos cargados
  ar_demons: array of t_demonio;
  idx_demonios:Integer=0;            //Idx de demonios cargados

const
  v = '[3.0]';
  //[3] Control de config desde db. Desaparece Bankia. Control de clientes. Backup.

implementation

uses
  u_globals, u_dm, u_listados, MidasLib, u_adjuntos, u_estados, u_clientes,
  u_articulos, u_controles;

{$R *.dfm}

procedure Tf_main.FormShow(Sender: TObject);
begin
  u_globals.leer_ini;
  Caption := 'Demonio ' + v;
  mm1.Lines.Clear;
  cargar_fechas;
  tm_1.Enabled:=true;
end;

procedure Tf_main.guardar_ini(idx:Integer);
var ini:tinifile;
begin                     //Guarda datos al ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_nut.ini');
  try
    case ar_elementos[idx].tipo of
      1:ini.writestring('Listados_'+inttostr(ar_elementos[idx].idx),'sig_Ejec',datetimetostr(ar_elementos[idx].sig_ejec));
      2:ini.writestring('Adjuntos_'+inttostr(ar_elementos[idx].idx),'sig_Ejec',datetimetostr(ar_elementos[idx].sig_ejec));
      3:ini.writestring('Estados_'+inttostr(ar_elementos[idx].idx),'sig_Ejec',datetimetostr(ar_elementos[idx].sig_ejec));
    end;
  finally
    ini.free;
  end;
end;

procedure Tf_main.sButton4Click(Sender: TObject);
begin
  fclientes.ShowModal;
end;

procedure Tf_main.sButton5Click(Sender: TObject);
begin
  f_articulos.ShowModal;
end;

procedure Tf_main.sButton6Click(Sender: TObject);
begin
  f_controles.ShowModal;
end;

procedure Tf_main.btAdjuntosClick(Sender: TObject);
begin
   f_adjuntos.ShowModal;
end;

procedure Tf_main.btEstadosClick(Sender: TObject);
begin
   f_estados.ShowModal;
end;

procedure Tf_main.tm_1Timer(Sender: TObject);
var i:integer;   s:string;   f:TextFile;
begin

  for i:=0 to idx_elementos-1 do begin
    if ar_elementos[i].sig_ejec<=now then begin        //ha pasado la hora
      tm_1.Enabled:=false;
      try
        s:='';
        case ar_elementos[i].tipo of
          1:begin
            s:='Listados - '+inttostr(ar_elementos[i].idx);
            f_listados.lanza_listados(ar_elementos[i].idx,False);
          end;

          2:begin
            s:='Adjuntos - '+inttostr(ar_elementos[i].idx);
            f_adjuntos.procesa_adjuntos(ar_elementos[i].idx,False);
          end;

          3:begin
            s:='Estados - '+inttostr(ar_elementos[i].idx);
            f_estados.procesa_estados(ar_elementos[i].idx,False);
          end;

        end;
        repeat
          ar_elementos[i].sig_ejec:=incminute(ar_elementos[i].sig_ejec,ar_elementos[i].intervalo);    //nueva ejecucion
        until (ar_elementos[i].sig_ejec>now);
        guardar_ini(i);
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

procedure Tf_main.bt_2Click(Sender: TObject);
begin
  f_listados.showmodal;
end;

procedure Tf_main.cargar_fechas;
var ini:tinifile;  n_listados,n_adjuntos,n_estados,i:Integer;
begin

  with dm.q1 do
  begin
    Close;
    SelectSQL.Add('select * from s_demonios where estado=:estado');
    ParamByName('estado').AsString := 'A';
    Open;

    if not IsEmpty then
    begin
       setlength(ar_demons,0);           //limpia array
       idx_demonios:=1;
       i:=1;

       first;
       while not Eof do
       begin
          SetLength(ar_demons,idx_demonios);
          ar_demons[i].nombre := 'n_' + FieldByName('nombre').AsString;
          ar_demons[i].repeticiones := FieldByName('repeticiones').AsInteger;
          Next;
       end;
    end;
  end;

                                                             //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_nut.ini');
  try
    n_listados:=StrToInt(ini.readstring('Datos','n_listados','0'));
    n_adjuntos:=StrToInt(ini.readstring('Datos','n_adjuntos','0'));
    n_estados:=StrToInt(ini.readstring('Datos','n_estados','0'));

    setlength(ar_elementos,0);           //limpia array
    idx_elementos:=1;

    for i:=1 to n_listados do begin
      SetLength(ar_elementos,idx_elementos);
      ar_elementos[idx_elementos-1].tipo:=1;
      ar_elementos[idx_elementos-1].idx:=i;
      ar_elementos[idx_elementos-1].sig_ejec:=StrToDatetime(ini.readstring('Listados_'+inttostr(i),'sig_ejec','01/01/2020 00:00:00'));
      ar_elementos[idx_elementos-1].intervalo:=StrToInt(ini.readstring('Listados_'+inttostr(i),'intervalo','1440'));

      inc(idx_elementos);
    end;

    for i:=1 to n_adjuntos do begin
      SetLength(ar_elementos,idx_elementos);
      ar_elementos[idx_elementos-1].tipo:=2;
      ar_elementos[idx_elementos-1].idx:=i;
      ar_elementos[idx_elementos-1].sig_ejec:=StrToDatetime(ini.readstring('Adjuntos_'+inttostr(i),'sig_ejec','01/01/2020 00:00:00'));
      ar_elementos[idx_elementos-1].intervalo:=StrToInt(ini.readstring('Adjuntos_'+inttostr(i),'intervalo','1440'));

      inc(idx_elementos);
    end;

    for i:=1 to n_estados do begin
      SetLength(ar_elementos,idx_elementos);
      ar_elementos[idx_elementos-1].tipo:=3;
      ar_elementos[idx_elementos-1].idx:=i;
      ar_elementos[idx_elementos-1].sig_ejec:=StrToDatetime(ini.readstring('Estados_'+inttostr(i),'sig_ejec','01/01/2020 00:00:00'));
      ar_elementos[idx_elementos-1].intervalo:=StrToInt(ini.readstring('estados_'+inttostr(i),'intervalo','1440'));

      inc(idx_elementos);
    end;

    dec(idx_elementos);
  finally
    ini.free;
  end;

end;

end.
