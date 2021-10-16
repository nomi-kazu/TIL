<template>
  <div>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchUsers"
    />
    <UsersWithPagination
      v-if="users && users.length > 0"
      :users="users"
      :loading="loading"
    />
  </div>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import UsersWithPagination from '~/components/organisms/users/UsersWithPagination'

export default {
  components: {
    TextFieldWithValidation,
    UsersWithPagination
  },

  data () {
    return {
      loading: false,
      users: [],
      keyword: ''
    }
  },

  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/users')
      .then((response) => {
        this.users = response.data
      }).catch((error) => {
        return error
      })
    this.loading = false
  },

  methods: {
    async searchUsers () {
      this.loading = true
      await this.$axios.get('api/v1/admin/users', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.users = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    },

    async deleteUser (userId) {
      if (window.confirm('削除してもよろしいですか？')) {
        await this.$axios.delete(`/api/v1/users/${userId}`)
          .then((response) => {
            this.users = this.users.filter(user => user.id !== userId)
          })
          .catch((error) => {
            return error
          })
      }
    }
  }
}
</script>
