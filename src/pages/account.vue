<script lang="ts">
// import { userInfo } from 'os'
import getUserReservations from '../server/api/account/getUserReservations'
import { Utente, Review, Reservation, Stanza } from '../types'
definePageMeta({
  middleware: ["require-login"]
})
export default defineComponent({
  setup() {
    return {
      container: inject("container") as Stanza | null,
      user: inject("user") as Utente,
    }
  },
  data() {
    return {
      review: [] as Review[],
      reservation: [] as Reservation[],
      imgStanza: '' as string,
      idStanza: [] as number[],
      contatore: 0 as number,
      votoPulizia: '',
      votoRistorazione: '',
      votoAccoglienza: '',
      email: '' as string | undefined
    }
  },
  methods: {
    getUserReviews() {
      console.log('email user = ' + this.user.email)
      console.log('email containier = ' + this.container)

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
    async getUserReservations1() {
      // console.log('1 email user = ' + this.user.email)
      await $fetch("/api/account/getUserReservations", {
        method: "POST",
        body: {
          email: this.user.email
        }
      }).then((data) => {
        this.reservation = data as Reservation[]
        console.log('3 reservation.lenght vale: : ' + this.reservation.length)
        console.log('2 idStanza vale: ' + this.reservation[0].idStanza)
        console.log('2 idStanza vale: ')
        console.log(this.reservation)
        console.log(this.reservation[2])
      })

      for (let i = 0; i < this.reservation.length; i++) {
        this.idStanza[i] = this.reservation[i].idStanza
      }
    },
    async getUserReservations2() {

      for (let i = 0; i < this.idStanza.length; i++) {
        await $fetch("/api/reservation/getUserRoom", {
          method: "POST",
          body: {
            id: this.idStanza[i]
          }
        }).then(() => {
          // this.reservation[].prezzoAnotte
          console.log('7 reservation con stanze: ')
          console.log(this.reservation)
        })
      }
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
    this.getUserReservations1();
    this.getUserReservations2();
    console.log('')
  }
})

</script>

<template >
  <div class="info">
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

  <div v-else class="review-history">
    <p>Storico recensione inserite da lei (Grazie per il suo feedback)</p>
    <table>
      <thead>
        <th>Data</th>
        <th>Pulizia</th>
        <th>Ristorazione</th>
        <th>Accoglienza</th>
      </thead>
      <tbody>
        <tr v-for="x in review">
          <td>{{ formatDate(x.dataRecensione) }}</td>
          <td><img :src="'img/stars/' + x.votoPulizia"></td>
          <td><img :src="'img/stars/' + x.votoRistorazione"></td>
          <td><img :src="'img/stars/' + x.votoAccoglienza"></td>
        </tr>
      </tbody>
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
        <td>{{ x.idStanza }}</td>
      </tr>
    </table>
  </div>
</template>

<style lang="scss" scoped>
img {
  max-width: 10%;
}

.info {
  display: flex;

  border: solid 1px rgb(200, 200, 200);
  border-radius: 7px;



  .row {
    display: flex;
  }

  .profile-data {
    display: flex;
  }

}

.review-history {
  table {
    display: grid;
    border-collapse: collapse;

    thead {
      display: flex;
    }

    tbody {
      display: flex;

      tr {
        display: flex;
      }
    }
  }
}



// table {
//   font-family: arial, sans-serif;
//   border-collapse: collapse;
//   // width: 100%;
// }

// td,
// th {
//   border: 1px solid #dddddd;
//   text-align: left;
//   padding: 8px;
// }

// tr:nth-child(even) {
//   background-color: #dddddd;
// }
</style>