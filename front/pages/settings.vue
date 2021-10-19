<template>
  <v-container>
    <v-row>
      <v-col cols="12">
        <v-card style="padding: 20px;">
          <v-card-title>
            <h4>通知</h4>
          </v-card-title>
          <v-card-text>
            <SettingCheckBox
              v-model="noticeComment"
              label="コメント"
              icon="mdi-comment-text-outline"
              explanation="自分の記録にコメントが付いた時に通知されます。"
              @input="updateNoticeSetting"
            />
            <SettingCheckBox
              v-model="noticeFollow"
              label="フォロー"
              icon="mdi-account-multiple"
              explanation="自分がフォローされた時に通知されます。"
              @input="updateNoticeSetting"
            />
            <SettingCheckBox
              v-model="noticePostLike"
              label="いいね"
              icon="mdi-heart"
              explanation="記録がいいねされた時に通知されます。"
              @input="updateNoticeSetting"
            />
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import SettingCheckBox from '~/components/molecules/SettingCheckBox'

export default {
  components: {
    SettingCheckBox
  },
  data () {
    return {
      noticeComment: true,
      noticeFollow: true,
      noticePostLike: true
    }
  },
  mounted () {
    this.noticeComment = this.$auth.user.notice_comment
    this.noticeFollow = this.$auth.user.notice_follow
    this.noticePostLike = this.$auth.user.notice_post_like
  },
  methods: {
    async updateNoticeSetting () {
      const formData = new FormData()
      formData.append('setting[notice_comment]', this.noticeComment)
      formData.append('setting[notice_follow]', this.noticeFollow)
      formData.append('setting[notice_post_like]', this.noticePostLike)
      await this.$axios.$patch(`/api/v1/users/${this.$auth.user.id}/setting`, formData)
        .then(
          (response) => {
            return response
          })
        .catch(
          (error) => {
            return error
          })
    }
  }
}
</script>
