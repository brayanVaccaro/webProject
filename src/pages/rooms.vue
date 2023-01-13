<script lang="ts">
import { Stanza } from '../types'
export default defineComponent({
    data() {
        return {
            stanza: [] as Stanza[],
            numeroPersone: 0 as number,
            dataSoggiorno: '' as string,
            dataSoggiornoGiusta: '' as string
        }
    },
    methods: {
        getPersona() {
            $fetch("/api/dbLinking")
                .then((data) => { this.stanza = data as Stanza[] })
        },
        increasePersone() {
            this.numeroPersone == 5 ? this.numeroPersone = this.numeroPersone : this.numeroPersone++
        },
        decreasePersone() {
            this.numeroPersone == 0 ? this.numeroPersone = this.numeroPersone : this.numeroPersone--
        },
        dateFormat() {
            let a =

                this.dataSoggiorno == '' ? console.log(this.dataSoggiorno) : this.dataSoggiornoGiusta = this.dataSoggiorno.split('-').reverse().toString().replaceAll(',', '/');
        }
    },
    mounted() {
        this.getPersona();
    }
})
</script>
<template>
    <div class="grid-container-main">
        <div class="grid-item-aside">
            <aside>
                <ul class="grid-item-aside-ul">
                    <li>Data inizio soggiorno:
                    <input v-model="dataSoggiorno" @change="dateFormat" type="date"></li>
                    <li>Data inizio soggiorno:
                    <input v-model="dataSoggiorno" @change="dateFormat" type="date"></li>

                    <li>Quante persone?
                    <input type="button" value="-" @click="decreasePersone" />
                    <label for="numeroPersone">{{ numeroPersone }}</label>
                    <input type="button" value="+" @click="increasePersone" /></li>
                </ul>
            </aside>
        </div>
        <div class="grid-item-table">
            <h3>Elenco stanze disponibili per il giorno {{ dataSoggiornoGiusta }}</h3>
            <table class="grid-item-table">
                <thead class="grid-item-thead">
                    <td>Immagine</td>
                    <td>Descrizione</td>
                    <td>prezzo a notte</td>
                </thead>
                <tbody class="grid-item-tbody">
                    <tr v-for="x in stanza" class="grid-item-tr">
                        <td> <img :src="'img/' + x.imgStanza"></td>
                        <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                        <td>{{ x.prezzoAnotte }}</td>

                    </tr>
                </tbody>
            </table>
        </div>
        <div class="grid-item-section">
            <section>
                <h3>Prenotazione</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Vero provident commodi odio temporibus
                    reprehenderit officiis maxime, distinctio ipsum repellendus adipisci, laborum vel dicta ipsam
                    quisquam
                    maiores cumque dolorem quam quasi laudantium repudiandae! Laudantium, dolores eius esse sit nam
                    ratione
                    veritatis culpa architecto, nihil commodi, accusamus magnam! Ut, doloribus temporibus iste maiores
                    vel
                    obcaecati consequatur minima laborum fuga quae provident dignissimos optio dolorem? Aliquid adipisci
                    sunt sapiente dolore. Reiciendis harum, unde necessitatibus ea quos consequuntur fuga suscipit atque
                    deserunt enim corporis. Quod debitis est odio impedit a tenetur? Aliquam laborum a rerum illo
                    officiis,
                    voluptate unde consequatur iure impedit quam itaque?</p>

            </section>
        </div>
    </div>
</template>
<style lang="scss" scoped>
// @import 'breakpoints';

img {
    // aspect-ratio: auto;
    width: 70%;
    height: auto;
    border: 1px solid black;
    border-radius: 10px;
}

h3 {
    display: block;
    position: relative;
    top: 0%;
}

li {
    list-style: none;
    margin: 5% 0%;
}

// .grid-container-main {

// }
// .grid-item-section {
//     display: flex;
//     flex-direction: row;
//     // background-color: black;
//     // width: 100%;
//     grid-column: 2 / 2;
// }
.grid-item-table {
    display: flex;
    flex-direction: column;
}

.grid-item-thead {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
}

.grid-item-tbody {
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.grid-item-tr {
    display: flex;
    flex-direction: row;
    // row-gap: 30%;
}

.grid-item-tr td:nth-child(1) {
    // max-width: none;
    width: 25%;
    // background-color: black;
}

.grid-item-tr td:nth-child(2) {
    // display: grid;
    width: 25%;
    // background-color: red;
    // max-width: min-content;
    // grid-template-columns: minmax(50px, 250px);
}

.grid-item-tr td:nth-child(3) {
    width: 25%;
    // background-color: orange;
    text-align: center;
}

.grid-item-tr td:nth-child(4) {
    width: 25%;
    // background-color: green;
    text-align: center;
}

.grid-item-aside-ul {
    display: flex;
    flex-direction: column;
}

.grid-item-aside {
    border-right: 1px solid black;
    height: 100%;
    padding: 0;
    margin: 0;
}

.grid-item-1 {
    background-color: rgb(254, 100, 0);

}


//
</style>