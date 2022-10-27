unit u_lotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, sLabel, Vcl.ExtCtrls, pFIBDataSet;

type
  TfrmLotes = class(TForm)
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CreaMensaje(Sender: TObject);
    procedure InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
    procedure ActualizaPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer);

  public
    { Public declarations }
    procedure ActualizaLotes(id_cliente,cl_padre,usu:Integer;pedidos:TStringList;nom_cli,nom_pc,ip:string);
    procedure EnviaLotes(peds:TStringList;nom_cli,nom_pc,ip: string; forzar,cl_padre:integer; url,user,pass:string);
  end;

var
  frmLotes: TfrmLotes;

implementation

{$R *.dfm}

uses
  u_dm, u_main, u_dmPargal, u_functions, u_envia_mail;


procedure TfrmLotes.CreaMensaje(Sender: TObject);
var
  AMsgDialog: TForm;
  res:TmodalResult;
  lbl:Tlabel;
  btn:TButton;
  img:TImage;
  chk:TCheckBox;
begin
  AMsgDialog := CreateMessageDialog('Mensaje de prueba...', mtWarning, [mbYes, mbNo]) ;
  AMsgDialog.Caption := 'Cambiando título...' ;

  // Cambiar el ancho
  AMsgDialog.Width := AMsgDialog.Width * 2;

  // Modificar el Label
  lbl := TLabel(AMsgDialog.FindComponent('Message'));
  lbl.Font.Style := lbl.Font.Style + [fsItalic];
  lbl.Font.Color := clRed;

  // Modificar el YES
  btn := TButton(AMsgDialog.FindComponent('YES'));
  btn.Font.Style := btn.Font.Style + [fsBold];

  // Modificar la imagen
  {img := TImage(AMsgDialog.FindComponent('Image'));
  img.Stretch := true;
  img.Picture.LoadFromFile('r:\neftali.bmp');
  }
  // Añadir un CheckBox
  {chk := TCheckBox.Create(AMsgDialog);
  chk.Parent := AMsgDialog;
  chk.Caption := 'No volver a &recordarmelo.';
  chk.Width := 200;
  AMsgDialog.Height := AMsgDialog.Height + 30;
  chk.Left := 15;
  chk.Top := AMsgDialog.Height - 20 - 30;   }


  res := AMsgDialog.ShowModal;

  AMsgDialog.Free;

end;


procedure TfrmLotes.FormShow(Sender: TObject);
begin
    CreaMensaje(self);
end;

procedure TfrmLotes.ActualizaLotes(id_cliente,cl_padre,usu:integer;pedidos:TStringList;nom_cli,nom_pc,ip:string);
var
  cant_pick, cant_ped, art_actual, alb_actual, art_aux: Integer;
  peds_act: string;
  i: integer;
