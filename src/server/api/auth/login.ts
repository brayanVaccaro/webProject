import bcrypt from "bcrypt"
import { codificaUtente, decodificaUtente, requireLogout } from "~/server/utils/auth"
import { createConnection } from "~/server/utils/db"

export default defineEventHandler(async function(event) {
  // l'utente non può loggare due volte
  console.log('ciao 1 riga')
  const utente = decodificaUtente(event)
  console.log('ciao 2 riga')

  requireLogout(utente)
  console.log('ciao 3 riga')

  // estraiamo username e password dal body
  const { email, password } = await readBody(event)
  console.log('ciao 4 riga ' + email + ' ' +password)


  //i dati dell'utente sono presi dal database in base allo email
  const connection = await createConnection()
  const [results] = await connection.execute(
    `SELECT *
    FROM utenti
    WHERE email=?`,
    [email]
  )
  console.log('ciao 5 riga ')
  
  /*perche left outer join? perche altrimenti con i join impliciti se un utente non ha la categoria allora non lo troviamo*/
  
  if (!Array.isArray(results) || results.length == 0) {
    throw createError({ statusCode: 400, statusMessage: "Credenziali errate"})/*messaggio di errore sempre uguale perche non vogliamo far sapere a un mal intenzionato che ha azzeccatto solo lo username rispetto a solo la password */
  }
  console.log('ciao 6 riga ')
  
  const user = results[0] as any
  console.log('ciao 7 riga ')
  
  // Confronta l'hash della password fornita con quello nel database
  const passwordCorretta = await bcrypt.compare(password, user.password)
  console.log('ciao 8 riga ')
  
  if (!passwordCorretta) {
    throw createError({ statusCode: 400, statusMessage: "Credenziali errate"})
  }
  console.log('ciao 9 riga ')
  
  /*messaggio di errore sempre uguale perche non vogliamo far sapere a un mal intenzionato che ha azzeccatto solo lo username rispetto a solo la password */
  
  // Rimuove la password dall'oggetto utente in modo che rimanga nel server
  delete user.password
  console.log('ciao 10 riga ')
  
  // Crea un JWT contenente i dati dell'utente e lo imposta come cookie
  codificaUtente(event, user)
  console.log('ciao 11 riga ')
  
  return { message: "Login effettuato con successo" }
  // console.log('ciao 12 riga ')
})
