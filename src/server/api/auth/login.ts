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
    `SELECT idautore, username, nome, password, GROUP_CONCAT(DISTINCT nomecategoria) as argomenti
     FROM autore
     LEFT OUTER JOIN articolo ON autore=idautore
     LEFT OUTER JOIN articolo_ha_categoria ON idarticolo=articolo
     LEFT OUTER JOIN categoria ON categoria=idcategoria
     WHERE username=? AND attivo=1
     GROUP BY idautore, username, nome, password;`,
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
