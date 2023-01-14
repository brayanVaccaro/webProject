<!-- <script lang="ts">
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
</script> -->

<template>
    <div id="index">
        <!-- breve descrizione dell'hotel -->
        <!-- elenco delle stanze con le relative info -->
        <section id="contenutoStanza">
            <div>

            </div>
            <div class="grid-container">
                <!--v-if="!utente"--> <h1>Benvento nel sito dell'hotel Astra</h1>
                <!-- <h1 v-else>Bentornato .... nel sito dell'hotel Astra</h1> -->
                <p>L'unico hotel di Gallipoli che comprende tutte le sue tradizioni e la sua storia</p>
                <!--v-if="!utente" --><p class="ciao">Per usufruire del nostro sito e prenotare una stanza <a href="\login" style="display:contents;">registrarsi</a>
                </p>

                <div class="map-container">
                    <iframe width="100%" height="800" frameborder="0" scrolling="no"
                        marginheight="0" marginwidth="0"
                        src="https://maps.google.com/maps?width=100%25&amp;height=600&amp;hl=en&amp;q=gallipolli,%20via%20xx%20settembre%20numero%2015+(My%20Business%20Name)&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed">
                    </iframe>
                </div>
            </div>
            <div>
                <img class="logo-img" src="/img/logo_transparent.png">
            </div>
        </section>

    </div>

</template>

<style lang="scss" scoped>
#contenutoStanza {
    display: flex;
    justify-content: center;
    // background-color: red;
}

//INDEX PAGE


.map-container {
    width: 600px;
}

.ciao {
    display: inline-block;
}

.logo-img {
    display: inline-block;
    width: 800px;
    margin-bottom: none;
}
</style> 