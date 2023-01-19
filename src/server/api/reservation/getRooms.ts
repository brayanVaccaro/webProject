import { createConnection } from "~/server/utils/db";
//devo collegarmi al database e prendere solo le stanze che rispettano le condizioni poste dall'utente
export default defineEventHandler(async function (event) {

    const { id } = await readBody(event)
    console.log("getRooms l'id vale" + id)

    // le stanze sono prese dal database in base alla tipologia
    //  FUNZIONA QUESTA SOTTO
    // const connection = await createConnection()
    // const [results] = await connection.execute(
    //     `SELECT prezzoAnotte, tagliaStanza, tipologiaStanza FROM stanza WHERE (prezzoAnotte=? AND tagliaStanza=? AND tipologiaStanza=?);`,
    //     [prezzoAnotte, tagliaStanza, tipologiaStanza]
    // )
    const connection = await createConnection()
    const [results] = await connection.execute(
        `SELECT * FROM stanza WHERE stanza.idStanza=?`,
        [id]
    )


    console.log('3 getRooms results vale ' + results.constructor.toLocaleString())

    // e ulteriormente filtrate. Se il loro id si trova nella tabella prenotazione allora si esclude

    return results

})