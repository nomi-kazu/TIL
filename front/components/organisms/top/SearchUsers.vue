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
    <SearchUsersTemplate
      v-if="users && users.length > 0"
      :users="users"
      :loading="loading"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import SearchUsersTemplate from '~/components/molecles/search/SearchUsersTemplate'

export default {
  components: {
    TextFieldWithValidation,
    SearchUsersTemplate
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
        console.log(response)
        this.users = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    }
  }
}
</script>
