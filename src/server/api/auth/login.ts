import bcrypt from "bcrypt"
import { codificaUtente, decodificaUtente, requireLogout } from "~/server/utils/auth"
import { createConnection } from "~/server/utils/db"

export default defineEventHandler(async function(event) {
  // Blocca la richiesta se l'utente ha già effettuato il login
  const utente = decodificaUtente(event)
  requireLogout(utente)

  // Estrae username e password dal body della richiesta
  const { username, password } = await readBody(event)

  // Esegue la query al database per ottenere i dati dell'utente in base allo username
  const connection = await createConnection()
  const [results] = await connection.execute(
    `SELECT idUtenti, username, nome, password, GROUP_CONCAT(DISTINCT idPrenotazione) as prenotazione
     FROM utenti
     LEFT OUTER JOIN articolo ON utenti=idUtenti
     LEFT OUTER JOIN prenotazione ON prenotazione=idPrenotazione
     WHERE username=?
     GROUP BY idUtenti, username, nome, password;`,
    [username]
  )

  // Errore se l'utente non è stato trovato
  if (!Array.isArray(results) || results.length == 0) {
    throw createError({ statusCode: 400, statusMessage: "Credenziali errate"})
  }

  const user = results[0] as any

  // Confronta l'hash della password fornita con quello nel database
  const passwordCorretta = await bcrypt.compare(password, user.password)

  // Errore se la password è errata
  if (!passwordCorretta) {
    throw createError({ statusCode: 400, statusMessage: "Credenziali errate"})
  }

  // Rimuove la password dall'oggetto utente
  delete user.password

  // Crea un JWT contenente i dati dell'utente e lo imposta come cookie
  codificaUtente(event, user)

  return { message: "Login effettuato con successo" }
})
