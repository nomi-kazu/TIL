<template>
  <div>
    <div id="mb_view" v-html="html" />
  </div>
</template>

<script>
export default {
  props: {
    md: {
      type: String,
      default: undefined
    }
  },

  computed: {
    html() {
      return this.$md.render(this.md)
    }
  },
}
</script>

<style scoped>

</style>