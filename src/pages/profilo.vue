<script lang="ts">
// import { userInfo } from 'os'
import { Utente, Review, Reservation } from '../types'
definePageMeta({
  middleware: ["require-login"]
})
export default defineComponent({
  setup() {
    return {
      user: inject("user") as Utente | null
    }
  },
  data() {
    return {
      review: [] as Review[],
      reservation: [] as Reservation[],
      // user: inject("user") as Utente,
      
      dataRecensione: '' as string,
      votoPulizia: '',
      votoRistorazione: '',
      votoAccoglienza: '',
      email: '' as string | undefined
    }
  },
  methods: {
    getReviewsByID() {
      $fetch("/api/reviews/getReviewsByID", {
        method: "POST",
        body: {
          email: this.user?.email
        }
      }).then((data) => { this.review = data as Review[]
      console.log(this.review) })
    }
  },
  mounted() {
    
    // this.email = this.user?.email
    // console.log('email vale'+this.email)
    this.getReviewsByID();
  }
})

</script>

<template >
  <div class="info-user">
    <img class="profile-img" :src="'img/' + user?.imgProfilo">
    <div class="row">
      <p class="profile-data">Nome: {{ user?.nome }}</p>
      <p class="profile-data">Cognome: {{ user?.cognome }}</p>
      <p class="profile-data">Data di Nascita: {{
        " " +
          user?.dataNascita.split("T")[0].split("-").reverse().toString().replaceAll(',', '/')
      }}</p>
      <p class="profile-data">Indirizzo email: {{  user?.email }}</p>
      <p class="profile-data">Ruolo: {{  user?.ruolo }}</p>      
    </div>
  </div>

  <div v-if="user?.ruolo=='gestore'" class="review-history">
    <p>Ecco a te gestore la lista delle prenotazioni</p>
    <table>
      <tr>
      <th>Data inizio prenotazione</th>
      <th>Data fine prenotazione</th>
      <th>Immagine stanza</th>
      <th>Taglia stanza</th>
    </tr>
    <tr v-for="x in reservation">
      <td>{{ x.dataInizioPrenotazione }}</td>
      <td>{{ x.dataFinePrenotazione }}</td>
      <td>{{ x.imgStanza }}</td>
      <td>{{ x.tagliaStanza }}</td>
    </tr>
    </table>
  </div>

<div v-else>
  <div  class="review-history">
    <p>Storico recensione inserite da lei (Grazie per il suo feedback)</p>
    <table>
      <tr>
        <th>Data recensione</th>
        <th>Voto pulizia</th>
        <th>Voto ristorazione</th>
        <th>Voto acooglienza</th>
      </tr>
      <tr v-for="x in review">
        <td>{{ x.dataRecensione }}</td>
        <td>{{ x.votoPulizia }}</td>
        <td>{{ x.votoRistorazione }}</td>
        <td>{{ x.votoAccoglienza }}</td>
      </tr>
    </table>
  </div>
  <div class="reservation-history">
    <p>Storico delle sue prenotazioni</p>
    <table>
      <tr>
        <th>Data inizio prenotazione</th>
        <th>Data fine prenotazione</th>
        <th>Immagine stanza</th>
        <th>Taglia stanza</th>
      </tr>
      <tr v-for="x in reservation">
        <td>{{ x.dataInizioPrenotazione }}</td>
        <td>{{ x.dataFinePrenotazione }}</td>
        <td>{{ x.imgStanza }}</td>
        <td>{{ x.tagliaStanza }}</td>
      </tr>
    </table>
  </div>
  </div>
</template>

<style lang="scss" scoped>

img {
  max-width: 100%;
  // padding: 5%;
  margin: auto;
}
.info-user {
  border: solid 1px rgb(200, 200, 200);
  border-radius: 7px;

}
.row {
  display: flex;
  flex-direction: column;
}
.profile-data {
  display: flex;
  flex-direction: row;
  font-size: 1em;
  margin: auto 0;
}

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 50%;
}

td,
th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>