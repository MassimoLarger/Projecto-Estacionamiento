import "dotenv/config";
import pkg from "pg";
const { Pool } = pkg;

export const pool = new Pool({
  allowExitOnIdle: true,
});

try {
  await pool.query("SELECT NOW()");
  console.log("Database connected");
} catch (error) {
  console.log(error);
}

const connectToDatabase = async () => {
  const pool = new Pool({
    allowExitOnIdle: true,
  });

  try {
    const result = await pool.query("SELECT nombre FROM usuario");
    console.log("Usuarios:", result.rows);
  } catch (error) {
    console.error("Error connecting to database:", error);
  }
};

const extract_data = async () => {
  const pool = new Pool({
    allowExitOnIdle: true,
  });

  try {
    const result = await pool.query("SELECT (id_usuario,nombre) FROM usuario WHERE nombre = 'Massimo Larger';");
    console.log("Usuarios:", result.rows);
  } catch (error) {
    console.error("Error connecting to database:", error);
  }
};

//connectToDatabase();
extract_data();