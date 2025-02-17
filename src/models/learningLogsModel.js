import { query } from '../config/db.js';

export const getAllLearningLogs = async (userId) => {
  const result =
    await query(`
      SELECT
        learning_logs.activity
        , learning_logs.start_time
        , learning_logs.end_time
        , learning_logs.learning_time
        , learning_logs.language_id
        , languages.name AS language_name
        , learning_logs.learning_category_id
        , learning_categories.name AS learning_category_name
        , learning_logs.material_id
        , learning_materials.name AS material_name
        , material_types.name AS type_name
      FROM learning_logs 
      LEFT OUTER JOIN languages ON languages.id = learning_logs.language_id
      LEFT OUTER JOIN learning_categories ON learning_categories.id = learning_logs.learning_category_id
      LEFT OUTER JOIN learning_materials ON learning_materials.id = learning_logs.material_id
      LEFT OUTER JOIN material_types ON material_types.id = learning_materials.material_type_id
      WHERE learning_logs.user_id = $1
      ORDER BY learning_logs.created_at DESC
    `, [userId]);
  return result.rows;
};
