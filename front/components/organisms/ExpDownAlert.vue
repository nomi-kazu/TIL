<template>
  <v-dialog
    v-model="dialog"
    max-width="500"
    transition="scroll-y-transition"
    persistent
  >
    <v-card>
      <v-card-title style="color: #FFD54F;">
        <v-icon style="color: #FBC02D">
          fas fa-exclamation-circle
        </v-icon>
        <h3 class="ml-3">
          注意
        </h3>
      </v-card-title>

      <v-card-text style="margin-top: 20px;">
        <p>経験値が下がります。</p>
        <p>レベルが下がる恐れがありますが、よろしいですか？</p>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          color="blue darken-1"
          text
          @click="cancel"
        >
          Close
        </v-btn>
        <v-btn
          color="green darken-1"
          text
          @click="understanding"
        >
          OK
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    displayModal: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      dialog: this.displayModal
    }
  },
  methods: {
    cancel () {
      this.$emit('cancel')
      this.dialog = false
    },
    understanding () {
      this.$emit('understanding')
      this.dialog = false
    }
  },
  watch: {
    displayModal (newValue) {
      this.dialog = newValue
    }
  }
}
</script>
