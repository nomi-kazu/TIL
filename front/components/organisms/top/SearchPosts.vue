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
    <SearchPostsTemplate
      v-if="posts && posts.length > 0"
      :posts="posts"
      :loading="loading"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import SearchPostsTemplate from '~/components/molecules/search/SearchPostsTemplate'

export default {
  components: {
    TextFieldWithValidation,
    SearchPostsTemplate
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
        console.log(response)
        this.posts = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    }
  }
}
</script>
