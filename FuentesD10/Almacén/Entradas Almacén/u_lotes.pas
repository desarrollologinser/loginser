unit u_lotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sToolEdit, sDBDateEdit, Vcl.StdCtrls, sGroupBox, sDBRadioGroup, Vcl.Buttons,
  sSpeedButton, Vcl.DBCtrls, sDBEdit, Vcl.ExtCtrls, sPanel, sDBNavigator,
  Data.DB, Vcl.Grids, Vcl.DBGrids, sEdit, sCheckBox, sDBCheckBox, sDialogs;

type
  Tf_lotes = class(TForm)
    btAdd: TsSpeedButton;
    btDel: TsSpeedButton;
    btCancel: TsSpeedButton;
    btSave: TsSpeedButton;
    dbgrd1: TDBGrid;
    edNombre: TsEdit;
    edLote: TsDBEdit;
    edCaducidad: TsDBDateEdit;
    chEstado: TsDBCheckBox;
    sSpeedButton1: TsSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sb_bu_loteClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure edNombreChange(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_lotes: Tf_lotes;
  modo:string; //S-StandBy I-Insert E-Edit

implementation

uses u_dm, u_globals, ubuscapro;

{$R *.dfm}

procedure Tf_lotes.btAddClick(Sender: TObject);
begin
  modo := 'I';

  btSave.Enabled := True;
  btCancel.Enabled := True;

  edLote.DataSource := dm.ds_lotes;
  edLote.DataField := 'NOMBRE';
  edCaducidad.DataSource := dm.ds_lotes;
  edCaducidad.DataField := 'CADUCIDAD';
  chEstado.DataSource := dm.ds_lotes;
  chEstado.DataField := 'ESTADO';

  dm.q_lotes.Insert;
end;

procedure Tf_lotes.btSaveClick(Sender: TObject);

begin

  if (modo='I') and (smessagedlg('Se va a crear un nuevo lote, ¿desea continuar?',mtConfirmation,[mbyes,mbno],0)=mryes) then
  begin
       //dm.q_lotes.FieldByName('NOMBRE').AsString := edNombre.Text;
       //dm.q_lotes.FieldByName('CADUCIDAD').AsDateTime := edCaducidad.Date;
       dm.q_lotes.Post;
  end else if (modo='U') and (smessagedlg('Se va a modificar el lote, ¿desea continuar?',mtConfirmation,[mbyes,mbno],0)=mryes) then
  begin
       //dm.q_lotes.FieldByName('NOMBRE').AsString := edNombre.Text;
       //dm.q_lotes.FieldByName('CADUCIDAD').AsDateTime := edCaducidad.Date;
       dm.q_lotes.Post;
  end else
          dm.q_lotes.Cancel;

  edLote.DataSource := dm.dsLotesFilter;
  edLote.DataField := 'NOMBRE';
  edCaducidad.DataSource := dm.dsLotesFilter;
  edCaducidad.DataField := 'CADUCIDAD';
  chEstado.DataSource := dm.dsLotesFilter;
  chEstado.DataField := 'ESTADO';
  dm.q_lotes_filter.Locate('ID_LOTE',dm.q_lotes.FieldByName('id_lote').AsInteger,[]);

  btSave.Enabled := False;
  btCancel.Enabled := False;
end;


procedure Tf_lotes.edNombreChange(Sender: TObject);
begin

  dm.q_lotes_filter.Close;
  dm.q_lotes_filter.SelectSQL.Clear;
  dm.q_lotes_filter.SelectSQL.Add(
    'SELECT * '+
    'FROM A_LOTES WHERE ESTADO=''A''');
  if edNombre.Text<>'' then
    dm.q_lotes_filter.SelectSQL.Add(' AND UPPER(NOMBRE) LIKE ''%' + UpperCase(edNombre.Text) + '%''');
  dm.q_lotes_filter.Open;

end;

procedure Tf_lotes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ver_estado_actualizacion(dm.q_lotes);
  modo := 'S';
end;

procedure Tf_lotes.sb_bu_loteClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_lote, nombre, caducidad, estado';
    titulos.commatext:='Id,Nombre,Caducidad,Estado';
    from:='a_lotes';
    where:='';
    orden[1]:=2; busca:=2;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then
      if not(dm.q_lotes.locate('id_lote',valor[1],[])) then raise exception.create('Lote No Encontrado');
  end;
end;

procedure Tf_lotes.sSpeedButton1Click(Sender: TObject);
begin
  modo := 'U';

  btSave.Enabled := True;
  btCancel.Enabled := True;

  edLote.DataSource := dm.ds_lotes;
  edLote.DataField := 'NOMBRE';
  edCaducidad.DataSource := dm.ds_lotes;
  edCaducidad.DataField := 'CADUCIDAD';
  chEstado.DataSource := dm.ds_lotes;
  chEstado.DataField := 'ESTADO';
end;

end.
