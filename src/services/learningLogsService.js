import * as model from '../models/learningLogsModel.js';

export const getAllLearningLogs = async (userId) => {
  try {
    const logs = await model.getAllLearningLogs(userId);
    return logs;
  } catch (err) {
    throw new Error('Error fetching learning logs');
  }
};
