<template>
  <PostFormTemplate
    :editValue="post"
    @record="updatePost"
  />
</template>

<script>
import { mapGetters } from 'vuex'
import PostFormTemplate from '~/components/templates/PostFormTemplate'

export default {
  components: {
    PostFormTemplate
  },
  middleware: 'loginAuth',
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/posts/${params.id}`)
      .then((response) => {
        store.commit('posts/setPost', response.data, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ post: 'posts/post' })
  },
  methods: {
    async updatePost (data) {
      await this.$axios.$patch(`/api/v1/posts/${this.post.id}`, data.formData)
        .then(
          (response) => {
            this.$store.commit('experience/setExperience', response.experience, { root: true })
            this.$store.commit('experience/setRequiredExp', response.required_exp, { root: true })
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'success',
                status: true
              },
              { root: true }
            )
            this.$router.push(`/posts/${response.post.id}`)
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
</script>
