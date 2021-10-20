<template>
  <v-container>
    <v-card-title>
      ユーザー
    </v-card-title>
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
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/TextFieldWithValidation'
import UsersWithPagination from '~/components/organisms/users/UsersWithPagination'

export default {
  components: {
    TextFieldWithValidation,
    UsersWithPagination
  },

  data () {
    return {
      keyword: '',
      users: [],
      loading: null
    }
  },

  methods: {
    async searchUsers () {
      this.loading = true
      await this.$axios.get('/api/v1/search/users', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.users = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    }
  }
}
</script>
