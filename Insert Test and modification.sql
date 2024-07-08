ALTER TABLE usuario ADD CONSTRAINT telefono_unico UNIQUE (Telefono);

insert into usuario values
	('massimoalberto.larger@alumnos.ulagos.cl','Massimo Larger',942415843,'Administrador','Digimon12'),
	('claudioandres.uribe@alumnos.ulagos.cl','Claudio Uribe',958455250,'Profesor','1234'),
	('constanzamarisol.jaramillo@alumnos.ulagos.cl','Constanza Jaramillo',949569835,'Guardia','1234'),
	('carolinaivone.hernandez@alumnos.ulagos.cl','Carolina Hernández',973088755,'Estudiante','1234');

insert into Tipo_Vehiculo values
	(1,'Automovil'),(2,'Camion'),(3,'Moto'),(4,'Camioneta'),(5,'Furgon');
	
insert into Campus_Sede values
	(1,'Chuyaca','Osorno',280),(2,'Meyer','Osorno',30);
	
insert into Lugar_Estacionamiento values
	(1,'Entrada C'),(2,'Gym'),(3,'Aulas Virtuales'), (4,'Casino'),(5,'Entrada M');

insert into Estacionamiento values
	('A01',1,1),('A02',1,1),('A03',1,1),('A04',1,1),('A05',1,1),
	('A06',1,1),('A07',1,1),('A08',1,1),('A09',1,1),('A10',1,1),
	('A11',1,1),('A12',1,1),('A13',1,1),('A14',1,1),('A15',1,1),
	('A16',1,1),('A17',1,1),('A18',1,1),('A19',1,1),('A20',1,1),
	('B01',2,1),('B02',2,1),('B03',2,1),('B04',2,1),('B05',2,1),
	('B06',2,1),('B07',2,1),('B08',2,1),('B09',2,1),('B10',2,1),
	('B11',2,1),('B12',2,1),('B13',2,1),('B14',2,1),('B15',2,1),
	('B16',2,1),('B17',2,1),('B18',2,1),('B19',2,1),('B20',2,1),
	('C01',3,1),('C02',3,1),('C03',3,1),('C04',3,1),('C05',3,1),
	('C06',3,1),('C07',3,1),('C08',3,1),('C09',3,1),('C10',3,1),
	('C11',3,1),('C12',3,1),('C13',3,1),('C14',3,1),('C15',3,1),
	('C16',3,1),('C17',3,1),('C18',3,1),('C19',3,1),('C20',3,1),
	('D01',4,1),('D02',4,1),('D03',4,1),('D04',4,1),('D05',4,1),
	('D06',4,1),('D07',4,1),('D08',4,1),('D09',4,1),('D10',4,1),
	('D11',4,1),('D12',4,1),('D13',4,1),('D14',4,1),('D15',4,1),
	('D16',4,1),('D17',4,1),('D18',4,1),('D19',4,1),('D20',4,1),
	('E01',1,2),('E02',1,2),('E03',1,2),('E04',1,2),('E05',1,2),
	('E06',1,2),('E07',1,2),('E08',1,2),('E09',1,2),('E10',1,2),
	('E11',1,2),('E12',1,2),('E13',1,2),('E14',1,2),('E15',1,2),
	('E16',1,2),('E17',1,2),('E18',1,2),('E19',1,2),('E20',1,2);

insert into Vehiculo (Patente, Año, Descripcion, ID_Tipo_V) values
	('XYZ123', 2020, 'Ford EcoSport', 1),
	('ABC456', 2019, 'Toyota Hilux', 4),
	('DEF789', 2018, 'Honda Civic', 1);

insert into Registra (ID_Usuario, ID_Vehiculo) values
	('massimoalberto.larger@alumnos.ulagos.cl', 'XYZ123'),
	('claudioandres.uribe@alumnos.ulagos.cl', 'ABC456'),
	('carolinaivone.hernandez@alumnos.ulagos.cl', 'DEF789');

insert into Reserva (fecha_reserva, ID_Usuario, ID_Estacionamiento) values
	('2024-07-10', 'claudioandres.uribe@alumnos.ulagos.cl', 'B01'),
	('2024-07-10', 'carolinaivone.hernandez@alumnos.ulagos.cl', 'C01');
	('2024-07-20', 'massimoalberto.larger@alumnos.ulagos.cl', 'A01');
	('2024-07-11', 'massimoalberto.larger@alumnos.ulagos.cl', 'E01');

insert into Ocupa (Fecha_Entrada, Fecha_Salida, Estado, ID_Estacionamiento, ID_Vehiculo) values
	('09:00:00', '17:00:00', true, 'B01', 'ABC456'),
	('10:00:00', '18:00:00', true, 'C01', 'DEF789');
	('07:00:00', '15:00:00', true, 'A01', 'XYZ123');
	('08:10:00', '16:00:00', true, 'E01', 'XYZ123');

UPDATE Campus_Sede
SET Capacidad = 300
WHERE Nombre = 'Chuyaca';

UPDATE Campus_Sede
SET Capacidad = 50
WHERE Nombre = 'Meyer';