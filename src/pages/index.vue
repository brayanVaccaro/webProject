<template>
    <div id="index">
        <!-- breve descrizione dell'hotel -->
        <section>
            <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Sequi mollitia laboriosam a facilis animi, quis
                odio aliquid enim numquam doloribus laborum accusantium suscipit, perferendis id maiores aliquam minima
                nesciunt iure?
            </p>
        </section>
        <!-- elenco delle stanze con le relative info -->
        <section id="contenutoStanza">
            <div class="flexbox-index">
                <table>
                    <thead>
                        <th>idStanza</th>
                        <th>Numero</th>
                        <th>Prezzo</th>
                        <th>img</th>
                        <th>utente</th>
                    </thead>
                    <tbody>
                        <tr>

                            <td>ciao!</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="flexbox-index-item">

            </div>
            <div class="flexbox-index-item"></div>
            <div class="flexbox-index-item"></div>
        </section>
    </div>
</template>

<style lang="scss" scoped>

#contenutoStanza {
    width: 100%;
    height: auto;
    padding-bottom: 1%;
    background-color: red;
}

//INDEX PAGE
.flexbox-index {
    display: flex;
    // flex-wrap: ;
    flex-direction: column;
    // flex-wrap: wrap;
}
.flexbox-index-item {
    width: auto;
    height: 100px;
    background-color: blue;
    margin: 1% 1% 0;
}
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}

td {
    text-align: center;
}
</style> 