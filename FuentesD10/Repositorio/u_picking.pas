unit u_picking;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, Data.DB,
  Datasnap.DBClient, FIBDataSet, pFIBDataSet, Vcl.Dialogs, System.Variants,
  frxExportPDF, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery;


type
  Tdm_pick = class(TDataModule)
    rep_pick: TfrxReport;
    rep_pick_lotes: TfrxReport;
    rep_pick_imei: TfrxReport;
    rep_db_pick: TfrxDBDataset;
    qLotes: TpFIBDataSet;
    qAlbaran: TpFIBDataSet;
    qPickLines: TpFIBDataSet;
    qCliConfig: TpFIBDataSet;
    frdevo: TfrxReport;
    rep_todos: TfrxReport;
    pdf_export: TfrxPDFExport;
    qAlbDest: TpFIBDataSet;
    rep_lotes_zebra: TfrxReport;
    ar_pick_ds: TClientDataSet;
    cds_pick_dsid_art: TIntegerField;
    strngfld_pick_dsref_art: TStringField;
    cds_pick_dsuds: TIntegerField;
    cds_pick_dsid_ubic: TIntegerField;
    strngfld_pick_dsnomApe: TStringField;
    strngfld_pick_dsdireccion: TStringField;
    strngfld_pick_dspoblacion: TStringField;
    strngfld_pick_dscp: TStringField;
    strngfld_pick_dsprovincia: TStringField;
    strngfld_pick_dsmail: TStringField;
    strngfld_pick_dstelefono: TStringField;
    strngfld_pick_dsubicacion: TStringField;
    strngfld_pick_dsarticulo: TStringField;
    strngfld_pick_dspedido: TStringField;
    cds_pick_dscodalbaran: TIntegerField;
    strngfld_pick_dsdeliv_time: TStringField;
    strngfld_pick_dsCodPais: TStringField;
    strngfld_pick_dsTag: TStringField;
    smlntfld_pick_dsEsDevo: TSmallintField;
    strngfld_pick_dslote: TStringField;
    strngfld_pick_dscaducidad: TStringField;
    cds_pick_dscantidad: TIntegerField;
    smlntfld_pick_dstiene_lotes: TSmallintField;
    strngfld_pick_dsimei: TStringField;
    strngfld_pick_dsobservaciones: TStringField;
    strngfld_pick_dsdt_txt: TStringField;
    strngfld_pick_dsagencia_txt: TStringField;
    blnfld_pick_dscon_retorno: TBooleanField;
    strngfld_pick_dscontacto: TStringField;
    strngfld_pick_dsservicio: TStringField;
    strngfld_pick_dshorario: TStringField;
    strngfld_pick_dsSERV_TXT: TStringField;
    strngfld_pick_dsHORA_TXT: TStringField;
    strngfld_pick_dspie_hoja_pick: TStringField;
    cds_pick_dsusu: TIntegerField;
    rep_pick_zebra: TfrxReport;
    upd: TpFIBQuery;
    db_gestoras: TpFIBDatabase;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    qry: TpFIBDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure imprime_hoja_pick(modo,path:string; tiene_lotes: Boolean; codalbaran:Integer);
    procedure InsertLinePicking(id_art:Integer; ref_art:string; uds:Integer; imei:string; tiene_lotes:Integer; lote, caducidad:string; uds_lote,id_ubic: Integer;
                        ubic,articulo,pedido,nomape,direccion,poblacion,provincia,cp,mail,telefono:string; codalbaran:Integer;
                        cod_pais, tag:string; es_devo: Integer; observaciones, agencia_txt, dt_txt, contacto: string; con_retorno:Boolean;
                        servicio, horario:string; usuario:integer);
    procedure LanzaImpresion(modo,path:string);
    function genera_picking(pedidos:string; id_usuario,id_almacem,packing,agrupado:integer):boolean;
  end;

var
  dm_pick: Tdm_pick;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  u_dm, u_gen_gl, u_main, u_cam_gl, u_functions, u_globals_gestoras;

procedure Tdm_pick.imprime_hoja_pick(modo,path:string; tiene_lotes: Boolean; codalbaran:Integer);
var
  j,ubi, id_pedido, es_devo:integer;
  agencia_txt, imei, ubicacion, cod_art, nombre_art, tags: string;
  repe: TStringList;
  enc: Boolean;
