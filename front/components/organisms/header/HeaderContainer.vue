<template>
  <v-app-bar app clipped-left color="amber lighten-2" dense fixed>
    <v-app-bar-nav-icon @click="onClick()" />

    <v-toolbar-title>
      <nuxt-link to="/" class="text--secondary text-decoration-none">
        <HeaderTitleText :elment="getTitleElement" :text="siteTitle" />
      </nuxt-link>
    </v-toolbar-title>

    <!-- headerのcontainer -->
    <slot />
  </v-app-bar>
</template>

<script>
import HeaderTitleText from '~/components/atoms/text/HeaderTitleText'

const SITE_TITLE = 'TIL'
export default {
  components: {
    HeaderTitleText
  },

  computed: {
    getTitleElement () {
      return this.$route.path === '/' ? 'h1' : 'p'
    },
    siteTitle: () => SITE_TITLE
  },

  methods: {
    onClick () {
      this.$store.commit('sidebar/onDrawer')
    }
  }
}
</script>
