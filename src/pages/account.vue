<script lang="ts">
// import { userInfo } from 'os'
import { Utente, Review, Reservation, Stanza } from '../types'
definePageMeta({
  middleware: ["require-login"]
})
export default defineComponent({
  setup() {
    return {
      container: inject("container") as Stanza | null,
      user: inject("user") as Utente ,
    }
  },
  data() {
    return {
      review: [] as Review[],
      reservation: [] as Reservation[],
      imgStanza: '' as string,
      votoPulizia: '',
      votoRistorazione: '',
      votoAccoglienza: '',
      email: '' as string | undefined
    }
  },
  methods: {
    getUserReviews() {
      console.log('email user = ' + this.user.email)

      $fetch("/api/account/getUserReviews", {
        method: "POST",
        body: {
          email: this.user.email
        }
      }).then((data) => {
        this.review = data as Review[]
        console.log(this.review)
      })
    },
    getUserReservations() {
      console.log('email user = ' + this.user.email)
      $fetch("/api/account/getUserReservations", {
        method: "POST",
        body: {
          email: this.user.email
        }
      }).then((data) => {
        this.reservation = data as Reservation[]
        console.log(this.reservation)
      })
    },
     formatDate(time: string) {
      
    const data = new Date(time)
    const year = data.toLocaleString("default", { year: "numeric" });
    const month = data.toLocaleString("default", { month: "2-digit" });
    const day = data.toLocaleString("default", { day: "2-digit" });
    
    return `${day}/${month}/${year}`;
  } 
  },
  mounted() {

  this.getUserReviews();
  this.getUserReservations();
  console.log('')
}
})

</script>

<template >
  <div class="info-user">
    <img class="profile-img" :src="'img/' + user.imgProfilo">
    <div class="row">
      <p class="profile-data">Nome: {{ user.nome }}</p>
      <p class="profile-data">Cognome: {{ user.cognome }}</p>
      <p class="profile-data">Data di Nascita: {{
        " " +
           formatDate(user.dataNascita)
      }}</p>
      <p class="profile-data">Indirizzo email: {{ user.email }}</p>
      <p class="profile-data">Ruolo: {{ user.ruolo }}</p>
    </div>
  </div>

  <div v-if="user.ruolo == 'gestore'" class="review-history">
    <p>Ecco a te gestore la lista delle prenotazioni</p>
    <table>
      <tr>
        <th>Data inizio prenotazione</th>
        <th>Data fine prenotazione</th>
        <th>Immagine stanza</th>
        <th>Prezzo a notte</th>
        <th>Tipologia stanza</th>
        <th>Nome Cliente</th>
        <th>Cognome Cliente</th>
        <th>Data di nascita del Cliente</th>
        <th>Indirizzo email del Cliente</th>
      </tr>
      <tr v-for="x in reservation">
        <td>{{ formatDate(x.dataInizioPrenotazione) }}</td>
        <td>{{ formatDate(x.dataFinePrenotazione) }}</td>
        <td><img :src="'img/' + x.imgStanza"></td>
        <td>{{ x.tagliaStanza }}</td>

      </tr>
    </table>
  </div>

  <div v-else>
    <div class="review-history">
      <p>Storico recensione inserite da lei (Grazie per il suo feedback)</p>
      <table>
        <tr>
          <th>Data recensione</th>
          <th>Voto pulizia</th>
          <th>Voto ristorazione</th>
          <th>Voto acooglienza</th>
        </tr>
        <tr v-for="x in review">
          <td>{{ formatDate(x.dataRecensione) }}</td>
          <td><img :src="'img/stars/' + x.votoPulizia"></td>
          <td><img :src="'img/stars/' + x.votoRistorazione"></td>
          <td><img :src="'img/stars/' + x.votoAccoglienza"></td>
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
          <th>Prezzo a notte</th>
          <th>Tipologia stanza</th>
        </tr>
        <tr v-for="x in reservation">
          <td>{{ formatDate(x.dataInizioPrenotazione) }}</td>
          <td>{{ formatDate(x.dataFinePrenotazione) }}</td>
          <td><img :src="'img/' + x.imgStanza"></td>
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
  width: 100%;
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