<template>
  <div>
    <p>ユーザー名：{{ username }}</p>
  </div>
</template>

<script>
export default {
  computed: {
    username() {
      return this.$route.params.username
    }
  },
}
</script>

<style scoped lang="scss">

</style>