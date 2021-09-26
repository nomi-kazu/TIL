<template>
  <SidebarContainer>
    <LoginSidebar v-if="$auth.isUserPresent()" />

    <GuestSidebar v-else />
  </SidebarContainer>
</template>

<script>
import SidebarContainer from '~/components/organisms/sidebar/SidebarContainer'
import LoginSidebar from '~/components/organisms/sidebar/LoginSidebar'
import GuestSidebar from '~/components/organisms/sidebar/GuestSidebar'

export default {
  components: {
    SidebarContainer,
    LoginSidebar,
    GuestSidebar
  }
}
</script>
