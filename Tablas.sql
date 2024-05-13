create table Usuario(
	ID_Usuario smallint primary key,
	Nombre varchar(50),
	Descripcion varchar(30),
	Telefono int,
	Tipo varchar(30)
);

create table Tipo_Vehiculo(
	ID_Tipo_V smallint primary key,
	Nombre varchar(50)
);

create table Vehiculo(
	ID_Vehiculo smallint primary key,
	Año int,
	Descripcion text,
	ID_Tipo_V smallint,
	foreign key (ID_Tipo_V) references Tipo_Vehiculo(ID_Tipo_V)
	on delete no action on update cascade
);

create table Registra(
	ID_Usuario smallint,
	ID_Vehiculo smallint,
	foreign key (ID_Usuario) references Usuario(ID_Usuario)
	on delete no action on update cascade,
	foreign key (ID_Vehiculo) references Vehiculo(ID_Vehiculo)
	on delete no action on update cascade,
	primary key (ID_Usuario,ID_Vehiculo)
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

create table Estacionamiento(
	ID_Estacionamiento smallint primary key,
	ID_Lugar smallint,
	ID_Campus smallint,
	Tipo varchar(20),
	foreign key (ID_Lugar) references Lugar_Estacionamiento(ID_Lugar)
	on delete no action on update cascade,
	foreign key (ID_Campus) references Campus_Sede(ID_Campus)
	on delete no action on update cascade
);

create table Reserva(
	ID_Usuario smallint,
	ID_Estacionamiento smallint,
	foreign key (ID_Usuario) references Usuario(ID_Usuario)
	on delete no action on update cascade,
	foreign key (ID_Estacionamiento) references Estacionamiento(ID_Estacionamiento)
	on delete no action on update cascade,
	primary key (ID_Usuario,ID_Estacionamiento)
);

create table Ocupa(
	Fecha_Entrada date,
	Fecha_Salida date,
	Estado Boolean,
	ID_Estacionamiento smallint,
	ID_Vehiculo smallint,
	foreign key (ID_Estacionamiento) references Estacionamiento(ID_Estacionamiento)
	on delete no action on update cascade,
	foreign key (ID_Vehiculo) references Vehiculo(ID_Vehiculo)
	on delete no action on update cascade,
	primary key (ID_Estacionamiento,ID_Vehiculo,Fecha_Entrada)
);