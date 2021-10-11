<template>
  <HeaderContainer @click="onClick">
    <v-spacer />

    <keep-alive>
      <LoginHeader v-if="$auth.isUserPresent()" />

      <GuestHeader v-else />
    </keep-alive>
  </HeaderContainer>
</template>

<script>
import HeaderContainer from '~/components/organisms/header/HeaderContainer'
import LoginHeader from '~/components/organisms/header/LoginHeader'
import GuestHeader from '~/components/organisms/header/GuestHeader'

export default {
  components: {
    HeaderContainer,
    LoginHeader,
    GuestHeader
  },
  methods: {
    onClick () {
      return this.$emit('click')
    }
  }
}
</script>
