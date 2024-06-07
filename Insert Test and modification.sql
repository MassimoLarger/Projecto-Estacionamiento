ALTER TABLE Reserva
ADD fecha_reserva date;

ALTER TABLE usuario ADD CONSTRAINT Telefono UNIQUE (Telefono);

insert into usuario (Nombre,Telefono,Tipo,Contrasena) values
	('Massimo Larger',942415843,'Administrador','Digimon12'),
	('Claudio Uribe',958455250,'Profesor','1234'),
	('Constanza Jaramillo',949569835,'Guardia','1234'),
	('Carolina Hernández',973088755,'Estudiante','1234');