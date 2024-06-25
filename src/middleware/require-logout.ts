// È la versione frontend di requireLogout in ~/server/utils/auth.ts
// Se una pagina utilizza questo middleware e l'utente che sta cercando di visitarla
// è autenticato, allora viene reindirizzato alla homepage
// Vedi:
// - https://nuxt.com/docs/guide/directory-structure/middleware

export default defineNuxtRouteMiddleware(async function () {
  const utente = await $fetch("/api/auth/php/profilo.php");
  if (utente.user) {
    alert(utente.message);
    return navigateTo("/");
  }
});

