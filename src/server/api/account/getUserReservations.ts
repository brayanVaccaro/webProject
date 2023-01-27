import { createConnection } from "~~/src/server/utils/db";

export default defineEventHandler(async function (event) {

const {email} = await readBody(event)
console.log('email vale '+ email)
// const id = idUtente
const connection = await createConnection()
const [results] = await connection.execute(
   `SELECT * FROM prenotazione INNER JOIN utenti ON utenti.idUtente=prenotazione.idUtente WHERE(email=?)`,
   [email]
   )
   
   console.log('prenotazioni by email '+ results)
   
   return results
})