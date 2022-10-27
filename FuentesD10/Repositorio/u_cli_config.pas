unit u_cli_config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, pFIBDataSet, JvDBGrid, Data.DB,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, FIBDataSet, Vcl.ExtCtrls, Vcl.StdCtrls,
  sGroupBox, sEdit;

type
  TfCliConfig = class(TForm)
    qConfig: TpFIBDataSet;
    grParams: TJvDBGrid;
    dsConfig: TDataSource;
    pn1: TPanel;
    lgsConfigID_CLIENTE: TFIBIntegerField;
    qConfigITEM: TFIBStringField;
    qConfigVALOR: TFIBStringField;
    qConfigDESCRIPCION: TFIBStringField;
    qConfigTIPO: TFIBStringField;
    edEdit: TsEdit;
    rgChk: TsRadioGroup;
    procedure grParamsCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure grParamsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grParamsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure DestruyeComps;
    procedure CargaDatos;
  public
    { Public declarations }
  end;

var
  fCliConfig: TfCliConfig;
  id_cliente: Integer;

implementation

{$R *.dfm}

uses
  u_dm;


procedure TfCliConfig.FormActivate(Sender: TObject);
begin
  qConfig.Close;
  qConfig.ParamByName('id_cliente').AsInteger := id_cliente;
  qConfig.Open;

  CargaDatos;
end;

procedure TfCliConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qConfig.Close;
  DestruyeComps;
end;

procedure TfCliConfig.grParamsCellClick(Column: TColumn);
var
    t_edit: TEdit;
    t_chk: TRadioGroup;
begin

    //DestruyeComps;

    CargaDatos;

end;

procedure TfCliConfig.grParamsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    CargaDatos;
end;

procedure TfCliConfig.grParamsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CargaDatos;
end;

procedure TfCliConfig.DestruyeComps;
var
  i:integer;
begin
    {for I := 0 to fCliConfig.ComponentCount-1 do
       If fCliConfig.Components[i].GetParentComponent.Name='pn1' then
            ShowMessage(fCliConfig.Components[i].name);             }
end;

procedure TfCliConfig.CargaDatos;
begin
  if qConfig.FieldByName('tipo').asstring = 'EDIT' then
    begin

       edEdit.BoundLabel.Caption := qConfig.FieldByName('descripcion').AsString;
       edEdit.Text := qConfig.FieldByName('valor').AsString;
       edEdit.Enabled := True;
       rgChk.Caption := '';
       rgChk.ItemIndex := -1;
       rgChk.Enabled := False;


       { t_edit := TEdit.Create(self);
        t_edit.Text := qConfig.FieldByName('valor').AsString;
        t_edit.Parent := pn1;
        t_edit.Top := 10;
        t_edit.Left := 10;
        t_edit.Width := 500;
        }
    end;

    if qConfig.FieldByName('tipo').asstring = 'CHK' then
    begin

        rgChk.Caption := qConfig.FieldByName('descripcion').AsString;
        rgChk.ItemIndex := qConfig.FieldByName('valor').AsInteger;
        rgChk.Enabled := True;
        edEdit.BoundLabel.Caption := '';
        edEdit.Text := '';
        edEdit.Enabled := False;
      { t_chk := TRadioGroup.Create(self);
        t_chk.Parent := pn1;
        t_chk.Top := 10;
        t_chk.Left := 10;
        t_chk.Items.Add('No');
        t_chk.Items.Add('Sí');
        t_chk.Caption := 'Valor';
        t_chk.ItemIndex := qConfig.FieldByName('valor').AsInteger;  }
    end;
end;

end.
