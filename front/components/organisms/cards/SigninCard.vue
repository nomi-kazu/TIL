<template>
  <v-card width="800" height="300" class="mx-auto">
    <v-row justify="center" align="center">
      <div class="mr-1 mr-mb-6 mr-lg-10">
        <signin-form />
      </div>

      <div class="mr-1 mr-mb-6 mr-lg-10">
        <p>その他のアカウント</p>
        <login-sns-btn-group />
      </div>
    </v-row>
  </v-card>
</template>

<script>
import LoginSnsBtnGroup from '~/components/organisms/btnGroup/LoginSnsBtnGroup'
import SigninForm from '~/components/organisms/form/SigninForm'

export default {
  components: {
    LoginSnsBtnGroup,
    SigninForm
  }
}
</script>

<style scoped>
  .row {
    width: 100%;
    height: 100%;
  }
</style>