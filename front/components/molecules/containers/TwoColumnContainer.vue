<template>
  <base-container :fluid="fluid" :no-gutters="noGutters">
    <v-row :justify="justify">
      <v-col :cols="leftCols" :sm="leftSm" :md="leftMd" :lg="leftLg" :xl="leftXl">
        <slot name="left" />
      </v-col>

      <v-col :cols="rightCols" :sm="rightSm" :md="rightMd" :lg="rightLg" :xl="rightXl">
        <slot name="right" />
      </v-col>
    </v-row>
  </base-container>
</template>

<script>
const BaseContainer = () =>import('~/components/molecules/containers/BaseContainer')

export default {
  components: {
    BaseContainer
  },

  props: {
    fluid: {
      type: Boolean,
      default: false
    },

     noGutters: {
      type: Boolean,
      default: false
    },

    justify: {
      type: String,
      default: "center"
    },

    leftCols: {
      type: Number,
      default: 8
    },

    leftSm: {
      type: [Boolean, String, Number],
      default: false
    },

    leftMd: {
      type: [Boolean, String, Number],
      default: 12
    },

    leftLg: {
      type: [Boolean, String, Number],
      default: false
    },

    leftXl: {
      type: [Boolean, String, Number],
      default: false
    },

    rightCols: {
      type: Number,
      default: 4
    },

    rightSm: {
      type: [Boolean, String, Number],
      default: false
    },

    rightMd: {
      type: [Boolean, String, Number],
      default: 12
    },

    rightLg: {
      type: [Boolean, String, Number],
      default: false
    },

    rightXl: {
      type: [Boolean, String, Number],
      default: false
    }
  }
}
</script>

<style scoped>

</style>