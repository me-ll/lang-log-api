import 'dotenv/config';

export const env = {
  PG_USER: process.env.PG_USER || 'postgres',
  PG_HOST: process.env.PG_HOST || 'localhost',
  PG_DATABASE: process.env.PG_DATABASE || 'lang_log',
  PG_PASSWORD: process.env.PG_PASSWORD || 'password',
  PG_PORT: process.env.PG_PORT ? Number(process.env.PG_PORT) : 5432,
  APP_PORT: process.env.APP_PORT ? Number(process.env.APP_PORT) : 3000,
};