begin
  ar_pick_ds.Close;
  ar_pick_ds.Active:=true;
  ar_pick_ds.EmptyDataSet;

  repe := TStringList.Create;

  qAlbaran.Close;
  qAlbaran.SelectSQL.Clear;
  qAlbaran.SelectSQL.Add('select * from albaranes where id_albaran=:codalbaran');
  qAlbaran.ParamByName('codalbaran').AsInteger := codalbaran;
  qAlbaran.Open;

  qAlbDest.Close;
  qAlbDest.SelectSQL.Clear;
  qAlbDest.SelectSQL.Add('select * from albaran_dest where id_albaran=:codalbaran');
  qAlbDest.ParamByName('codalbaran').AsInteger := codalbaran;
  qAlbDest.Open;

  qPickLines.Close;
  qPickLines.SelectSQL.Clear;
  qPickLines.SelectSQL.Add('select * from a_picklin where codalbaran=:codalbaran and estado=''A'' order by id_articulo');
  qPickLines.ParamByName('codalbaran').AsInteger := codalbaran;
  qPickLines.Open;
  qPickLines.First;

  id_pedido := GetIdPedidoXAlbaran(codalbaran,qAlbaran.fieldbyname('cliente').Asinteger);

   while not qPickLines.Eof do
  begin

    if id_pedido>0 then
    begin
      imei := getimeiPedido(id_pedido,qPickLines.FieldByName('id_articulo').AsInteger);
      tags := getTagPedido(id_pedido);
      es_devo := Integer(EsDevo(id_pedido));
    end;

    if not tiene_lotes then      //Clientes sin lotes
    begin

      ubicacion := GetUbiPick(qPickLines.FieldByName('id_pickcab').AsInteger,qPickLines.FieldByName('id_articulo').AsInteger);

      agencia_txt := get_nombre_agencia(qAlbaran.FieldByName('agencia').asinteger);
      nombre_art := BuscaArticulo(qPickLines.FieldByName('id_articulo').AsInteger,cod_art);

      InsertLinePicking(qPickLines.FieldByName('id_articulo').AsInteger,       //id_art
                        UpperCase(cod_art),        //ref_art
                        qPickLines.FieldByName('cantidad').AsInteger,       //uds
                        imei,        //imei
                        0,                                   //tiene_lotes
                        '','',0,                               //lote, caducidad, uds_lote
                        ubi,
                        ubicacion,  //ubicacion
                        UpperCase(nombre_art),   //artículo
                        qAlbaran.FieldByName('ref_cliente').asstring,             //pedido
                        qAlbDest.FieldByName('nombre').AsString,                 //nombre
                        qAlbDest.FieldByName('calle').AsString,                  //direccion
                        qAlbDest.FieldByName('localidad').AsString,              //poblacion
                        qAlbDest.FieldByName('provincia').AsString,              //provincia
                        qAlbDest.FieldByName('cod_postal').AsString,             //cp
                        qAlbDest.FieldByName('email').AsString,                  //email
                        qAlbDest.FieldByName('telefono').AsString,               //telefono
                        codalbaran,   //codalbaran
                        //cb_delivery.Text,               //deliv_time
                        qAlbDest.FieldByName('pais').AsString,                  //cod_pais
                        tags,       //tag
                        es_devo, //es_devo
                        qAlbDest.FieldByName('observaciones').AsString,                    //observaciones
                        agencia_txt,                    //agencia_txt
                        '',               //dt_txt
                        qAlbDest.FieldByName('contacto').AsString,                //contacto
                        (qAlbaran.FieldByName('retorno').AsInteger=1),              //con retorno
                        qAlbaran.FieldByName('tipo_servicio').AsString,    //servicio
                        qAlbaran.FieldByName('horario').AsString,                 //horario
                        usuario.id);                                              //usuario

    end else begin         //Clientes con lotes
                enc := False;
                for j := 0 to repe.Count-1 do
                begin
                    enc := (qPickLines.FieldByName('id_articulo').AsString=repe[j]);
                end;

                if not enc then
                begin
                  repe.Add(qPickLines.FieldByName('id_articulo').AsString);

                  qLotes.Close;                                                            //datos de lotes
                  qLotes.SQLs.SelectSQL.Clear;
                  {qLotes.SQLs.SelectSQL.Add('SELECT l.id_pedido as id_pedido, lt.id_lote, lt.nombre as lote, lt.caducidad, a.codigo, a.nombre as nom_art, sum(l.cantidad) as cantidad  '+
                    ' from c_pedidos_lines_lotes l ' +
                    ' left outer join a_lotes lt on lt.id_lote=l.id_lote ' +
                    ' left outer join g_articulos a on a.id_articulo=l.id_articulo ' +
                    ' where id_pedido=:id_pedido and l.id_articulo=:articulo ' +
                    ' group by 1,2,3,4,5,6');    }
                  qLotes.SQLs.SelectSQL.Add('SELECT lt.id_lote, lt.nombre as lote, lt.caducidad, a.codigo, a.nombre as nom_art, sum(l.cantidad) as cantidad  '+
                    ' from a_picklin l ' +
                    ' left outer join a_lotes lt on lt.id_lote=l.id_lote ' +
                    ' left outer join g_articulos a on a.id_articulo=l.id_articulo ' +
                    ' where codalbaran=:codalbaran and l.id_articulo=:articulo ' +
                    ' group by 1,2,3,4,5');
                  qLotes.ParamByName('codalbaran').AsInteger := codalbaran;
                  qLotes.ParamByName('articulo').AsInteger  := qPickLines.FieldByName('id_articulo').AsInteger;
                  qLotes.Open;

                  {if qLotes.Eof then
                  begin
                      ShowMessage('No se han actualizado los lotes de este pedido.');
                      Exit;
                  end;}

                  qLotes.First;
                   while not qLotes.eof do
                   begin
                     { if ar_pick_ds.Locate('id_art',cdsLines.FieldByName('id_articulo').asinteger,[]) then
                      begin
                           ar_pick_ds.Edit;
                           ar_pick_ds.FieldByName('uds').AsInteger := ar_pick_ds.FieldByName('uds').AsInteger + dm.ds_2.FieldByName('cantidad').AsInteger;
                           ar_pick_ds.Post;
                      end;     }

                      if not ar_pick_ds.Locate('id_art;lote',VarArrayOf([qPickLines.FieldByName('id_articulo').AsInteger,Trim(qLotes.FieldByName('lote').asstring)]),[]) then
                      begin

                        ubicacion := GetUbiPick(qPickLines.FieldByName('id_pickcab').AsInteger,qPickLines.FieldByName('id_articulo').AsInteger);

                        agencia_txt := get_nombre_agencia(qAlbaran.FieldByName('agencia').asinteger);
                        nombre_art := BuscaArticulo(qPickLines.FieldByName('id_articulo').AsInteger,cod_art);

                        InsertLinePicking(qPickLines.FieldByName('id_articulo').AsInteger,       //id_art
                        UpperCase(cod_art),        //ref_art
                        suma_cantidad_art_en_gestoras(codalbaran,qPickLines.FieldByName('id_articulo').AsInteger),       //uds
                        imei,        //imei
                        1,                                           //tiene_lotes
                        Trim(qLotes.FieldByName('lote').AsString),   //lote
                        qLotes.FieldByName('caducidad').AsString,    //caducidad
                        qLotes.FieldByName('cantidad').asInteger,    //uds_lote
                        ubi,
                        ubicacion,  //ubicacion
                        UpperCase(nombre_art),   //artículo
                        qAlbaran.FieldByName('ref_cliente').asstring,             //pedido
                        qAlbDest.FieldByName('nombre').AsString,                 //nombre
                        qAlbDest.FieldByName('calle').AsString,                  //direccion
                        qAlbDest.FieldByName('localidad').AsString,              //poblacion
                        qAlbDest.FieldByName('provincia').AsString,              //provincia
                        qAlbDest.FieldByName('cod_postal').AsString,                     //cp
                        qAlbDest.FieldByName('email').AsString,                  //email
                        qAlbDest.FieldByName('telefono').AsString,               //telefono
                        codalbaran,   //codalbaran
                        //cb_delivery.Text,               //deliv_time
                        qAlbDest.FieldByName('pais').AsString,                 //cod_pais
                        UpperCase(tags),       //tag
                        es_devo, //es_devo
                        qAlbDest.FieldByName('observaciones').AsString,                    //observaciones
                        agencia_txt,                    //agencia_txt
                        '',               //dt_txt
                        qAlbDest.FieldByName('contacto').AsString,                //contacto
                        (qAlbaran.FieldByName('retorno').AsInteger=1),              //con retorno
                        qAlbaran.FieldByName('tipo_servicio').AsString,    //servicio
                        qAlbaran.FieldByName('horario').AsString,            //horario
                        usuario.id);
                      end else begin
                            ar_pick_ds.Edit;
                            ar_pick_ds.FieldByName('cantidad').AsInteger := ar_pick_ds.FieldByName('cantidad').AsInteger + qLotes.FieldByName('cantidad').asInteger;
                            ar_pick_ds.Post;
                      end;

                      qLotes.Next;
                   end;
                end;
    end;

    //ar_pick_ds.Post;
    qPickLines.Next;
  end;


  {modo:
   p imprimir
   v previsualizar
   f fichero
   z zebra}
  if ar_pick_ds.RecordCount>0 then
        LanzaImpresion(modo, path);

  repe.Free;
