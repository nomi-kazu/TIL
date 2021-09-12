<template>
  <ValidationProvider
    v-slot="{ errors, valid }"
    :name="$attrs.label"
    :rules="rules"
    :vid="$attrs.label"
  >
    <v-autocomplete
      v-model="innerValue"
      :error-messages="errors"
      :items="items"
      :success="valid"
      v-bind="$attrs"
      v-on="$listeners"
    />
  </ValidationProvider>
</template>

<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },

    items: {
      type: Array
    },

    value: {
      type: null
    }
  },

  data: () => ({
    innerValue: ''
  }),

  watch: {
    innerValue (newVal) {
      this.$emit('input', newVal)
    },

    value (newVal) {
      this.innerValue = newVal
    }
  },

  created () {
    if (this.value) {
      this.innerValue = this.value
    }
  }
}
</script>
