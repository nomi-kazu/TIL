<template>
  <one-column-container>
    <change-username-card @submit="submit" />
  </one-column-container>
</template>

<script>
import OneColumnContainer from '~/components/molecules/containers/OneColumnContainer'
import ChangeUsernameCard from '~/components/organisms/cards/ChangeUsernameCard'

export default {
  components: {
    OneColumnContainer,
    ChangeUsernameCard
  },

  methods: {
    submit(userName) {
      this.$emit('submit', userName)
    }
  }
}
</script>

<style scoped>

</style>