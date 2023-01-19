import { createConnection } from "~~/src/server/utils/db";

export default defineEventHandler(async function (event) {

   const [idStanza] = await readBody(event)
   console.log('getImgName id vale ' + idStanza)
   // const id = idUtente
   const connection = await createConnection()
   const [results] = await connection.execute(
      `SELECT imgStanza FROM stanza WHERE stanza.idStanza=?`,
      [idStanza]
   )

   console.log('getImgName results vale ' + results)

   return results
})