<script lang="ts">
import { Stanza, Utente } from '../types'
import AddRoom from './addRoom.vue'
definePageMeta({
    middleware: ["require-login"]
})
export default defineComponent({
    setup() {
        return {
            user: inject("user") as Utente | null,
        };
    },
    provide() {
        return {
            container: computed(() => this.container)
        };
    },
    data() {
        return {
            stanza: [] as Stanza[],
            idStanza: [] as number[],
            prezzoAnotte: "" as string,
            imgStanza: "" as string,
            tagliaStanza: "" as string,
            tipologiaStanza: "" as string,
            dataSoggiornoGiusta: ["", ""] as string[],
            selettoreInputData: undefined as any,
            dataInizio: new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0] as string,
            dataFine: "" as string,
            nomeImgStanza: "" as string,
            container: null as Stanza | null,
            buffer: [] as Stanza[],
            stanzaScelta: [] as Stanza[],
            options: [
                { value: "Singola" },
                { value: "Doppia" },
                { value: "Tripla" },
                { value: "Quadrupla" }
            ],
            scelte: [
                { value: "matrimoniale" },
                { value: "suite" },
                { value: "vistaMare" },
            ],
            controlloPrenotazione: false as boolean,
            controlloUtente: false as boolean,
            // controlloContainer: false as boolean
        };
    },
    methods: {
        date() {
            this.selettoreInputData = document.querySelectorAll(".grid-item-aside-ul > li > input");

            this.selettoreInputData[0].setAttribute("min", this.dataInizio);
            this.selettoreInputData[1].setAttribute("min", this.dataInizio);
        },
        getAllRooms(controlloUtente: boolean) {
            //sono gestore e mi interessa vedere tutte le stanze
            console.log('sono dentro getAllRooms')
            $fetch("/api/reservation/searchRoom", {
                method: "POST",
                body: {
                    controlloUtente: controlloUtente,
                    tagliaStanza: this.tagliaStanza,
                    dataInizio: this.dataInizio,
                    dataFine: this.dataFine,
                }
            })
                .then((data) => {
                    this.stanza = data as Stanza[];
                    console.log(this.stanza);
                })
                .catch((e) => alert(e));
        },
        searchRoom() {
            if (this.dataInizio == "" || this.dataFine == "") {
                return;
            }
            else {
                this.dataSoggiornoGiusta[0] = this.dataInizio.split("-").reverse().toString().replaceAll(",", "/");
                this.dataSoggiornoGiusta[1] = this.dataFine.split("-").reverse().toString().replaceAll(",", "/");
            }
            ;
            // $fetch("/api/reservation/searchRoom", {
            //     method: "POST",
            //     body: {
            //         tagliaStanza: this.tagliaStanza,
            //         dataInizio: this.dataInizio,
            //         dataFine: this.dataFine,
            //     }
            // })
            //     .then((data) => {
            //         this.stanza = data as Stanza[];
            //         console.log(this.stanza);
            //     })
            //     .catch((e) => alert(e));
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
                .catch((e) => (alert(e)));
        },
        zoomContainer(idStanza: number, controlloContainer: boolean) {
            // this.idStanza = idStanza
            console.log(" 1 id VALE " + idStanza);
            // query per prendere il nome del file
            const imgZoomContainer = document.querySelector("div.imgZoomContainer");
            const imgTag = document.querySelector("div.imgZoomContainer img");
            if (controlloContainer) {
                $fetch("/api/reservation/getImgName", {
                    method: "POST",
                    body: {
                        idStanza: idStanza
                    }
                }).then((data) => {
                    this.buffer = data as Stanza[];
                    console.log("2 lunghezza buffer");
                    console.log(this.buffer.length);
                    console.log(" e buffer  ");
                    console.log(this.buffer[0]);
                    this.container = this.buffer[0];
                    this.nomeImgStanza = this.container.imgStanza;
                    console.log("3 user vale ");
                    console.log(this.user);
                    console.log("container vale ");
                    console.log(this.container);
                });
                //rendo visibile il container della foto ingrandita
                imgZoomContainer?.setAttribute("style", "display: block");
                //imposto la giusta src al tag img
                imgTag?.setAttribute("src", "img/" + this.container?.imgStanza);
            }
            else {
                imgZoomContainer?.setAttribute("style", "display: none");
            }
        },
        getUserRoom(idStanza: number) {
            console.log(" prima idstanza vale" + idStanza);
            $fetch("/api/reservation/getUserRoom", {
                method: "POST",
                body: {
                    id: idStanza
                }
            })
                .then((data) => {
                    this.stanzaScelta = data as Stanza[];
                    console.log("dentro la fetch" + this.stanzaScelta);
                });
            this.controlloPrenotazione = true;
            console.log("dopo idStanza vale" + idStanza);
        },
        durataSoggiorno() {
            const durataSoggiorno = this.dataInizio.charCodeAt(0) - this.dataInizio.charCodeAt(2);
        },
        insertRoom() {
            $fetch("/api/reservation/insertRoom", {
                method: "POST",
                body: {
                    idStanza: this.idStanza,
                    prezzoAnotte: this.prezzoAnotte,
                    imgStanza: this.imgStanza,
                    tagliaStanza: this.tagliaStanza,
                    tipologiaStanza: this.tipologiaStanza,
                }
            })
                .then((response) => (alert(response.message)))
                .then(() => window.location.href = "/reservation")
                .catch((e) => (alert(e)));
        },
        deleteRoom(idStanza: number) {
            $fetch("/api/reservation/deleteRoom", {
                method: "POST",
                body: {
                    idStanza: idStanza
                }
            })
                .then((response) => (alert(response.message)))
                .then(() => window.location.href = "/reservation")
                .catch((e) => (alert(e)));
        },
    },
    mounted() {
        // this.imgZoomContainer = document.querySelector("div.imgZoomContainer")
        // this.console();
        if (this.user?.ruolo == 'cliente') {

            this.date();
            this.getAllRooms(true)
        }
        else {
            this.getAllRooms(false)

        }
    },
    components: { AddRoom }
})
</script>
<template>
    <div class="grid-container-main main">
        <div class="imgZoomContainer" style="display: none;">
            <input type="checkbox" id="closeZoomContainer">
            <label for="closeZoomContainer" @click="zoomContainer(0, false)">x</label>
            <img :src="'img/' + nomeImgStanza" @click="">
        </div>

        <div class="grid-item-aside aside">
            <aside>
                <ul class="grid-item-aside-ul">
                    <div v-if="user?.ruolo == 'cliente'">
                        <li>Data inizio soggiorno:
                            <input v-model="dataInizio" type="date" id="dataInizio" @change="date()">
                        </li>
                        <li>Data fine soggiorno:
                            <input v-model="dataFine" type="date" id="dataFine" @change="date()">
                        </li>
                        <li>
                            <label for="tipologiaStanza"> Tipologia Stanza
                                <select id="tipologiaStanza" v-model="tagliaStanza">
                                    <option v-for="option in options" :key="option.value" :value="option.value">{{
                                        option.value
                                    }}</option>

                                    <!-- <option selected disabled hidden :value="options[2].value" >{{ options[2].value }}</option> -->


                                </select>
                            </label>
                            <button @click="searchRoom()">---></button>
                        </li>
                    </div>
                    <li v-if="user?.ruolo == 'gestore'">
                        <AddRoom></AddRoom>
                        <button>
                            <NuxtLink to="addRoom">
                                Aggiungi stanza
                            </NuxtLink>
                        </button>
                    </li>
                </ul>
            </aside>
        </div>
        <div class="grid-item-table table">

            <h3 v-if="user?.ruolo == 'cliente'">Elenco stanze nel periodo {{
                new Date(dataInizio).toLocaleDateString() + ' - ' + new
                    Date(dataFine).toLocaleDateString()
            }}</h3>
            <h3 v-else>
                Elenco di tutte le Stanze
            </h3>
            <table class="">
                <thead class="grid-item-thead">
                    <tr>
                        <td>Immagine</td>
                        <td>Descrizione</td>
                        <td>Prezzo a Notte</td>

                    </tr>
                </thead>
                <tbody class="grid-item-tbody">
                    <input type="checkbox" id="imageZoom">

                    <tr v-for="x in stanza" class="grid-item-tr">
                        <td>
                            <img :src="'img/' + x.imgStanza" @click="" alt="imgBedrrom">

                            <label for="imageZoom" @click.self="zoomContainer(x.idStanza, true)">Ingrandisci</label>
                        </td>
                        <td>{{ x.tagliaStanza + ' ' + x.tipologiaStanza   }}</td>
                        <td>{{ x.prezzoAnotte }}</td>
                        <td v-if="user?.ruolo == 'cliente'" @click.self="getUserRoom(x.idStanza)">SELEZIONA</td>
                        <td><button v-if="user?.ruolo == 'gestore'" @click.prevent="deleteRoom(x.idStanza)">
                                Rimuovi Stanza
                            </button></td>


                    </tr>
                </tbody>
            </table>
        </div>
        <div class="grid-item-section section">
            <section v-if="user?.ruolo == 'cliente'">
                <h3>Riepilogo Prenotazione</h3>

                <table>
                    <thead class="grid-item-thead">
                        <tr>
                            <td>Stanza scelta</td>
                            <td>Prezzo a notte</td>
                        </tr>
                    </thead>
                    <tbody class="grid-item-tbody">

                        <tr v-for="x in stanzaScelta" class="grid-item-tr" @click="">
                            <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>
                            <td>
                                {{ durataSoggiorno() }}
                            </td>

                            <td>{{ x.prezzoAnotte }}</td>
                            <button v-if="user?.ruolo == 'cliente' && controlloPrenotazione"
                                @click="insertReservation(x.idStanza)">Prenota</button>

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
                // display: none;
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
</style>