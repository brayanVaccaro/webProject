import { createConnection } from "../../utils/db";
import { decodificaUtente } from "../../utils/auth";

export default defineEventHandler(async function(event) {
  const user = decodificaUtente(event)
  const { dataFine, dataInizio, idStanza, idUtente } = await readBody(event)
  console.log('dati prenotazione ' + dataFine +' ' + dataInizio +' '+ idStanza + ' ' + idUtente )

  // Verifica che l'email sia disponibile
  const connection = await createConnection()
  
  // Inserisce l'utente nel database
  await connection.execute(
    `INSERT INTO prenotazione ( dataInizioPrenotazione, dataFinePrenotazione, idUtente, idStanza) VALUES (?, ?, ?, ?)`,
    [dataInizio, dataFine, user?.idUtente, idStanza]
  )

  return { message: "Prenotazione effettuata con successo" }
});