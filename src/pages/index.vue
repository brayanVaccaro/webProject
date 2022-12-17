<script lang="ts">
import { Persona } from '../types'
export default defineComponent({
    data() {
        return {
            persona: [] as Persona[]
        }
    },
    methods: {
        getPersona() {
            $fetch("/api/dbLinking")
            .then((data) => {this.persona = data as Persona[]})
        }
    },
    mounted() {
        this.getPersona();
    }
})
</script>

<template>
    <div id="index">
        <!-- breve descrizione dell'hotel -->
        <section>
            <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Sequi mollitia laboriosam a facilis animi, quis
                odio aliquid enim numquam doloribus laborum accusantium suscipit, perferendis id maiores aliquam minima
                nesciunt iure?
            </p>
        </section>
        <!-- elenco delle stanze con le relative info -->
        <section id="contenutoStanza">
            <div class="flexbox-index">
                <table>
                    <thead>
                        <th>Nome</th>
                        <th>Cognome</th>
                        <th>CartaID</th>
                        <th>Data Nascita</th>
                        <th>Bracciale</th>
                    </thead>
                    <tbody>
                        <tr v-for="x in persona"> 
                            <td> {{x.Nome}}</td>
                            <td> {{x.Cognome}}</td>
                            <td> {{x.CartaId}}</td>
                            <td> {{x.DataNascita}}</td>
                            <td> {{x.Bracciale}}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="flexbox-index-item">

            </div>
            <div class="flexbox-index-item"></div>
            <div class="flexbox-index-item"></div>
        </section>
    </div>
</template>

<style lang="scss" scoped>

#contenutoStanza {
    width: 100%;
    height: auto;
    padding-bottom: 1%;
    background-color: red;
}

//INDEX PAGE
.flexbox-index {
    display: flex;
    // flex-wrap: ;
    flex-direction: column;
    // flex-wrap: wrap;
}
.flexbox-index-item {
    width: auto;
    height: 100px;
    background-color: blue;
    margin: 1% 1% 0;
}
table {
    border-collapse: collapse;
    margin: 1% 10%;
}

th, td {
    
    border: 1px solid black;
    text-align: center;
}
</style> 