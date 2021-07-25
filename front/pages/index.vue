<template>
  <div>
    <p>{{ uid }} : {{ access_token }} : {{ isAuthenticated }}</p>
  </div>
</template>

<script>
export default {
  computed: {
    uid() {
      return this.$store.getters["authentication/uid"];
    },
    access_token() {
      return this.$store.getters["authentication/access_token"];
    },
    isAuthenticated() {
      return this.$store.getters["authentication/isAuthenticated"];
    },
  },
}
</script>
