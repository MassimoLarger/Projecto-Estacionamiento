import { pool } from "../database/connection.js";

const findAll = async () => {
  const { rows } = await pool.query("select * from usuario");
  return rows;
};

export const todoModel = {
  findAll
};