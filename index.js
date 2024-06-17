import express from 'express';
import pkg from 'pg';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import Ppu from './ppu.js';

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

// Existing routes
app.get('/api/consultau', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuario');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.get('/api/consultav', async (req, res) => {
  try {
    const result = await pool.query(`
        SELECT v.patente, v.año, v.descripcion as modelo, tv.nombre as tipo
        FROM vehiculo v
        JOIN Tipo_Vehiculo tv ON v.ID_Tipo_V = tv.ID_Tipo_V;
    `);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.get('/api/consultar', async (req, res) => {
  try {
    const result = await pool.query(`
        SELECT u.nombre as usuario, r.id_vehiculo as patente, v.descripcion as modelo
        FROM registra r
        JOIN usuario u ON u.rut = r.rut
        JOIN vehiculo v ON r.id_vehiculo = v.patente;
    `);
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
    const {telefono} = result.rows[0];
    res.json({ success: true, userId: telefono, message: 'Usuario encontrado'});
  } else {
    res.json({ success: false, message: 'Usuario no encontrado, o algun campo incorrecto' });
  }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
    }
  });

app.post('/api/register', async (req, res) => {
  const { telefono, nombre, tipo, contrasena } = req.body;
    
  try {
  const result = await pool.query(
    'INSERT INTO usuario VALUES ($1, $2, $3, $4) RETURNING *',
     [telefono, nombre, tipo, contrasena]
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

// New route for PPU verification
app.post('/api/verify-ppu', (req, res) => {
  const { ppu } = req.body;

  try {
    const ppuInstance = new Ppu(ppu);
    res.status(200).json({ success: true, ppu: ppuInstance });
  } catch (error) {
    console.error('Error al verificar la patente:', error);
    res.status(500).send('Error al verificar la patente');
  }
});

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

// Start the server
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});