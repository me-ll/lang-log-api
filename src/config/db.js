import pkg from 'pg';
import { config } from './dbConfig.js';

const { Pool } = pkg;

const pool = new Pool({
  user: config.PG_USER,
  host: config.PG_HOST,
  database: config.PG_DATABASE,
  password: config.PG_PASSWORD,
  port: config.PG_PORT,
});

export const query = (text, params) => pool.query(text, params);
