<script lang="ts">
import { Stanza } from '../types'
export default defineComponent({
    data() {
        return {
            stanza: [] as Stanza[],
            numeroPersone: 0 as number,
            dataSoggiorno: '' as string,
            dataSoggiornoGiusta: '' as string,
            dataInizio: '' as string,
            dataFine: '' as string,
            tagliaStanza: '' as string,
            selectedOption: '',
            options: [
                { value: 'Singola'},
                { value: 'Doppia'},
                { value: 'Tripla'},
                { value: 'Quadrupla'}
            ]
        }
    },
    methods: {
        getStanze() {
            $fetch("/api/dbLinking")
                .then((data) => { this.stanza = data as Stanza[] })
        },

        async filtra() {
            console.log('1' + this.tagliaStanza)

            $fetch("/api/reservation/filter", {
                method: "POST",
                body: {
                    tagliaStanza: this.selectedOption
                }
            }).then((data) => { this.stanza = data as Stanza[] })
            // const choise = document.querySelector();
            // for (let i = 0; i < this.stanza.length; i++) {
            //     this.stanza[i].tagliaStanza == this.dataSoggiornoGiusta ? console.log() : i++
            // }

        },
        dateFormat() {
            this.dataSoggiorno == '' ? console.log(this.dataSoggiorno) : this.dataSoggiornoGiusta = this.dataSoggiorno.split('-').reverse().toString().replaceAll(',', '/');
        }
    },
    mounted() {
        this.getStanze();
    }
})
</script>
<template>
    <div class="grid-container-main main">
        <div class="grid-item-aside aside">
            <aside>
                <ul class="grid-item-aside-ul">
                    <li>Data inizio soggiorno:
                        <input v-model="dataSoggiorno" @change="dateFormat" type="date">
                    </li>
                    <li>Data fine soggiorno:
                        <input v-model="dataSoggiorno" @change="dateFormat" type="date">
                    </li>
                    <select v-model="selectedOption" >
                        <option v-for="option in options" :key="option.value" :value="option.value">
                            {{ option.value }}
                        </option>
                    </select>
                    <!-- 
                    <li>Tipologia Stanza:
                        <input type="checkbox" value="ciao" id="choise" v-bind="tagliaStanza">
                        <label for="choise" >Singola</label>
                        <input type="checkbox" id="choise">
                        <label for="choise">Doppia</label>
                        <input type="checkbox" id="choise">
                        <label for="choise">Tripla</label>
                        <input type="checkbox" id="choise">
                        <label for="choise">Quadrupla</label>
                    </li> -->
                    <button @click.prevent="filtra">---></button>

                </ul>
            </aside>
        </div>
        <div class="grid-item-table table">
            <h3>Elenco stanze disponibili per il giorno {{ dataSoggiornoGiusta }}</h3>
            <table class="">
                <thead class="grid-item-thead">
                    <td>Immagine</td>
                    <td>Descrizione</td>
                    <td>prezzo a notte</td>
                </thead>
                <tbody class="grid-item-tbody">
                    <!-- qua la condizionie  -->
                    <tr v-for="x in stanza" class="grid-item-tr">
                        <td> <img :src="'img/' + x.imgStanza"></td>
                        <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                        <td>{{ x.prezzoAnotte }}</td>

                    </tr>
                </tbody>
            </table>
        </div>
        <div class="grid-item-section section">
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
img {
    width: 70%;
    height: auto;
    border: 1px solid black;
    border-radius: 10px;
}

h3 {}

li {
    list-style: none;
    margin: 5% 0%;
}

.grid-container-main {
    display: grid;
}

.grid-item-aside {}

.grid-item-aside-ul {
    display: flex;
    flex-direction: column;
}

.grid-item-table {}

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

.grid-item-section {}

.grid-item-tr {
    display: flex;
    flex-direction: row;
}

.grid-item-tr td:nth-child(1) {
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
</style>