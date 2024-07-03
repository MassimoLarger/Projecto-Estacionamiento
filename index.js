import express from 'express';
import bodyParser from 'body-parser';
import { sendVerificationEmail } from './emailService.js';
import pkg from 'pg';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import { Ppu } from './ppu.js';
import _ from 'lodash';
import _variables from './variables.json' assert { type: 'json' };
import _letterDvDb from './letterDvDB.json' assert { type: 'json' };

const { Pool } = pkg;
dotenv.config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false, // Esta opción es para desarrollo. En producción, usa certificados adecuados.
  },
});

const app = express();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(bodyParser.json());
app.use(express.json());

// Servir archivos estáticos
app.use('/static/css', express.static(path.join(__dirname, 'vistas/app_web_guardia/css')));
app.use('/static/js', express.static(path.join(__dirname, 'vistas/app_web_guardia/js')));
app.use(express.static(path.join(__dirname, 'vistas/app_web_guardia/assets')));


// Ruta principal para servir el archivo HTML
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'vistas/app_web_guardia/html/bienvenida.html'));
});


// esto va en una carpeta aparte 
// Rutas existentes
app.post('/api/consultau', async (req, res) => {
  const { correo } = req.body;
  try {
    const result = await pool.query('SELECT * FROM Usuario WHERE Correo = $1', [correo]);
    if (result.rows.length > 0) {
      const { nombre, telefono, tipo, contrasena } = result.rows[0];
      res.json({ success: true, message: 'Usuario encontrado', usuario: { nombre, telefono, tipo, contrasena } });
    } else {
      res.json({ success: false, message: 'No se encuentra el usuario' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.post('/api/consultar', async (req, res) => {
  const { correo } = req.body;
  try {
    const result = await pool.query('SELECT id_vehiculo FROM registra WHERE ID_Usuario = $1', [correo]);
    if (result.rows.length > 0) {
      // Extraer todos los id_vehiculo en una lista
      const patentes = result.rows.map(row => row.id_vehiculo);
      res.json({ success: true, patentes: patentes, message: 'Vehículos encontrados' });
    } else {
      res.json({ success: false, message: 'No hay vehículos registrados para este usuario' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.post('/api/vehiculoR', async (req, res) => {
  const { patente } = req.body;
  try {
    const result = await pool.query('SELECT * FROM Vehiculo WHERE Patente = $1', [patente]);
    if (result.rows.length > 0) {
      const { patente, descripcion } = result.rows[0];
      res.json({ success: true, patentes:{ patente, descripcion } , message: 'Vehículos encontrados' });
    } else {
      res.json({ success: false, message: 'No hay vehículos registrados para este usuario' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.post('/api/updateProfile', async (req, res) => {
  const { correo, nombre } = req.body;

  try {
    const result = await pool.query('UPDATE usuario SET nombre = $1 WHERE correo = $2 RETURNING *', [nombre, correo]);
    // Verificar si se encontró y actualizó el usuario
    if (result.rows.length > 0) {
      res.json({ success: true, message: 'Perfil actualizado correctamente' });
    } else {
      res.json({ success: false, message: 'Usuario no encontrado' });
    }
  } catch (error) {
    console.error('Error al actualizar perfil:', error);
    res.status(500).send('Error al actualizar perfil');
  }
});


app.post('/api/login', async (req, res) => {
  const { correo, contrasena } = req.body;
  try {
    const result = await pool.query('SELECT * FROM usuario WHERE correo = $1 AND contrasena = $2', [correo, contrasena]);
    if (result.rows.length > 0) {
      const { correo } = result.rows[0];
      const { tipo } = result.rows[0];
      res.json({ success: true, userId: correo, typeId: tipo, message: 'Usuario encontrado' });
    } else {
      res.json({ success: false, message: 'Usuario no encontrado, o algun campo incorrecto' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.post('/api/register', async (req, res) => {
  const { correo, nombre, telefono, tipo, contrasena } = req.body;
  try {
    const result = await pool.query('INSERT INTO usuario VALUES ($1, $2, $3, $4, $5) RETURNING *', [correo, nombre, telefono, tipo, contrasena]);
    res.status(200).json({ success: true, id: result.rows[0].id });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Error al registrar usuario.' });
  }
});

app.post('/api/vehiculos', async (req, res) => {
  const { patente, year, model, vehicleId, userId } = req.body;
  try {
    const result = await pool.query('INSERT INTO Vehiculo VALUES ($1, $2, $3, $4) RETURNING *', [patente, year, model, vehicleId]);
    const resultado = await pool.query('INSERT INTO Registra VALUES ($1, $2) RETURNING *', [userId, patente]);
    res.status(200).send({ success: true, vehicle: result.rows[0].id, register: resultado.rows[0].id });
  } catch (error) {
    console.error('Error al registrar el vehículo:', error);
    res.status(500).send('Error al registrar el vehículo');
  }
});

app.post('/api/verify-ppu', (req, res) => {
  const { patente, verificador } = req.body;
  try {
    const ppuInstance = new Ppu(patente);
    if (ppuInstance.dv === verificador) {
      res.status(200).json({ success: true, ppu: ppuInstance });
    } else {
      console.error('Error en el digito verificador');
      res.status(500).send('Error en el digito verificador');
    }
  } catch (error) {
    console.error('Error al verificar la patente:', error);
    res.status(500).send('Error al verificar la patente');
  }
});

app.post('/api/send-verification-code', async (req, res) => {
  const { email } = req.body;
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  try {
    const result = await pool.query('SELECT * FROM usuario WHERE Correo = $1', [email]);
    if (result.rows[0] != null) {
      const { correo } = result.rows[0];
      await sendVerificationEmail(correo, code);
      res.json({ success: true, userId: correo, codigo_verificacion: code, message: 'Correo Enviado' });
    } else {
      res.json({ success: false, message: 'Usuario no encontrado' });
    } 
  } catch (error) {
    console.error('Error al enviar el correo:', error);
    res.status(500).send('Error al enviar el correo');
  }
});

app.post('/api/verify-code', async (req, res) => {
  const {code, codigo_verificacion } = req.body;
  try {
    if (codigo_verificacion === code) {
      res.json({ success: true, message: 'Codigo Verificado Correctamente'  });
    } else {
      res.json({ success: false, message: 'Código incorrecto' });
    }
  } catch (error) {
    console.error('Error al verificar el código:', error);
    res.status(500).send('Error al verificar el código');
  }
});

app.post('/api/actualizar_contrasena', async (req, res) => {
  const { email, newPassword, newPassword_verify} = req.body;

  try {
    // Ejecutar la consulta para actualizar la contraseña
    if (newPassword === newPassword_verify){
      const result = await pool.query('UPDATE usuario SET Contrasena = $1 WHERE correo = $2 RETURNING *', [newPassword, email]);
      // Verificar si se encontró y actualizó el usuario
      if (result.rows.length > 0) {
        res.json({ success: true, message: 'Contraseña actualizada exitosamente' });
      } else {
        res.json({ success: false, message: 'Usuario no encontrado' });
      }
    } else {
      res.json({ success: false, message: 'Contraseña incorrecta' });
    }
  } catch (error) {
    console.error('Error al actualizar contraseña:', error);
    res.status(500).send('Error al actualizar contraseña');
  }
});

app.post('/api/ocupados', async (req, res) => {
  const { estNum, timeFrom, timeTo } = req.body;
  try {
    const result = await pool.query(`
    SELECT * FROM Ocupa 
    WHERE id_estacionamiento = $1 
    AND ($2::time < Fecha_Salida AND $3::time > Fecha_Entrada)
    AND Estado = True;
    `, [estNum, timeFrom, timeTo]);
    if (result.rows.length > 0) {
      const { estado } = result.rows[0];
      res.json({ success: true, status: estado, message: 'Estado del estacionamiento actualizado' });
    } else {
      res.json({ success: false, message: 'Error al actualizar el estado del estacionamiento' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Código del estacionamiento no válido' });
  }
});


app.post('/api/estacionamientos', async (req, res) => {
  const { sectionName, sedeName } = req.body;
  try {
    const result = await pool.query(
      `SELECT ID_Estacionamiento
       FROM Estacionamiento
       WHERE ID_Lugar = (
         SELECT ID_Lugar
         FROM Lugar_Estacionamiento
         WHERE Descripcion = $1
       ) AND ID_Campus = (
         SELECT ID_Campus
         FROM Campus_Sede
         WHERE Nombre = $2
       )`,
      [sectionName, sedeName]
    );
    if (result.rows.length > 0) {
      const estacionamientos = result.rows.map(row => row.id_estacionamiento);
      res.json({ success: true, estacionamientos: estacionamientos });
    } else {
      res.json({ success: false, message: 'No se encontraron estacionamientos' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta a la base de datos' });
  }
});

app.post('/api/reserva', async (req, res) => {
  const { userId, estacionamiento, selectedDate, timeFrom, timeTo, vehicleid } = req.body;
  try {
    const result = await pool.query('INSERT INTO Reserva VALUES ($1, $2, $3) RETURNING *', [selectedDate, userId, estacionamiento ]);
    const resultado = await pool.query('INSERT INTO Ocupa VALUES ($1, $2, True, $3, $4) RETURNING *', [timeFrom, timeTo, estacionamiento, vehicleid]);
    res.status(200).send({ success: true, reserva: result.rows[0].id, ocupado: resultado.rows[0].id });
  } catch (error) {
    console.error('Error al reservar el espacio:', error);
    res.status(500).send('Error al reservar el espacio');
  }
});

app.post('/api/cancelar-reserva', async (req, res) => {
  const { vehicleid } = req.body;
  try {
    const result = await pool.query('DELETE FROM Ocupa WHERE ID_Vehiculo = $1', [vehicleid]);
    if (result.rowCount > 0) {
      res.status(200).json({ success: true });
    } else {
      res.status(500).json({ success: false, error: 'No se pudo cancelar la reserva o liberar el vehículo.' });
    }
  } catch (error) {
    console.error('Error al cancelar la reserva:', error);
    res.status(500).send('Error al cancelar la reserva');
  }
});


// Start the server
const PORT = process.env.PORT || 3500;
app.listen(PORT, () => {
  console.log(`Servidor activo en el puerto ${PORT}`);
});
