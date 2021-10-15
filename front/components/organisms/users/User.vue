<template>
  <v-row
    class="mb-3"
    style="border-bottom: solid 1px #ccc;"
  >
    <v-col cols="12" class="pb-0">
      <nuxt-link
        :to="{ path: `/users/${user.id}` }"
        style="color: inherit; text-decoration: none;"
      >
        <v-avatar
          v-if="user.image_url"
          color="white"
          size="35"
        >
          <v-img
            :src="user.image_url"
          />
        </v-avatar>
        <v-icon
          v-else
          size="40"
        >
          mdi-account-circle
        </v-icon>
        {{ user.name }}
      </nuxt-link>
    </v-col>
    <v-col cols="8">
      <v-card-text class="px-0">
        {{ user.description }}
      </v-card-text>
    </v-col>
    <v-col cols="4">
      <FollowBtnGroup
        v-if="user.id != $auth.user.id"
        :user="user"
        class="float-right"
      />
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {}
    }
  }
}
</script>
