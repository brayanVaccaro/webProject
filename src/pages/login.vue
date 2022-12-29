<script lang="ts">
// Applica a questa pagina il middleware creato in ~/middleware/require-logout
// Vedi:
// - https://nuxt.com/docs/api/utils/define-page-meta
definePageMeta({
  middleware: ["require-logout"]
})

export default defineComponent({
  data() {
    return {
      loginUsername: "",
      loginPassword: "",
      registerUsername: "",
      registerPassword: "",
      registerName: ""
    }
  },
  methods: {
    onLoginSubmit() {
      $fetch("/api/auth/login", {
        method: "POST",
        body: {
          username: this.loginUsername,
          password: this.loginPassword,
        }
      })
        .then(() => window.location.href = "/")
        .catch((e) => alert(e))
    },
    onRegisterSubmit() {
      $fetch("/api/auth/register", {
        method: "POST",
        body: {
          username: this.registerUsername,
          password: this.registerPassword,
          nome: this.registerName
        }
      })
        .then(() => window.location.href = "/")
        .catch((e) => alert(e))
    }
  }
})
</script>
<template>
    <section>
        <div class="enter">
            <input type="checkbox" id="chk" aria-hidden="true">

            <div class="signup">
                <form>
                    <label for="chk" aria-hidden="true">Sign up</label>
                    <input type="text" name="Name" placeholder="Name" required="true">
                    <input type="text" name="Surname" placeholder="Surname" required="true">
                    <input type="text" name="txt" placeholder="username" required="true">
                    <input type="email" name="email" placeholder="Email" required="true">
                    <input type="password" name="pswd" placeholder="Password" required="true">
                    <input type="password" name="confirm-pswd" placeholder="Confirm Password" required="true">
                    <button>Sign up</button>
                </form>
            </div>

            <div class="login">
                <form @submit.prevent="onLoginSubmit">
                    <label for="chk" aria-hidden="true">Login</label>
                    <!-- <input type="email" name="email" placeholder="Email" required="true"> -->
                    <input type="text" name="username" placeholder="Username" required="true" v-model="loginUsername">
                    <input type="password" name="pswd" placeholder="Password" required="true" v-model="loginPassword">
                    <button>Login</button>
                </form>
            </div>
        </div>
    </section>
</template>

<style lang="scss" scoped>
section {
    display: flex;
    justify-content: center;
    margin: 2% auto;
}
.enter {
    width: 450px;
    height: 600px;
    background: red;
    overflow: hidden;
    // background: 
    border-radius: 10px;
    box-shadow: 5px 20px 50px #000;

}

#chk {
    display: none;
}

.signup {
    position: relative;
    width: 100%;
    height: 100%;
}

label {
    color: #fff;
    font-size: 2.3em;
    justify-content: center;
    display: flex;
    margin: 45px;
    font-weight: bold;
    cursor: pointer;
    transition: .5s ease-in-out;
}

input {
    width: 60%;
    height: 20px;
    background: #e0dede;
    justify-content: center;
    display: flex;
    margin: 20px auto;
    padding: 10px;
    border: none;
    outline: none;
    border-radius: 5px;
}

button {
    width: 60%;
    height: 40px;
    margin: 10px auto;
    justify-content: center;
    display: block;
    color: #fff;
    background: #573b8a;
    font-size: 1em;
    font-weight: bold;
    margin-top: 20px;
    outline: none;
    border: none;
    border-radius: 5px;
    transition: .2s ease-in;
    cursor: pointer;
}

button:hover {
    background: #6d44b8;
}

.login {
    height: 550px;
    background: #eee;
    border-radius: 60% / 10%;
    transform: translateY(-160px);
    transition: .5s ease-in-out;
}

.login label {
    color: #573b8a;
    transform: scale(.6);
    padding-top: 3%;
}

#chk:checked~.login {
    transform: translateY(-570px);
}

#chk:checked~.login label {
    transform: scale(1);
}

#chk:checked~.signup label {
    transform: scale(.6);
}
</style>