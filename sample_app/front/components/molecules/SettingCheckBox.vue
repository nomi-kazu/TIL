<template>
  <div>
    <v-row>
      <v-col cols="4">
        <v-icon small>{{ icon }}</v-icon>
        <strong>{{ label }}</strong>
        <span style="margin-left: 10px;">
          <Hint
            v-if="hint"
            :explanation="hint"
          />
        </span>
      </v-col>
    </v-row>
    <v-row>
      <span style="padding-left: 10px;">{{ explanation }}</span>
    </v-row>
    <v-row justify="center" style="padding-left: 10px;">
      <v-checkbox
        v-model="inputValue"
      />
      <v-spacer />
    </v-row>
  </div>
</template>

<script>
import Hint from '~/components/atoms/Hint'

export default {
  components: {
    Hint
  },
  props: {
    label: {
      type: String,
      required: true
    },
    explanation: {
      type: String,
      required: true
    },
    icon: {
      type: String,
      default: ''
    },
    hint: {
      type: String,
      default: ''
    },
    value: {
      type: Boolean,
      default: true
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
