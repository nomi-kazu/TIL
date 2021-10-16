<template>
  <div v-if="notice && notice.action_user">
    <v-row>
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
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    notice: {
      type: Object,
      required: true
    }
  }
}
</script>
