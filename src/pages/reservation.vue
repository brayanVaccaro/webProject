<script lang="ts">
import { Stanza, Utente } from '../types'
definePageMeta({
    middleware: ["require-login"]
})
export default defineComponent({
    setup() {
        return {
            user: inject("user") as Utente | null,
        }
    },
    provide() {
        return {
            container: computed(() => this.container)
        }
    },
    data() {
        return {
            stanza: [] as Stanza[],
            dataSoggiornoGiusta: ['', ''] as string[],
            selettoreInputData: undefined as any,
            dataInizio: new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0] as string,
            dataFine: '' as string,
            tagliaStanza: '' as string,
            nomeImgStanza: '' as string,
            container: null as Stanza | null,
            buffer: [] as Stanza[],
            stanzaScelta: [] as Stanza[],
            options: [
                { value: 'Singola' },
                { value: 'Doppia' },
                { value: 'Tripla' },
                { value: 'Quadrupla' }
            ],
            controlloPrenotazione: false as boolean,
            // controlloContainer: false as boolean
        }
    },
    methods: {

        date() {
            this.selettoreInputData[0].setAttribute("min", this.dataInizio)
            this.selettoreInputData[1].setAttribute("min", this.dataInizio)

        },

        searchRoom() {
            if (this.dataInizio == '' || this.dataFine == '') {
                return
            }
            else {
                this.dataSoggiornoGiusta[0] = this.dataInizio.split('-').reverse().toString().replaceAll(',', '/')
                this.dataSoggiornoGiusta[1] = this.dataFine.split('-').reverse().toString().replaceAll(',', '/')
            };


            $fetch("/api/reservation/searchRoom", {
                method: "POST",
                body: {
                    tagliaStanza: this.tagliaStanza,
                    dataInizio: this.dataInizio,
                    dataFine: this.dataFine,
                }
            })
                .then((data) => {
                    this.stanza = data as Stanza[]
                    console.log(this.stanza)
                })
                .catch((e) => alert(e))




        },
        insertReservation(idStanza: number) {
            $fetch("/api/reservation/insertReservation", {
                method: "POST",
                body: {
                    dataFine: this.dataFine,
                    dataInizio: this.dataInizio,
                    idStanza: idStanza,
                    idUtente: this.user?.idUtente
                }
            })
                .then((response) => (alert(response.message)))
                .then(() => window.location.href = "/")
                .catch((e) => (alert(e)))

        },
        zoomContainer(idStanza: number, controlloContainer: boolean) {

            // this.idStanza = idStanza
            console.log(' 1 id VALE ' + idStanza)
            // query per prendere il nome del file

            const imgZoomContainer = document.querySelector("div.imgZoomContainer")
            const imgTag = document.querySelector("div.imgZoomContainer img")

            if (controlloContainer) {
                $fetch("/api/reservation/getImgName", {
                    method: "POST",
                    body: {
                        idStanza: idStanza
                    }
                }).then((data) => {
                    this.buffer = data as Stanza[]
                    console.log('2 lunghezza buffer e buffer  ' + this.buffer.length + this.buffer[0])
                    this.container = this.buffer[0]
                    this.nomeImgStanza = this.container.imgStanza
                    console.log('3 user vale ' + this.user + 'container vale ' + this.container)
                })

                //rendo visibile il container della foto ingrandita
                imgZoomContainer?.setAttribute("style", "display: block")
                //imposto la giusta src al tag img
                imgTag?.setAttribute("src", "img/" + this.container?.imgStanza)
            } else {
                imgZoomContainer?.setAttribute("style", "display: none")

            }

        },

        getUserRoom(idStanza: number) {
            // this.idStanza = idStanza
            console.log(' prima idstanza vale' + idStanza)
            $fetch("/api/reservation/getUserRoom", {
                method: "POST",
                body: {
                    id: idStanza
                }

            })
                .then((data) => {
                    this.stanzaScelta = data as Stanza[]
                    console.log('dentro la fetch'+ this.stanzaScelta)

                })

            // this.stanzaScelta[0].
            this.controlloPrenotazione = true
            console.log('dopo idStanza vale' + idStanza)
        },
        durataSoggiorno() {
            const durataSoggiorno = this.dataInizio.charCodeAt(0) - this.dataInizio.charCodeAt(2)
            // console.log('dataInizio: ' + this.dataInizio)
            // console.log('dataInizio: ' + durataSoggiorno)
            // return durataSoggiorno

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
            <label for="closeZoomContainer" @click="zoomContainer(0,false)">x</label>
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
                        <button @click="searchRoom()">---></button>
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
                    <td></td>

                </thead>
                <tbody class="grid-item-tbody">
                    <input type="checkbox" id="imageZoom">

                    <tr v-for="x in stanza" class="grid-item-tr">
                        <td>
                            <p>{{ x.idStanza }}</p>
                            <img :src="'img/' + x.imgStanza" @click="">

                            <label for="imageZoom" @click.self="zoomContainer(x.idStanza, true)">Ingrandisci</label>
                        </td>
                        <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                        <td>{{ x.prezzoAnotte }}</td>
                        <td @click.self="getUserRoom(x.idStanza)">SELEZIONA</td>



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

                            <button v-if="controlloPrenotazione" @click="insertReservation(x.idStanza)">Prenota</button>

                            <p>{{ x.idStanza }}</p>


                        </tr>
                    </tbody>
                </table>
            </section>
        </div>
    </div>
</template>

<style lang="scss" scoped>
#closeZoomContainer,
#imageZoom {
    display: none;
}

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

            td:nth-child(4) {
                display: none;
            }
        }

        .grid-item-tr:hover {

            td:nth-child(4) {
                display: block;
                color: red;
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