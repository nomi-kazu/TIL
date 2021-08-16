<template>
  <base-container :fluid="fluid" :no-guitters="noGutters">
    <v-row justify="center">
      <v-col :cols="cols" :sm="sm" :md="md" :lg="lg" :xl="xl">
        <slot />
      </v-col>
    </v-row>
  </base-container>
</template>

<script>
const BaseContainer = () => import('~/components/molecules/containers/BaseContainer')

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

    cols: {
      type: [Boolean, String, Number],
      default: 12
    },

    sm: {
      type: [Boolean, String, Number],
      default: false
    },

    md: {
      type: [Boolean, String, Number],
      default: false
    },

    lg: {
      type: [Boolean, String, Number],
      default: false
    },

    xl: {
      type: [Boolean, String, Number],
      default: false
    }
  }
}
</script>