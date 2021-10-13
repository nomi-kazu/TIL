<template>
  <v-menu
    v-model="noticeVal"
    app
    offset-x
    offset-y
    max-width="300"
  >
    <template #activator="{ on, attrs }">
      <v-badge
        color="orange"
        :content="count"
        :value="count"
        overlap
      >
        <v-icon v-bind="attrs" v-on="on" @click="openNoticeFeed">
          mdi-bell-outline
        </v-icon>
      </v-badge>
    </template>
    <v-list subheader two-line width="300px">
      <v-card flat>
        <v-card-title>
          <v-icon>
            mdi-bell-outline
          </v-icon>
          <span id="notice-title">通知</span>
          <v-spacer />
          <v-card flat to="/notices">
            <span id="notice-sublink">通知一覧</span>
          </v-card>
        </v-card-title>
        <v-card-text>
          <Notice
            v-for="notice in notices"
            :key="notice.id"
            :notice="notice"
          />
          <span v-if="!notices.length">通知はありません。</span>
        </v-card-text>
      </v-card>
    </v-list>
  </v-menu>
</template>
<script>
import Notice from '~/components/molecules/Notice'

export default {
  components: {
    Notice
  },
  data () {
    return {
      count: 0,
      noticeFeed: false,
      notices: [],
      noticeVal: false
    }
  },
  mounted () {
    this.$axios.$get('/api/v1/notices/unchecked', {
      params: {
        user_id: this.$auth.user.id
      }
    })
      .then((response) => {
        this.count = response
      })
  },

  methods: {
    openNoticeFeed () {
      if (this.noticeFeed === false) {
        this.$axios.$get('/api/v1/notices/checked', {
          params: {
            user_id: this.$auth.user.id
          }
        })
          .then((response) => {
            response.forEach((n) => {
              switch (n.action) {
                case ('like'):
                  n.noticeActionUser = `${n.action_user.name}さんが`
                  n.noticeAction = 'あなたの投稿にいいねしました'
                  n.noticeLink = `/posts/${n.post.id}`
                  n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                  break
                case ('post_comment'):
                  n.noticeActionUser = `${n.action_user.name}さんが`
                  n.noticeAction = 'あなたの投稿にコメントしました'
                  n.noticeLink = `/posts/${n.post.id}`
                  n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                  break
                case ('post_comments'):
                  n.noticeActionUser = `${n.action_user.name}さんが`
                  n.noticeAction = '投稿にコメントしました'
                  n.noticeLink = `/posts/${n.post.id}`
                  n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                  break
                case ('follow'):
                  n.noticeActionUser = `${n.action_user.name}さんが`
                  n.noticeAction = 'あなたをフォローしました'
                  n.noticeLink = `/users/${n.action_user.id}`
                  n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                  break
              }
            })
            this.notices = response
          })
      }
      this.noticeFeed = !this.noticeFeed
      this.count = 0
    }
  }
}
</script>

<style scoped>
#notice-title {
  font-size: 0.8em;
}
#notice-sublink {
  font-size: 0.6em;
}
</style>
