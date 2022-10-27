unit u_dmLabels;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, pFIBDataSet, Vcl.Dialogs,
  Data.DB, FIBDataSet;

type
  TdmLabels = class(TDataModule)
    eti_lgs_old: TfrxReport;
    db_eti_lgs: TfrxDBDataset;
    q_dame_datos_etiquetas: TpFIBDataSet;
    ds_dame_datos_etiquetas: TDataSource;
    lgs_dame_datos_etiquetasSEDE: TFIBSmallIntField;
    lgs_dame_datos_etiquetasFECHA_ALBARAN: TFIBDateTimeField;
    lgs_dame_datos_etiquetasTIPO_ALBARAN: TFIBSmallIntField;
    lgs_dame_datos_etiquetasESTADO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasAGENCIA: TFIBSmallIntField;
    q_dame_datos_etiquetasEXPEDICION_AGE: TFIBStringField;
    lgs_dame_datos_etiquetasORIGEN_WEB: TFIBSmallIntField;
    lgs_dame_datos_etiquetasEMPRESA: TFIBSmallIntField;
    lgs_dame_datos_etiquetasCLIENTE: TFIBIntegerField;
    lgs_dame_datos_etiquetasID_CLIENTE: TFIBIntegerField;
    q_dame_datos_etiquetasALBARAN_CLIENTE: TFIBStringField;
    lgs_dame_datos_etiquetasTIPO_SERVICIO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasHORARIO: TFIBSmallIntField;
    q_dame_datos_etiquetasARCHIVO_RESGUARDO: TFIBStringField;
    lgs_dame_datos_etiquetasPAQUETES: TFIBFloatField;
    lgs_dame_datos_etiquetasBULTOS: TFIBIntegerField;
    lgs_dame_datos_etiquetasPESO: TFIBFloatField;
    lgs_dame_datos_etiquetasKGS_VOL: TFIBFloatField;
    lgs_dame_datos_etiquetasZONA: TFIBIntegerField;
    lgs_dame_datos_etiquetasREPARTIDOR: TFIBSmallIntField;
    lgs_dame_datos_etiquetasPORTES_DEBIDOS: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_PORTES: TFIBFloatField;
    lgs_dame_datos_etiquetasREEMBOLSO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_REEMBOLSO: TFIBFloatField;
    lgs_dame_datos_etiquetasASEGURADO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_ASEGURADO: TFIBFloatField;
    lgs_dame_datos_etiquetasRETORNO: TFIBSmallIntField;
    q_dame_datos_etiquetasOBSERVACIONES: TFIBMemoField;
    q_dame_datos_etiquetasNOTAS_INTERNAS: TFIBMemoField;
    q_dame_datos_etiquetasORIG_NOMBRE: TFIBStringField;
    q_dame_datos_etiquetasORIG_CALLE: TFIBStringField;
    lgs_dame_datos_etiquetasORIG_ID_LOCAL: TFIBIntegerField;
    q_dame_datos_etiquetasORIG_COD_POSTAL: TFIBStringField;
    q_dame_datos_etiquetasORIG_LOCALIDAD: TFIBStringField;
    q_dame_datos_etiquetasORIG_PROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasORIG_PAIS: TFIBStringField;
    q_dame_datos_etiquetasORIG_TELEFONO: TFIBStringField;
    q_dame_datos_etiquetasORIG_TELEFONO2: TFIBStringField;
    q_dame_datos_etiquetasORIG_CONTACTO: TFIBStringField;
    q_dame_datos_etiquetasORIG_NOTAS: TFIBMemoField;
    q_dame_datos_etiquetasORIG_EMAIL: TFIBStringField;
    lgs_dame_datos_etiquetasVEHICULO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDNI_NOMBRE: TFIBSmallIntField;
    lgs_dame_datos_etiquetasRCS: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDIGITALIZADO: TFIBSmallIntField;
    q_dame_datos_etiquetasCAMPO_STR1: TFIBStringField;
    q_dame_datos_etiquetasCAMPO_STR2: TFIBStringField;
    q_dame_datos_etiquetasCAMPO_STR3: TFIBStringField;
    lgs_dame_datos_etiquetasCAMPO_CANT1: TFIBFloatField;
    lgs_dame_datos_etiquetasCAMPO_CANT2: TFIBFloatField;
    lgs_dame_datos_etiquetasCAMPO_CANT3: TFIBFloatField;
    lgs_dame_datos_etiquetasENTRADA: TFIBIntegerField;
    lgs_dame_datos_etiquetasVALIJA: TFIBSmallIntField;
    lgs_dame_datos_etiquetasRECOGIDA_PROPIA: TFIBSmallIntField;
    lgs_dame_datos_etiquetasRECOGIDA_NACIONAL: TFIBSmallIntField;
    lgs_dame_datos_etiquetasAUTOMATICO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasSEGUIMIENTO: TFIBSmallIntField;
    q_dame_datos_etiquetasALBARAN_AGENCIA: TFIBStringField;
    lgs_dame_datos_etiquetasFACTURABLE: TFIBSmallIntField;
    lgs_dame_datos_etiquetasCAMPO_CK1: TFIBSmallIntField;
    lgs_dame_datos_etiquetasCAMPO_CK2: TFIBSmallIntField;
    lgs_dame_datos_etiquetasCAMPO_CK3: TFIBSmallIntField;
    lgs_dame_datos_etiquetasFECHA_SERVICIO: TFIBDateTimeField;
    lgs_dame_datos_etiquetasORIG_H_DESDE: TFIBDateTimeField;
    lgs_dame_datos_etiquetasORIG_H_HASTA: TFIBDateTimeField;
    lgs_dame_datos_etiquetasAYUDANTE: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDESEMBOLSO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_DESEMBOLSO: TFIBFloatField;
    lgs_dame_datos_etiquetasSEGUNDA_ENTREGA: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDUA_IMPORT: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDUA_EXPORT: TFIBSmallIntField;
    lgs_dame_datos_etiquetasMINUTOS_ESPERA: TFIBSmallIntField;
    q_dame_datos_etiquetasORIG_CODIGO: TFIBStringField;
    lgs_dame_datos_etiquetasORIG_H_DESDE2: TFIBDateTimeField;
    lgs_dame_datos_etiquetasORIG_H_HASTA2: TFIBDateTimeField;
    lgs_dame_datos_etiquetasPESO_EXPEDICION: TFIBFloatField;
    lgs_dame_datos_etiquetasBULTOS_TOTALES: TFIBIntegerField;
    q_dame_datos_etiquetasORIG_COD_PROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasORIG_NIF: TFIBStringField;
    q_dame_datos_etiquetasORIG_DEPARTAMENTO: TFIBStringField;
    lgs_dame_datos_etiquetasDAC: TFIBSmallIntField;
    lgs_dame_datos_etiquetasPOD: TFIBSmallIntField;
    q_dame_datos_etiquetasREF_CLIENTE: TFIBStringField;
    q_dame_datos_etiquetasREF_CLIENTE_2: TFIBStringField;
    q_dame_datos_etiquetasCONTENIDO: TFIBStringField;
    lgs_dame_datos_etiquetasFECHA_PREVISTA: TFIBDateTimeField;
    lgs_dame_datos_etiquetasSOLICITUD: TFIBIntegerField;
    lgs_dame_datos_etiquetasFACT_DEVOLUCION: TFIBSmallIntField;
    lgs_dame_datos_etiquetasFACT_RCS: TFIBSmallIntField;
    lgs_dame_datos_etiquetasFACT_RETORNO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasSEDE_DESTINO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasSEDE_ORIGEN: TFIBSmallIntField;
    lgs_dame_datos_etiquetasTIENE_INCIDENCIA: TFIBSmallIntField;
    q_dame_datos_etiquetasTITULO_HORARIO: TFIBStringField;
    q_dame_datos_etiquetasCODIGO_CLIENTE_EXP: TFIBStringField;
    lgs_dame_datos_etiquetasID_ALBARAN_DET: TFIBIntegerField;
    lgs_dame_datos_etiquetasLINEA: TFIBSmallIntField;
    q_dame_datos_etiquetasDEST_NOMBRE: TFIBStringField;
    q_dame_datos_etiquetasDEST_CALLE: TFIBStringField;
    q_dame_datos_etiquetasDEST_CODPOSTAL: TFIBStringField;
    q_dame_datos_etiquetasDEST_LOCALIDAD: TFIBStringField;
    q_dame_datos_etiquetasDEST_PROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasDEST_PAIS: TFIBStringField;
    q_dame_datos_etiquetasDEST_TELEFONO01: TFIBStringField;
    q_dame_datos_etiquetasDEST_TELEFONO02: TFIBStringField;
    q_dame_datos_etiquetasDEST_EMAIL: TFIBStringField;
    q_dame_datos_etiquetasDEST_CONTACTO: TFIBStringField;
    q_dame_datos_etiquetasDEST_OBSERVACIONES: TFIBMemoField;
    lgs_dame_datos_etiquetasDEST_ID_LOCAL: TFIBIntegerField;
    lgs_dame_datos_etiquetasDEST_PRINCIPAL: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDEST_HDESDE: TFIBDateTimeField;
    lgs_dame_datos_etiquetasDEST_HHASTA: TFIBDateTimeField;
    q_dame_datos_etiquetasDEST_CODIGO: TFIBStringField;
    q_dame_datos_etiquetasDEST_CODPROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasDEST_NIF: TFIBStringField;
    q_dame_datos_etiquetasDEST_DEPARTAMENTO: TFIBStringField;
    lgs_dame_datos_etiquetasDEST_RECIBIR: TFIBSmallIntField;
    lgs_dame_datos_etiquetasBULTO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasID_BULTO: TFIBIntegerField;
    lgs_dame_datos_etiquetasPESO_BULTO: TFIBFloatField;
    lgs_dame_datos_etiquetasX: TFIBFloatField;
    lgs_dame_datos_etiquetasY: TFIBFloatField;
    lgs_dame_datos_etiquetasZ: TFIBFloatField;
    q_dame_datos_etiquetasREFERENCIA: TFIBStringField;
    q_dame_datos_etiquetasCOD_BARRAS: TFIBStringField;
    lgs_dame_datos_etiquetasID_ALB: TFIBIntegerField;
    q_dame_datos_etiquetasTITULO_ZONA: TFIBStringField;
    q_dame_datos_etiquetasTIT_AGENCIA: TFIBStringField;
    q_dame_datos_etiquetasTIT_SEDE: TFIBStringField;
    q_dame_datos_etiquetasTIT_SEDE_DESTINO: TFIBStringField;
    q_dame_datos_etiquetasTIT_SEDE_ORIGEN: TFIBStringField;
    lgs_dame_datos_etiquetasGRUPO_CL: TFIBIntegerField;
    q_dame_datos_etiquetasZONA_TXT: TFIBStringField;
    eti_lgs: TfrxReport;
    strngfld_dame_datos_etiquetasRUTA_LOGO: TStringField;
    db_pack_bulto: TfrxDBDataset;
    q_dame_pack_bulto: TpFIBDataSet;
    ds_dame_pack_bulto: TDataSource;
    lgs_dame_pack_bultoID_PEDIDO: TFIBIntegerField;
    lgs_dame_pack_bultoID_ARTICULO: TFIBIntegerField;
    q_dame_pack_bultoCODIGO: TFIBStringField;
    q_dame_pack_bultoNOM_ART: TFIBStringField;
    q_dame_pack_bultoORDER_NAME: TFIBStringField;
    q_dame_pack_bultoREF_CLIENTE: TFIBStringField;
    q_dame_pack_bultoNOM_DEST: TFIBStringField;
    eti_pack_x_bulto: TfrxReport;
    lgs_dame_pack_bultoCANTIDAD: TFIBIntegerField;
    q_dame_pack_bultoN_SERIE: TFIBStringField;
    lgs_dame_pack_bultoBULTOS: TFIBIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    imp_eti: string;
    procedure imprime_etiqueta_loginser(codalbaran, id_dest, impr_logo:Integer);
    function GetFormatoEtiqueta(id_albaran:Integer):string;
    function PedidoTieneEtiqueta(id_pedido:Integer):Boolean;
    procedure imprime_pack_x_bulto(id_pedido:integer; app:string);
  end;

