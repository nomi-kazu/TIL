<template>
  <v-app-bar app clipped-left color="amber lighten-2" dense fixed>
    <v-toolbar-title>
      <nuxt-link to="/" class="text--secondary text-decoration-none">
        <h2>TIL</h2>
      </nuxt-link>
    </v-toolbar-title>
    <v-spacer />

    <keep-alive>
      <LoginHeader v-if="$auth.isUserPresent()" />

      <GuestHeader v-else />
    </keep-alive>
  </v-app-bar>
</template>

<script>
import LoginHeader from '~/components/organisms/header/LoginHeader'
import GuestHeader from '~/components/organisms/header/GuestHeader'

export default {
  components: {
    LoginHeader,
    GuestHeader
  }
}
</script>
