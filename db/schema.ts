import { createInsertSchema } from 'drizzle-zod'

import { text, pgTable, integer } from 'drizzle-orm/pg-core';

export const accounts = pgTable('accounts', {
    id: text('id').primaryKey(),
    name: text('name').notNull(),
    userId: text('user_id').notNull(),
});

export const insertAccountSchema = createInsertSchema(accounts);