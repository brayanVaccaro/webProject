<script lang="ts">
import { Utente } from "~/types"

export default defineComponent({
    // Fornisce l'oggetto utente a tutti i componenti dell'applicativo
    provide() {
        return {
            utente: computed(() => this.utente)
        }
    },
    data() {
        return {
            utente: null as Utente | null
        }
    },
    methods: {
        async getUtente() {
            const utente = await $fetch("/api/auth/profilo")
            this.utente = utente
        },
        async logout() {
            await $fetch("/api/auth/logout")
            this.getUtente()
        }
    },
    mounted() {
        this.getUtente()
    }
})
</script> 

<template>
    <div id="index">
        <div class="head-container">
            <h1 class="head" v-if="!utente">Benvento nel sito dell'hotel Astra</h1>
            <h1 class="head" v-else>Bentornato {{utente.nome + " " +utente.cognome}} nel sito dell'hotel Astra</h1>
            <p class="head" v-if="!utente">
                Prenota con noi e passa il miglior tempo della tua estate qui a Gallipoli, la città del divertimento
            </p>
            <p class="head" v-else>Per vedere le nostre stanze disponibili e passare il miglior tempo delle tue vacanze
                premi qui<a href="\rooms" style="display:contents;"> Prenotazioni</a> <br>
                Se invece hai già eseguito una prenotazione e vuoi controllare i dati premi qua<a href="\profilo "
                    style="display:contents;"> Profilo</a></p>
        </div>
        <div class="map-container">
            <p style="margin: 0; font-size: 20px">Dove ci troviamo?</p>
            <iframe width="600" height="500" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
            src="https://maps.google.com/maps?width=100%25&amp;height=600&amp;hl=en&amp;q=gallipolli,%20via%20xx%20settembre%20numero%2015+(My%20Business%20Name)&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed">
            </iframe>
        </div>
        <div class="history-container">
            <p class="story-text">La nostra storia: <br>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mi neque, pretium sed lorem non, tempus
            lobortis justo. Suspendisse magna metus, dignissim at aliquet non, dictum eget urna. Sed et felis et tellus
            varius bibendum. Nulla vel tempor sapien. Sed non felis nulla. Fusce urna urna, elementum in porta ac,
            semper ut mauris. Vivamus purus lectus, eleifend vel lorem vitae, sollicitudin elementum ligula.

            Duis vel libero ac justo convallis cursus eu quis ante. Nullam in ante pellentesque, vehicula dui quis,
            mattis turpis. Donec lobortis sapien vitae mattis finibus. Cras feugiat sit amet purus vel posuere. Etiam
            accumsan nulla nec aliquam placerat. Aliquam quis urna at massa malesuada fringilla. Proin mauris lectus,
            sollicitudin sit amet quam in, volutpat placerat lacus.

            Fusce hendrerit quam eu dui egestas, eu vestibulum eros molestie. Morbi malesuada molestie tellus at
            viverra. Nunc at facilisis ligula, a consequat libero. Quisque dignissim quis turpis quis vestibulum. Mauris
            at dignissim nisl. Maecenas consectetur, ipsum eget ultrices laoreet, lectus libero ultrices leo, a volutpat
            nunc sem eget tortor. Donec tellus magna, bibendum eget tempor in, consequat sit amet lorem. Phasellus at
            sodales tellus. Vestibulum ac imperdiet metus. Aenean a ex sit amet tortor luctus aliquet. Pellentesque nisl
            est, molestie vitae lorem non, laoreet congue nibh.

            Nunc non urna eget felis lobortis vestibulum. Vivamus et vehicula turpis. Maecenas finibus sit amet ante vel
            molestie. Nulla a sapien tellus. Nullam nec enim fringilla est mollis facilisis. Integer fringilla
            vestibulum neque, id sagittis ipsum varius eget. Proin sit amet mauris elit. Nunc lacus nisl, ultricies sit
            amet ipsum vitae, finibus convallis eros. Class aptent taciti sociosqu ad litora torquent per conubia
            nostra, per inceptos himenaeos. Quisque egestas cursus risus. Donec convallis est et dolor tempus, sit amet
            consequat velit placerat. Maecenas molestie metus pretium enim feugiat porttitor.</p>
        </div>
        <img class="logo-img" src="/img/logo_transparent.png">
    </div>

</template>

<style lang="scss" scoped>
#contenutoStanza {
    display: flex;
    justify-content: center;
}

//INDEX PAGE


.history-container{
    display: inline-block;
    margin-left: 50px;
}

.map-container{
    display: inline-block;
    margin-left: 10px;
}
.story-text{
    width: 500px;
    display: inline-block;
    text-align: center;
}


.head {
    text-align: center;
    margin: 0;
    margin-top: 5px;
    // display: inline-block;
}

.logo-img {
    margin-right: 20px;
    float: right;
    width: 123px;
}
</style> 