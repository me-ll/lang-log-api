import { z } from 'zod';

export const getLearningLogs = z.object({
    userId: z
        .string()
        .refine((val) => !isNaN(val), { message: 'userId must be a number' })
        .transform((val) => Number(val)), 
});