end;

procedure Tdm_pick.InsertLinePicking(id_art:Integer; ref_art:string; uds:Integer; imei:string; tiene_lotes:Integer; lote, caducidad:string; uds_lote,id_ubic: Integer;
                        ubic,articulo,pedido,nomape,direccion,poblacion,provincia,cp,mail,telefono:string; codalbaran:Integer;
                        cod_pais, tag:string; es_devo: Integer; observaciones, agencia_txt, dt_txt, contacto: string; con_retorno:Boolean;
                        servicio, horario:string; usuario:integer);
begin
  ar_pick_ds.insert;
  ar_pick_ds.FieldByName('id_art').AsInteger := id_art;
  ar_pick_ds.FieldByName('ref_art').AsString := ref_art;
  ar_pick_ds.FieldByName('uds').Asinteger := uds;
  ar_pick_ds.FieldByName('imei').AsString := imei;
  ar_pick_ds.FieldByName('tiene_lotes').Asinteger := tiene_lotes;
  ar_pick_ds.FieldByName('lote').AsString := lote;
  ar_pick_ds.FieldByName('caducidad').AsString := caducidad;
  ar_pick_ds.FieldByName('cantidad').Asinteger := uds_lote;
  ar_pick_ds.FieldByName('id_ubic').Asinteger := id_ubic;
  ar_pick_ds.FieldByName('ubicacion').Asstring := ubic;
  ar_pick_ds.FieldByName('articulo').Asstring := articulo;
  ar_pick_ds.FieldByName('pedido').asstring := pedido;
  ar_pick_ds.FieldByName('nomape').asstring := nomape;
  ar_pick_ds.FieldByName('direccion').asstring := direccion;
  ar_pick_ds.FieldByName('poblacion').asstring := poblacion;
  ar_pick_ds.FieldByName('provincia').asstring := provincia;
  ar_pick_ds.FieldByName('cp').asstring := cp;
  ar_pick_ds.FieldByName('mail').asstring := mail;
  ar_pick_ds.FieldByName('telefono').asstring := telefono;
  ar_pick_ds.FieldByName('codalbaran').AsInteger := codalbaran;
  //ar_pick_ds.FieldByName('deliv_time').Asstring := deliv_time;
  ar_pick_ds.FieldByName('CodPais').Asstring := cod_pais;
  ar_pick_ds.FieldByName('Tag').asstring := tag;
  ar_pick_ds.FieldByName('EsDevo').AsInteger := es_devo;
  ar_pick_ds.FieldByName('observaciones').asstring := observaciones;
  ar_pick_ds.FieldByName('agencia_txt').asstring := agencia_txt;
  ar_pick_ds.FieldByName('dt_txt').asstring := dt_txt;
  ar_pick_ds.FieldByName('con_retorno').AsBoolean := con_retorno;
  ar_pick_ds.FieldByName('contacto').asstring   := contacto;
  ar_pick_ds.FieldByName('servicio').asstring   := servicio;
  ar_pick_ds.FieldByName('horario').asstring   := horario;
  ar_pick_ds.FieldByName('pie_hoja_pick').asstring   := u_main.pie_hoja_pick;
  if servicio<>'' then
      ar_pick_ds.FieldByName('serv_txt').AsString := CargarDatosTablaGestoras('servicios','descripcion','codigo='+servicio);
  if horario<>'' then
      ar_pick_ds.FieldByName('hora_txt').AsString := CargarDatosTablaGestoras('horarios','descripcion','horario='+horario);
  ar_pick_ds.FieldByName('usu').AsInteger := usuario;
  ar_pick_ds.Post;
