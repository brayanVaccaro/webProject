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
            <NuxtLink to="/reviews">Recensioni</NuxtLink>
        </button>

    </nav>
    <main id="centerPage">
        <slot></slot>
    </main>
</template>

