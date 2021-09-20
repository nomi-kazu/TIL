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
    {{ users }}
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'

export default {
  components: {
    TextFieldWithValidation
  },

  data () {
    return {
      keyword: '',
      users: []
    }
  },

  methods: {
    async searchUsers () {
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
    }
  }
}
</script>
