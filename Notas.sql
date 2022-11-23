/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     04/11/2022 18:04:12                          */
/*==============================================================*/
create database Sistema_catastro;
use Sistema_catastro;
/*==============================================================*/
/* Table: Zona                                                  */
/*==============================================================*/
create table Zona 
(
   id_zona              integer                        not null,
   nombre_zona          varchar(20)                    null,
   primary key (id_zona)
);
/*==============================================================*/
/* Table: Tecnico                                               */
/*==============================================================*/
create table Tecnico 
(
   id_tecnico           integer                        not null,
   nombre_tecnico       varchar(20)                    null,
   apellido_tecnico     varchar(20)                    null,
   cedula_tecnico       varchar(10)                    null,
   telefono_tecnico     varchar(10)                    null,
   correo_tecnico       varchar(20)                    null,
   primary key (id_tecnico)
);
/*==============================================================*/
/* Table: Propietario                                           */
/*==============================================================*/
create table Propietario 
(
   id_propietario       integer                        not null,
   nombre_propietario   varchar(20)                    null,
   apellido_propietario varchar(20)                    null,
   cedula_propietario   varchar(10)                    null,
   telefono_domicilio   integer                        null,
   telefono_trabajo     integer                        null,
   correo_propietario   varchar(30)                    null,
   primary key (id_propietario)
);

/*==============================================================*/
/* Table: Provincia                                             */
/*==============================================================*/
create table Provincia 
(
   id_provincia         integer                        not null,
   nombre_provincia     varchar(20)                    null,
   region_provincia     varchar(20)                    null,
   primary key (id_provincia)
);
/*==============================================================*/
/* Table: Canton                                                */
/*==============================================================*/
create table Canton 
(
   id_canton            integer                        not null,
   id_provincia         integer                        null,
   nombre_canton        varchar(20)                    null,
   primary key (id_canton),
   foreign key (id_provincia) references Provincia (id_provincia)
);
/*==============================================================*/
/* Table: Lugar                                                 */
/*==============================================================*/
create table Lugar 
(
   id_lugar             integer                        not null,
   id_canton            integer                        null,
   nombre_lugar         varchar(30)                    null,
   direccion_lugar      varchar(60)                    null,
   primary key (id_lugar),
   foreign key (id_canton) references Canton(id_canton)
);


/*==============================================================*/
/* Table: Servicio                                              */
/*==============================================================*/
create table Servicio 
(
   id_servicio          integer                        not null,
   id_zona              integer                        null,
   nombre_servicio      varchar(20)                    null,
   estado_servicio      varchar(20)                    null,
   duracion_servicio    varchar(30)                    null,
   precio_servicio      decimal                        null,
   cotizacion_servicio  decimal                        null,
   primary key (id_servicio),
   foreign key (id_zona) references Zona (id_zona)
);
/*==============================================================*/
/* Table: Etapa_servicio                                        */
/*==============================================================*/
create table Etapa_servicio 
(
   id_etapa             integer                        not null,
   id_servicio          integer                        null,
   nombre_etapa         varchar(30)                    null,
   descripcion_etapa    varchar(100)                   null,
   fecha_inicio_etapa   date                           null,
   fecha_fin_etapa      date                           null,
   primary key (id_etapa),
   foreign key (id_servicio) references Servicio (id_servicio)
);
/*==============================================================*/
/* Table: Factura                                               */
/*==============================================================*/
create table Factura 
(
   id_factura           integer                        not null,
   id_servicio          integer                        null,
   id_propietario       integer                        null,
   num_factura          varchar(10)                    null,
   detalle_factura      varchar(30)                    null,
   costo_factura        decimal                        null,
   fecha_factura        date                           null,
   primary key (id_factura),
   foreign key (id_servicio) references Servicio (id_servicio),
   foreign key (id_propietario) references Propietario (id_propietario)
);

/*==============================================================*/
/* Table: Predio                                                */
/*==============================================================*/
create table Predio 
(
   id_predio            integer                        not null,
   descripcion_predio   varchar(100)                   null,
   largo_predio         decimal                        null,
   ancho_predio         decimal                        null,
   cotizacion_predio    decimal                        null,
   precio_predio        decimal                        null,
   primary key (id_predio)
);