begin
    peds_act := '';
    art_actual := -1;
    alb_actual := -1;
    art_aux := -1;

    try
      with tpfibdataset.Create(dm) do
      begin
        for I := 0 to pedidos.Count-1 do
        begin
          close;
          database := dm.db;
          SelectSQL.Clear;
          SelectSQL.Add('select distinct p.id_pedido, p.codalbaran, l.id_articulo ' +
                        'from c_pedidos p ' +
                        'inner join c_pedidos_lines l on p.id_pedido=l.id_pedido ' +
                        'left outer join c_pedidos_lines_lotes lt on l.id_pedido=lt.id_pedido and l.id_articulo=lt.id_articulo ' +
                        'where p.id_cliente=:id_cliente and p.codalbaran>0 and ' +
                        'lt.id_pedido is null and lt.id_articulo is null ');
          SelectSQL.Add(' and p.id_pedido=:id_pedido');

          ParamByName('id_pedido').AsInteger := StrToInt(pedidos[i]);
          ParamByName('id_cliente').AsInteger := id_cliente;
          Open;

          if not IsEmpty then
          begin
            dm.t_write.StartTransaction;

            First;

            while not Eof do
            begin

              if Pos(FieldByName('id_pedido').AsString,peds_act)=0 then
                        peds_act := peds_act + FieldByName('id_pedido').AsString + ',';

              if ((art_actual <> FieldByName('id_articulo').AsInteger) or (alb_actual <> FieldByName('codalbaran').AsInteger)) then
              begin
                art_actual := FieldByName('id_articulo').AsInteger;
                alb_actual := FieldByName('codalbaran').AsInteger;

                if FieldByName('codalbaran').AsInteger > 0 then
                begin

                  if cl_padre<0 then
                       art_aux := FieldByName('id_articulo').AsInteger
                  else
                       art_aux := busca_art(get_codcli_art(FieldByName('id_articulo').AsInteger),cl_padre);

                  if art_aux>=0 then
                  begin
                    dm.q_pick_lotes.Close;
                    dm.q_pick_lotes.ParamByName('albaran').AsInteger := FieldByName('codalbaran').AsInteger;
                    dm.q_pick_lotes.ParamByName('articulo').AsInteger := art_aux;
                    dm.q_pick_lotes.Open;
                    dm.q_pick_lotes.First;

                    while not dm.q_pick_lotes.eof do
                    begin
                      InsertaLote(FieldByName('id_pedido').AsInteger, FieldByName('id_articulo').AsInteger, dm.q_pick_lotes.FieldByName('id_lote').AsInteger, dm.q_pick_lotes.FieldByName('cantidad').AsInteger, dm.q_pick_lotes.FieldByName('id_pickcab').AsInteger, dm.q_pick_lotes.FieldByName('linea').AsInteger);
                      //ActualizaPackLote(dm.q_pick_lotes.FieldByName('id_pickcab').AsInteger, dm.q_pick_lotes.FieldByName('linea').AsInteger, FieldByName('codalbaran').AsInteger, FieldByName('id_articulo').AsInteger, dm.q_pick_lotes.FieldByName('cantidad').AsInteger, dm.q_pick_lotes.FieldByName('id_lote').AsInteger);

                      if cl_padre<0 then

                        InsertaLog(usu,0,0,nom_pc,ip,'c_pedidos_lines_lotes','',
                                   'insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' +
                                   'values (' + FieldByName('id_pedido').AsString + ',' +
                                   FieldByName('id_articulo').asstring + ',' +
                                   dm.q_pick_lotes.FieldByName('id_lote').asstring + ',' +
                                   dm.q_pick_lotes.FieldByName('cantidad').asstring + ',' +
                                   dm.q_pick_lotes.FieldByName('id_pickcab').AsString + ',' +
                                   dm.q_pick_lotes.FieldByName('linea').AsString + ')',
                                   'Lote Insertado (' + ExtractFileName(Application.ExeName)+')','')

                      else
                         InsertaLog(usu,0,0,nom_pc,ip,'c_pedidos_lines_lotes','',
                                   'insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' +
                                   'values (' + FieldByName('id_pedido').AsString + ',' +
                                   FieldByName('id_articulo').asstring + ',' +
                                   dm.q_pick_lotes.FieldByName('id_lote').asstring + ',' +
                                   dm.q_pick_lotes.FieldByName('cantidad').asstring + ',' +
                                   dm.q_pick_lotes.FieldByName('id_pickcab').AsString + ',' +
                                   dm.q_pick_lotes.FieldByName('linea').AsString + ')',
                                   'Lote Insertado (' + ExtractFileName(Application.ExeName)+')','ArtClPadre:' + IntToStr(art_aux));


                      dm.q_pick_lotes.Next;
                    end;
                  end;
                end;
              end;
              Next;
            end;

            dm.t_write.Commit;
          end;
        end;
      end;

    except
      dm.t_write.Rollback;
      ShowMessage('Error al actualizar lotes.');
    end;


end;

procedure TfrmLotes.InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' + 'values (:id_pedido, :id_articulo, :id_lote, :cantidad, :id_picking, :linea)');
  dm.q_1.ParamByName('id_pedido').AsInteger := pedido;
  dm.q_1.ParamByName('id_articulo').AsInteger := art;
  dm.q_1.ParamByName('id_lote').asinteger := lote;
  dm.q_1.ParamByName('cantidad').asinteger := cantidad;
  dm.q_1.ParamByName('id_picking').asinteger := id_pick;
  dm.q_1.ParamByName('linea').asinteger := l_pick;

  dm.q_1.ExecQuery;
end;

procedure TfrmLotes.ActualizaPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer);
begin
  dm.qu_1.Close;
  dm.qu_1.sql.Clear;
  dm.qu_1.sql.Add('update a_packlin ' +
                  'set id_lote=:id_lote ' +
                  'where id_packcab=:id_packcab and ' +
                  'linea=:linea and codalbaran=:codalbaran and ' +
                  'id_articulo=:id_articulo and cantidad=:cantidad and id_lote<>:id_lote');
  dm.qu_1.ParamByName('id_packcab').AsInteger := id_pickcab;
  dm.qu_1.ParamByName('linea').AsInteger := linea;
  dm.qu_1.ParamByName('codalbaran').AsInteger := codalbaran;
  dm.qu_1.ParamByName('id_articulo').AsInteger := id_articulo;
  dm.qu_1.ParamByName('cantidad').AsInteger := cantidad;
  dm.qu_1.ParamByName('id_lote').AsInteger := id_lote;

  dm.qu_1.ExecQuery;
end;

