<script lang="ts">

import { Utente, Review, Reservation, Stanza } from '../types'
definePageMeta({
  middleware: ["require-login"]
})
export default defineComponent({
  setup() {
    return {
      user: inject("user") as Utente,
    }
  },
  data() {
    return {
      review: [] as Review[],
      reservation: [] as Reservation[],
      idStanza: [] as number[],
      controllo: 0 as number,
    }
  },
  methods: {
    getUserReviews() {
      console.log('email user = ' + this.user.email)
      if (this.user.ruolo == 'gestore') {
        return
      }

      $fetch("/api/account/getUserReviews", {
        method: "POST",
        body: {
          email: this.user.email
        }
      }).then((data) => {
        this.review = data as Review[]
        console.log('review vale')
        console.log(this.review)
      })
    },
    async getUserReservations1() {
      // console.log('1 email user = ' + this.user.email)
      if (this.user.ruolo == 'cliente') {
        this.controllo = 1
      }
      await $fetch("/api/account/getUserReservations", {
        method: "POST",
        body: {
          email: this.user.email,
          controllo: this.controllo
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
      console.log('qua funziona')
      for (let i = 0; i < this.idStanza.length;) {
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

        // this.reservation.forEach(x => console.log('ciao' + x.email))
        i++;
      }

    },


    formatDate(time: string) {

      const data = new Date(time)
      const year = data.toLocaleString("default", { year: "2-digit" });
      const month = data.toLocaleString("default", { month: "2-digit" });
      const day = data.toLocaleString("default", { day: "2-digit" });

      return `${day}/${month}/${year}`;
    },
    deleteReservation(idPrenotazione: number){
            $fetch("/api/account/deleteReservation", {
                method: "POST",
                body: {
                    idPrenotazione: idPrenotazione
                }

            })
                .then((response) => (alert(response.message)))
                .then(() => window.location.href = "/")
                .catch((e) => (alert(e)))

        },
  },
  mounted() {

    this.getUserReviews();
    this.getUserReservations1();
    this.getUserReservations2();
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


<!-- se sono cliente vedo le mie recensioni -->
  <div v-if="user.ruolo == 'cliente'" class="review-history">
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
<!-- se sono gestore vedo tutte le prenotazioni -->
  <div v-if="user.ruolo == 'gestore'" class="reservation-history-gestore">
    <p>Ecco a te gestore la lista di tutte le prenotazioni</p>
    <table>
      <thead>
        <th>Elimina</th>
        <th>Data Inizio</th>
        <th>Data Fine</th>
        <th>Email</th>
        <th>Immagine</th>
      </thead>
      <tbody>
        <tr v-for="x in reservation">
          <td>
            <button @click.prevent="deleteReservation(x.idPrenotazione)">
              Elmina prenotazione
            </button>
          </td>
          <td>{{ formatDate(x.dataInizioPrenotazione) }}</td>
          <td>{{ formatDate(x.dataFinePrenotazione) }}</td>
          <td>{{ x.email }}</td>
          <td><img :src="'img/' + x.imgStanza"></td>
        </tr>
      </tbody>
    </table>
  </div>

  <div v-else class="reservation-history-cliente">
    <p>Storico delle sue prenotazioni</p>
    <table>
      <thead>
        <th>Data inizio</th>
        <th>Data fine</th>
        <th>Prezzo a notte</th>
        <th>Descrizione</th>
        <th>Immagine</th>
      </thead>
      <tbody>
        <tr v-for="x in reservation">
          <td>{{ formatDate(x.dataInizioPrenotazione) }}</td>
          <td>{{ formatDate(x.dataFinePrenotazione) }}</td>
          <td>{{ x.prezzoAnotte }}</td>
          <td>
            {{ x.tagliaStanza + ' ' + x.tipologiaStanza }}
          </td>
          <td><img :src="'img/' + x.imgStanza"></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style lang="scss" scoped>
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
    // display: grid;
    border-collapse: collapse;

    thead {
      display: flex;
    }

    tbody {
      display: flex;

      tr {
        display: flex;

        td {
          font-size: small;

          // display: flex;
          img {
            max-width: 100%;
          }
        }
      }
    }
  }
}

.reservation-history-cliente {
  table {
    display: grid;
    border-collapse: collapse;

    thead {
      display: grid;
      grid-template-columns: repeat(5,auto);
    }

    tbody {
      display: grid;
      // grid-template-columns: repeat(5,25%);

      tr {
        display: grid;
        grid-template-columns: repeat(5, 20%);
        // justify-content: space-between;
        border: 1px solid red;
        align-items: center;

      



        td {
          text-align: center;
          font-size: small;

          img {
            max-width: 100%;

          }
        }
      }
    }
  }
}

.reservation-history-gestore{
  table {
    display: grid;
    border-collapse: collapse;

    thead {
      display: grid;
      grid-template-columns: repeat(5,auto);
    }

    tbody {
      display: grid;
      // grid-template-columns: repeat(5,25%);

      tr {
        display: grid;
        grid-template-columns: repeat(5, 20%);
        // justify-content: space-between;
        border: 1px solid red;
        align-items: center;

        td {
          text-align: center;
          font-size: small;

          img {
            max-width: 100%;

          }
        }
      }
    }
  }
}
</style>