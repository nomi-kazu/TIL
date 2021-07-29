<template>
  <v-card>
    ユーザーIDを入力してください
    <change-username-form />
  </v-card>
</template>

<script>
import ChangeUsernameForm from '~/components/organisms/form/ChangeUsername/Form'

export default {
  components: {
    ChangeUsernameForm
  }
}
</script>

<style scoped>

</style>