end;

procedure Tdm_pick.LanzaImpresion(modo,path:string);
var
  pic: TfrxPictureView;
begin
  frdevo.PrintOptions.Printer := imp_def;
  rep_pick_imei.PrintOptions.Printer := imp_def;
  rep_pick_lotes.PrintOptions.Printer := imp_def;
  rep_pick.PrintOptions.Printer := imp_def;
  rep_lotes_zebra.PrintOptions.Printer := imp_eti;

  if qAlbaran.fieldByName('cliente').asinteger = 9000 then
  begin
     if rep_todos.PrepareReport(True) then rep_todos.ShowPreparedReport;
  end
  else
    //Para Flamingos se saca en la hoja de picking el texto de devolución.
      if qAlbaran.fieldByName('cliente').asinteger = 7252 then
      begin
        qCliConfig.Close;
        qCliConfig.SQLs.SelectSQL.Clear;
        qCliConfig.SQLs.SelectSQL.Add('SELECT * from g_clientes_config where id_cliente=7252');
        qCliConfig.Open;
        qCliConfig.First;

        pic := frdevo.FindObject('txtNac') as TfrxPictureView;
        if Assigned(pic) then
          pic.Picture.Assign(qCliConfig.FieldByName('img_1'));

        pic := frdevo.FindObject('txtInt') as TfrxPictureView;
        if Assigned(pic) then
          pic.Picture.Assign(qCliConfig.FieldByName('img_2'));

        if frdevo.PrepareReport(True) then frdevo.ShowPreparedReport;
      end
      else //Grupo Merydeis saca las hojas mostrando el IMEI
          if u_main.tiene_imei then
          begin
            if modo='p' then
            begin
                if rep_pick.PrepareReport(True) then rep_pick.Print;
            end else if modo='v' then
                     begin
                          if rep_pick_imei.PrepareReport(True) then rep_pick_imei.ShowPreparedReport;
                     end
                     else if modo='f' then begin
                              pdf_export.FileName:=path;
                              if rep_pick_imei.Preparereport(true) then
                                rep_pick_imei.Export(pdf_export);
                          end;
          end
          else if u_main.tiene_lotes then
               begin
                   if modo='p' then
                   begin
                        if rep_pick_lotes.PrepareReport(True) then rep_pick_lotes.Print;
                   end
                   else if modo='v' then
                         begin
                              if rep_pick_lotes.PrepareReport(True) then rep_pick_lotes.ShowPreparedReport;
                         end
                         else if modo='f' then begin
                                  pdf_export.FileName:=path;
                                  if rep_pick_lotes.Preparereport(true) then
                                    rep_pick_lotes.Export(pdf_export);
                              end else if modo='z' then
                                             if rep_lotes_zebra.PrepareReport(True) then rep_lotes_zebra.print;
               end else begin
                       if modo='p' then
                       begin
                            if rep_pick.PrepareReport(True) then rep_pick.Print;
                       end
                       else if modo='v' then
                            begin
                                 if rep_pick.PrepareReport(True) then rep_pick.ShowPreparedReport;
                            end
                            else if modo='f' then begin
                                      pdf_export.FileName:=path;
                                      if rep_pick.Preparereport(true) then
                                        rep_pick.Export(pdf_export);
                                 end else if modo='z' then
                                             if rep_pick_zebra.PrepareReport(True) then rep_pick_zebra.print;

                      //if r2.PrepareReport(True) then r2.ShowPreparedReport;
                      end;


