
{*****************************************************************************}
{                                                                             }
{                              XML Data Binding                               }
{                                                                             }
{         Generated on: 22/06/2015 18:32:38                                   }
{       Generated from: C:\Users\Ivan.LOGINSER\Desktop\Muzybar\Document.xsd   }
{   Settings stored in: C:\Users\Ivan.LOGINSER\Desktop\Muzybar\Document.xdb   }
{                                                                             }
{*****************************************************************************}

unit Documento;

interface

uses xmldom, XMLDoc, XMLIntf,variants;

type

{ Forward Decls }

  IXMLDocumento = interface;
  IXMLDocumento_InfGeneral = interface;
  IXMLDocumento_InfGeneral_InfAlb = interface;
  IXMLDocumento_InfGeneral_InfAlb_InfDetAlb = interface;
  IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb = interface;
  IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList = interface;

{ IXMLDocumento }

  IXMLDocumento = interface(IXMLNode)
    ['{7208C0A8-E945-46F9-91EC-F92043DE9C89}']
    { Property Accessors }
    function Get_Xsi: UnicodeString;
    function Get_InfGeneral: IXMLDocumento_InfGeneral;
    procedure Set_Xsi(Value: UnicodeString);
    { Methods & Properties }
    property Xsi: UnicodeString read Get_Xsi write Set_Xsi;
    property InfGeneral: IXMLDocumento_InfGeneral read Get_InfGeneral;
  end;

{ IXMLDocumento_InfGeneral }

  IXMLDocumento_InfGeneral = interface(IXMLNode)
    ['{77111668-D5CD-4320-9558-8F5285BF38E6}']
    { Property Accessors }
    function Get_MsgId: UnicodeString;
    function Get_MsgNomFic: UnicodeString;
    function Get_MsgDtTm: UnicodeString;
    function Get_MsgEmp: UnicodeString;
    function Get_NumAlbs: Integer;
    function Get_InfAlb: IXMLDocumento_InfGeneral_InfAlb;
    procedure Set_MsgId(Value: UnicodeString);
    procedure Set_MsgNomFic(Value: UnicodeString);
    procedure Set_MsgDtTm(Value: UnicodeString);
    procedure Set_MsgEmp(Value: UnicodeString);
    procedure Set_NumAlbs(Value: Integer);
    { Methods & Properties }
    property MsgId: UnicodeString read Get_MsgId write Set_MsgId;
    property MsgNomFic: UnicodeString read Get_MsgNomFic write Set_MsgNomFic;
    property MsgDtTm: UnicodeString read Get_MsgDtTm write Set_MsgDtTm;
    property MsgEmp: UnicodeString read Get_MsgEmp write Set_MsgEmp;
    property NumAlbs: Integer read Get_NumAlbs write Set_NumAlbs;
    property InfAlb: IXMLDocumento_InfGeneral_InfAlb read Get_InfAlb;
  end;

