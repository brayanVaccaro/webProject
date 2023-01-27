<script lang="ts">
import { Utente } from "~/types"

export default defineComponent({
    // Fornisce l'oggetto utente a tutti i componenti dell'applicativo

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
        <div id="row-1">

            <img class="logo-img" src="/img/logo_transparent.png">
            <div class="grid-container-head">

                <h1 class="head-element" v-if="!utente">Benvenuto nel sito dell'hotel Astra</h1>
                <h1 class="head-element" v-if="utente?.ruolo == 'gestore'">Bentornato gestore {{ utente?.nome + " " +
                utente?.cognome }} nel tuo sito dell'hotel Astra</h1>
                <h1 class="head-element" v-if="utente?.ruolo == 'cliente'">Bentornato {{
                    utente.ruolo + " " + utente?.nome + "" + utente?.cognome
                }} nel sito dell'hotel Astra</h1>
                <p class="head-element" v-if="!utente">
                    Prenota con noi e passa il miglior tempo della tua estate qui a Gallipoli, la città del divertimento
                </p>
                <p class="head-element" v-else>Per vedere le nostre stanze disponibili e passare il miglior tempo delle
                    tue
                    vacanze
                    premi qui<a href="\rooms" style="display:contents;"> Prenotazioni</a> <br>
                    Se invece hai già eseguito una prenotazione e vuoi controllare i dati premi qua<a href="\profilo "
                        style="display:contents;"> Profilo</a></p>
            </div>

        </div>
        <div id="row-2">
            <div class="history-container">
                <p>
                    La nostra storia:
                </p>
                <p>
                    Lorem ipsum dolor sit, amet consectetur adipisicing elit.
                    Aperiam placeat illum enim, corrupti fuga provident nostrum aliquid vero molestiae aut omnis ab!
                    Illo minus temporibus rem consequuntur aspernatur voluptates? Iste commodi officiis magni porro
                    cumque ullam repellat repellendus nobis, in, saepe qui! Blanditiis placeat accusantium deserunt nam
                    pariatur consectetur eius earum excepturi, sint modi dicta impedit expedita vitae culpa eaque illo?
                    Vero aspernatur, asperiores cumque possimus soluta culpa beatae reprehenderit repellat, officiis
                    non, eos illo delectus mollitia. Eligendi reiciendis voluptatem impedit ratione iste dicta soluta
                    est nobis, saepe inventore, nesciunt voluptas. Ipsum nulla corrupti perferendis labore modi, cumque
                    debitis? Maxime.
                </p>
            </div>
            <div class="map-container">
                <p>Dove ci troviamo?</p>
                <iframe width="100%" height="100%" scrolling="no" marginheight="0" marginwidth="0"
                    src="https://maps.google.com/maps?width=100%25&amp;height=100%&amp;hl=en&amp;q=gallipolli,%20via%20xx%20settembre%20numero%2015+(My%20Business%20Name)&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed">
                </iframe>
            </div>
        </div>
    </div>

</template>

<style lang="scss" scoped>
#contenutoStanza {
    display: flex;
    justify-content: center;
}

//INDEX PAGE

#index {
    display: grid;
    // grid-template-rows: 1fr auto;

    margin: 2% 0;
    h1 {
        font-size: 1.5em;
    }

    // grid-template-rows: 30% 70%;
    // grid-column: 2, auto;

    #row-1 {
        display: flex;
        
        // flex-direction: column;
        // margin-bottom: 1%;
        // height: 100%;
        // width: 100%;

        img {
            // display: flex;
            // max-width: 100%;
            aspect-ratio: 1/1;
            // height: 70%;
        }

        .grid-container-head {
            // height: 30%;
            display: flex;
            flex-direction: column;
            // justify-content: center;

            .head-element {
                text-align: center;
                margin: 0;
            }
        }


    }

    #row-2 {
        display: flex;
        // margin: 1% 0;

        .history-container {
            display: flex;
            flex-direction: column;
            // width: 45%;
            p:nth-child(1) {
                margin: 2%;
            }
            p:nth-child(2) {
                margin: 0% 0% 2% 5%;
            }
        }

        .map-container {
            display: flex;
            flex-direction: column;
            p:nth-child(1) {
                margin: 2%;
            }
            // height: 60%;

            // width: 55%;
            // margin-left: 15%;
            
        }

        .map-container iframe {
            // width: auto;
            // display: grid;

        }

    }








}




.grid-container-main {
    // display: grid;
}
</style> 