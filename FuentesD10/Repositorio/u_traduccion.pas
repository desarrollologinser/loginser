unit u_traduccion;

interface

uses  cxClasses, cxgridstrs, cxFilterControlStrs, cxFilterConsts;

procedure trQuantumGrid;

implementation

procedure trquantumgrid;
begin
  cxSetResourceString(@scxGridGroupByBoxCaption,'Arrastre una columna aqui para agrupar por dicha columna');
  cxSetResourceString(@scxGridFilterIsEmpty,'<Filtro Vac�o>');
  cxSetResourceString(@scxGridCustomizationFormCaption,'Personalizar');
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption,'Personalizar');
  cxSetResourceString(@scxGridFilterRowInfoText,'Haga Click aqui para definir un filtro');
  cxSetResourceString(@scxGridNoDataInfoText,'Ning�n dato que mostrar');
  cxSetResourceString(@scxGridChartToolBoxDataLevelSelectValue,'Seleccione valor');
  cxSetResourceString(@scxGridChartCustomizationFormSortBySeries,'Ordenar por');
  cxSetResourceString(@cxSFilterBoolOperatorAnd,'Y');
  cxSetResourceString(@cxSFilterBoolOperatorOr,'O');
  cxSetResourceString(@cxSFilterDialogOperationAnd, 'Y');
  cxSetResourceString(@cxSFilterDialogOperationOr, 'O');
  cxSetResourceString(@cxSFilterDialogRows,'Mostrar filas seg�n');
  cxSetResourceString(@cxSFilterFooterAddCondition,'Pulse el bot�n para a�adir otra condici�n');
  cxSetResourceString(@cxSFilterRemoveRow,'Eliminar fila');
  cxSetResourceString(@cxSFilterAndCaption, 'Y');
  cxSetResourceString(@cxSFilterBoxAllCaption,'Todo');
  cxSetResourceString(@cxSFilterBoxCustomCaption,'Personalizar');
  cxSetResourceString(@cxSFilterOperatorBeginsWith,'Comienza por');
  cxSetResourceString(@cxSFilterOperatorBetween,'Entre');
  cxSetResourceString(@cxSFilterOperatorContains,'Contiene');
  cxSetResourceString(@cxSFilterOperatorDoesNotBeginWith,'No empieza por');
  cxSetResourceString(@cxSFilterOperatorDoesNotContain,'No contiene');
  cxSetResourceString(@cxSFilterOperatorDoesNotEndWith,'No termina por');
  cxSetResourceString(@cxSFilterOperatorEndsWith,'Termina por');
  cxSetResourceString(@cxSFilterOperatorEqual, '=');
  cxSetResourceString(@cxSFilterOperatorGreater, 'mayor que');
  cxSetResourceString(@cxSFilterOperatorGreaterEqual, 'mayor o igual que');
  cxSetResourceString(@cxSFilterOperatorLess, 'menor que');
  cxSetResourceString(@cxSFilterOperatorLessEqual, 'menor o igual que');
  cxSetResourceString(@cxSFilterOperatorLike,'contiene a');
  cxSetResourceString(@cxSFilterOperatorNotEqual, 'distinto a');
  cxSetResourceString(@cxSFilterOperatorNotLike,'no contiene a');
  cxSetResourceString(@cxSFilterOrCaption, 'o');



end;




end.
