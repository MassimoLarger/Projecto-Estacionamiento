import "dotenv/config";
import pkg from "pg";
const { Pool } = pkg;

export const pool = new Pool({
  allowExitOnIdle: true,
});

try {
  await pool.query("SELECT NOW()");
  console.log("Database connected");
  await pool.query("select * from usuario");
} catch (error) {
  console.log(error);
}

const connectToDatabase = async () => {
  const pool = new Pool({
    allowExitOnIdle: true,
  });

  try {
    const result = await pool.query("SELECT * FROM usuario");
    console.log("Usuarios:", result.rows);
  } catch (error) {
    console.error("Error connecting to database:", error);
  }
};

connectToDatabase();
