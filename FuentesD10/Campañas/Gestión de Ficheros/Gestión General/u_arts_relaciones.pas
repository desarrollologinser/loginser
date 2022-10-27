unit u_arts_relaciones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  Vcl.DBCtrls, sDBComboBox, sSpeedButton, sEdit, System.Types, System.strUtils,
  pFIBQuery, Data.DB, Vcl.ExtCtrls, JvDBControls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, sLabel, sGroupBox;

type
  Tf_arts_relaciones = class(TForm)
    sGroupBox1: TsGroupBox;
    lbArtRel: TsLabel;
    bpArtRel: TsSpeedButton;
    lb_art_rel: TsLabel;
    JvDBGrid1: TJvDBGrid;
    nav_art_rel: TJvDBNavigator;
    edArtRel: TsEdit;
    procedure btAceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bpArtRelClick(Sender: TObject);
    procedure nav_art_relBeforeAction(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  f_arts_relaciones: Tf_arts_relaciones;
  todos, id_articulo, id_art_relacionado: integer;

implementation

uses
    u_dm, ubuscapro, u_main, u_gen_gl, u_globals;

{$R *.dfm}

procedure Tf_arts_relaciones.bpArtRelClick(Sender: TObject);
begin
   with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='ar.id_articulo,ar.codigo,ar.nombre';
    titulos.commatext:='Id_Articulo,Referencia,Nombre';
    from:='g_articulos ar inner join g_clientes_config c on c.peds_en_cadena=ar.id_cliente ';

    where:=' estado=''A''';
    orden[1]:=2;   orden_ini:=0;  group:='';
    busca:=2;   distinct:=0;   fillimpio:=True;    row_height:=17;

    showmodal;

    if resultado then begin
      edArtRel.Text:=valor[2];
      lb_art_rel.caption:=valor[3];
      //dm.q_arts_relacionados.Insert;
      dm.q_arts_relacionados.FieldByName('id_art_relacionado').AsInteger := StrToInt(valor[1]);
      dm.q_arts_relacionados.FieldByName('cod_art_rel').AsString := valor[2];
      dm.q_arts_relacionados.FieldByName('id_articulo').AsInteger := id_articulo;
      //dm.q_arts_relacionados.Post;
    end;
  end;
end;

procedure Tf_arts_relaciones.btAceptarClick(Sender: TObject);
begin
  Close;
end;


procedure Tf_arts_relaciones.FormShow(Sender: TObject);
var
  datos: TStringDynArray;
begin
  Datos := SplitString(CargarDatosTabla('g_articulos','codigo, nombre','id_articulo='+ IntToStr(id_articulo)),'#');

  lbArtRel.Caption := Datos[0]+ ' - ' + Datos[1];

end;

procedure Tf_arts_relaciones.nav_art_relBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
   if not(button in [nbpost,nbcancel]) then
   begin
    u_globals.ver_estado_actualizacion(dm.q_arts_relacionados);
    edArtRel.Text := '';
    lb_art_rel.Caption := '';
   end;

   edArtRel.Visible := (button in [nbInsert]);
   lb_art_rel.Visible := (button in [nbInsert]);
   bpArtRel.Visible := (button in [nbInsert]);

end;

end.
