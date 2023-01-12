<template>
    <div id="review" class="grid-container-main">
        <section id="listaRecensioni" class="grid-item-list">
            <h3>Elenco recensioni:</h3>
            <div>
                <ul>
                    <li>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut consequatur explicabo, quia libero ratione, rerum asperiores voluptates nulla aliquam fuga delectus veniam sequi ullam impedit quisquam accusantium repellendus nisi reiciendis laboriosam corporis. Error ea, perspiciatis dolor debitis dignissimos, harum, hic quis facilis molestias doloremque ipsam quaerat sequi et aspernatur ipsum!</li>
                </ul>
            </div>
        </section>
        <section id="scriviRecensione" class="grid-item-list">
            <h3>Scrivi la tua recensione:</h3>
            <input type="text">
            <button>Pubblica</button>
        </section>
    </div>
</template>

<style lang="scss" scoped>
.grid-container-main {
    display: grid;
    grid-template-rows: 2fr 1fr;
}
.grid-item-list {
    // display: flex;
    // flex-direction: columns;
}
section {
    // display: ;
}
</style>