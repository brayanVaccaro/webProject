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
            
            this.dataSoggiorno == '' ? console.log(this.dataSoggiorno) : this.dataSoggiornoGiusta = this.dataSoggiorno.split('-').reverse().toString().replaceAll(',','/');
        }
    },
    mounted() {
        this.getPersona();
    }
})
</script>

<template>
    <div class="grid-container-main">
        <aside class="grid-item-aside">
            <ul>
                <li>Data inizio soggiorno:</li>
                <input v-model="dataSoggiorno" @change="dateFormat"  type="date">
                <li>Data inizio soggiorno:</li>
                <input v-model="dataSoggiorno" @change="dateFormat"  type="date">

                <li>Quante persone?</li>
                <input type="button" value="-" @click="decreasePersone" />
                <label for="numeroPersone">{{ numeroPersone }}</label>
                <input type="button" value="+" @click="increasePersone" />
            </ul>
        </aside>
        <div class="position-h3">
        <h3>Elenco stanze disponibili per il giorno {{dataSoggiornoGiusta}}</h3>
        <table class="grid-item-table grid-container-table">
            <thead class="grid-item-thead">
                <td>immagine</td>
                <td>Descrizione</td>
                <td>numero stanza</td>
                <td>prezzo a notte</td>
            </thead>
            <tbody class="grid-item-tbody">
                <tr v-for="x in stanza" class="grid-item-tr">
                    <td> <img :src="'img/' + x.imgStanza"></td>
                    <td>{{ x.Descrizione }}</td>
                    <td>{{ x.numeroStanza }}</td>
                    <td>{{ x.prezzoStanzaAnotte }}</td>

                </tr>
            </tbody>
        </table>
        </div>
        <section>
            <h3>Prenotazione</h3>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Vero provident commodi odio temporibus reprehenderit officiis maxime, distinctio ipsum repellendus adipisci, laborum vel dicta ipsam quisquam maiores cumque dolorem quam quasi laudantium repudiandae! Laudantium, dolores eius esse sit nam ratione veritatis culpa architecto, nihil commodi, accusamus magnam! Ut, doloribus temporibus iste maiores vel obcaecati consequatur minima laborum fuga quae provident dignissimos optio dolorem? Aliquid adipisci sunt sapiente dolore. Reiciendis harum, unde necessitatibus ea quos consequuntur fuga suscipit atque deserunt enim corporis. Quod debitis est odio impedit a tenetur? Aliquam laborum a rerum illo officiis, voluptate unde consequatur iure impedit quam itaque?</p>

        </section>
    </div>
</template>

<style lang="scss">

</style>