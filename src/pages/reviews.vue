<script lang="ts">
import { Recensione } from '../types'
import { Utente } from '../types'

export default defineComponent({
    // setup() {
    //     return {
    //         utente: inject('utente') as Utente,
    //     }
    // },
    data() {
        return {
            utente: [] as Utente[],
            recensione: [] as Recensione[],
            dataRecensione: '' as string,
            testoRecensione: '' as string,
            votoRecensione: '',
            options: [
                { value: '1 stellina' },
                { value: '2 stellina' },
                { value: '3 stellina' },
                { value: '4 stellina' },
                { value: '5 stellina' },
            ], 
        }
    },
    methods: {
        getRecensione() {
            $fetch("/api/reviews/getReviews").then((data) => { this.recensione = data as Recensione[]})
        },
        getUtente(){
            $fetch("/api/reviews/getUtenti").then((data) => { this.utente = data as Utente[] })  
        }
    },
    mounted() {
        this.getRecensione();
        this.getUtente();
    }
})

</script>

<template>
    <div class="flex-container" >
        <div v-for="x in utente">
            <img class="profile-picture" :src=" 'img/' + x.imgProfilo">
            <p class="profile-name">{{ x.nome + '' + x.cognome }}</p>
        </div>
        <div class="text-conteiner" v-for = "y in recensione">
            <p>{{y.dataRecensione.split('T')[0].split('-').reverse().toString().replaceAll(',','/')}}</p>
            <p>{{y.testoRecensione}}</p>
            <img class="stars-review" :src="'img/stars/' + y.votoRecensione" >
        </div>
    </div>

    <div v-for="x in utente">
        <img class="profile-picture" :src=" 'img/' + x.imgProfilo">
        <p class="profile-name">{{ x.nome + '' + x.cognome }}</p>
        <input type="text" placeholder="Inserisci la tua recensione">
    </div>
</template>

<style lang="scss" scoped>
p {
    margin: 0;
    padding: 0;
}

.flex-container {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-left: 20px;
}

.stars-review{
    max-width: 300px;
}

.profile-picture {
    width: 70px;
    height: 70px;
    object-fit: cover;
    border-radius: 50px;
    margin-bottom: 50px;
}

.text-conteiner {
    width: 300px;
    margin-left: 10px;
}

.profile-name {
    font-weight: bold;
    padding-bottom: 5px;
    font-size: 18px;
    margin-top: 10px;
}

.profile-description {
    color: rgb(150, 150, 150);
    padding-bottom: 5px;
    font-size: 18px;
}

.profile-category {
    color: rgb(150, 150, 150);
}

.follow-button {
    background-color: rgb(2, 139, 237);
    color: white;
    border: none;
    font-weight: bold;
    padding-top: 10px;
    padding-bottom: 10px;
    padding-left: 15px;
    padding-right: 15px;
    border-radius: 5px;
    cursor: pointer;
}
</style>