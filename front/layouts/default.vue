<template>
  <v-app>
    <TheHeader />
    <TheSidebar />
    <v-main class="grey lighten-5">
      <nuxt />
    </v-main>
    <Flash />
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from '~/components/organisms/header/TheHeader'
import TheFooter from '~/components/organisms/footer/TheFooter'
import Flash from '~/components/atoms/top/Flash'
import TheSidebar from '~/components/organisms/sidebar/TheSidebar'

export default {
  components: {
    TheHeader,
    TheFooter,
    Flash,
    TheSidebar
  }
}
</script>
