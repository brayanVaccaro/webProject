<script lang="ts">
definePageMeta({
    middleware: ["require-login"]
})
export default defineComponent({
    data() {
        return {
            idStanza: [] as number[],
            prezzoAnotte: '' as string,
            tagliaStanza: '' as string,
            tipologiaStanza: '' as string,
            options: [
                { value: 'Singola' },
                { value: 'Doppia' },
                { value: 'Tripla' },
                { value: 'Quadrupla' }
            ],
            scelte: [
                { value: 'matrimoniale' },
                { value: 'suite' },
                { value: 'vistaMare' },
            ],
        }
    },
    methods: {
        insertRoom() {
            $fetch("/api/reservation/insertRoom", {
                method: "POST",
                body: {
                    idStanza: this.idStanza,
                    prezzoAnotte: this.prezzoAnotte,
                    tagliaStanza: this.tagliaStanza,
                    tipologiaStanza: this.tipologiaStanza,
                }
            })
                .then((response) => (alert(response.message)))
                .then(() => window.location.href = "/reservation")
                .catch((e) => (alert(e)))

        },

    },
})
</script>
<template>
    <h2>Aggiungi una nuova stanza</h2>
    <p>
        Prezzo a notte
    </p>
    <input type="text" v-model="prezzoAnotte" />
    <p>
        Immagine della stanza
    </p>
    <input type="file" />
    <p>
        Taglia della stanza
    </p>
    <select v-model="tagliaStanza">
        <option v-for="option in options" :key="option.value" :value="option.value">
            {{ option.value }}
        </option>
    </select>
    <p>
        Tipologia della stanza
    </p>
    <select style="display: block;" v-model="tipologiaStanza">
        <option v-for="option in scelte" :key="option.value" :value="option.value">
            {{ option.value }}
        </option>
    </select>

    <button @click.prevent="insertRoom()">
        inserisci stanza
    </button>
</template>

