<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="300"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        class="px-0"
        v-bind="attrs"
        text
        v-on="on"
      >
        {{ post.liked_users.length }}
      </v-btn>
    </template>
    <v-card>
      <v-banner class="grey lighten-5" sticky outlined>
        <v-btn
          class="float-right"
          icon
          @click="dialog=false"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
      </v-banner>
      <LikedUsersTemplate
        :post="post"
      />
    </v-card>
  </v-dialog>
</template>

<script>
import LikedUsersTemplate from '~/components/molecules/LikedUsersTemplate'
export default {
  components: {
    LikedUsersTemplate
  },
  props: {
    post: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      dialog: false
    }
  }
}
</script>
