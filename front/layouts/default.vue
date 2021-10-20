<template>
  <v-app>
    <Flash />
    <TheHeader />
    <TheSidebar />
    <LevelUpModal />
    <v-main class="grey lighten-5">
      <nuxt />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from '~/components/organisms/header/TheHeader'
import TheFooter from '~/components/organisms/footer/TheFooter'
import Flash from '~/components/atoms/Flash'
import TheSidebar from '~/components/organisms/sidebar/TheSidebar'
import LevelUpModal from '~/components/organisms/LevelUpModal'

export default {
  components: {
    TheHeader,
    TheFooter,
    Flash,
    TheSidebar,
    LevelUpModal
  }
}
</script>
