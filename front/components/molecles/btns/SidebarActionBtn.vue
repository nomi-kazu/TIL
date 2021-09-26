<template>
  <client-only>
    <v-btn
      class="sidebar-btn"
      nuxt
      outlined
      large
      :to="to"
      :width="width"
      @click="onClick()"
      v-text="text"
    />
  </client-only>
</template>

<script>
export default {
  props: {
    text: {
      type: String,
      default: 'ログイン'
    },
    to: {
      type: [String, Object],
      default: undefined
    },
    width: {
      type: [String, Number],
      default: '70%'
    }
  },
  methods: {
    onClick () {
      return this.$emit('click')
    }
  }
}
</script>

<style lang="scss" scoped>
.sidebar-btn {
  border-color: #2196F3;
  border-radius: 8px;
  font-size: 1.1rem;
}
</style>
