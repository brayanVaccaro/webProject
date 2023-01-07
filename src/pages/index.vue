<template>
    <div id="index">
        <!-- breve descrizione dell'hotel -->
        <!-- elenco delle stanze con le relative info -->
        <section id="contenutoStanza">
            <div>
               
            </div>
            <div class="grid-container"> <h1>Benvento nel sito dell'hotel Astra</h1>
                <p>L'unico hotel di Gallipoli che comprende tutte le sue tradizioni e la sua storia</p>
                <p class="ciao">Per usufruire del nostro sito e prenotare una stanza <a href="\login">registrarsi</a>
                </p>
                <div class="map-container"><iframe width="100%" height="500" frameborder="0" scrolling="no"
                        marginheight="0" marginwidth="0"
                        src="https://maps.google.com/maps?width=100%25&amp;height=600&amp;hl=en&amp;q=gallipolli,%20via%20xx%20settembre%20numero%2015+(My%20Business%20Name)&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"></iframe>
                </div></div>
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
</style> 