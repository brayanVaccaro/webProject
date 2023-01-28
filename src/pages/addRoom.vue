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
            idStanza: [] as number[],
            prezzoAnotte: '' as string,
            imgStanza: '' as string,
            tagliaStanza: '' as string,
            tipologiaStanza: '' as string,
            dataSoggiornoGiusta: ['', ''] as string[],
            selettoreInputData: undefined as any,
            dataInizio: new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0] as string,
            dataFine: '' as string,
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
            scelte: [
                { value: 'matrimoniale' },
                { value: 'suite' },
                { value: 'vistaMare' },
            ],
            controlloPrenotazione: false as boolean,
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

        },
        insertRoom() {
            $fetch("/api/reservation/insertRoom", {
                method: "POST",
                body: {
                    idStanza: this.idStanza,
                    prezzoAnotte: this.prezzoAnotte,
                    tagliaStanza: this.tagliaStanza,
                    tipologiaStanza: this.tipologiaStanza,
                }
            })
                .then((response) => (alert(response.message)))
                .then(() => window.location.href = "/reservation")
                .catch((e) => (alert(e)))

        },

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
  <h2>Aggiungi una nuova stanza</h2>
    Prezzo a notte <input type="text" v-model="prezzoAnotte"/>
    Immagine della stanza <input type="file"/>
    Taglia della stanza <select v-model="tagliaStanza"> 
      <option v-for="option in options" :key="option.value" :value="option.value">
        {{ option.value }}
      </option>
    </select> 
    Tipologia della stanza <select v-model="tipologiaStanza">
      <option v-for="option in scelte" :key="option.value" :value="option.value">
        {{ option.value }}
      </option>
  </select>

  <button @click.prevent="insertRoom()">
    inserisci stanza 
  </button>
</template>