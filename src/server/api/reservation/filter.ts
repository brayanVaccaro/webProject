import { createConnection } from "~/server/utils/db";
//devo collegarmi al database e prendere solo le stanze che rispettano le condizioni poste dall'utente
export default defineEventHandler(async function (event) {
    const {tagliaStanza} = await readBody(event)
    console.log('2' + tagliaStanza)

    // le stanze sono prese dal database in base alle date
    const connection = await createConnection()
    const [results] = await connection.execute(
        `SELECT * FROM stanza WHERE tagliaStanza=?`,
        [tagliaStanza]

    )
    console.log('3' + results)
    return results

})