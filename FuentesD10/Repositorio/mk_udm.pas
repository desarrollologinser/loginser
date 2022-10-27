unit mk_udm;

interface

uses
  System.SysUtils, System.Classes, Marketing.Manipulado,
  Marketing.TareaManipulado, Marketing.CorreoCliente,
  Marketing.CorreoServicio, Marketing.Servicios,
  Marketing.TarifaCliente, Marketing.Correos, ORM.General,
  Marketing.TareaCliente,Sistema.Sesion, Data.DB, DataSet.MdDsCustom,
  DataSet.MdDsList, DataSet.MdDsConsulta, General.Clientep,
  Marketing.ServiciosManipulado;

type
  Tdm = class(TDataModule)
    QTipoRecogida: TMdConsultaDataSet;
    QTipoRecogidaTIPO: TWideStringField;
    TareaCliente: TTareaClienteComponente;
    Correo: TCorreoComponente;
    ServicioManipulado: TServicioManipuladoComponente;
    CorreoServicio: TCorreoServicioComponente;
    TareaManipulado: TTareaManipuladoComponente;
    CorreoCliente: TCorreoClienteComponente;
    Manipulado: TManipuladoComponente;
    TarifaCliente: TTarifaClienteComponente;
    Cliente: TClientepComponente;
  private
    { Private declarations }
  public
    { Public declarations }
    function LeerIniCorreos: TStringList;
    function LeerIni(seccion:string;Campos:TStringList): TStringList;
    function EsRecogidaConTarifaFija(cliente:Integer):Boolean;
  end;

var
  dm: Tdm;

implementation

uses
    System.IniFiles;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


function Tdm.LeerIniCorreos: TStringList;
var
  ini: TIniFile;
  Rutas: TStringList;
begin
  try
    ini := TIniFile.Create(Sesion.RutaIni);
    Rutas := TStringList.Create;

    Rutas.Add(ini.ReadString('Manipulados', 'dir_correos', 'C:\'));
    Rutas.Add(ini.ReadString('Manipulados', 'dir_xls_correos', 'C:\'));
    Rutas.Add(ini.ReadString('Manipulados', 'dir_remoto','\\seth\SysFiles\Correos\'));
    Rutas.Add(ini.ReadString('Manipulados', 'tarea_correos', '54'));
    Rutas.Add(ini.ReadString('Manipulados', 'id_recogida', '280'));
    Rutas.Add(ini.ReadString('Manipulados', 'dir_save', 'C:\'));

    Result := Rutas;
  finally
    ini.Free;
    // Rutas.Free;
  end;
end;

function Tdm.EsRecogidaConTarifaFija(cliente: Integer):Boolean;
var
  datos: TStringList;
begin
      datos := LeerIniCorreos;
      QTipoRecogida.Active := False;
      QTipoRecogida.Params.ParamByName('CLIENTE').AsInteger := cliente;
      QTipoRecogida.Params.ParamByName('SERVICIO').AsInteger := StrToInt(datos[4]);
      QTipoRecogida.Active := True;
      if ((QTipoRecogida.FieldByName('TIPO').AsString<>'') and (QTipoRecogida.FieldByName('TIPO').AsString = 'F')) then
          Result := True
      else
          Result := False;
end;

function Tdm.LeerIni(seccion:string;Campos:TStringList): TStringList;
var
  ini: TIniFile;
  valores: TStringList;
  i: integer;
begin
  try
    ini := TIniFile.Create(Sesion.RutaIni);
    valores := TStringList.Create;

    for I := 0 to Campos.Count-1 do
    begin
      Valores.Add(ini.ReadString(seccion, campos[i],''));
    end;

    Result := Valores;
  finally
    ini.Free;
    // Campos.Free;
  end;
end;

end.
