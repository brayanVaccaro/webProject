import { createConnection } from "~~/src/server/utils/db";

export default defineEventHandler(async function (event) {

   // const { tagliaStanza } = await readBody(event)

   const connection = await createConnection()
   const [results] = await connection.execute(
      `SELECT * FROM stanza`,
   )
   return results
})