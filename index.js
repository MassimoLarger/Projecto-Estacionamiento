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

// New route for PPU verification
app.post('/api/verify-ppu', (req, res) => {
  const { ppu } = req.body;

  try {
    const ppuInstance = new Ppu(ppu);
    res.status(200).json({ success: true, ppu: ppuInstance });
  } catch (error) {
    console.error(error);
    res.status(400).json({ success: false, message: error.message });
  }
});

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

// Start the server
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});