<template>
  <div>
    <p>{{ uid }} : {{ accessToken }} : {{ isAuthenticated }}</p>
  </div>
</template>

<script>
export default {
  computed: {
    uid() {
      return this.$store.getters["authentication/uid"];
    },
    accessToken() {
      return this.$store.getters["authentication/accessToken"];
    },
    isAuthenticated() {
      return this.$store.getters["authentication/isAuthenticated"];
    },
  },
}
</script>
