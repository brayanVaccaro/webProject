<script lang="ts">
import { Stanza } from '../types'
export default defineComponent({
    data() {
        return {
            stanza: [] as Stanza[]
        }
    },
    methods: {
        getPersona() {
            $fetch("/api/dbLinking")
                .then((data) => { this.stanza = data as Stanza[] })
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
        <!-- elenco delle stanze con le relative info -->
        <section id="contenutoStanza">
            <div class="grid-container">
                <div class="grid-item grid-item-1">Lorem ipsum dolor sit, amet consectetur adipisicing elit. At quidem excepturi a nobis quae architecto quod officia et vitae labore est ducimus alias dicta ex doloribus optio nihil eius, quia aliquam illum odit, eos culpa. Enim reprehenderit quos necessitatibus totam! Eligendi, repellendus nisi quos corporis, minus ipsam eveniet illum consectetur est iure corrupti deserunt, et nostrum officiis labore sapiente laborum. Minus rem inventore vero quae possimus sit eaque velit voluptas dolore, recusandae hic sunt! Ratione, autem molestiae rem tempora esse accusantium nesciunt debitis accusamus eveniet placeat aspernatur tempore repellat quo vel laudantium consequuntur itaque ipsam at dolorum sit eaque numquam. Lorem, ipsum dolor sit amet consectetur adipisicing elit. Repellendus perspiciatis, suscipit dolor eius quam fuga, nostrum molestias temporibus vel odit assumenda aliquid dolore veniam dolorem. Suscipit magni pariatur consequuntur itaque debitis, quasi possimus natus error voluptas quam ut molestias veniam omnis repudiandae quis quos nostrum dicta qui cum nesciunt exercitationem aspernatur? Reprehenderit quos ad ipsa eum praesentium explicabo non, mollitia accusantium, incidunt amet dolore beatae fugiat autem, nemo atque corporis iste aut recusandae. Possimus laudantium sed cumque esse ullam modi earum saepe doloribus maiores officia delectus, nulla temporibus. Ducimus omnis in facere ullam? Architecto, voluptatum rerum. Exercitationem harum quis itaque?
                    at aut quae suscipit.</div>
                <div class="grid-item grid-item-2"> Lorem ipsum dolor sit, amet consectetur adipisicing elit. Enim eaque
                    excepturi, repellat hic totam soluta sunt cum laborum fugiat dolorem autem impedit cumque cupiditate
                    fugit.</div>
                <div class="grid-item grid-item-3">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Labore
                    omnis maiores vel blanditiis, voluptate, tenetur fuga veniam delectus quam possimus ratione
                    perspiciatis voluptas ullam sunt aliquid ea, asperiores repellat iure!</div>
            </div>
        </section>
    </div>
    <table>
        <thead>
            <td>numero stanza</td>
            <td>prezzo a notte</td>
            <td>immagine</td>
        </thead>
        <tbody>
            <tr v-for="x in stanza">
                <td>{{x.numeroStanza}}</td>
                <td>{{x.prezzoStanzaAnotte}}</td>
                <td> <img :src="'img/' + x.imgStanza"></td>
            
            </tr>
        </tbody>
    </table>
</template>

<style lang="scss" scoped>
#contenutoStanza {
    width: 100%;
    height: auto;
    padding-bottom: 1%;
    // background-color: red;
}
img {
    width: 100px;
    height: 100px;
    border: 1px solid red;
    border-radius: 10px;
}
//INDEX PAGE
.grid-container {
    display: grid;
    // height: 100vh;
    grid-template-columns: repeat(2, auto); //gestisco la larghezza delle colonne
    grid-auto-rows: minmax(150px, auto); //gestisco l'altezza delle righe
    // background-color: blue;
    // gap: 1%;
    // overflow: hidden;
}

.grid-item {
    // height: 100px;
    // width: 100px;
    margin: 2%;
    // background-color: red;
}
.grid-item-1 {
    background-color: rgb(254, 100, 0);
    
}
</style> 