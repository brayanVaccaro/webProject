// È la versione frontend di requireLogin in ~/server/utils/auth.ts
// Se una pagina utilizza questo middleware e l'utente che sta cercando di visitarla
// non è autenticato, allora viene reindirizzato alla pagina di login
// Vedi:
// - https://nuxt.com/docs/guide/directory-structure/middleware

export default defineNuxtRouteMiddleware(async function () {
  const utente = await $fetch("/api/auth/php/profilo.php");

  if (!utente.user) {
    alert(utente.message);
    return navigateTo("/login");
  }
});
