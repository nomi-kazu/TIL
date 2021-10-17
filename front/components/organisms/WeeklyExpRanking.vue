<template>
  <div>
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
      users: []
    }
  },
  mounted () {
    this.$axios.get('/api/v1/top/exp_ranking', { params: { weekly: true } })
      .then((response) => {
        this.users = response.data.users
      })
  }
}
</script>
