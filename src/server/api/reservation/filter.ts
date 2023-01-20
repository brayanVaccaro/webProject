import { createConnection } from "~/server/utils/db";
//devo collegarmi al database e prendere solo le stanze che rispettano le condizioni poste dall'utente
export default defineEventHandler(async function (event) {
    const {tagliaStanza, dataInizio, dataFine} = await readBody(event)
    console.log('filter taglia stanza vale ' + tagliaStanza)
    console.log('filter data inizio vale ' + dataInizio)
    console.log('filter data fine vale ' + dataFine)
    // le stanze sono prese dal database in base alla tipologia
    const connection = await createConnection()
    const [results] = await connection.execute(
        `SELECT stanza.* 
        FROM stanza
        LEFT JOIN prenotazione
        ON stanza.idStanza = prenotazione.idStanza
        AND prenotazione.dataInizioPrenotazione >= '?' 
        AND prenotazione.dataFinePrenotazione <= '?' 
        WHERE prenotazione.idPrenotazione IS NULL AND stanza.tagliaStanza = '?'  
        `,
        [dataInizio, dataFine, tagliaStanza]

    )
    console.log('3 filter' + results)

// e ulteriormente filtrate. Se il loro id si trova nella tabella prenotazione allora si esclude

    return results

})