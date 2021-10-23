<template>
  <v-row justify="center" align="center">
    <v-col lg="8" cols="9" class=" mr-2">
      <v-progress-linear height="10px" :value="progressProportion" />
    </v-col>
    <v-col
      cols="2"
      lg="2"
      class="py-0"
    >
      <div v-if="!maxLevel" class="float-right">
        {{ progressNumeretor }}/{{ requiredExp }}
      </div>
      <div v-else>
        MAX
      </div>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    requiredExp: {
      type: Number,
      default: 0
    },
    experienceToNext: {
      type: Number,
      default: 0
    }
  },
  computed: {
    progressProportion () {
      if (this.maxLevel) {
        return 100
      }
      const proportion = 100 - this.experienceToNext / this.requiredExp * 100
      if (proportion === 100) {
        return 0
      } else {
        return proportion
      }
    },
    maxLevel () {
      if (this.requiredExp === 1660) {
        return true
      }
      return false
    },
    progressNumeretor () {
      return this.requiredExp - this.experienceToNext
    }
  }
}
</script>
