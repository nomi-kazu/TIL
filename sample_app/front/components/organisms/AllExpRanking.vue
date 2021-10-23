<template>
  <div>
    <RankingUserCard
      v-for="(user, i) in users"
      :key="user.id"
      :user="user"
      :index="i"
    />
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
    this.$axios.get('/api/v1/top/exp_ranking')
      .then((response) => {
        this.users = response.data.users
      })
  }
}
</script>
