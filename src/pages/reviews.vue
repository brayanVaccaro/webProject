<script lang="ts">
import { userInfo } from 'os'
import { Recensione, Utente, Review } from '../types'

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
            recensione: [] as Recensione[],
            dataRecensione: '' as string,
            votoPulizia: '',
            votoRistorazione: '',
            votoAccoglienza: '',
            scelte: [
                { value: '5stellina' },
                { value: '4stellina' },
                { value: '3stellina' },
                { value: '2stellina' },
                { value: '1stellina' },
            ],
        }
    },
    methods: {
        getReviews() {
            $fetch("/api/reviews/getReviews").then((data) => { this.review = data as Review[] })
        },
        insertReviews(){
            $fetch("/api/reviews/insertReviews",{
                method: "POST",
                body: {
                    votoPulizia: this.votoPulizia + '.png',
                    votoRistorazione: this.votoRistorazione + '.png',
                    votoAccoglienza: this.votoAccoglienza + '.png',
                    idUser: this.user?.idUtente
                }
                
            })
            .then(() => { window.location.href = "/reviews"; })
            .catch((e) => alert(e))
        }
        
    },
    mounted() {
        this.getReviews();
    }
})

</script>

<template>

    <div class="prova">
        <div v-for="x in review" class="review-preview">
            <div class="info-user">
                <img class="profile-img" :src="'img/' + x.imgProfilo">
                <p class="video-title">
                    {{ x.nome + " " + x.cognome }}
                </p>
                <p class="video-stats">
                    {{ x.dataRecensione.split("T")[0].split("-").reverse().toString().replaceAll(',', '/') }}
                </p>
            </div>
            <div>
                <p class="review-valutation">Pulizia:</p>
                <img class="stars" :src="'img/stars/' + x.votoPulizia"> <br>
                <p class="review-valutation">Ristorazione:</p>
                <img class="stars" :src="'img/stars/' + x.votoRistorazione"> <br>
                <p class="review-valutation">Accoglienza:</p>
                <img class="stars" :src="'img/stars/' + x.votoAccoglienza"> <br>
            </div>
        </div>
    </div>

    <div v-if="user">
        <div class="info-user">
            <img class="profile-img" :src="'img/' + user?.imgProfilo">
            <p class="profile-name">{{ user?.nome + ' ' + user?.cognome }}</p>
        </div>
        <div class="review-insertion">
            <p class="review-question">Come valuti la nostra pulizia?</p>
            <select v-model="votoPulizia">
                <option v-for="option in scelte" :key="option.value" :value="option.value">
                    {{ option.value }}
                </option>
            </select>
            <p class="review-question">Come valuti la nostra Ristorazione?</p>
            <select v-model="votoRistorazione">
                <option v-for="option in scelte" :key="option.value" :value="option.value">
                    {{ option.value }}
                </option>
            </select>
            <p class="review-question">Come valuti la nostra Accoglienza?</p>
            <select v-model="votoAccoglienza">
                <option v-for="option in scelte" :key="option.value" :value="option.value">
                    {{ option.value }}
                </option>
            </select>
        </div>
        <button @click.prevent="insertReviews()">
            Invia
        </button>
    </div>
</template>

<style lang="scss" scoped>
.review-preview {
    display: flex;
    flex-direction: row;
    margin-bottom: 3%;
}

.stars {
    width: 200px;
}

.review-valutation {
    display: inline-block;
}

p {
    margin: 0;
    padding: 0;
}




.video-title {
    margin-top: 0;
    font-size: 14px;
    font-weight: 500;
    line-height: 20px;
    margin-bottom: 12px;
}


.profile-img {
    border-radius: 50px;
    width: 70px;
    height: 70px;
    object-fit: cover;
}

.video-author,
.video-stats {
    font-size: 12px;
    color: rgb(96, 96, 96);
}
</style>