<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card>
          <v-toolbar
            color="amber lighten-2"
            flat
          >
            <v-toolbar-title class="text--secondary">
              <v-icon>
                mdi-bell-outline
              </v-icon>
              <span>通知一覧</span>
            </v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-row>
              <v-col cols="12" v-if="loading">
                <v-skeleton-loader
                  class="mx-auto"
                  type="card"
                  v-for="n in 5"
                  :key="n.id"
                />
              </v-col>
              <v-col cols="12" v-if="loading === false">
                <v-row
                  dense
                  v-for="(notice, index) in notices"
                  :key="index"
                >
                  <v-col cols="12">
                    <v-card
                      flat
                      :to="notice.noticeLink"
                    >
                      <v-card-text>
                        <v-row>
                          <v-col>
                            <v-avatar size="25">
                              <v-img
                                v-if="notice.action_user.image_url !== null"
                                :src="notice.action_user.image_url"
                              />
                              <v-icon v-else>
                                mdi-account-circle
                              </v-icon>
                            </v-avatar>
                            <span>{{ notice.noticeActionUser }}</span>
                            <span>{{ notice.noticeAction }}</span>
                          </v-col>
                        </v-row>
                        <v-row>
                          <v-col>
                            <span>{{ notice.noticeTime }}</span>
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-card>
                  </v-col>
                  <v-col cols="12">
                    <v-divider />
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
      loading: true,
      notices: []
    }
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
            case ('event_comment'):
              console.log(n.event)
              n.noticeActionUser = `${n.action_user.name}さんが`
              n.noticeAction = 'あなたが作成したイベントにコメントしました'
              n.noticeLink = `/events/${n.event.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('event_comments'):
              n.noticeActionUser = `${n.action_user.name}さんが`
              n.noticeAction = 'イベントにコメントしました'
              n.noticeLink = `/events/${n.event.id}`
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
  mounted () {
    this.loading = false
  }
}
</script>
