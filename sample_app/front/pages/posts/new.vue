<template>
  <PostFormTemplate
    @record="createPost"
  />
</template>

<script>
import PostFormTemplate from '~/components/templates/PostFormTemplate'

export default {
  components: {
    PostFormTemplate
  },

  middleware: 'loginAuth',

  methods: {
    async createPost (data) {
      await this.$axios.$post('/api/v1/posts', data.formData)
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
