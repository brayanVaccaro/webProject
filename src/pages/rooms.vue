<script lang="ts">
import { Stanza } from '../types'
definePageMeta({
    middleware: ["require-login"]
})
export default defineComponent({
// inject
    data() {
        return {
            stanza: [] as Stanza[],
            dataSoggiornoGiusta: ['', ''] as string[],
            selettoreInputData: undefined as any,
            dataInizio: new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0] as string,
            dataFine: '' as string,
            tagliaStanza: '' as string,
            imgStanza: '' as string,
            stanzaScelta: [] as Stanza[],
            options: [
                { value: 'Singola' },
                { value: 'Doppia' },
                { value: 'Tripla' },
                { value: 'Quadrupla' }
            ]
        }
    },
    methods: {
        delete() {
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




        },
        insertReservation() {
            $fetch("/api/reservation/reserve", {
                method: "POST",
                body: {
                    dataInizio: this.dataInizio,
                    dataFine: this.dataFine,
                }
            })
                .catch((e) => alert(e))
        },
        imgZoomContainer() {
            let imgZoomContainer = document.querySelector("div.imgZoomContainer")
            imgZoomContainer?.setAttribute("style", "display: block")
            console.log(imgZoomContainer)

            this.imgStanza = document.querySelector("p")?.innerText as string
            console.log(this.imgStanza)
            // document.querySelector(`#centerPage > div > div.grid-item-table.table > table > tbody > tr:nth-child(${id}) > div`)
            document.querySelector("#centerPage > div > div.grid-item-table.table > table > tbody > tr:nth-child(3) > div")

        },
        imgCloseContainer() {
            let imgZoomContainer = document.querySelector("div.imgZoomContainer") as HTMLElement
            
            imgZoomContainer?.setAttribute("style", "display: none")
        },
        stanzaSeleziona() {
            for (let i= 0; i<this.stanza.length; i++) {
                this.stanzaScelta[i] = this.stanza[i]
                
                
            }
            for (let x in this.stanza) {
                console.log()
            }
            console.log(this.imgStanza + ' ' + this.stanza.length)
            // this.imgStanza = 
        }

    },

    mounted() {
        this.selettoreInputData = document.querySelectorAll("#data")
    
        // this.imgZoomContainer = document.querySelector("div.imgZoomContainer")
        // this.console();
        this.date();



    }
})
</script>
<template>
    <div class="grid-container-main main">
        <div class="imgZoomContainer" style="display: none;">
            <input type="checkbox" id="closeZoomContainer">
            <label for="closeZoomContainer" @click="imgCloseContainer()">x</label>
            <img :src="'img/' + imgStanza" @click="">
        </div>

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
                    <input type="checkbox" id="imageZoom">

                    <tr v-for="x in stanza" class="grid-item-tr" @click="stanzaSeleziona()">
                        <td>
                            <img :src="'img/' + x.imgStanza" @click="">

                            <p>{{ x.imgStanza }}</p>
                            
                            
                            <label for="imageZoom" @click="imgZoomContainer()">Ingrandisci</label>
                        </td>
                        <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                        <td>{{ x.prezzoAnotte }}</td>



                    </tr>
                </tbody>
            </table>
        </div>
        <div class="grid-item-section section">
            <section>
                <h3>Riepilogo Prenotazione</h3>
                <p>data scelta:</p>
                <b>{{ dataInizio + ' ' + dataFine }}</b>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Vero provident commodi odio temporibus
                    reprehenderit officiis maxime, distinctio ipsum repellendus adipisci, laborum vel dicta ipsam
                    quisquam
                </p>
                <table>
                <tbody class="grid-item-tbody">
                    <input type="checkbox" id="imageZoom">

                    <tr v-for="x in stanza" class="grid-item-tr" @click="stanzaSeleziona()">
                        <td>
                            <img :src="'img/' + x.imgStanza" @click="">

                            <p>{{ x.imgStanza }}</p>
                            
                            
                            <label for="imageZoom" @click="imgZoomContainer()">Ingrandisci</label>
                        </td>
                        <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                        <td>{{ x.prezzoAnotte }}</td>



                    </tr>
                </tbody>
            </table>
            </section>
        </div>
    </div>
</template>

<style lang="scss" scoped>
b {
    // display: none;
}

img {
    max-width: 100%;
    height: auto;
    border: 1px solid black;
    border-radius: 10px;
    aspect-ratio: auto;
}

.imgZoomContainer {
    position: fixed;
    padding-top: 100px;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.9);

    label {
        position: absolute;
        top: 15px;
        right: 35px;
        color: #f1f1f1;
        font-size: 40px;
        font-weight: bold;
        transition: 0.3s;
    }

    img {
        margin: auto;
        display: block;
        width: 80%;
        max-width: 750px;
    }
}



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

//ELENCO STANZE
.grid-item-table, .grid-item-section  {

    // align-items: center;
    .grid-item-thead {
        display: flex;
        flex-direction: row;
        justify-content: space-evenly;
    }

    .grid-item-tbody {
        display: flex;
        flex-direction: column;

        // gap: 30px;
        .grid-item-tr {
            display: flex;
            flex-direction: row;
            justify-content: space-evenly;

            // align-items: flex-end;
            td {
                width: 33.3%;
                text-align: center;

                // background-color: black;
                label {
                    display: none;
                }
            }
        }

        .grid-item-tr td:nth-child(1):hover {
            // background-color: black;
            border: 2px solid red;

            label {
                display: block;
            }

        }
    }
}

// SEZIONE RIEPILOGO PRENOTAZIONE

.grid-item-section {}
</style>