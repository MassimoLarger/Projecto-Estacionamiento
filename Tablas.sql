create table Usuario(
	Correo text primary key,
	Nombre varchar(50),
	Telefono int,
	Tipo varchar(30),
	Contrasena varchar(50)
);

create table Tipo_Vehiculo(
	ID_Tipo_V smallint primary key,
	Nombre varchar(50)
);

create table Campus_Sede(
	ID_Campus smallint primary key,
	Nombre varchar(50),
	Ubicacion varchar(50),
	Capacidad int
);

create table Lugar_Estacionamiento(
	ID_Lugar smallint primary key,
	Descripcion text
);
----------------------------

create table Vehiculo(
	Patente varchar(12) primary key,
	Año int,
	Descripcion text,
	ID_Tipo_V smallint,
	foreign key (ID_Tipo_V) references Tipo_Vehiculo(ID_Tipo_V)
	on delete no action on update cascade
);

------------------------------

create table Registra(
	ID_Usuario text,
	ID_Vehiculo varchar(12),
	foreign key (ID_Usuario) references Usuario(Correo)
	on delete no action on update cascade,
	foreign key (ID_Vehiculo) references Vehiculo(Patente)
	on delete no action on update cascade,
	primary key (ID_Usuario,ID_Vehiculo)
);

create table Estacionamiento(
	ID_Estacionamiento text primary key,
	ID_Lugar smallint,
	ID_Campus smallint,
	Tipo varchar(20),
	foreign key (ID_Lugar) references Lugar_Estacionamiento(ID_Lugar)
	on delete no action on update cascade,
	foreign key (ID_Campus) references Campus_Sede(ID_Campus)
	on delete no action on update cascade
);

create table Reserva(
	fecha_reserva date,
	ID_Usuario text,
	ID_Estacionamiento text,
	foreign key (ID_Usuario) references Usuario(Correo)
	on delete no action on update cascade,
	foreign key (ID_Estacionamiento) references Estacionamiento(ID_Estacionamiento)
	on delete no action on update cascade
);

create table Ocupa(
	Fecha_Entrada time,
	Fecha_Salida time,
	Estado Boolean,
	ID_Estacionamiento text,
	ID_Vehiculo varchar(12),
	foreign key (ID_Estacionamiento) references Estacionamiento(ID_Estacionamiento)
	on delete no action on update cascade,
	foreign key (ID_Vehiculo) references Vehiculo(Patente)
	on delete no action on update cascade,
	primary key (ID_Estacionamiento,ID_Vehiculo,Fecha_Entrada)
);