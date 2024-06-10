ALTER TABLE Reserva
ADD fecha_reserva date;

ALTER TABLE usuario ADD CONSTRAINT Telefono UNIQUE (Telefono);
ALTER TABLE usuario ADD CONSTRAINT Nombre UNIQUE (Nombre);

insert into usuario (Nombre,Telefono,Tipo,Contrasena) values
	('Massimo Larger',942415843,'Administrador','Digimon12'),
	('Claudio Uribe',958455250,'Profesor','1234'),
	('Constanza Jaramillo',949569835,'Guardia','1234'),
	('Carolina Hernández',973088755,'Estudiante','1234');

insert into Tipo_Vehiculo values
	(1,'Automovil'),(2,'Camion'),(3,'Moto'),(4,'Camioneta'),(5,'Furgon');

INSERT INTO Vehiculo VALUES ('CH DR 12', 2012, 'Toyota', 1);

delete from Vehiculo where ID_Vehiculo = 'CH DR 12';