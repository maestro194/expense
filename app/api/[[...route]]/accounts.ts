import { Hono } from 'hono'
import { clerkMiddleware, getAuth } from '@hono/clerk-auth';
import { eq } from 'drizzle-orm';
import { HTTPException } from 'hono/http-exception'
import { zValidator } from '@hono/zod-validator'
import { createId } from '@paralleldrive/cuid2'

import { db } from '@/db/drizzle'
import { accounts, insertAccountSchema } from '@/db/schema'

const app = new Hono()
    .get(
        '/',
        clerkMiddleware(),
        async (c) => {
            const auth = getAuth(c);
            if (!auth?.userId) {
                throw new HTTPException(401,{
                    res: c.json({ error: 'Unauthorized'}, 401),
                });
            }
                
            const data = await db
            .select({
                id: accounts.id,
                name: accounts.name,
            })
            .from(accounts)
            .where(eq(accounts.userId, auth.userId))

            return c.json({ data })
        }
    )
    .post(
        "/",
        clerkMiddleware(),
        zValidator("json", insertAccountSchema.pick({
            name: true,
        })),
        async (c) => {
            const auth = getAuth(c);
            const values = c.req.valid("json");
            
            if (!auth?.userId) {
                return c.json({ error: 'Unauthorized'}, 401);
            }

            const [data] = await db.insert(accounts).values({
                id: createId(),
                userId: auth.userId,
                ...values,
            }).returning();

            return c.json({ data });
        }
    )
    // .post array[0] example
    // .post(
    //     "/",
    //     clerkMiddleware(),
    //     zValidator("json", insertAccountSchema.pick({
    //         name: true,
    //     })),
    //     async (c) => {
    //         const auth = getAuth(c);
    //         const values = c.req.valid("json");

    //         if (!auth?.userId) {
    //             throw new HTTPException(401,{
    //                 res: c.json({ error: 'Unauthorized'}, 401),
    //             });
    //         }

    //         const [data] = await db.insert(accounts).values({ // using [] here to take the first element of data
    //             id: createId(),
    //             userId: auth.userId,
    //             ...values,
    //         }).returning();

    //         return c.json({ data: data[i] }); // or using [i] here to take the i element of the array
    //     }
    // )
    ;

export default app;