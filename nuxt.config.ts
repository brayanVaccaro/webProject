// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    srcDir: "src",
    nitro: {
        compressPublicAssets: true,
      },
      runtimeConfig: {
        databaseName: process.env.DB_HOSTNAME,
        serviceUserName: process.env.DB_SERVICE_USER,
        serviceUserPassword: process.env.DB_SERVICE_USER_PASSWORD,
        serviceDbName: process.env.DB_NAME
      },          
    ssr: false
})
