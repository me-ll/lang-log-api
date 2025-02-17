import { getLearningLogs } from '../controllers/learningLogsController.js';

export const learningLogsRoutes = (app) => {
    app.get('/learning-logs', getLearningLogs);
};
