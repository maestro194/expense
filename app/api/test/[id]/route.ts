import { NextRequest, NextResponse } from "next/server"

export const GET = (
  req: NextRequest,
  { params } : { params: { id: string } }
) => {
  return NextResponse.json({ 
    message: "Hello World",
    id: params.id,
  }) 
}