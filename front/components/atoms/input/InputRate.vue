<template>
  <v-card-text>
    <ValidationProvider
      :name="$attrs.label"
      :rules="rules"
      :vid="$attrs.vid"
    >
      <div class="text-center">
        <v-card-actions>
          <span class="font-weight-bold">
            {{ inputValue }}
          </span>
          <h3>評価（必須）</h3>
          <v-rating
            v-model="inputValue"
            v-bind="$attrs"
            color="yellow darken-3"
            v-on="$listeners"
            dense
          />
        </v-card-actions>
      </div>
    </ValidationProvider>
  </v-card-text>
</template>

<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },

    value: {
      type: Number,
      default: 0
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
