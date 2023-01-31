import { createConnection } from "~/server/utils/db";
//devo collegarmi al database e prendere solo le stanze che rispettano le condizioni poste dall'utente
export default defineEventHandler(async function (event) {
    const { tagliaStanza, dataInizio, dataFine, controlloUtente } = await readBody(event)
    console.log('searchRoom taglia stanza vale ' + tagliaStanza)
    console.log('searchRoom data inizio vale ' + dataInizio)
    console.log('searchRoom data fine vale ' + dataFine)
    console.log('searchRoom controlloUtente vale ' + controlloUtente)

    const connection = await createConnection()


    switch (controlloUtente) {
        case false: //prendo tutte le stanze NON prenotate, sono gestore
           const [results1] = await connection.execute(
              `SELECT stanza.* 
              FROM stanza
              LEFT JOIN prenotazione
              ON stanza.idStanza = prenotazione.idStanza
              ORDER BY tagliaStanza`,
           )
           return results1
        case true: //mi prendo le stanze NON prenotate filtrate per periodo e tipologiaStanza, sono utente
           const [results2] = await connection.execute(
            `SELECT stanza.* 
            FROM stanza
            LEFT JOIN prenotazione
            ON stanza.idStanza = prenotazione.idStanza
            AND prenotazione.dataInizioPrenotazione <= ? 
            AND prenotazione.dataFinePrenotazione >= ?
            WHERE prenotazione.idPrenotazione IS NULL AND stanza.tagliaStanza = ?;  
            `,
            [dataFine, dataInizio, tagliaStanza]
           )
           return results2
     }

})