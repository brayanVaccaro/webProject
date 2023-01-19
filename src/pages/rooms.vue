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
            idStanza: 0 as number,
            tagliaStanza: 'singola' as string,
            tipologiaStanza: '' as string,
            prezzoAnotte: '' as string,
            nomeImgStanza: '' as any,
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

        date() {
            this.selettoreInputData[0].setAttribute("min", this.dataInizio)
            this.selettoreInputData[1].setAttribute("min", this.dataInizio)

        },

        filtra() {

            if (this.dataInizio == '' || this.dataFine == '') {
                return
            }
            else {
                this.dataSoggiornoGiusta[0] = this.dataInizio.split('-').reverse().toString().replaceAll(',', '/')
                this.dataSoggiornoGiusta[1] = this.dataFine.split('-').reverse().toString().replaceAll(',', '/')
            };


            $fetch("/api/reservation/filter", {
                method: "POST",
                body: {
                    tagliaStanza: this.tagliaStanza
                }
            })
                .then((data) => {
                    this.stanza = data as Stanza[]
                })
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
        imgZoomContainer(idStanza: number) {
            this.idStanza = idStanza
            console.log('id VALE ' + this.idStanza )
            // query per prendere il nome del file
            $fetch("/api/reservation/getImgName", {
                method: "POST",
                body: {
                    id: this.idStanza
                }
            }).then(() => {
                console.log('porcapaletta' + this.nomeImgStanza)
            })


            
            //rendo visibile il container della foto ingrandita
            let imgZoomContainer = document.querySelector("div.imgZoomContainer")
            imgZoomContainer?.setAttribute("style", "display: block")
            console.log(imgZoomContainer)


            const nomeImg = document.querySelector("p")?.innerText as string
            imgZoomContainer?.setAttribute("src", "ciao")
            console.log(nomeImg)
            // console.log(this.imgStanza)

            const imgTag = document.querySelector("div.imgZoomContainer img")
            console.log('abc' + imgTag?.getAttribute("src"))
            imgTag?.setAttribute("src", "img/" + this.nomeImgStanza)
        },
        imgCloseContainer() {
            let imgZoomContainer = document.querySelector("div.imgZoomContainer") as HTMLElement

            imgZoomContainer?.setAttribute("style", "display: none")
        },
        stanzaSeleziona(idStanza: number) {
            this.idStanza = idStanza
            console.log('id taglia tipo e prezzo = ' + this.idStanza + ' ' + this.tagliaStanza + ' ' + this.tipologiaStanza + ' ' + this.prezzoAnotte)

            $fetch("/api/reservation/getRooms", {
                method: "POST",
                body: {
                    id: this.idStanza
                }

            })
                .then((data) => {
                    this.stanzaScelta = data as Stanza[]

                })

            // this.stanzaScelta[0].
            this.idStanza = 0
            console.log(this.stanzaScelta)
        },
        durataSoggiorno() {
            const durataSoggiorno = this.dataInizio.charCodeAt(0) - this.dataInizio.charCodeAt(2)
            console.log('dataInizio: ' + this.dataInizio)
            console.log('dataInizio: ' + durataSoggiorno)
            return durataSoggiorno

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
            <img :src="'img/' + nomeImgStanza" @click="">
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
                        <select v-model="tagliaStanza">
                            <option v-for="option in options" :key="option.value" :value="option.value">{{
                                option.value
                            }}</option>

                            <!-- <option selected disabled hidden :value="options[2].value" >{{ options[2].value }}</option> -->


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

                    <tr v-for="x in stanza" class="grid-item-tr" @click="stanzaSeleziona(x.idStanza)">
                        <td>
                            <img :src="'img/' + x.imgStanza" @click="">

                            <label for="imageZoom" @click="imgZoomContainer(x.idStanza)">Ingrandisci</label>
                        </td>
                        <td>{{ (tipologiaStanza = x.tipologiaStanza) + ' ' + (x.tagliaStanza) }}</td>
                        <td>{{ prezzoAnotte= x.prezzoAnotte }}</td>



                    </tr>
                </tbody>
            </table>
        </div>
        <div class="grid-item-section section">
            <section>
                <h3>Riepilogo Prenotazione</h3>

                <table>
                    <thead class="grid-item-thead">
                        <tr>
                            <td>Stanza scelta</td>
                            <td>Durata Pernottamento</td>
                            <td>Prezzo Totale</td>
                        </tr>
                    </thead>
                    <tbody class="grid-item-tbody">

                        <tr v-for="x in stanzaScelta" class="grid-item-tr" @click="">
                            <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                            <td>
                                {{ durataSoggiorno() }}
                            </td>

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
    padding: 5% 10% 0%;
}

//ELENCO STANZE
.grid-item-table,
.grid-item-section {

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