/*==============================================================*/
/* Table: Solicitud                                             */
/*==============================================================*/
create table Solicitud 
(
   id_solicitud         integer                        not null,
   id_tecnico           integer                        null,
   id_propietario       integer                        null,
   id_servicio          integer                        null,
   id_provincia         integer                        null,
   descripcion_solicitud varchar(10)                    null,
   num_solicitud        varchar(10)                    null,
   fecha_solicitud      date                           null,
   estado_solicitud     varchar(10)                    null,
   primary key (id_solicitud),
   foreign key (id_tecnico) references Tecnico(id_tecnico),
   foreign key (id_propietario) references Propietario(id_propietario),
   foreign key (id_servicio) references Servicio(id_servicio),
   foreign key (id_provincia) references Provincia(id_provincia)
);
/*==============================================================*/
/* Table: predio_propietario                                    */
/*==============================================================*/
create table predio_propietario 
(
   id_propietario       integer                        not null,
   id_predio            integer                        not null,
   primary key (id_propietario, id_predio)
);

insert into Zona values(1,'RURAL');
insert into Zona values(2,'URBANA');
insert into Zona values(3,'CIUDAD');
insert into Zona values(4,'CIUDADELA');
insert into Tecnico values (1,'Samuel','Velez','1305842457','096321254','samuel10@gmail.com');
insert into Tecnico values (2,'Ricardo','Bowen','130562370','09541208','ricardo0@gmail.com');
insert into Tecnico values (3,'Jose','Mendoza','1342058752','0935471258','josemen@gmail.com');
insert into Tecnico values (4,'Kathia','Chavez','1311236571','0952301478','kathiach@gmail.com');
insert into Tecnico values (5,'Luis','Hernandez','1320125478','0985321236','luishrndz@gmail.com');

insert into Propietario values (1,'Pedro','Zambrano','1302585258',2532547,2542365,'perdozm@hotmail.com');
insert into Propietario values (2,'Daniela','Vaca','1311200485',2532547,2542365,'perdozm@hotmail.com');
insert into Propietario values (3,'Xavier','Diaz','1320125684',2532547,2542365,'perdozm@hotmail.com');
insert into Propietario values (4,'Wilson','Murillo','1311123654',2532547,2542365,'perdozm@hotmail.com');
insert into Propietario values (5,'Eduarda','Quiroz','1325458745',2532547,2542365,'perdozm@hotmail.com');

insert into Provincia values(1,'Guayas','Costa');
insert into Provincia values(2,'Manabi','Costa');
insert into Provincia values(3,'Pichincha','Sierra');
insert into Provincia values(4,'Azuay','Sierra');

insert into Canton values (1,1,'Guayaquil');
insert into Canton values (2,1,'Pedro Carbo');
insert into Canton values (3,1,'Duran');
insert into Canton values (4,2,'Manta');
insert into Canton values (5,2,'Portoviejo');
insert into Canton values (6,3,'Quito');
insert into Canton values (7,4,'Cuenca');

insert into Lugar values (1,5,'Cdla. Los Mangos','Calle 1 y calle 2');
insert into Lugar values (2,4,'Cdla. La Aurora','Calle 1 y calle 2');
insert into Lugar values (3,1,'Cdla. La Rioja','Calle 1 y calle 2');

insert into Servicio values (1,1,'Medicion de terreno','Aprobado','1 mes',500.50,600.00);
insert into Servicio values (2,2,'Medicion de terreno','Aprobado','1 mes',600.50,700.00);
insert into Servicio values (3,1,'Nombramiento','Aprobado','2 mes',900.50,1000.00);
insert into Servicio values (4,2,'Nombramiento','Aprobado','2 mes',950.50,1050.00);

insert into Etapa_servicio values (1,1,'Documentacion','Procesos de recepcion de documentos del predio','2022-01-05','2022-02-05');
insert into Etapa_servicio values (2,1,'Medicion','Procesos de medidicion del predio','2022-01-05','2022-01-06');
insert into Etapa_servicio values (3,2,'Logistica','Proceso de consultoria del predio','2022-01-07','2022-01-10');
insert into Etapa_servicio values (4,3,'Documentacion','Proceso de recepcion de documentos del predio','2022-01-12','2022-01-13');
insert into Etapa_servicio values (5,4,'Finalizacion','Proceso de entrega de nombramiento','2022-01-20','2022-01-21');

