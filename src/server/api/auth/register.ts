import bcrypt from "bcrypt"
import { codificaUtente, decodificaUtente, requireLogout } from "~/server/utils/auth"
import { createConnection } from "~/server/utils/db"

export default defineEventHandler(async function(event) {
  // Blocca la richiesta se l'utente ha già effettuato il login
  const utente = decodificaUtente(event)
  requireLogout(utente)

  // Estrae username e password dal body della richiesta
  const { username, password, nome } = await readBody(event)
  console.log('dati utente' + username, password, nome)

  // Verifica che l'username sia disponibile
  const connection = await createConnection()
  const [users] = await connection.execute(
    "SELECT username FROM utenti WHERE username=?",
    [username]
  )
  if ((users as any[]).length > 0) {
    throw createError({ statusCode: 400, statusMessage: "Username già in uso"})
  }

  // Crea l'hash della password per non salvarla in chiaro
  const passwordHash = await bcrypt.hash(password, 10)
  console.log('psw hash'+passwordHash)

  // Inserisce l'utente nel database
  await connection.execute(
    `INSERT INTO utenti (username, password, nome)
     VALUES (?, ?, ?)`,
    [username, passwordHash, nome]
  )

  // Estrae i dati per il nuovo utente
  const [results] = await connection.execute(
    `SELECT idautore, username, nome, "" AS argomenti FROM utenti WHERE username=?`,
    [username]
  )
  const user = (results as any)[0] as any

  // Crea un JWT contenente i dati dell'utente e lo imposta come cookie
  codificaUtente(event, user)

  return { message: "Registrazione effettuata con successo" }
})