var
  dmLabels: TdmLabels;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  u_dm,UDMCreaBultos, u_LstEtiquetas, u_AlbaranValidate;


procedure TdmLabels.imprime_etiqueta_loginser(codalbaran, id_dest, impr_logo:Integer);
var
  texto, ruta_logo: string;
  pic: TfrxPictureView;

begin
 if id_dest>0 then
     DMCreaBultos.GeneraBultos(codalbaran,id_dest);

  If ValidaAlbaran(IntToStr(codalbaran),texto)  then
  begin
    eti_lgs.PrintOptions.Printer := imp_eti;
    eti_lgs.PrintOptions.ShowDialog := False;

    with q_dame_datos_etiquetas do
      begin
         Close;
         ParamByName('id_albaran').AsInteger := codalbaran;
         Open;

         if (FieldByName('RUTA_LOGO').AsString<>'') then
         begin
           pic := eti_lgs.FindObject('logo_cli') as TfrxPictureView;
           if Assigned(pic) then
            if impr_logo>0 then
              pic.Picture.LoadFromFile(FieldByName('RUTA_LOGO').AsString)
            else
              pic.Picture.Assign(nil);
         end;

         if eti_lgs.PrepareReport(True) then eti_lgs.Print;

         if texto<>'' then
                      ShowMessage(texto);

      end;
  end;
