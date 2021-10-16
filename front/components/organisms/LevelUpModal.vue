<template>
  <v-dialog
    v-model="levelUp"
    max-width="500"
    transition="scroll-x-transition"
  >
    <v-card justify="center" align="center">
      <v-card-text style="color: #FFD54F;">
        <h1 class="pt-2">
          Level UP!!
          <v-icon large style="color: #FFD54F;">
            mdi-transfer-up
          </v-icon>
        </h1>
      </v-card-text>

      <v-card-text class="mt-4">
        <h1 style="color: #FF8F00; font-size: 3.4rem">
          Lv.{{ level }}
        </h1>
        <p class="mt-5">
          レベルがあがりました！
        </p>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          color="green darken-1"
          text
          @click="levelUp = false"
        >
          OK
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      levelUp: false,
      level: 1
    }
  },
  computed: {
    ...mapGetters({ user: 'user/user' })
  },
  mounted () {
    this.$store.subscribe((mutation, state) => {
      if (mutation.type === 'experience/setExperience') {
        const level = mutation.payload.level
        if (level > this.user.level) {
          this.levelUp = true
          this.level = level
        }
        this.$store.commit('user/setLevel', level)
      }
    })
  }
}
</script>