procedure TfrmLotes.EnviaLotes(peds:TStringList; nom_cli,nom_pc,ip: string; forzar,cl_padre:Integer; url,user,pass:string);
var
  token,log: string;
  i: integer;
  resultado, body: string;
  cuerpo:TStringList;
begin

   resultado := '';
   token := dmPargal.Login(url,user,pass);

   for I := 0 to peds.Count-1 do
   begin
       if ((forzar=1) or (GetExtraPedido(StrToInt(peds[i]),'LOG_LOTE')='')) then
       begin
        log := '';

        try
          resultado := dmPargal.EnviaPedido(token,url,StrToInt(peds[i]),cl_padre,log);
        except on e:Exception do begin
           resultado := 'SYS ' + e.message;

            body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                  '<body><table border=0> ' +
                  '<tr><td>Intento fallido de envío de lotes al cliente. Por favor, revisar pedido ' + peds[i] +'.</td></tr>'+
                  '<tr><td>Por favor, contactar con el cliente en caso necesario. Gracias.</td></tr> '+
                  '<tr><td>ERROR DE SISTEMA.</td></tr>'+
                  '<tr><td>' + e.Message + '</td></tr>'+
                  '</table></body><html>';

            cuerpo:=tstringlist.Create;
            cuerpo.Add(body);
            f_envia_mail.Show;
            f_envia_mail.envia_email(u_main.mail_error,'','Intento fallido envío lotes ' + nom_cli,
                                     '','', cuerpo);
            f_envia_mail.Close;
            u_functions.insertalog(u_main.usuario.id,0,0,nom_pc,ip,'','','','Envio email aviso error a ' + mail_error,body);
            cuerpo.Free;
          end;
        end;

        if Pos('(409)',resultado)>0 then
        begin
          body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                  '<body><table border=0> ' +
                  '<tr><td>Intento fallido de envío de lotes al cliente. Por favor, revisar pedido ' + peds[i] +'.</td></tr>'+
                  '<tr><td>El cliente indica que el pedido ya se ha pasado a factura y no permite modificar el pedido.</td></tr>'+
                  '<tr><td>Por favor, contactar con el cliente en caso necesario. Gracias.</td></tr> '+
                  '<tr><td>Respuesta automática desde el sistema del cliente:' + resultado +'</td></tr>'+
                  '</table></body><html>';

          cuerpo:=tstringlist.Create;
          cuerpo.Add(body);
          f_envia_mail.Show;
          f_envia_mail.envia_email(u_main.mail_error,'','Intento fallido envío lotes ' + nom_cli,
                                   '','', cuerpo);
          f_envia_mail.Close;
          u_functions.insertalog(u_main.usuario.id,0,0,nom_pc,ip,'','','','Envio email aviso error a ' + mail_error,body);
          cuerpo.Free;
        end else if Pos('(404)',resultado)>0 then
                 begin
                    body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                            '<body><table border=0> ' +
                            '<tr><td>Intento fallido de envío de lotes al cliente. Por favor, revisar pedido ' + peds[i] +'.</td></tr>'+
                            '<tr><td>El cliente indica que el pedido no existe en su sistema.</td></tr>'+
                            '<tr><td>Por favor, contactar con el cliente en caso necesario. Gracias.</td></tr> '+
                            '<tr><td>Respuesta automática desde el sistema del cliente:' + resultado +'</td></tr>'+
                            '</table></body><html>';

                    cuerpo:=tstringlist.Create;
                    cuerpo.Add(body);
                    f_envia_mail.Show;
                    f_envia_mail.envia_email(u_main.mail_error,'','Intento fallido envío lotes ' + IntToStr(u_main.main_cli),
                                             '','', cuerpo);
                    u_functions.insertalog(u_main.usuario.id,0,0,nom_pc,ip,'','','','Envio email aviso error a ' + mail_error, body);
                    cuerpo.Free;
                 end;

        if Log<>'' then
           u_functions.insertalog(u_main.usuario.id,0,0,nom_pc,ip,'','','','Envío lotes a cliente',log);

        if ((Pos('(409)',resultado)>0) or (Pos('(404)',resultado)>0) or (Pos('SYS',resultado)>0)) then
            inserta_pedido_extra(StrToInt(peds[i]),'LOG_LOTE_ERROR',FormatDateTime('dd.mm.yy hh:mm:ss',now)+' '+resultado)
        else
            inserta_pedido_extra(StrToInt(peds[i]),'LOG_LOTE',FormatDateTime('dd.mm.yy hh:mm:ss',now)+' '+resultado);

       end else inserta_pedido_extra(StrToInt(peds[i]),'LOG_LOTE',FormatDateTime('dd.mm.yy hh:mm:ss',now)+' Intento reenvío de lotes a cliente. ');
   end;

   //showmessage(resultado);
end;


end.
