--Trigger
--Trigger que no permita asignar las solicitudes a un técnico cuando tenga tres solicitudes pendientes

create trigger Trigger_Bloqueo_Tecnicos
	on Solicitud
	for insert as
	if exists(select count(*)
				from Solicitud 
				inner join Tecnico on Solicitud.id_tecnico = Tecnico.id_tecnico
				where Solicitud.estado_solicitud = 'Pendiente' 
				group by Solicitud.id_tecnico
				having count(*) = 4
				)
begin
RAISERROR ('No puede ingresar una nueva solicitud debido a que el tecnico tiene 3 solicitudes pendientes', 16, 1);       
ROLLBACK TRANSACTION;  
RETURN   
END;  
GO  

--Procedimiento almacenado
--Ingresar como parámetro el nombre del técnico y me muestre por cada año que servicio a emitido y la cantidad.
--Parámetro de entrada: nombre del técnico.

create procedure Servicios_atendidos
(
	@nombre_tecnico varchar(20)
)
as begin 
	select 
		year (Solicitud.fecha_solicitud) as c,
		@nombre_tecnico as nombre_tecnico,
		COUNT(*) as cantidad_servicios_atendidos,
		Servicio.nombre_servicio
	from
		Tecnico 
		inner join Solicitud on Tecnico.id_tecnico = Solicitud.id_tecnico
		inner join Servicio on Solicitud.id_servicio= Servicio.id_servicio
	where Tecnico.nombre_tecnico=@nombre_tecnico
	group by year (Solicitud.fecha_solicitud),Tecnico.nombre_tecnico,Servicio.nombre_servicio
end;

--ejecutar procedimiento almacenado
exec Servicios_atendidos 'Jose';


--Cursor
--Mostrar por año y por provincia cuanto hubo de ingreso por cada servicio.

declare Cursor_recorrer_ingresosxprovincia cursor
for 
	select
		year(Solicitud.fecha_solicitud) as año,
		Provincia.nombre_provincia,
		Servicio.nombre_servicio,
		SUM(Factura.costo_factura) as total_ingresos
	from Factura
		inner join Servicio on Servicio.id_servicio = Factura.id_servicio
		inner join Solicitud on Servicio.id_servicio=Solicitud.id_servicio
		inner join Provincia on Solicitud.id_provincia=Provincia.id_provincia
	group by 
		year(Solicitud.fecha_solicitud),
		Provincia.nombre_provincia,
		Servicio.nombre_servicio
--abrir el cursor
open Cursor_recorrer_ingresosxprovincia;
--recorrer el cursor
Fetch next from Cursor_recorrer_ingresosxprovincia;
--cerrar el cursor
close Cursor_recorrer_ingresosxprovincia;
--liberar de memoria
deallocate Cursor_recorrer_ingresosxprovincia;


--Ireport
--Reporte en Ireport que muestre en un diagrama de barras en vertical total de ingresos a la empresa por cada servicio.

select 
Servicio.nombre_servicio,
sum(Factura.costo_factura) as Total_ingresos
from
Servicio
inner join Factura on Servicio.id_servicio = Factura.id_servicio
group by Servicio.nombre_servicio


