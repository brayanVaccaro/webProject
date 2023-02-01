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
            // dataSoggiornoGiusta: ["", ""] as string[],
            selettoreInputDataInizio: undefined as any,
            selettoreInputDataFine: undefined as any,
            dataOdierna: new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0] as string,
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
            controlloUtente: false as boolean, //false sono gestore
            step: 0 as number
            // controlloContainer: false as boolean
        };
    },
    methods: {
        date() {

            this.selettoreInputDataInizio.setAttribute("min", this.dataOdierna);
            this.selettoreInputDataFine.setAttribute("min", this.dataOdierna);
        },
        async getAllRooms(controlloUtente: boolean) {

            console.log('0 sono dentro getAllRooms')
            console.log(' 1 prima del change controlloUtente vale ')
            console.log(this.controlloUtente)

            //sono gestore e mi interessa vedere tutte le stanze
            this.controlloUtente = controlloUtente
            // console.log('2 dopo del change controlloUtente vale ')
            // console.log(this.controlloUtente)


            console.log(' 2 prima dello switch step vale ')
            console.log(this.step)

            console.log(' 3 prima dello switch controlloUtente vale ')
            console.log(this.controlloUtente)

            switch (this.controlloUtente) {
                case false:
                    this.step = 1
                    console.log('3.1 sono gestore')
                    break;
                case true:
                    // conso
                    if (this.dataFine == '' || this.dataOdierna == '' || this.tagliaStanza == '') {
                        console.log('3.2 errore, dati vuoti, sono cliente')
                        return
                    }
                    else {
                        this.step = 1
                        console.log('3.3 errore step vale' + this.step + 'sono cliente')

                    }

                    break;
            }
            console.log('4 dopo lo switch step vale ')
            console.log(this.step)
            console.log('5 dopo dello switch controlloUtente vale ')
            console.log(this.controlloUtente)

            await $fetch("/api/reservation/searchRoom", {
                method: "POST",
                body: {
                    controlloUtente: this.controlloUtente,
                    tagliaStanza: this.tagliaStanza,
                    dataInizio: this.dataOdierna,
                    dataFine: this.dataFine,
                }
            })
                .then((data) => {
                    this.stanza = data as Stanza[];
                    console.log('stanza vale ')
                    console.log(this.stanza);
                })
                .catch((e) => alert(e));
        },

        insertReservation(idStanza: number) {
            $fetch("/api/reservation/insertReservation", {
                method: "POST",
                body: {
                    dataFine: this.dataFine,
                    dataInizio: this.dataOdierna,
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
        //prendo la stanza quando l'utente clicca su seleziona
        getUserRoom(idStanza: number) {
            console.log(" prima idstanza vale" + idStanza);
            this.step = 2;
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
        this.selettoreInputDataInizio = document.querySelector("#dataInizio");
        this.selettoreInputDataFine = document.querySelector("#dataFine");
        // document.querySelector("#dataFine")
        console.log('selettore input vale')
        console.log(this.selettoreInputDataInizio)
        console.log(this.selettoreInputDataFine)
        if (this.user?.ruolo == 'cliente') {

            this.date();
            this.getAllRooms(true)
        }
        else if (this.user?.ruolo == 'gestore') {

            this.getAllRooms(false)
            console.log(this.user)
            // this.step = 1

        }
    },
    // beforeRouteUpdate
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
                <ul v-if="user?.ruolo == 'cliente'" class="grid-item-aside-ul">
                    <li>Data inizio soggiorno:
                        <input v-model="dataOdierna" type="date" id="dataInizio" @change="date()">
                    </li>
                    <li>Data fine soggiorno:
                        <input v-model="dataFine" type="date" id="dataFine" @change="date()">
                    </li>
                    <li>Tipologia stanza
                        <select id="tipologiaStanza" v-model="tagliaStanza">
                            <option v-for="option in options" :key="option.value" :value="option.value">{{
                                option.value
                            }}</option>
                        </select>
                    </li>
                    <button @click="getAllRooms(true)">CERCA</button>

                </ul>
                <div v-else>
                    <h2>Aggiungi una nuova stanza</h2>
                    <p>
                        Prezzo a notte
                    </p>
                    <input type="text" v-model="prezzoAnotte" />
                    <p>
                        Immagine della stanza
                    </p>
                    <input type="file" />
                    <p>
                        Taglia della stanza
                    </p>
                    <select v-model="tagliaStanza">
                        <option v-for="option in options" :key="option.value" :value="option.value">
                            {{ option.value }}
                        </option>
                    </select>
                    <p>
                        Tipologia della stanza
                    </p>
                    <select style="display: block;" v-model="tipologiaStanza">
                        <option v-for="option in scelte" :key="option.value" :value="option.value">
                            {{ option.value }}
                        </option>
                    </select>

                    <button @click.prevent="insertRoom()">
                        inserisci stanza
                    </button>
                </div>

                <!-- <AddRoom v-else>

                </AddRoom> -->
            </aside>
        </div>
        <div v-show="(step == 1) || (step == 2)" class="grid-item-table table">

            <h3 v-if="user?.ruolo == 'cliente'">Elenco stanze nel periodo {{
                new Date(dataOdierna).toLocaleDateString() + ' - ' + new
                    Date(dataFine).toLocaleDateString()
            }}</h3>
            <h3 v-else>
                Elenco di tutte le Stanze
            </h3>
            <table class="">
                <thead class="grid-item-thead">
                    <tr>
                        <th>Immagine</th>
                        <th>Descrizione</th>
                        <th>Prezzo</th>
                        <th v-if="user?.ruolo == 'cliente'">Aggiungi</th>
                        <th v-else>Elimina stanza</th>

                    </tr>
                </thead>
                <tbody class="grid-item-tbody">
                    <input type="checkbox" id="imageZoom">

                    <tr v-for="x in stanza" class="grid-item-tr">
                        <td>
                            <img :src="'img/' + x.imgStanza" @click="" alt="imgBedrrom">

                            <label for="imageZoom" @click.self="zoomContainer(x.idStanza, true)">zoomIn</label>
                        </td>
                        <td>{{ x.tagliaStanza + ' ' + x.tipologiaStanza }}</td>
                        <td>{{ x.prezzoAnotte }}</td>
                        <td v-if="user?.ruolo == 'cliente'" @click.self="getUserRoom(x.idStanza)">&#10133</td>
                        <td v-if="user?.ruolo == 'gestore'">
                            <button @click.prevent="deleteRoom(x.idStanza)">
                                &#10060
                            </button>
                        </td>


                    </tr>
                </tbody>
            </table>
        </div>
        <div v-show="step == 2" class="grid-item-section section">
            <h3>Riepilogo</h3>
            <section v-if="user?.ruolo == 'cliente'">

                <table>
                    <thead class="grid-item-thead">
                        <tr>
                            <th>Stanza</th>
                            <th>Prezzo Totale</th>
                            <th>Conferma</th>
                        </tr>
                    </thead>
                    <tbody class="grid-item-tbody">

                        <tr v-for="x in stanzaScelta" class="grid-item-tr" @click="">
                            <td>{{ x.tagliaStanza + ' ' + x.tipologiaStanza }}</td>
                            <td>{{ x.prezzoAnotte }}</td>
                            <td>
                                <button v-if="user?.ruolo == 'cliente' && controlloPrenotazione"
                                    @click="insertReservation(x.idStanza)">Prenota</button>
                            </td>

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
    // height: auto;
    border: 1px solid black;
    // border-radius: 10px;
    // aspect-ratio: auto;
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





.grid-container-main {
    display: grid;


}


.grid-item-aside {
    display: grid;

    ul {
        display: flex;
        flex-direction: column;
        padding: 0;
        margin: 0;

        li {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            list-style: none;
            margin: 5% 0%;

            input,
            select {
                // width: 40%;
            }
        }

        button {
            align-self: center;
            width: 40%;
        }

        // padding: 5% 10% 0%;
    }
}

//ELENCO STANZE
.grid-item-table {
    display: grid;

    table {

        thead {
            tr {
                display: grid;
                grid-template-columns: repeat(4, 25%);
                justify-content: space-evenly;
            }
        }

        tbody {
            // display: grid;

            tr {
                display: grid;
                grid-template-columns: repeat(4, 25%);
                align-items: center;



                td {
                    text-align: center;
                    overflow-wrap: break-word;

                    label {
                        display: none;
                    }
                }

                td:nth-child(4) {
                    cursor: pointer;
                }
            }


        }

        td:nth-child(1):hover {
            // cursor: zoom-in;

            label {
                display: block;
                cursor: zoom-in;
            }

        }
    }
}

.grid-item-section {
    display: grid;

    table {
        display: grid;
        grid-template-columns: repeat(2, auto);
        justify-content: center;


        thead {

            tr {
                display: flex;
                flex-direction: column;
                // align-items: flex-start;
                grid-template-rows: repeat(3, auto);
                justify-content: space-evenly;

            }
        }

        tbody {
            display: grid;
            // grid-template-columns: ;

            tr {
                display: flex;
                flex-direction: column;
                grid-template-columns: repeat(3, 33.3%);
            }


            align-items: center;


            // align-items: flex-end;
            td {
                // width: 33.3%;
                // align-items: flex-end;

                text-align: right;


                // background-color: black;
                label {
                    display: none;
                }
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
            cursor: zoom-in;

            label {
                display: block;
                cursor: zoom-in;
            }

        }
    }
}
</style>