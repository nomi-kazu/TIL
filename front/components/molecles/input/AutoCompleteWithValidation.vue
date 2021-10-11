<template>
  <ValidationProvider
    v-slot="{ errors, valid }"
    :name="$attrs.label"
    :rules="rules"
    :vid="$attrs.label"
  >
    <v-autocomplete
      v-model="inputValue"
      :items="items"
      :success="valid"
      :error-messages="errors"
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

    value: {
      type: null,
      default: null
    },

    items: {
      type: Array
    }
  },

  computed: {
    inputValue: {
      get () {
        return this.value
      },

      set (value) {
        this.$emit('input', value)
      }
    }
  }
}
</script>
