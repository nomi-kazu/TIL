<template>
  <div>
    <v-row class="py-5">
      <v-col cols="6">
        <v-row justify="center">
          <h1>Lv.{{ user.level }}</h1>
        </v-row>
        <v-row justify="center">
          <span>Level</span>
        </v-row>
      </v-col>
      <v-col cols="6">
        <v-row justify="center">
          <h1>{{ user.lifelong_exp }}</h1>
        </v-row>
        <v-row justify="center">
          <span>合計EXP</span>
        </v-row>
      </v-col>
    </v-row>
    <ExpProgressLinear
      v-if="Object.keys(user).length && requiredExp.required_exp"
      :requiredExp="requiredExp.required_exp"
      :experienceToNext="user.experience_to_next"
      class="pb-2"
    />
  </div>
</template>

<script>
import ExpProgressLinear from '~/components/molecules/ExpProgressLinear'

export default {
  components: {
    ExpProgressLinear
  },
  props: {
    user: {
      type: Object,
      default: () => {}
    },
    requiredExp: {
      type: Object,
      default: () => {}
    },
    posts: {
      type: Array,
      default: () => {}
    }
  }
}
</script>
