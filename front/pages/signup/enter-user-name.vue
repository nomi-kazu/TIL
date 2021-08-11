<template>
  <div>
    <signin-enterusername-template @submit="updateUsername" />
  </div>
</template>

<script>
import SigninEnterusernameTemplate from '~/components/templates/SigninEnterusernameTemplate'
export default {
  components: {
    SigninEnterusernameTemplate
  },

  methods: {
    async updateUsername(userName) {
      try {
        console.log("submit")
        // await this.$axios.put(`/api/v1/auth`, {
        //   username: userName,
        // })
        this.$router.push(`/settings/profile`)
      } catch (error) {
        console.error(error)
      }
    },
  },

  middleware: "authenticated"
}
</script>

<style scoped lang="scss">

</style>