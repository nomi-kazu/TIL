<template>
  <div>
    <v-row v-if="loading">
      <v-col
        v-for="n in 10"
        :key="n"
        cols="12"
      >
        <v-skeleton-loader
          type="article, actions"
        />
      </v-col>
    </v-row>
    <Post
      v-for="post in displayPosts"
      :key="post.id"
      :post="post"
    />
    <v-pagination
      v-model="page"
      color="info"
      :length="PostsLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import Post from '~/components/organisms/posts/Post'

export default {
  components: {
    Post
  },
  props: {
    posts: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 5,
      loading: false
    }
  },

  computed: {
    displayPosts () {
      return this.posts.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },

    PostsLength () {
      return Math.ceil(this.posts.length / this.pageSize)
    }
  },

  mounted () {
    this.loading = true
    setTimeout(this.stopLoading, 500)
  },

  methods: {
    pageChange (pageNumber) {
      this.displayPosts.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    },

    stopLoading () {
      this.loading = false
    }
  }
}
</script>