end;

function Tdm_pick.genera_picking(pedidos: string; id_usuario,id_almacem,packing,agrupado:integer): Boolean;
var
  error, error_exe, titulo_error: string;
begin
  t_write.StartTransaction;

  try
    if tiene_albs_gestoras then
    begin
      qry.close;                                                 //recoge picking
      qry.SelectSQL.clear;
      qry.SelectSQL.Add('select codalbaran ' + 'from c_pedidos ' + 'where id_pedido in (' + pedidos + ')');
      qry.Open;

      if not qry.IsEmpty then
      begin


      end;
    end;

    dm.t_write.Commit;
  except
    dm.t_write.Rollback;
  end;

  t_write_gestoras.StartTransaction;
  try
    upd.Database := db_gestoras;
    upd.SQL.Clear;
    upd.SQL.Add('execute procedure c_picking(:id_usuario,:id_almacem,:packing,:agrupado)');
   // upd.ParamByName('id_usuario').Value := dm.ds_2.FieldByName('id_pedido').AsInteger;
    upd.ParamByName('id_almacen').Value := id_almacen;
    upd.ExecProc;
    t_write_gestoras.CommitRetaining;

    error := upd.ParamByName('error').Value;
  except
    on E: Exception do
    begin
      error_exe := 'Error creando picking. ' + titulo_error;
      result := False;
      t_write_gestoras.RollbackRetaining;
      raise;
    end;
  end;

end;

end.
