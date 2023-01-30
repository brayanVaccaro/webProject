import { createConnection } from "../../utils/db";

export default defineEventHandler(async function(event) {
  const {rispostaRecensione, idRecensione} = await readBody(event)
  console.log(rispostaRecensione)
  const connection = await createConnection()
  
  await connection.execute(
    `UPDATE recensione SET rispostaRecensione = ? WHERE recensione.idRecensione = ?`,
    [rispostaRecensione, idRecensione]
  )

  return { message: "risposta aggiunta con successo" }
});