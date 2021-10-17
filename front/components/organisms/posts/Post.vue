<template>
  <v-card class="mb-8">
    <v-card-text>
      {{ $moment(post.created_at).format('YYYY/MM/DD HH:MM') }}
    </v-card-text>
    <nuxt-link
      :to="{ path: `/posts/${post.id}` }"
      style="color: inherit; text-decoration: none;"
    >
      <v-card-title class="pb-0" style="font-size: 15px;">
        {{ post.title }}
      </v-card-title>
    </nuxt-link>
    <v-card-text class="py-0">
      <v-chip-group
        v-if="post.tags && post.tags.length > 0"
        class="w-100"
        active-class="primary--text"
        column
      >
        <v-chip
          v-for="tag in post.tags"
          :key="tag.id"
          color="info"
          outlined
          small
        >
          <nuxt-link
            :to="{ path: `/tags/${tag.id}` }"
            style="color: inherit; text-decoration: none;"
          >
            {{ tag.name }}
          </nuxt-link>
        </v-chip>
      </v-chip-group>
    </v-card-text>
    <v-card-text
      v-if="$auth.loggedIn&&$auth.user.id==post.user_id||$auth.user.admin"
      class="pt-0"
    >
      <v-btn
        :to="{ path: `/posts/edit/${post.id}` }"
        icon
      >
        <v-icon>
          mdi-square-edit-outline
        </v-icon>
      </v-btn>
      <v-btn
        icon
        @click="deletePost(post.id)"
      >
        <v-icon>
          mdi-trash-can-outline
        </v-icon>
      </v-btn>
    </v-card-text>
    <v-card-text>
      <nuxt-link
        :to="{ path: `/users/${post.user.id}` }"
        style="color: inherit; text-decoration: none;"
      >
        <v-avatar
          v-if="post.user.image_url"
          size="20"
        >
          <v-img
            :src="post.user.image_url"
          />
        </v-avatar>
        <v-icon
          v-else
          size="20"
        >
          mdi-account-circle
        </v-icon>
        {{ post.user.name }}
      </nuxt-link>
      <LikeBtnGroup
        v-if="$auth.loggedIn"
        class="float-right"
        :post="post"
      />
    </v-card-text>
  </v-card>
</template>

<script>
import LikeBtnGroup from '~/components/molecules/posts/LikeBtnGroup'

export default {
  components: {
    LikeBtnGroup
  },
  props: {
    post: {
      type: Object,
      default: () => {}
    }
  },
  methods: {
    async deletePost (postId) {
      if (window.confirm('投稿を削除してもよろしいですか？')) {
        await this.$axios.$delete(`/api/v1/posts/${postId}`, { data: { user_id: this.$auth.user.id } })
          .then(
            (response) => {
              this.$store.commit('experience/setExperience', response.experience, { root: true })
              this.$store.commit('experience/setRequiredExp', response.required_exp, { root: true })
              this.$store.commit('posts/deletePost', postId, { root: true })
              this.$store.commit('posts/deleteLikedPost', postId, { root: true })
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'primary',
                  status: true
                },
                { root: true }
              )
            },
            (error) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: error,
                  color: 'error',
                  status: true
                },
                { root: true }
              )
              return error
            }
          )
      }
    }
  }
}
</script>
