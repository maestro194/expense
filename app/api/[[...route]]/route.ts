import { Hono } from 'hono'
import { handle } from 'hono/vercel'
import { z } from 'zod'
import { zValidator } from '@hono/zod-validator'
import { clerkMiddleware, getAuth } from '@hono/clerk-auth'

export const runtime = 'edge'

const app = new Hono().basePath('/api');

app
    .get('/hello', clerkMiddleware(), (c) => {
        const user = getAuth(c)
        if (!user?.userId) {
            return c.json({ message: 'Unauthorized'})
        }
        return c.json({ 
            message: 'Hello World! Hono test!',
            id: user.userId,
        })
    })
    .post("/create/:postId", 
        zValidator("json", z.object({
            name: z.string(),
            userId: z.number(),
        })),
        zValidator("param", z.object({
            postId: z.number()
        })),
        (c) => {
            const { name, userId } = c.req.valid('json')
            const { postId } = c.req.valid('param')

            return c.json({});
        }
    )
    

export const GET = handle(app);
export const POST = handle(app);