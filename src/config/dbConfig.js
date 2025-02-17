import 'dotenv/config';
import { env } from './env.js';

export const config = {
    PG_USER: env.PG_USER,
    PG_PASSWORD: env.PG_PASSWORD,
    PG_HOST:env.PG_HOST,
    PG_DATABASE: env.PG_DATABASE,
    PG_PORT: env.PG_PORT,
};