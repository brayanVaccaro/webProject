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