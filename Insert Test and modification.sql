ALTER TABLE usuario ADD CONSTRAINT telefono_unico UNIQUE (Telefono);

insert into usuario values
	('massimoalberto.larger@alumnos.ulagos.cl','Massimo Larger',942415843,'Administrador','Digimon12'),
	('claudioandres.uribe@alumnos.ulagos.cl','Claudio Uribe',958455250,'Profesor','1234'),
	('constanzamarisol.jaramillo@alumnos.ulagos.cl','Constanza Jaramillo',949569835,'Guardia','1234'),
	('carolinaivone.hernandez@alumnos.ulagos.cl','Carolina Hernández',973088755,'Estudiante','1234');

insert into Tipo_Vehiculo values
	(1,'Automovil'),(2,'Camion'),(3,'Moto'),(4,'Camioneta'),(5,'Furgon');