{ IXMLDocumento_InfGeneral_InfAlb }

  IXMLDocumento_InfGeneral_InfAlb = interface(IXMLNode)
    ['{7095FCD2-EDD7-46ED-80D2-13C075191149}']
    { Property Accessors }
    function Get_IdAlb: Integer;
    function Get_Fecha: UnicodeString;
    function Get_FecEnt: UnicodeString;
    function Get_IdCli: Integer;
    function Get_Cliente: UnicodeString;
    function Get_NomEnv: UnicodeString;
    function Get_DirEnv: UnicodeString;
    function Get_CPEnv: UnicodeString;
    function Get_PobEnv: UnicodeString;
    function Get_ProEnv: UnicodeString;
    function Get_PaiEnv: UnicodeString;
    function Get_TlfEnv: UnicodeString;
    function Get_IdTrans: Integer;
    function Get_Transpor: UnicodeString;
    function Get_Bultos: Integer;
    function Get_Tracking: UnicodeString;
    function Get_InfDetAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb;
    function Get_Remitente: UnicodeString;
    function Get_Contacto: UnicodeString;
    function Get_emailEnv: UnicodeString;
    procedure Set_IdAlb(Value: Integer);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_FecEnt(Value: UnicodeString);
    procedure Set_IdCli(Value: Integer);
    procedure Set_Cliente(Value: UnicodeString);
    procedure Set_NomEnv(Value: UnicodeString);
    procedure Set_DirEnv(Value: UnicodeString);
    procedure Set_CPEnv(Value: UnicodeString);
    procedure Set_PobEnv(Value: UnicodeString);
    procedure Set_ProEnv(Value: UnicodeString);
    procedure Set_PaiEnv(Value: UnicodeString);
    procedure Set_TlfEnv(Value: UnicodeString);
    procedure Set_IdTrans(Value: Integer);
    procedure Set_Transpor(Value: UnicodeString);
    procedure Set_Tracking(Value: UnicodeString);
    procedure Set_Bultos(Value: Integer);
    procedure Set_Remitente(Value: UnicodeString);
    procedure Set_Contacto(Value: UnicodeString);
    procedure Set_emailEnv(Value: UnicodeString);

    { Methods & Properties }
    property IdAlb: Integer read Get_IdAlb write Set_IdAlb;
    property Fecha: UnicodeString read Get_Fecha write Set_Fecha;
    property FecEnt: UnicodeString read Get_FecEnt write Set_FecEnt;
    property IdCli: Integer read Get_IdCli write Set_IdCli;
    property Cliente: UnicodeString read Get_Cliente write Set_Cliente;
    property NomEnv: UnicodeString read Get_NomEnv write Set_NomEnv;
    property DirEnv: UnicodeString read Get_DirEnv write Set_DirEnv;
    property CPEnv: UnicodeString read Get_CPEnv write Set_CPEnv;
    property PobEnv: UnicodeString read Get_PobEnv write Set_PobEnv;
    property ProEnv: UnicodeString read Get_ProEnv write Set_ProEnv;
    property PaiEnv: UnicodeString read Get_PaiEnv write Set_PaiEnv;
    property TlfEnv: UnicodeString read Get_TlfEnv write Set_TlfEnv;
    property IdTrans: Integer read Get_IdTrans write Set_IdTrans;
    property Transpor: UnicodeString read Get_Transpor write Set_Transpor;
    property Bultos: Integer read Get_Bultos write Set_Bultos;
    property Tracking: UnicodeString read Get_Tracking write Set_Tracking;
    property InfDetAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb read Get_InfDetAlb;
    property Remitente: UnicodeString read Get_Remitente write Set_Remitente;
    property Contacto: UnicodeString read Get_Contacto write Set_Contacto;
    property emailEnv: UnicodeString read Get_emailEnv write Set_emailEnv;
  end;

{ IXMLDocumento_InfGeneral_InfAlb_InfDetAlb }

  IXMLDocumento_InfGeneral_InfAlb_InfDetAlb = interface(IXMLNode)
    ['{CD4027F1-7A33-4271-9A65-EDFE24AED9EF}']
    { Property Accessors }
    function Get_LinAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList;
    function Get_NLinsAlb: Integer;
    procedure Set_NLinsAlb(Value: Integer);
    { Methods & Properties }
    property LinAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList read Get_LinAlb;
    property NLinsAlb: Integer read Get_NLinsAlb write Set_NLinsAlb;
  end;

{ IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb }

  IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb = interface(IXMLNode)
    ['{0F52F1F1-E2C5-4B24-8157-ED0697B904F5}']
    { Property Accessors }
    function Get_DIdAlb: Integer;
    function Get_IdLin: Integer;
    function Get_DFecha: UnicodeString;
    function Get_DFecEnt: UnicodeString;
    function Get_IdArt: Integer;
    function Get_Articulo: UnicodeString;
    function Get_Unidades: Integer;
    function Get_NSerie: UnicodeString;
    function Get_Almacen: Integer;
    procedure Set_DIdAlb(Value: Integer);
    procedure Set_IdLin(Value: Integer);
    procedure Set_DFecha(Value: UnicodeString);
    procedure Set_DFecEnt(Value: UnicodeString);
    procedure Set_IdArt(Value: Integer);
    procedure Set_Articulo(Value: UnicodeString);
    procedure Set_Unidades(Value: Integer);
    procedure Set_NSerie(Value: UnicodeString);
    procedure Set_Almacen(Value: Integer);
    { Methods & Properties }
    property DIdAlb: Integer read Get_DIdAlb write Set_DIdAlb;
    property IdLin: Integer read Get_IdLin write Set_IdLin;
    property DFecha: UnicodeString read Get_DFecha write Set_DFecha;
    property DFecEnt: UnicodeString read Get_DFecEnt write Set_DFecEnt;
    property IdArt: Integer read Get_IdArt write Set_IdArt;
    property Articulo: UnicodeString read Get_Articulo write Set_Articulo;
    property Unidades: Integer read Get_Unidades write Set_Unidades;
    property NSerie: UnicodeString read Get_NSerie write Set_NSerie;
    property Almacen: Integer read Get_Almacen write Set_Almacen;
  end;

{ IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList }

  IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList = interface(IXMLNodeCollection)
    ['{1A34BA4D-4054-4FB1-B775-72A3ACE4F842}']
    { Methods & Properties }
    function Add: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
    function Insert(const Index: Integer): IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;

    function Get_Item(Index: Integer): IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
    property Items[Index: Integer]: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb read Get_Item; default;
  end;

{ Forward Decls }

  TXMLDocumento = class;
  TXMLDocumento_InfGeneral = class;
  TXMLDocumento_InfGeneral_InfAlb = class;
  TXMLDocumento_InfGeneral_InfAlb_InfDetAlb = class;
  TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb = class;
  TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList = class;

{ TXMLDocumento }

  TXMLDocumento = class(TXMLNode, IXMLDocumento)
  protected
    { IXMLDocumento }
    function Get_Xsi: UnicodeString;
    function Get_InfGeneral: IXMLDocumento_InfGeneral;
    procedure Set_Xsi(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDocumento_InfGeneral }

  TXMLDocumento_InfGeneral = class(TXMLNode, IXMLDocumento_InfGeneral)
  protected
    { IXMLDocumento_InfGeneral }
    function Get_MsgId: UnicodeString;
    function Get_MsgNomFic: UnicodeString;
    function Get_MsgDtTm: UnicodeString;
    function Get_MsgEmp: UnicodeString;
    function Get_NumAlbs: Integer;
    function Get_InfAlb: IXMLDocumento_InfGeneral_InfAlb;
    procedure Set_MsgId(Value: UnicodeString);
    procedure Set_MsgNomFic(Value: UnicodeString);
    procedure Set_MsgDtTm(Value: UnicodeString);
    procedure Set_MsgEmp(Value: UnicodeString);
    procedure Set_NumAlbs(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDocumento_InfGeneral_InfAlb }

  TXMLDocumento_InfGeneral_InfAlb = class(TXMLNode, IXMLDocumento_InfGeneral_InfAlb)
  protected
    { IXMLDocumento_InfGeneral_InfAlb }
    function Get_IdAlb: Integer;
    function Get_Fecha: UnicodeString;
    function Get_FecEnt: UnicodeString;
    function Get_IdCli: Integer;
    function Get_Cliente: UnicodeString;
    function Get_NomEnv: UnicodeString;
    function Get_DirEnv: UnicodeString;
    function Get_CPEnv: UnicodeString;
    function Get_PobEnv: UnicodeString;
    function Get_ProEnv: UnicodeString;
    function Get_PaiEnv: UnicodeString;
    function Get_TlfEnv: UnicodeString;
    function Get_IdTrans: Integer;
    function Get_Transpor: UnicodeString;
    function Get_Bultos: Integer;
    function Get_Remitente: UnicodeString;
    function Get_Tracking: UnicodeString;
    function Get_InfDetAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb;
    function Get_Contacto: UnicodeString;
    function Get_emailEnv: UnicodeString;
    procedure Set_IdAlb(Value: Integer);
    procedure Set_Fecha(Value: UnicodeString);
    procedure Set_FecEnt(Value: UnicodeString);
    procedure Set_IdCli(Value: Integer);
    procedure Set_Cliente(Value: UnicodeString);
    procedure Set_NomEnv(Value: UnicodeString);
    procedure Set_DirEnv(Value: UnicodeString);
    procedure Set_CPEnv(Value: UnicodeString);
    procedure Set_PobEnv(Value: UnicodeString);
    procedure Set_ProEnv(Value: UnicodeString);
    procedure Set_PaiEnv(Value: UnicodeString);
    procedure Set_TlfEnv(Value: UnicodeString);
    procedure Set_IdTrans(Value: Integer);
    procedure Set_Transpor(Value: UnicodeString);
    procedure Set_Bultos(Value: Integer);
    procedure Set_Tracking(Value: UnicodeString);
    procedure Set_Remitente(Value: UnicodeString);
    procedure Set_Contacto(Value: UnicodeString);
    procedure Set_emailEnv(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDocumento_InfGeneral_InfAlb_InfDetAlb }

  TXMLDocumento_InfGeneral_InfAlb_InfDetAlb = class(TXMLNode, IXMLDocumento_InfGeneral_InfAlb_InfDetAlb)
  private
    FLinAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList;
  protected
    { IXMLDocumento_InfGeneral_InfAlb_InfDetAlb }
    function Get_LinAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList;
    function Get_NLinsAlb: Integer;
    procedure Set_NLinsAlb(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb }

  TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb = class(TXMLNode, IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb)
  protected
    { IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb }
    function Get_DIdAlb: Integer;
    function Get_IdLin: Integer;
    function Get_DFecha: UnicodeString;
    function Get_DFecEnt: UnicodeString;
    function Get_IdArt: Integer;
    function Get_Articulo: UnicodeString;
    function Get_Unidades: Integer;
    function Get_NSerie: UnicodeString;
    function Get_Almacen: Integer;
    procedure Set_DIdAlb(Value: Integer);
    procedure Set_IdLin(Value: Integer);
    procedure Set_DFecha(Value: UnicodeString);
    procedure Set_DFecEnt(Value: UnicodeString);
    procedure Set_IdArt(Value: Integer);
    procedure Set_Articulo(Value: UnicodeString);
    procedure Set_Unidades(Value: Integer);
    procedure Set_NSerie(Value: UnicodeString);
    procedure Set_Almacen(Value: Integer);
  end;

{ TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList }

  TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList = class(TXMLNodeCollection, IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList)
  protected
    { IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList }
    function Add: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
    function Insert(const Index: Integer): IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;

    function Get_Item(Index: Integer): IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
  end;

{ Global Functions }

function GetDocumento(Doc: IXMLDocument): IXMLDocumento;
function LoadDocumento(const FileName: string): IXMLDocumento;
function NewDocumento: IXMLDocumento;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetDocumento(Doc: IXMLDocument): IXMLDocumento;
begin
  Result := Doc.GetDocBinding('Document', TXMLDocumento, TargetNamespace) as IXMLDocumento;
end;

function LoadDocumento(const FileName: string): IXMLDocumento;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Document', TXMLDocumento, TargetNamespace) as IXMLDocumento;
end;

function NewDocumento: IXMLDocumento;
begin
  Result := NewXMLDocument.GetDocBinding('Document', TXMLDocumento, TargetNamespace) as IXMLDocumento;
end;

{ TXMLDocumento }

procedure TXMLDocumento.AfterConstruction;
begin
  RegisterChildNode('InfGeneral', TXMLDocumento_InfGeneral);
  inherited;
end;

function TXMLDocumento.Get_Xsi: UnicodeString;
begin
  Result := AttributeNodes['xmlns:xsi'].Text;
end;

procedure TXMLDocumento.Set_Xsi(Value: UnicodeString);
begin
  SetAttribute('xmlns:xsi', Value);
end;

function TXMLDocumento.Get_InfGeneral: IXMLDocumento_InfGeneral;
begin
  Result := ChildNodes['InfGeneral'] as IXMLDocumento_InfGeneral;
end;

{ TXMLDocumento_InfGeneral }

