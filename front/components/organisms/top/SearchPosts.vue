<template>
  <v-container>
    <v-card-title>
      投稿
    </v-card-title>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchPosts"
    />
    <PostsWithPagination
      v-if="posts && posts.length > 0"
      :posts="posts"
      :loading="loading"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import PostsWithPagination from '~/components/organisms/posts/PostsWithPagination'

export default {
  components: {
    TextFieldWithValidation,
    PostsWithPagination
  },

  data () {
    return {
      keyword: '',
      posts: [],
      loading: null
    }
  },

  methods: {
    async searchPosts () {
      this.loading = true
      await this.$axios.get('/api/v1/search/posts', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.posts = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    }
  }
}
</script>
