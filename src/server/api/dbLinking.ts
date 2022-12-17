import { createConnection } from "~/server/utilis/db";

export default defineEventHandler (async function() {
 const connection = await createConnection()
 const [results] = await connection.execute(
    `SELECT * FROM persone `
 )
 return results
})