procedure TXMLDocumento_InfGeneral.AfterConstruction;
begin
  RegisterChildNode('InfAlb', TXMLDocumento_InfGeneral_InfAlb);
  inherited;
end;

function TXMLDocumento_InfGeneral.Get_MsgId: UnicodeString;
begin
  Result := ChildNodes['MsgId'].Text;
end;

procedure TXMLDocumento_InfGeneral.Set_MsgId(Value: UnicodeString);
begin
  ChildNodes['MsgId'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral.Get_MsgNomFic: UnicodeString;
begin
  Result := ChildNodes['MsgNomFic'].Text;
end;

procedure TXMLDocumento_InfGeneral.Set_MsgNomFic(Value: UnicodeString);
begin
  ChildNodes['MsgNomFic'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral.Get_MsgDtTm: UnicodeString;
begin
  Result := ChildNodes['MsgDtTm'].Text;
end;

procedure TXMLDocumento_InfGeneral.Set_MsgDtTm(Value: UnicodeString);
begin
  ChildNodes['MsgDtTm'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral.Get_MsgEmp: UnicodeString;
begin
  Result := ChildNodes['MsgEmp'].Text;
end;

procedure TXMLDocumento_InfGeneral.Set_MsgEmp(Value: UnicodeString);
begin
  ChildNodes['MsgEmp'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral.Get_NumAlbs: Integer;
begin
  Result := ChildNodes['NumAlbs'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral.Set_NumAlbs(Value: Integer);
begin
  ChildNodes['NumAlbs'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral.Get_InfAlb: IXMLDocumento_InfGeneral_InfAlb;
begin
  Result := ChildNodes['InfAlb'] as IXMLDocumento_InfGeneral_InfAlb;
end;

{ TXMLDocumento_InfGeneral_InfAlb }

procedure TXMLDocumento_InfGeneral_InfAlb.AfterConstruction;
begin
  RegisterChildNode('InfDetAlb', TXMLDocumento_InfGeneral_InfAlb_InfDetAlb);
  inherited;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_IdAlb: Integer;
begin
  Result := ChildNodes['IdAlb'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_IdAlb(Value: Integer);
begin
  ChildNodes['IdAlb'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Fecha: UnicodeString;
begin
  Result := ChildNodes['Fecha'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Fecha(Value: UnicodeString);
begin
  ChildNodes['Fecha'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_FecEnt: UnicodeString;
begin
  Result := ChildNodes['FecEnt'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_FecEnt(Value: UnicodeString);
begin
  ChildNodes['FecEnt'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_IdCli: Integer;
begin
  Result := ChildNodes['IdCli'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_IdCli(Value: Integer);
begin
  ChildNodes['IdCli'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Cliente: UnicodeString;
begin
  Result := ChildNodes['Cliente'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Cliente(Value: UnicodeString);
begin
  ChildNodes['Cliente'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_NomEnv: UnicodeString;
begin
  Result := ChildNodes['NomEnv'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_NomEnv(Value: UnicodeString);
begin
  ChildNodes['NomEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_DirEnv: UnicodeString;
begin
  Result := ChildNodes['DirEnv'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_DirEnv(Value: UnicodeString);
begin
  ChildNodes['DirEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_CPEnv: UnicodeString;
begin
  Result := ChildNodes['CPEnv'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_CPEnv(Value: UnicodeString);
begin
  ChildNodes['CPEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_PobEnv: UnicodeString;
begin
  Result := ChildNodes['PobEnv'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_PobEnv(Value: UnicodeString);
begin
  ChildNodes['PobEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_ProEnv: UnicodeString;
begin
  Result := ChildNodes['ProEnv'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_ProEnv(Value: UnicodeString);
begin
  ChildNodes['ProEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_PaiEnv: UnicodeString;
begin
  Result := ChildNodes['PaiEnv'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_PaiEnv(Value: UnicodeString);
begin
  ChildNodes['PaiEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_TlfEnv: UnicodeString;
begin
  if ChildNodes['TlfEnv'].NodeValue<>null then Result := ChildNodes['TlfEnv'].NodeValue
  else result:='';
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_TlfEnv(Value: UnicodeString);
begin
  ChildNodes['TlfEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_IdTrans: Integer;
begin
  Result := ChildNodes['IdTrans'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_IdTrans(Value: Integer);
begin
  ChildNodes['IdTrans'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Transpor: UnicodeString;
begin
  Result := ChildNodes['Transpor'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Transpor(Value: UnicodeString);
begin
  ChildNodes['Transpor'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Bultos: Integer;
begin
  Result := ChildNodes['Bultos'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Bultos(Value: Integer);
begin
  ChildNodes['Bultos'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Tracking: UnicodeString;
begin
  Result := ChildNodes['Tracking'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Tracking(Value: UnicodeString);
begin
  ChildNodes['Tracking'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_InfDetAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb;
begin
  Result := ChildNodes['InfDetAlb'] as IXMLDocumento_InfGeneral_InfAlb_InfDetAlb;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Remitente(Value: UnicodeString);
begin
  ChildNodes['Remitente'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Remitente: UnicodeString;
begin
  Result := ChildNodes['Remitente'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_Contacto(Value: UnicodeString);
begin
  ChildNodes['Contacto'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_Contacto: UnicodeString;
begin
  Result := ChildNodes['Contacto'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb.Set_emailEnv(Value: UnicodeString);
begin
  ChildNodes['emailEnv'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb.Get_emailEnv: UnicodeString;
begin
  Result := ChildNodes['emailEnv'].Text;
end;

{ TXMLDocumento_InfGeneral_InfAlb_InfDetAlb }

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb.AfterConstruction;
begin
  RegisterChildNode('LinAlb', TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb);
  FLinAlb := CreateCollection(TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList, IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb, 'LinAlb') as IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList;
  inherited;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb.Get_LinAlb: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList;
begin
  Result := FLinAlb;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb.Get_NLinsAlb: Integer;
begin
  Result := ChildNodes['NLinsAlb'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb.Set_NLinsAlb(Value: Integer);
begin
  ChildNodes['NLinsAlb'].NodeValue := Value;
end;

{ TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb }

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_DIdAlb: Integer;
begin
  Result := ChildNodes['DIdAlb'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_DIdAlb(Value: Integer);
begin
  ChildNodes['DIdAlb'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_IdLin: Integer;
begin
  Result := ChildNodes['IdLin'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_IdLin(Value: Integer);
begin
  ChildNodes['IdLin'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_DFecha: UnicodeString;
begin
  Result := ChildNodes['DFecha'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_DFecha(Value: UnicodeString);
begin
  ChildNodes['DFecha'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_DFecEnt: UnicodeString;
begin
  Result := ChildNodes['DFecEnt'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_DFecEnt(Value: UnicodeString);
begin
  ChildNodes['DFecEnt'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_IdArt: Integer;
begin
  Result := ChildNodes['IdArt'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_IdArt(Value: Integer);
begin
  ChildNodes['IdArt'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_Articulo: UnicodeString;
begin
  Result := ChildNodes['Articulo'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_Articulo(Value: UnicodeString);
begin
  ChildNodes['Articulo'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_Unidades: Integer;
begin
  Result := ChildNodes['Unidades'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_Unidades(Value: Integer);
begin
  ChildNodes['Unidades'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_NSerie: UnicodeString;
begin
  Result := ChildNodes['NSerie'].Text;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_NSerie(Value: UnicodeString);
begin
  ChildNodes['NSerie'].NodeValue := Value;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Get_Almacen: Integer;
begin
  Result := ChildNodes['Almacen'].NodeValue;
end;

procedure TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb.Set_Almacen(Value: Integer);
begin
  ChildNodes['Almacen'].NodeValue := Value;
end;

{ TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList }

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList.Add: IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
begin
  Result := AddItem(-1) as IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList.Insert(const Index: Integer): IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
begin
  Result := AddItem(Index) as IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
end;

function TXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlbList.Get_Item(Index: Integer): IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
begin
  Result := List[Index] as IXMLDocumento_InfGeneral_InfAlb_InfDetAlb_LinAlb;
end;



end.