end;

function TdmLabels.GetFormatoEtiqueta(id_albaran:Integer):string;
begin
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select formato from calcula_formato_etiqueta(:id_albaran) ');
      ParamByName('id_albaran').AsInteger := id_albaran;
      Open;

      if not isempty then
          result := FieldByName('formato').asstring;

    finally
      free;
    end;
end;

function TdmLabels.PedidoTieneEtiqueta(id_pedido:Integer):boolean;
begin
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_etiquetas where id_pedido=:id_pedido and estado=''A''');
      ParamByName('id_pedido').AsInteger := id_pedido;
      Open;

      result := not isempty;

    finally
      free;
    end;
end;

procedure TdmLabels.imprime_pack_x_bulto(id_pedido:integer; app:string);
var
    memo_app: TfrxMemoView;
begin
    eti_pack_x_bulto.PrintOptions.Printer := imp_eti;
    eti_pack_x_bulto.PrintOptions.ShowDialog := False;

    with q_dame_pack_bulto do
    try
      Close;
      ParamByName('id_pedido').AsInteger := id_pedido;
      Open;

      memo_app := eti_pack_x_bulto.FindObject('app') as TfrxMemoView;
      if Assigned(memo_app) then
          memo_app.Memo.Text := app;

      if eti_pack_x_bulto.PrepareReport(True) then eti_pack_x_bulto.Print;
    finally
    end;

end;
end.
