<script lang="ts">
import { Stanza } from '../types'
export default defineComponent({
    data() {
        return {
            stanza: [] as Stanza[],
            dataSoggiornoGiusta: ['', ''] as string[],
            selettoreInputData: undefined as any,
            dataInizio: new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0] as string,
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
        console() {
            $fetch("/api/reservation/getRooms")
                .then((data) => { this.stanza = data as Stanza[] })

        },
        date() {
            this.selettoreInputData[0].setAttribute("min", this.dataInizio)
            this.selettoreInputData[1].setAttribute("min", this.dataInizio)

        },

        filtra() {
            console.log('1' + this.tagliaStanza)
            
            console.log('prima ' + this.dataInizio)
            if (this.dataInizio == '' || this.dataFine == '') {
                return
            }

            if (2 > 3) {
                return
            }
            else (this.dataSoggiornoGiusta[0] = this.dataInizio.split('-').reverse().toString().replaceAll(',', '/'), this.dataSoggiornoGiusta[1] = this.dataFine.split('-').reverse().toString().replaceAll(',', '/'));
            console.log('dopo ', + this.dataInizio)
            console.log(this.dataFine)
            console.log(this.dataSoggiornoGiusta)

            $fetch("/api/reservation/filter", {
                method: "POST",
                body: {
                    dataInizio: this.dataInizio,
                    dataFine: this.dataFine,
                    tagliaStanza: this.tagliaStanza
                }
            })
                .then((data) => { this.stanza = data as Stanza[] })
                .catch((e) => alert(e))




        }

    },
    beforeMount() {
        // this.date()
    },
    mounted() {
        this.selettoreInputData = document.querySelectorAll("#data")
        this.console();
        this.date();



    }
})
</script>
<template>
    <div class="grid-container-main main">
        <div class="grid-item-aside aside">
            <aside>
                <ul class="grid-item-aside-ul">
                    <li>Data inizio soggiorno:
                        <input v-model="dataInizio" type="date" id="data" @change="date()">
                    </li>
                    <li>Data fine soggiorno:
                        <input v-model="dataFine" type="date" id="data" @change="date()">
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
                    <input type="checkbox" id="imageZoom" checked>

                    <tr v-for="x in stanza" class="grid-item-tr">
                        <td> <label for="imageZoom">
                                <img :src="'img/' + x.imgStanza" @click="">
                            </label>
                        </td>
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
                </p>

            </section>
        </div>
    </div>
</template>
<style lang="scss" scoped>
img {
    width: 100%;
    max-width: 200%;
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

.grid-item-table tr:hover {
    background-color: grey;
}

#centerPage>div>div.grid-item-table.table>table>tbody>tr:nth-child(1)>td:nth-child(1) .grid-item-table tr:nth-child(1) td:nth-child(1):hover {
    border: red 2px solid;
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

#imageZoom {
    // display: none;
}

#imageZoom:checked+label>img {
    // background-color: black;

    box-shadow: 0 19px 38px rgba(0, 0, 0, 0.30), 0 15px 12px rgba(0, 0, 0, 0.22);
}

#imageZoom:checked~.grid-item-tr td:nth-child(1) img:hover {
    background-color: black;
    // width: 150%;

    // width: 800px;


// box-shadow: 0 19px 38px rgba(0, 0, 0, 0.30), 0 15px 12px rgba(0, 0, 0, 0.22);
}

.grid-item-section {}

.grid-item-tr {
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    // align-items: flex-end;
}

.grid-item-tr td:nth-child(1):hover {
    // background-color: black;
    border: 1px solid red;

    img {
        // aspect-ratio: 16/9;


    }
}

.grid-item-tr td {
    width: 33.3%;
    // text-align: center;
    // background-color: black;
}
</style>