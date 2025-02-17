import { Hono } from 'hono';
import { learningLogsRoutes } from './routes/learningLogsRoute.js';
import { ZodError } from 'zod';

const app = new Hono();

app.onError((err, c) => {
  console.error(err);

  if (err instanceof ZodError) {
    return c.json({ error: 'Invalid request parameters', message: err.errors }, 400);
  }

  return c.json({ error: 'Something went wrong', message: err.message }, 500);
});

learningLogsRoutes(app);

export default app;