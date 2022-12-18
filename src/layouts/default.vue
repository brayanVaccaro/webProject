<template>
    <nav id="nav">
        <button>
            <li>
                <NuxtLink to="/">Home</NuxtLink>
            </li>
        </button>
        <button>
            <li>
                <NuxtLink to="/login">Login</NuxtLink>
            </li>
        </button>
        <button>
            <li>
                <NuxtLink to="/login">Prova1</NuxtLink>
            </li>
        </button>
        <button>
            <li role="button">
                <NuxtLink to="/login">Prova2</NuxtLink>
            </li>
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
}

nav {
    display: flex;
    justify-content: center;
    background-color: rgb(26, 176, 196);
}
li {
    list-style: none;
    // margin: auto;

}

button {
    padding: 1%;
    margin: 2% 5%;
    // background-color: black;
}
</style>