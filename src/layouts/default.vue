<script lang="ts">
import { Utente } from "~/types"

export default defineComponent({
  // Fornisce l'oggetto utente a tutti i componenti dell'applicativo
  provide() {
    return {
      user: computed(() => this.utente)
    }
  },
  data() {
    return {
      utente: null as Utente | null
    }
  },
  methods: {
    async getUtente() {
      const user = await $fetch("/api/auth/profilo")
      this.utente = user
    },
    async logout() {
      await $fetch("/api/auth/logout").then((response) => alert(response.message)).then(() => window.location.href = "/") 
      this.getUtente()
    }
  },
  mounted() {
    this.getUtente()
  }
})
</script>

<template>
  <Head>
    <Title>Astra</Title>
  </Head>
    <nav id="nav">
        <button class="nav-buttons">
            <NuxtLink class="nuxt-link" to="/">Home</NuxtLink>
        </button>

        <button class="nav-buttons" v-if="!utente">
            <NuxtLink class="nuxt-link" to="/login">Login</NuxtLink>
        </button>
        <button class="nav-buttons" v-else>
            <NuxtLink class="nuxt-link" to="/" @click.prevent = "logout">Logout</NuxtLink>
        </button> 

        <button class="nav-buttons" v-if="utente">
            <NuxtLink class="nuxt-link" to="/rooms">Stanze disponibili</NuxtLink>
        </button>

        <button class="nav-buttons" >
            <NuxtLink class="nuxt-link" to="/reviews">Cosa pensano di noi</NuxtLink>
        </button>
    </nav>
    <div class="background-image">
    </div>
    <main id="centerPage">
        <slot></slot>
    </main>
    <footer class="footer">Contatti: astraHotel@gmail.com	+393888958648</footer>
</template>


<style lang="scss">
@import '../assets/styles/global.scss';
.nav-buttons{
  max-width: 180px ;
  font-weight: bold;
  border: solid gray;
  border-radius: 10px;
  cursor: pointer;
  font-size: 11px;
}

</style>