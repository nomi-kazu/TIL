<template>
  <v-card class="mx-auto pt-4" width="800" height="400">
    <h2 class="mb-10 text-center">TIL</h2>
    <v-row class="d-flex flex-row justify-center">
      <signup-form class="mr-10" @signup="signup" />

      <div class="ml-10">
        <p>その他のアカウント</p>
        <login-sns-btn-group />
      </div>
    </v-row>
  </v-card>
</template>

<script>
import SignupForm from '~/components/organisms/form/SignupForm'
import LoginSnsBtnGroup from '~components/organisms/btnGroup/LoginSnsBtnGroup'

export default {
  components: {
    SignupForm,
    LoginSnsBtnGroup
  },

  methods: {
    signup() {
      this.$emit('signup', userInfo)
    }
  }
}
</script>

<style>
  .row {
    width: 100%;
    height: 100%;
  }
</style>