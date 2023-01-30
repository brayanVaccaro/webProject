import { createConnection } from "~~/src/server/utils/db";

export default defineEventHandler(async function (event) {

   const { email, controllo } = await readBody(event)
   console.log('email vale ' + email)
   console.log('controllo vale ' + controllo)
   // const id = idUtente

   // let controllo = 0  
   // const id = idUtente
   const connection = await createConnection()
   switch (controllo) {
      case 0: //prendo le reservation di tutti gli utenti
         const [results1] = await connection.execute(
            `SELECT * FROM prenotazione INNER JOIN utenti ON utenti.idUtente=prenotazione.idUtente INNER JOIN stanza ON stanza.idStanza=prenotazione.idStanza`,
            [email]
         )
         return results1
      case 1: //mi prendo le reservation del singolo utente
         const [results2] = await connection.execute(
            `SELECT * FROM prenotazione INNER JOIN utenti ON utenti.idUtente=prenotazione.idUtente INNER JOIN stanza ON stanza.idStanza=prenotazione.idStanza WHERE(email=?) ORDER BY stanza.idStanza ASC;`,
            [email]
         )
         return results2
   }


   // console.log('prenotazioni by email ' + results)
})