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
    <nav id="nav">
        <button>
            <NuxtLink to="/">Home</NuxtLink>
        </button>

        <button v-if="!utente">
            <NuxtLink to="/login">Login</NuxtLink>
        </button>
        <button v-else>
            <NuxtLink to="/login" @click.prevent = "logout">Logout</NuxtLink>
        </button>

        <button>
            <NuxtLink to="/rooms">Stanze disponibili</NuxtLink>
        </button>

        <button>
            <NuxtLink to="/reviews">Recensioni</NuxtLink>
        </button>

    </nav>
    <main id="centerPage">
        <slot></slot>
    </main>
</template>

