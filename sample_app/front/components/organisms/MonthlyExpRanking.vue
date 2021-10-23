<template>
  <div>
    <template v-if="users.length === 0 && loading">
      <v-skeleton-loader
        v-for="n in 10"
        :key="n"
        class="mx-auto"
        type="list-item-avatar"
      />
    </template>
    <RankingUserCard
      v-for="(user, i) in users"
      :key="user.id"
      :user="user"
      :index="i"
    />
    <v-row
      v-if="!users.length"
      justify="center"
    >
      <span>該当するユーザーがいません</span>
    </v-row>
  </div>
</template>

<script>
import RankingUserCard from '~/components/molecules/RankingUserCard'
export default {
  components: {
    RankingUserCard
  },
  data () {
    return {
      users: [],
      loading: false
    }
  },
  mounted () {
    this.loading = true
    this.$axios.get('/api/v1/top/exp_ranking', { params: { monthly: true } })
      .then((response) => {
        this.users = response.data.users
        this.loading = false
      })
  }
}
</script>
