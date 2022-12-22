<template>
    <nav id="nav">
        <button>
            <NuxtLink to="/">Home</NuxtLink>
        </button>

        <button>
            <NuxtLink to="/login">Login</NuxtLink>
        </button>

        <button>
            <NuxtLink to="/rooms">Stanze disponibili</NuxtLink>
        </button>

        <button>
            <NuxtLink to="/login">Recensioni</NuxtLink>
        </button>
        

    </nav>
    <main id="centerPage">
        <slot></slot>
    </main>
</template>

<script>
</script>

<style lang="scss" scoped>
#centerPage {
    background-color: rgb(133, 207, 203);
    // display: flex;
}

nav {
    display: flex;
    justify-content: space-around;
    background-color: rgb(26, 176, 196);
    // margin: 1%;
    padding: 1%;
}

button {
    cursor: pointer;
    list-style: none;
    margin: 1% auto;
    width: 20%;
}

a {
    text-align: center;
    display: inline-block;
    width: 100%;
    height: 100%;
    text-decoration: none;
    font-size: medium;
}
</style>