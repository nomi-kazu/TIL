<template>
  <PostsTemplate
    :post="post"
    :comments="comments"
  />
</template>

<script>
import { mapGetters } from 'vuex'
import PostsTemplate from '~/components/templates/PostsTemplate'

export default {
  components: {
    PostsTemplate
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`/api/v1/posts/${params.id}`)
      .then((response) => {
        store.commit('posts/setPost', response.data, { root: true })
        store.commit('comments/setComments', response.data.comments, { root: true })
      })
      .catch((error) => {
        return error
      })
  },

  computed: {
    ...mapGetters({
      post: 'posts/post',
      comments: 'comments/comments'
    })
  }
}
</script>
