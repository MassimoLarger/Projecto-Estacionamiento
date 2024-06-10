import express from 'express';
import pkg from 'pg';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

dotenv.config();

const { Pool } = pkg;
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

const app = express();
const PORT = process.env.PORT || 3500;
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(express.json());

// Ruta para realizar una consulta
app.get('/api/consulta', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuario');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

// Nueva ruta para verificar credenciales
app.post('/api/login', async (req, res) => {
  const { telefono, contrasena } = req.body;

  try {
    const result = await pool.query(
      'SELECT * FROM usuario WHERE telefono = $1 AND contrasena = $2',
      [telefono, contrasena]
    );

    if (result.rows.length > 0) {
      const {nombre} = result.rows[0];
      res.json({ success: true, userId: nombre, message: 'Usuario encontrado'});
    } else {
      res.json({ success: false, message: 'Usuario no encontrado, o algun campo incorrecto' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.post('/api/register', async (req, res) => {
  const { nombre, telefono, tipo, contrasena } = req.body;
  
  try {
    const result = await pool.query(
      'INSERT INTO usuario (Nombre, Telefono, Tipo, Contrasena) VALUES ($1, $2, $3, $4) RETURNING id_usuario',
      [nombre, telefono, tipo, contrasena]
    );
    
    res.status(200).json({ success: true, id: result.rows[0].id });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Error al registrar usuario.' });
  }
});

app.post('/api/vehiculos', async (req, res) => {
  const { patente, year, model, vehicleId, userId } = req.body;

  try {
    // Insertar el nuevo vehículo
    const result = await pool.query(
      'INSERT INTO Vehiculo VALUES ($1, $2, $3, $4) RETURNING *',
      [patente, year, model, vehicleId]
    );

    // Registrar la relación del vehículo con el usuario
    const resultado = await pool.query(
      'INSERT INTO Registra VALUES ($1, $2) RETURNING *',
      [userId, patente]
    );

    res.status(200).send({ success: true, vehicle: result.rows[0].id, register: resultado.rows[0].id });
  } catch (error) {
    console.error('Error al registrar el vehículo:', error);
    res.status(500).send('Error al registrar el vehículo');
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
