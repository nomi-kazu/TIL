<template>
  <div>
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
  </div>
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
      loading: false,
      posts: [],
      keyword: ''
    }
  },
  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/posts')
      .then((response) => {
        this.posts = response.data
      }).catch((error) => {
        return error
      })
    this.loading = false
  },
  methods: {
    async searchPosts () {
      this.loading = true
      await this.$axios.get('api/v1/admin/posts', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.posts = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    },

    async deletePost (postId) {
      await this.$axios.$delete(`/api/v1/posts/${postId}`)
        .then(
          (response) => {
            this.posts = this.posts.filter(post => post.id !== postId)
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
