<template>
  <sidebar-container>
    <guest-sidebar v-if="isGuest" />>
    <login-sidebar v-if="isLogin" />
  </sidebar-container>
</template>

<script>
import SidebarContainer from '~/components/organisms/sidebar/SidebarContainer'
import GuestSidebar from '~/components/organisms/sidebar/GuestSidebar'
import LoginSidebar from '~/components/organisms/sidebar/LoginSidebar'

export default {
  components: {
    SidebarContainer,
    GuestSidebar,
    LoginSidebar
  },

  computed: {
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
}
</script>

<style scoped>

</style>