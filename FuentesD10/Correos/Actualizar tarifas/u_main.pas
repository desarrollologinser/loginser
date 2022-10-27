unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit, System.AnsiStrings, System.Win.ComObj,
  sEdit, sSpinEdit, Data.DB, Datasnap.DBClient, frxClass, frxDBSet, dxPrnDev,
  cxClasses, dxPrnDlg, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore,
  dxPSPDFExport, cxDrawTextUtils, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPSdxPDFViewerLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxPDFDocument, dxBarBuiltInMenu, dxCustomPreview,
  dxPDFViewer, frxExportPDF, Vcl.ComCtrls;

type
  Tf_main = class(TForm)
    grp1: TGroupBox;
    fich: TsFilenameEdit;
    ed_fila: TsSpinEdit;
    ed_col: TsSpinEdit;
    edFDesde: TsDateEdit;
    edFHasta: TsDateEdit;
    ed_fila_nom: TsSpinEdit;
    cds: TClientDataSet;
    strngfld_cliente: TStringField;
    strngfldcdsnombre: TStringField;
    strngfldcdsservicio: TStringField;
    strngfldcdstarifa: TStringField;
    strngfldcdsdesde: TStringField;
    strngfldcdshasta: TStringField;
    strngfldcdsid: TStringField;
    rep: TfrxReport;
    ds: TfrxDBDataset;
    pdf: TfrxPDFExport;
    grp2: TGroupBox;
    deDirDestino: TsDirectoryEdit;
    lb1: TLabel;
    sButton1: TsButton;
    edPrinter: TsEdit;
    lb2: TLabel;
    pr1: TPrintDialog;
    procedure sButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AbreFichero(nombre:string);
  public
    { Public declarations }
  end;

var
  f_main: Tf_main;

  excel, libro: Variant;
  hoja:OleVariant;

const
  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  v = '[1]';
  //[1] Primera versión

  impresora = 'CutePDF Writer';


implementation

{$R *.dfm}

procedure Tf_main.AbreFichero(nombre:string);
begin

   Excel:=CreateOleObject('Excel.Application');
   try
     Excel.Visible := False;
     Excel.DisplayAlerts:= False;
     Excel.WorkBooks.Open(nombre);//fichero que queremos leer
   except
     Excel.Quit ;
     Excel := Unassigned;
   end;
end;
procedure Tf_main.FormCreate(Sender: TObject);
begin
   lb1.Caption := '';
   Caption := 'Actualizar Tarifas Manipulado ' + v;
end;

procedure Tf_main.sButton1Click(Sender: TObject);
var
  fila, columna, id_cliente, cod_cliente, cont: integer;
  valor, v_aux, id_cl: string;

begin
  if not FileExists(fich.text) then
  begin
    ShowMessage('No existe el fichero indicado.');
    Exit;
  end;

   if IndexStr(ExtractFileExt(fich.text),['.xls','.xlsx'])<0 then
  begin
    ShowMessage('El tipo del fichero no es Excel.');
    Exit;
  end;

  if not DirectoryExists(deDirDestino.text) then
  begin
    ShowMessage('No existe la carpeta de destino indicada.');
    Exit;
  end;

  pr1.Execute;
  if pr1.='' then
  begin
    ShowMessage('Indicar impresora PDF.');
    Exit;
  end;

  screen.Cursor := crHourGlass;
  Application.ProcessMessages;


  AbreFichero(fich.text);

  fila := ed_fila.Value + 1;
  columna := ed_col.Value;
  id_cliente := -1;
  cont := 1;

  valor := excel.cells[ed_fila.Value,columna];

  while (valor<>'') do
  begin
      lb1.Caption := 'Creando ' +  excel.cells[ed_fila_nom.Value,columna].value;
      while (valor<>'') do
      begin
           cds.Append;
           cds.FieldByName('id_cliente').AsString := excel.cells[ed_fila.Value,columna].value;
           id_cl := excel.cells[ed_fila.Value,columna].value;
           cds.FieldByName('nombre').AsString := excel.cells[ed_fila_nom.Value,columna].value;
           cds.FieldByName('servicio').AsString := excel.cells[fila,1].value;
           if StrToFloatDef(excel.cells[fila,columna].value,-1)>=0 then
           begin
               v_aux := excel.cells[fila,columna].value;

               if StrToFloatDef(v_aux,-1)>1 then
                cds.FieldByName('tarifa').AsString := v_aux
               else
                cds.FieldByName('tarifa').AsString := FormatFloat('#0.0000',excel.cells[fila,columna].value);

           end
           else
                cds.FieldByName('tarifa').AsString := excel.cells[fila,columna].value;
           cds.FieldByName('desde').AsString := edFDesde.Text;
           cds.FieldByName('hasta').AsString := edFHasta.Text;
           cds.FieldByName('id').AsString := Format(Format('%%.%dd', [2]), [cont]);
           cds.Post;

           Inc(fila);
           Inc(cont);
           valor := excel.cells[fila,columna];
      end;

      fila := ed_fila.Value + 1;
      cont := 1;
      Inc(columna);
      valor := excel.cells[fila,columna];

      rep.PrintOptions.Printer := impresora;
      rep.PrintOptions.ShowDialog := False;

      pdf.ShowDialog := False;
      pdf.FileName := deDirDestino.Text + '\' + id_cl + '.pdf';
      if rep.PrepareReport(True) then //rep.Print;
           rep.Export(pdf);

      cds.EmptyDataSet;
  end;


  Excel.Quit ;
  Excel := Unassigned;

  screen.Cursor := crDefault;
  Application.ProcessMessages;

  lb1.Caption := 'Proceso finalizado.';

end;

end.
