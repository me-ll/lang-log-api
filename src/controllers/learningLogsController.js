import * as schema from '../schemas/learningLogsSchema.js';
import * as service from '../services/learningLogsService.js';

export const getLearningLogs = async (c) => {
    const query = c.req.query();
    const validatedQuery = schema.getLearningLogs.parse(query);
    const userId = validatedQuery.userId;

    const logs = await service.getAllLearningLogs(userId);
        return c.json(logs);
};
