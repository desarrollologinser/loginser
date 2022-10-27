unit u_packing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinProvider, sSkinManager, StdCtrls, sLabel, sEdit, sSpinEdit,
  Mask, sMaskEdit, sCustomComboEdit, sTooledit, sMemo, Buttons, sSpeedButton,
  sGroupBox, ImgList, ExtCtrls, sPanel, sDBNavigator, DB, FIBDataSet,
  pFIBDataSet,sdialogs, sComboBox, Grids, JvExGrids, JvStringGrid, ComCtrls,
  sPageControl, DBCGrids, acDBCtrlGrid, sBevel, DBGrids, JvExDBGrids, JvDBGrid;

type
  Tf_packing = class(TForm)
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sb_salir: TsSpeedButton;
    ImageList1: TImageList;
    sGroupBox3: TsGroupBox;
    sLabel5: TsLabel;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    sEdit2: TsEdit;
    sGroupBox1: TsGroupBox;
    sLabel4: TsLabel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    l_cliente: TsLabel;
    l_fecha: TsLabel;
    sGroupBox2: TsGroupBox;
    sLabel6: TsLabel;
    l_albaran: TsLabel;
    sLabel7: TsLabel;
    l_articulo: TsLabel;
    sLabel8: TsLabel;
    l_unidades: TsLabel;
    sLabel9: TsLabel;
    l_bultos: TsLabel;
    sSpeedButton1: TsSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sb_salirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sb_buscaClick(Sender: TObject);
    procedure sb_nuevoClick(Sender: TObject);
    procedure sb_grabaClick(Sender: TObject);
    procedure sb_cancelaClick(Sender: TObject);
    procedure sb_as_clienteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure e_clienteExit(Sender: TObject);
    procedure sb_modifClick(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure llena_cabecera;
    procedure vacia_cabecera;
    procedure cambio_modo(modo:integer);
    procedure llena_detalle;
  end;

var
  f_packing: Tf_packing;
  modo_cabecera:integer=0; //0-modo nada, 1-busqueda, 2-nuevo
  modo_detalle:integer=0;  //0-modo visualizar, 1-añadir, 2-modificar lineas

implementation

uses udm, u_globals, ubuscapro;

{$R *.dfm}



procedure Tf_packing.FormCreate(Sender: TObject);
begin
  {e_fecha.date:=date;
  e_hora.time:=time;

  u_globals.conectar;      }
end;

procedure Tf_packing.FormShow(Sender: TObject);
begin
 { dm.ini_tables;
  cambio_modo(0);          }
end;

procedure Tf_packing.sb_buscaClick(Sender: TObject);
begin                                            //Buscar entrada
{with fbuscapro do begin
 limpia_fields;     multiselect:=false;    livekey:=false;      
// if con_con.items.count=3 then con_con.items.delete(2);       
 wide[1]:=30;   wide[2]:=30;   wide[3]:=90;   wide[4]:=45;   wide[5]:=45;  wide[6]:=50;
 wide[7]:=50;   wide[8]:=50;   wide[9]:=60;
 //ancho:=600;    alto:=400;
 fields.commatext:='c.id_moacab,c.id_cliente,cl.nombre,c.fecha,c.hora,c.albaran,c.transportista,c.matricula,u.usuario';
 titulos.commatext:='Numero,Cliente,NCliente,Fecha,Hora,Albaran,Transportsita,Matricula,Usuario';
 from:='a_moacab c left outer join g_clientes cl on (c.id_cliente=cl.id_cliente) left outer join g_usuarios u on (c.id_usuario=u.id_usuario)';
 where:='(c.id_empresa='+u_globals.empresa+')';
 orden[1]:=1;  orden[2]:=2;   busca:=1;   distinct:=0;

 showmodal;

 if resultado then begin
   dm.q.close;
   dm.q.SQLs.selectsql.Clear;
   dm.q.SQLs.selectsql.add('select * from a_moacab where id_moacab='+valor[1]);
   dm.q.Open;
   if not(dm.q.IsEmpty) then begin
       llena_cabecera;
       cambio_modo(1);
     end else raise exception.create('Movimiento De Entrada No Encontrado');
 end else raise exception.create('Movimiento De Entrada No Encontrado');
end;//with               }
end;

procedure Tf_packing.sb_cancelaClick(Sender: TObject);
begin                                  //Cancelar entrada
  cambio_modo(0);
end;

procedure Tf_packing.sb_grabaClick(Sender: TObject);
var s:string;    i:integer;
begin                                    //Grabar entrada
 {if smessagedlg('Se Va A Proceder A Grabar Los Datos De La Entrada Y A Actualizarlos, ¿Esta Seguro?',mtconfirmation,[mbyes,mbno],0)=mryes then begin
   //Verificacion de datos                                     
      if e_cliente.text<>'' then
        with tpfibdataset.create(self) do
        try
          database:=dm.db;
          s:='select nombre from g_clientes where id_cliente='+e_cliente.text+' and id_empresa='+u_globals.empresa;
          sqls.selectsql.Add(s);
          open;
          if not(isempty) then s:=fieldbyname('nombre').asstring
            else s:='';
        finally
          free;
        end
      else s:='';
      l_cliente.Caption:=s;
      if s='' then raise exception.create('Campo Cliente Invalido');
   //Grabacion de cabecera
     //Obtener numero de cabecera
       with tpfibdataset.create(self) do
        try
          database:=dm.db;
          s:='select max(id_moacab) as numero from a_moacab where id_empresa='+u_globals.empresa;
          sqls.selectsql.Add(s);
          open;
          if not(isempty) then i:=fieldbyname('numero').asinteger+1
            else i:=1;
        finally
          free;
        end;
       e_numero.text:=inttostr(i);
     //Grabar cabecera en bd
       with dm.q_w do begin
         close;
         sql.clear;
         sql.add('insert into a_moacab (id_moacab,fecha,hora,id_usuario,id_cliente,albaran,transportista,matricula,observaciones,estado,id_empresa) '+
           ' values ('+e_numero.text+','+quotedstr(formatdatetime('mm/dd/yyyy',e_fecha.date))+','+quotedstr(timetostr(e_hora.time))+','+
           inttostr(u_globals.id_usuario)+','+e_cliente.text+','+quotedstr(e_albaran.text)+','+quotedstr(e_transportista.text)+','+
           quotedstr(e_matricula.text)+','+quotedstr(m_observaciones.text)+','+quotedstr(cb_estado.text[1])+','+u_globals.empresa+')');
         execquery;
       end;

       cambio_modo(1);

 end;          }
end;

procedure Tf_packing.sb_modifClick(Sender: TObject);
begin                                            //Modificar Entrada
  modo_detalle:=2;
end;

procedure Tf_packing.sb_nuevoClick(Sender: TObject);
begin                                     //Nueva entrada
 { vacia_cabecera;
  cambio_modo(2);
  cb_estado.itemindex:=0;  }
end;

procedure Tf_packing.sb_salirClick(Sender: TObject);
begin                                     //Salir
  close;
end;

procedure Tf_packing.sSpeedButton6Click(Sender: TObject);
begin
{dm.d_ubic_entra.active:=true;  }
end;

procedure Tf_packing.llena_cabecera;
var s:string;
begin                                      //Llena datos de cabecera desde la bd
 { with dm.q do begin
    e_numero.text:=fieldbyname('id_moacab').asstring;
    e_fecha.date:=fieldbyname('fecha').asdatetime;
    e_hora.Time:=fieldbyname('hora').asdatetime;
    e_cliente.Text:=fieldbyname('id_cliente').asstring;

    if fieldbyname('id_cliente').asstring<>'' then
      with tpfibdataset.create(self) do
      try
        database:=dm.db;
        s:='select nombre from g_clientes where id_cliente='+dm.q.fieldbyname('id_cliente').asstring+' and id_empresa='+u_globals.empresa;
        sqls.selectsql.Add(s);
        open;
        if not(isempty) then s:=fieldbyname('nombre').asstring
          else s:='';
      finally
        free;
      end
    else s:='';
    l_cliente.Caption:=s;

    e_albaran.text:=fieldbyname('albaran').asstring;
    e_transportista.text:=fieldbyname('transportista').asstring;
    e_matricula.text:=fieldbyname('matricula').asstring;
    m_observaciones.text:=fieldbyname('observaciones').asstring;

    s:=fieldbyname('estado').asstring;
    if s='A' then cb_estado.itemindex:=0;
    if s='B' then cb_estado.itemindex:=1;
    if s='S' then cb_estado.itemindex:=2;
  end;          }
end;

procedure Tf_packing.vacia_cabecera;
begin                                   //Deja la cabecera limpia de datos
 { e_numero.text:='';
  e_fecha.date:=date;
  e_hora.time:=time;
  e_cliente.text:='';
  l_cliente.caption:='';
  e_albaran.text:='';
  e_transportista.text:='';
  e_matricula.text:='';
  m_observaciones.text:='';     }
end;

procedure Tf_packing.cambio_modo(modo:integer);
begin                                  //Cambia de modo visual (0=Nada/1=Busqueda/2=Edicion)
{if modo=0 then begin
  f_ubicaciones.Height:=90;
  gb_cabecera.visible:=false;
  gb_detalle.visible:=false; 
  sb_busca.enabled:=true;
  sb_nuevo.Enabled:=true;
  sb_graba.Enabled:=false;
  sb_cancela.Enabled:=false;
  sb_modif.enabled:=false;
  modo_detalle:=0;
end;

if modo=1 then begin
  f_ubicaciones.Height:=620;
  gb_cabecera.visible:=true;
  gb_detalle.visible:=true; 
  sb_as_cliente.enabled:=false;
  e_numero.readonly:=true;
  e_fecha.readonly:=true;
  e_hora.readonly:=true;
  e_cliente.readonly:=true;
  e_albaran.readonly:=true;
  e_transportista.readonly:=true;
  e_matricula.readonly:=true;
  m_observaciones.readonly:=true;
  cb_Estado.enabled:=false;
  sb_busca.enabled:=true;
  sb_nuevo.Enabled:=true;
  sb_graba.Enabled:=false;
  sb_cancela.Enabled:=false;
  sb_modif.enabled:=true;
  lb_lineas.caption:='Líneas de la Cabecera';
  modo_detalle:=0;
end;

if modo=2 then begin
  f_ubicaciones.Height:=620;
  gb_cabecera.visible:=true;
  gb_detalle.visible:=true;
  sb_as_cliente.enabled:=true;
  e_numero.readonly:=true;
  e_fecha.readonly:=false;
  e_hora.readonly:=false;
  e_cliente.readonly:=false;
  e_albaran.readonly:=false;
  e_transportista.readonly:=false;
  e_matricula.readonly:=false;
  m_observaciones.readonly:=false;
  cb_Estado.enabled:=true;
  sb_busca.enabled:=false;
  sb_nuevo.Enabled:=false;
  sb_graba.Enabled:=true;
  sb_cancela.Enabled:=true;
  sb_modif.enabled:=false;
  lb_lineas.caption:='Añadiendo Líneas de la Cabecera';
  modo_detalle:=1;
end;

llena_detalle;       }

end;

procedure Tf_packing.sb_as_clienteClick(Sender: TObject);
begin                                           //Busca y asigna cliente
{with fbuscapro do begin
 limpia_fields;     multiselect:=false;    livekey:=false;      
// if con_con.items.count=3 then con_con.items.delete(2);       
 wide[1]:=30;   wide[2]:=90;   wide[3]:=90;   wide[4]:=30;   wide[5]:=45;  wide[6]:=45;
 wide[7]:=45;   wide[8]:=45;   wide[9]:=60;   wide[10]:=45;
 //ancho:=600;    alto:=400;
 fields.commatext:='id_cliente,nombre,direccion,cp,poblacion,provincia,telefono,fax,email,nif';
 titulos.commatext:='Numero,Cliente,Direccion,CP,Poblacion,Provincia,Telefono,FAX,Email,NIF';
 from:='g_clientes';
 where:='(estado<''B'') and (id_empresa='+u_globals.empresa+')';
 orden[1]:=1;  orden[2]:=2;   busca:=1;   distinct:=0;

 showmodal;

 if resultado then begin
   e_cliente.text:=valor[1];
   l_cliente.caption:=valor[2];
   e_albaran.setfocus;
 end else raise exception.create('Cliente No Encontrado');
end;//with   }
end;

procedure Tf_packing.e_clienteExit(Sender: TObject);
var s:string;
begin                                        //Saliendo del edit cliente
 { if e_cliente.text<>'' then
    with tpfibdataset.create(self) do
    try
      database:=dm.db;
      s:='select nombre from g_clientes where id_cliente='+e_cliente.text+' and id_empresa='+u_globals.empresa;
      sqls.selectsql.Add(s);
      open;
      if not(isempty) then s:=fieldbyname('nombre').asstring
        else s:='';
    finally
      free;
    end
  else s:='';
  l_cliente.Caption:=s;   }
end;
           
procedure Tf_packing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then                          { if it's an enter key }
   begin
       Key := #0;                                 { eat enter key }
       Perform(WM_NEXTDLGCTL, 0, 0);              { move to next control }
   end
end;

procedure Tf_packing.llena_detalle;
begin                                     //Prepara detalle
{sg_lineas.rowcount:=0;       }


end;

end.
