<template>
  <NoticesTemplate
    :notices="notices"
    :loading="loading"
  />
</template>

<script>
import NoticesTemplate from '~/components/templates/NoticesTemplate'

export default {
  components: {
    NoticesTemplate
  },
  async asyncData ({ $axios, $auth, $moment }) {
    return await $axios.$get('/api/v1/notices', {
      params: {
        user_id: $auth.user.id
      }
    })
      .then((response) => {
        response.forEach((n) => {
          switch (n.action) {
            case ('like'):
              n.noticeActionUser = `${n.action_user.name}さんが`
              n.noticeAction = 'あなたの投稿にいいねしました'
              n.noticeLink = `/posts/${n.post.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('post_comment'):
              n.noticeActionUser = `${n.action_user.name}さんが`
              n.noticeAction = 'あなたの投稿にコメントしました'
              n.noticeLink = `/posts/${n.post.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('post_comments'):
              n.noticeActionUser = `${n.action_user.name}さんが`
              n.noticeAction = '投稿にコメントしました'
              n.noticeLink = `/posts/${n.post.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('follow'):
              n.noticeActionUser = `${n.action_user.name}さんが`
              n.noticeAction = 'あなたをフォローしました'
              n.noticeLink = `/users/${n.action_user.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
          }
        })
        return {
          notices: response
        }
      })
  },
  data () {
    return {
      loading: true,
      notices: []
    }
  },
  mounted () {
    this.loading = true
  }
}
</script>
