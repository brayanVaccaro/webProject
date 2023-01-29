<script lang="ts">
// import { userInfo } from 'os'
import { use } from 'h3'
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
      controllo: 0 as number,
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
        console.log(this.review)
      })
    },
    async getUserReservations1() {
      // console.log('1 email user = ' + this.user.email)
      if (this.user.ruolo == 'gestore') {

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
    }
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
  <div v-if="user.ruolo == 'gestore'" class="reservation-history-gestore">
    <p>Ecco a te gestore la lista di tutte le prenotazioni</p>
    //table per la prenotazione ()
    <table>
      <thead id="">
        <tr class="col">
          <th>Stanza</th>
          <div id="inferiore-1">
            <th>Immagine</th>
            <th>Prezzo/notte</th>
            <th>Descrizione</th>
            <!-- <th>Tipologia</th>
            <th>Taglia</th> -->
          </div>
        </tr>
        <tr class="col">
          <th>Cliente</th>
          <div id="inferiore-2">
            <th>Nome</th>
            <th>Cognome</th>
            <th>Data di Nascita</th>
            <th>Email</th>

          </div>
        </tr>
        <tr class="col">
          <th>Info</th>
          <div id="inferiore-3">
            <th>Data Inizio</th>
            <th>Data Fine</th>
          </div>
        </tr>

      </thead>

      <tbody>
        <div id="Stanza">
          <tr v-for="x in reservation">

            <td><img :src="'img/' + x.imgStanza"></td>
            <td>{{ x.prezzoAnotte }}</td>
            <td>{{ x.tipologiaStanza + ' ' + x.tagliaStanza }}</td>

          </tr>
        </div>
        <div id="Cliente">
          <tr v-for="x in reservation">
            <td>{{ x.nome }}</td>
            <td>{{ x.cognome }}</td>
            <td>{{ formatDate(x.dataNascita) }}</td>
            <td>{{ x.email }}</td>
          </tr>
        </div>
        <div id="Info-Prenotazione">
          <tr v-for="x in reservation">
            <td>{{ formatDate(x.dataInizioPrenotazione) }}</td>
            <td>{{ formatDate(x.dataFinePrenotazione) }}</td>
          </tr>
        </div>
        <!-- <tr v-for="x in reservation">
          <td>{{ formatDate(x.dataInizioPrenotazione) }}</td>
          <td>{{ formatDate(x.dataFinePrenotazione) }}</td>
          <td>{{ x.tagliaStanza }}</td>
          <td><img :src="'img/' + x.imgStanza"></td>
        </tr> -->
      </tbody>

      <!-- <thead>
        <th>Tipologia stanza</th>
        
      </thead> -->

    </table>
  </div>
  <div v-else class="reservation-history-cliente">
    <p>Storico delle sue prenotazioni</p>
    <table>
      <thead>
        <th>Data inizio</th>
        <th>Data fine</th>
        <th>Prezzo</th>
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
      grid-template-columns: repeat(5, 20%);
      // justify-content: space-between;

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

        td:last-child {
          // width: 20%;
        }



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

.reservation-history-gestore {
  table {
    display: grid;

    border-collapse: collapse;

    thead {
      display: flex;
      // justify-content: space-between;

      .col {
        display: grid;
        grid-template-rows: repeat(2, auto); // justify-content: space-between;

        #inferiore-1 {
          th {
            // font-size: smaller;
          }
        }

      }


    }

    tbody {
      display: flex;
      flex-direction: row;
      grid-template-columns: repeat(3, 33.3%);
      
      #Stanza {
        display: grid;
        width: 37.12%;

        tr {
          display: flex;
          // grid-template-columns: repeat(3,auto);
          justify-content: space-between;
          align-items: center;

          td:first-child {
width: 33.3%;
          }



          td {
            text-align: center;
            font-size: small;

            img {
              max-width: 100%;
              margin: auto
            }
          }
        }
      }

      #Cliente {
        display: grid;
        width: 40.04%;


        tr {
          display: flex;
          // grid-template-columns: repeat(3,auto);
          justify-content: space-between;
          align-items: center;

          td {
            // width: 33.3%;
          }



          td {
            text-align: center;
            font-size: small;
          }
        }
      }

      #Info-Prenotazione {
        display: grid;
        width: 22.4%;


        tr {
          display: flex;
          // grid-template-columns: repeat(3,auto);
          justify-content: space-between;
          align-items: center;

          td {
            // width: 33.3%;
          }



          td {
            text-align: center;
            font-size: small;
          }
        }
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