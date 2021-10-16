<template>
  <div>
    <v-row v-if="loading">
      <v-col
        v-for="n in 10"
        :key="n"
        cols="12"
      >
        <v-skeleton-loader
          type="list-item-avatar, divider, list-item-three-line, actions"
        />
      </v-col>
    </v-row>
    <User
      v-for="user in displayUsers"
      :key="user.id"
      :user="user"
    />
    <v-pagination
      v-model="page"
      color="info"
      :length="UsersLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import User from '~/components/organisms/users/User'

export default {
  components: {
    User
  },

  props: {
    users: {
      type: Array,
      default: () => {}
    },

    loading: {
      type: Boolean,
      default: false
    }
  },

  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 10
    }
  },

  computed: {
    displayUsers () {
      return this.users.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },

    UsersLength () {
      return Math.ceil(this.users.length / this.pageSize)
    }
  },

  methods: {
    pageChange (pageNumber) {
      this.displayUsers.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
