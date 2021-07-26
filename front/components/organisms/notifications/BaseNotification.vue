<template>
  <v-alert
    v-bind="$attrs"
    :class="[`elevation-${elevation}`]"
    :value="isDisplay"
    :color="color"
    :type="type"
    class="v-alert--notification mb-3"
  >
    <slot />
  </v-alert>
</template>

<script>
export default {
  props: {
    color: {
      type: String,
      default: "info"
    },

    elevation: {
      type: [Number, String],
      default: 6
    },

    hiddenForce: {
      type: Boolean,
      default: false
    },

    time: {
      type: Number,
      default: 3000
    },
    
    type: {
      type: String,
      default: undefined
    }
  },

  data: () => ({
    hidden: false
  }),

  computed: {
    isDisplay() {
      return !this.hidden || this.hiddenForce
    }
  },

  methods: {
    //TODO: ボタンでflashを削除したい
    del() {
      this.hidden = true
    }
  },

  inheritAttrs: false,

  mounted() {
    setTimeout( () => {
      this.del()
    }, this.time);
  }
}
</script>

<style scoped lang="scss">
.v-alert--notification {
  border-radius: 4px !important;
  border-top: none !important;
}
</style>