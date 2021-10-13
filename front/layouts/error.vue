<template>
  <v-app dark>
    <v-container>
      <v-card-text v-if="error.statusCode === 404">
        {{ pageNotFound }}
      </v-card-text>
      <v-card-text v-else>
        {{ otherError }}
      </v-card-text>
      <NuxtLink to="/">
        Home
      </NuxtLink>
    </v-container>
  </v-app>
</template>

<script>
export default {
  layout: 'empty',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      pageNotFound: '404 Not Found',
      otherError: 'An error occurred'
    }
  },
  head () {
    const title =
      this.error.statusCode === 404 ? this.pageNotFound : this.otherError
    return {
      title
    }
  }
}
</script>

<style scoped>
h1 {
  font-size: 20px;
}
</style>
