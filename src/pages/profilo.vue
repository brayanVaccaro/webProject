<script lang="ts">
// import { userInfo } from 'os'
import { Utente, Review, Reservation } from '../types'

export default defineComponent({
  setup() {
    return {
      user: inject("user") as Utente | null
    }
  },
  data() {
    return {
      review: [] as Review[],
      utente: [] as Utente[],
      reservation: [] as Reservation[],
      dataRecensione: '' as string,
      votoPulizia: '',
      votoRistorazione: '',
      votoAccoglienza: ''
    }
  },
  method: {
    getReviews() {
      $fetch("/api/reviews/getReviews").then((data) => { this.review = data as Review[] })
    }
  },
  mounted() {
    this.getReviews();
  }
})

definePageMeta({
  middleware: ["require-login"]
})

</script>

<template >
  <img class="profile-img" :src="'img/' + user?.imgProfilo">
  <div class="info-user">
    <p class="profile-name">Nome:{{ " " + user?.nome }}</p>
    <p class="profile-name">Cognome:{{ " " + user?.cognome }}</p>
    <p class="profile-name">Data di Nascita: {{
      " " +
        user?.dataNascita.split("T")[0].split("-").reverse().toString().replaceAll(',', '/')
    }}</p>
    <p class="profile-name">Indirizzo email: {{ " " + user?.email }}</p>
  </div>

  <p>Storico recensione inserite da lei (Grazie per il suo feedback)</p>
  <table>
    <tr>
      <th>Data recensione</th>
      <th>Voto pulizia</th>
      <th>Voto ristorazione</th>
      <th>Voto acooglienza</th>
    </tr>
    <tr v-for="x in review">
      <td>{{x.dataRecensione}}</td>
      <td>{{x.votoPulizia}}</td>
      <td>{{x.votoRistorazione}}</td>
      <td>{{x.votoAccoglienza}}</td>
    </tr>
  </table>

  <p>Storico delle sue prenotazioni</p>
  <table>
    <tr>
      <th>Data inizio prenotazione</th>
      <th>Data fine prenotazione</th>
      <th>Immagine stanza</th>
      <th>Taglia stanza</th>
    </tr>
    <tr v-for="x in reservation">
      <td>{{x.dataInizioPrenotazione}}</td>
      <td>{{x.dataFinePrenotazione}}</td>
      <td>{{x.imgStanza}}</td>
      <td>{{x.tagliaStanza}}</td>
    </tr>
  </table>
</template>

<style>
.profile-img {
  border-radius: 10px;
  width: 500px;
  object-fit: cover;
}

.info-user {
  border: solid 1px rgb(200, 200, 200);
  border-radius: 7px;
  display: inline-block;
  width: 500px;

}

.profile-name {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  font-size: 30px;
}

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 50%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>