<template>
    <div>
        <section id="login">
            <h1>LOGIN</h1>
            <div class="flexbox-login">
                <th>Username</th>
                <input type="text" placeholder="username">

                <th>Password</th>
                <input type="text" placeholder="password">
                <button id="invioLogin">
                    <NuxtLink to="/">INIZIA QUI</NuxtLink>

                </button>
                <section id="notRegistered">
                    <a href="/">Non sei ancora registrato?</a>
                </section>
            </div>

        </section>
    </div>
</template>