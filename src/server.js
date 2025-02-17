import { serve } from "@hono/node-server";
import app from "./index.js";
import { env } from "./config/env.js";

const port = env.APP_PORT;

serve({
  fetch: app.fetch,
  port,
});

console.log(`🚀 Server running on http://localhost:${port}`);