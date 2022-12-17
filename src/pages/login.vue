<template>
    <div>
        <section id="login">
            <h1>LOGIN</h1>
            <div class="flexbox-login">
                <b>Username</b>
                <input type="text" placeholder="username">

                <b>Password</b>
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

<style lang="scss" scoped>

h1 {
    text-align: center;
    margin: 1%;
}



input {
    margin: 0;
}

.flexbox-login {
    padding: 0 25%;
    margin: 1% 0% 1% 1%;
    display: flex;
    align-items: flex-start;
    flex-direction: column;
}

#invioLogin {
    display: block;
    width: 30%;
    margin: 1% 0;
}

#notRegistered {
    padding: 0;
}
</style>