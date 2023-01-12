import { createConnection } from "~~/src/server/utils/db";

export default defineEventHandler (async function() {
 const connection = await createConnection()
 const [results] = await connection.execute(
    `SELECT * FROM stanza`
 )
 return results
})