insert into Factura values (1,1,1,'FACT-001','pago de servicio de medicion ',500,'2022-04-21');
insert into Factura values (2,2,3,'FACT-002','pago de servicio de medicion ',500,'2022-05-22');
insert into Factura values (3,3,4,'FACT-003','pago de servicio nombramiento ',900,'2022-10-29');
insert into Factura values (4,3,2,'FACT-004','pago de servicio nombramiento ',1000,'2022-11-10');
insert into Factura values (5,4,1,'FACT-005','pago de servicio nombramiento ',1000,'2022-07-01');

insert into Predio values (1,'Lote de terreno',30,50,30000,35000);
insert into Predio values (2,'Terreno',300,500,300000,350000);
insert into Predio values (3,'Terreno ubicado en las afueras de la ciudad',35,60,30000,31500);
insert into Predio values (4,'Terreno ubicado en un hacienda',20,30,30000,33000);
insert into Predio values (5,'Terreno familira',33,30,30000,34000);

insert into Solicitud values (1,1,2,2,2,'Medicion','SOL-0001','2022-01-03','Pendiente');
insert into Solicitud values (2,1,2,3,1,'Nombra','SOL-0002','2022-04-03','Aprobada');
insert into Solicitud values (3,1,2,1,3,'Medicion','SOL-0003','2022-03-23','Aprobada');
insert into Solicitud values (4,2,2,4,2,'Nombra','SOL-0004','2022-03-21','Pendiente');
insert into Solicitud values (5,2,2,1,1,'Medicion','SOL-0005','2022-10-11','Aprobada');
insert into Solicitud values (6,3,2,2,4,'Medicion','SOL-0006','2022-03-12','Aprobada');


insert into Solicitud values (7,4,2,2,1,'Medicion','SOL-0007','2022-12-05','Pendiente');
insert into Solicitud values (8,4,2,1,1,'Medicion','SOL-0008','2021-12-07','Pendiente');
insert into Solicitud values (9,4,3,2,3,'Medicion','SOL-0009','2021-12-07','Pendiente');
insert into Solicitud values (10,4,5,2,3,'Medicion','SOL-0009','2021-12-07','Pendiente');




insert into predio_propietario values (1,1);
insert into predio_propietario values (1,2);
insert into predio_propietario values (1,3);
insert into predio_propietario values (2,4);
insert into predio_propietario values (2,5);



-- 1.	Histórico de servicios atendidos por los técnicos

select 
	year (Solicitud.fecha_solicitud) as año_solicitud,
	Tecnico.nombre_tecnico,
	COUNT(*) as cantidad_servicios_atendidos,
	Servicio.nombre_servicio
from Tecnico 
	inner join Solicitud on Tecnico.id_tecnico = Solicitud.id_tecnico
	inner join Servicio on Solicitud.id_servicio= Servicio.id_servicio
where Servicio.estado_servicio='Aprobado'
group by year (Solicitud.fecha_solicitud),Tecnico.nombre_tecnico,Servicio.nombre_servicio

-- 2.	Histórico de ingresos por servicio

select 
	year(Factura.fecha_factura) as año_ingresos,
	Servicio.nombre_servicio,
	sum(Factura.costo_factura) as Ingresos
from Servicio
	inner join Factura on Servicio.id_servicio=Factura.id_servicio
group by year(Factura.fecha_factura),Servicio.nombre_servicio

-- 3.	Histórico de solicitudes pendientes y aprobadas por año.

select
	year (Solicitud.fecha_solicitud) as Anio_sol,
	Servicio.nombre_servicio,
	Solicitud.estado_solicitud,
	count(*) as cantidad
from Solicitud
	inner join Servicio on Servicio.id_servicio = Solicitud.id_servicio
group by year (Solicitud.fecha_solicitud),Servicio.nombre_servicio,Solicitud.estado_solicitud

-- 4.	Histórico de solicitudes por lugar.

select 
	year(Solicitud.fecha_solicitud) as year_sol,
	Lugar.nombre_lugar,
	Canton.nombre_canton,
	Servicio.nombre_servicio,
	COUNT(*) as cantidad_solicitudes
from Servicio
	inner join Solicitud on Servicio.id_servicio=Solicitud.id_servicio
	inner join Provincia on Solicitud.id_provincia= Provincia.id_provincia
	inner join Canton on Provincia.id_provincia = Canton.id_provincia
	inner join Lugar on Canton.id_canton = Lugar.id_canton
group by year(Solicitud.fecha_solicitud),Lugar.nombre_lugar,Canton.nombre_canton,Servicio.nombre_servicio





