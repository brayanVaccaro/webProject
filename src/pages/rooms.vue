<script lang="ts">
import { Stanza } from '../types'
export default defineComponent({
    data() {
        return {
            stanza: [] as Stanza[],
            dataSoggiornoGiusta: ['', ''] as string[],
            dataInizio: '' as string,
            dataFine: '' as string,
            tagliaStanza: '',
            options: [
                { value: 'Singola' },
                { value: 'Doppia' },
                { value: 'Tripla' },
                { value: 'Quadrupla' }
            ]
        }
    },
    methods: {
        getStanze() {
            $fetch("/api/dbLinking")
                .then((data) => { this.stanza = data as Stanza[] })
        },

        filtra() {
            console.log('1' + this.tagliaStanza)

            $fetch("/api/reservation/filter", {
                method: "POST",
                body: {
                    tagliaStanza: this.tagliaStanza
                }
            })
                .then((data) => { this.stanza = data as Stanza[] })
                .catch((e) => alert(e))


            this.dataInizio == '' ? this.dataInizio = ' ' : (this.dataSoggiornoGiusta[0] = this.dataInizio.split('-').reverse().toString().replaceAll(',', '/'), this.dataSoggiornoGiusta[1] = this.dataFine.split('-').reverse().toString().replaceAll(',', '/'));
            console.log(this.dataInizio)
            console.log(this.dataFine)
            console.log(this.dataSoggiornoGiusta)


        }

    },
    mounted() {
        // this.getStanze();
    }
})
</script>
<template>
    <div class="grid-container-main main">
        <div class="grid-item-aside aside">
            <aside>
                <ul class="grid-item-aside-ul">
                    <li>Data inizio soggiorno:
                        <input v-model="dataInizio" type="date">
                    </li>
                    <li>Data fine soggiorno:
                        <input v-model="dataFine" type="date">
                    </li>
                    <li>Tipologia stanza
                        <select v-model="tagliaStanza" placeholder="tipo di stanza">
                            <option v-for="option in options" :key="option.value" :value="option.value">
                                {{ option.value }}
                            </option>
                        </select>
                        <button @click="filtra()">---></button>
                    </li>
                </ul>
            </aside>
        </div>
        <div class="grid-item-table table">
            <h3>Elenco stanze nel periodo {{ dataSoggiornoGiusta[0]+ ' - ' + dataSoggiornoGiusta[1] }}</h3>
            <table class="">
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
    max-width: 100%;
    height: auto;
    border: 1px solid black;
    border-radius: 10px;
    aspect-ratio: auto;
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

.grid-item-table {
    // align-items: center;

}

.grid-item-thead {
    display: flex;
    // flex-direction: row;
    justify-content: space-evenly;
}

.grid-item-tbody {
    display: flex;
    flex-direction: column;
    // gap: 30px;
}

.grid-item-section {}

.grid-item-tr {
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    // align-items: flex-end;
}

.grid-item-tr td {
    width: 33.3%;
    text-align: center;
    // background-color: black;
}
</style>