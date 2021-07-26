<template>
  <header-container>
    <common-header>
      <guest-header v-if="isGuest" />

      <login-header v-if="isLogin" />
    </common-header>
  </header-container>
</template>

<script>
import CommonHeader from '~/components/organisms/header/CommonHeader'
import GuestHeader from '~/components/organisms/header/GuestHeader'
import HeaderContainer from '~/components/organisms/header/HeaderContainer'
import LoginHeader from '~/components/organisms/header/LoginHeader'

export default {
  components: {
    CommonHeader,
    GuestHeader,
    HeaderContainer,
    LoginHeader
  },

  computed: {
    isLogin() {
      // TODO: login済みか判定
      return false
    },

    isGuest() {
      // TODO: loginしていないか判定
      return true
    }
  }
  
}
</script>

<style scoped>

</style>