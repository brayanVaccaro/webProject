import { createConnection } from "~/server/utils/db";
//devo collegarmi al database e prendere solo le stanze che rispettano le condizioni poste dall'utente
export default defineEventHandler(async function (event) {
    const {tagliaStanza} = await readBody(event)
    console.log('2' + tagliaStanza)

    // le stanze sono prese dal database in base alla tipologia
    const connection = await createConnection()
    const [results] = await connection.execute(
        `SELECT prezzoAnotte, imgStanza, tagliaStanza, tipologiaStanza, dataInizioPrenotazione, dataFinePrenotazione FROM stanza INNER JOIN prenotazione ON prenotazione.idStanza != stanza.idStanza WHERE tagliaStanza=?`,
        [tagliaStanza]

    )
    console.log('3' + results)

// e ulteriormente filtrate. Se il loro id si trova nella tabella prenotazione allora si esclude

    return results

})