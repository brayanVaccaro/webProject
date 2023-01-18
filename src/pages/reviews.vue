<script lang="ts">
import { Recensione } from '../types'
import { Utente } from '../types'

export default defineComponent({
    provide() {
        return {
            user: computed(() => this.user)
        }
    },
    data() {
        return {
            user: null as Utente | null,
            utente: [] as Utente[],
            recensione: [] as Recensione[],
            dataRecensione: '' as string,
            votoPulizia: '',
            scelte: [
                { value: '5 stellina' },
                { value: '4 stellina' },
                { value: '3 stellina' },
                { value: '2 stellina' },
                { value: '1 stellina' },
            ],
            votoRistorazione: '',
            options: [
                { value: '5 stellina' },
                { value: '4 stellina' },
                { value: '3 stellina' },
                { value: '2 stellina' },
                { value: '1 stellina' },
            ],
            votoAccoglienza: '',
            opzioni: [
                { value: '5 stellina' },
                { value: '4 stellina' },
                { value: '3 stellina' },
                { value: '2 stellina' },
                { value: '1 stellina' },
            ],
        }
    },
    methods: {
        getRecensione() {
            $fetch("/api/reviews/getReviews").then((data) => { this.recensione = data as Recensione[] })
        },
        getUtente() {
            $fetch("/api/reviews/getUtenti").then((data) => { this.utente = data as Utente[] })
        },
        async getUser() {
            const user = await $fetch("/api/auth/profilo")
            this.user = user
        },
        async logout() {
            await $fetch("/api/auth/logout").then((response) => alert(response.message)).then(() => window.location.href = "/")
            this.getUser()
        }
    },
    mounted() {
        this.getRecensione();
        this.getUtente();
        this.getUser()
    }
})

</script>

<template>
    <div v-for="x in utente" class="review-preview">
      <div v-for="y in recensione" class="thumbnail-row">
        <p class="review-valutation">Pulizia:</p>
        <img class="stars" :src="'img/stars/' + y.votoPulizia" > <br>
        <p class="review-valutation">Ristorazione:</p>
        <img class="stars" :src="'img/stars/' + y.votoRistorazione" > <br>
        <p class="review-valutation">Accoglienza:</p>
        <img class="stars" :src="'img/stars/' + y.votoAccoglienza" > <br>
      </div>
      <div class="video-info-grid">
        <div class="profile-div">
          <img class="profile-img" :src="'img/' + x.imgProfilo">
        </div>
        <div class="video-info">
          <p class="video-title">
            {{ x.nome + " " + x.cognome }}
          </p>
          <p v-for="y in recensione" class="video-stats">
            {{ y.dataRecensione.split("T")[0].split("-").reverse().toString().replaceAll(',', '/') }}
          </p>
        </div>
      </div>
    </div>

    <div v-if="user">
        <div class="review-insertion">
            <p class="review-question">Come valuti la nostra pulizia?</p>
            <select>
                <option v-for="option in scelte" :key="option.value" :value="option.value">
                    {{ option.value }}
                </option>
            </select>
        </div>
        <img class="profile-img" :src="user.imgProfilo"> 
        <p class="profile-name">{{ user.nome + ' ' + user.cognome }}</p>
    </div>
</template>

<style lang="scss" scoped>

.review-preview{
    display: grid;
    grid-template-columns: 300px 400px;
}
.stars{
    width: 200px;
}

.review-valutation{
    display: inline-block;
}

p {
    margin: 0;
    padding: 0;
}


.review-insertion{
    margin-top: 50px;
}

.thumbnail-row{
  margin-bottom: 12px;
}
.video-title{
  margin-top: 0;
  font-size: 14px;
  font-weight: 500;    
  line-height: 20px;
  margin-bottom: 12px;
}

.video-info{
    margin-left: 20px;
}
.video-info-grid{
  display: grid;
  grid-template-columns: 50px 1fr;
}
.profile-img{
  border-radius: 50px;
  width: 70px;
  height: 70px;
  object-fit: cover;
}

.video-author, .video-stats{
  font-size: 12px;
  color: rgb(96, 96, 96);
}
</style>