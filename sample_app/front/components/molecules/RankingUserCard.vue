<template>
  <v-row justify="center">
    <v-col cols="1" class="mr-1">
      <div v-if="[0, 1, 2].includes(index)">
        <v-icon v-if="index === 0" style="color: #ffc400;">
          mdi-medal-outline
        </v-icon>
        <v-icon v-if="index === 1" style="color: #c9c9c9;">
          mdi-medal-outline
        </v-icon>
        <v-icon v-if="index === 2" style="color: #ac6d4d;">
          mdi-medal-outline
        </v-icon>
      </div>
      <span v-else class="mx-1">{{ index + 1 }}</span>
    </v-col>
    <v-col cols="2">
      <v-avatar
        size="30"
        class="user-avatar"
      >
        <v-img
          v-if="user.image_url"
          :src="user.image_url"
        />
        <v-icon
          v-else
        >
          mdi-account-circle
        </v-icon>
      </v-avatar>
    </v-col>
    <v-col
      cols="5"
      class="px-1"
    >
      <div class="user-name">
        {{ user.name }}
      </div>
    </v-col>
    <v-col
      cols="3"
      class="px-1"
    >
      <div class="user-exp amber--text text--darken-4">
        {{ user.exp }}
      </div>
      <div class="exp">
        exp
      </div>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    },
    index: {
      type: Number,
      required: true
    }
  }
}
</script>
