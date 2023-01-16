import { createConnection } from "~~/src/server/utils/db";

export default defineEventHandler(async function () {


   const connection = await createConnection()
   const [results] = await connection.execute(
      `SELECT nome, cognome, imgProfilo FROM utenti INNER JOIN recensione ON recensione.idUtente=utenti.idUtente`
   )

   
   return results
})