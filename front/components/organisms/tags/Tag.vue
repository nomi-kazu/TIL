<template>
  <v-row
    class="mb-3"
    style="border-bottom: solid 1px #ccc;"
  >
    <v-col cols="12" class="pb-0">
      <nuxt-link
        :to="{ path: `/tags/${tag.id}` }"
        style="color: inherit; text-decoration: none;"
      >
        <v-card-text style="padding: 0;">
          {{ tag.name }}
        </v-card-text>
      </nuxt-link>
    </v-col>
    <v-col cols="7">
      <v-row no-gutters>
        <v-col cols="12">
          <span class="font-weight-bold pr-2">
            フォロワー
          </span>
          {{ tag.users.length }}
        </v-col>
        <v-col cols="12">
          <span class="font-weight-bold pr-2">
            投稿
          </span>
          {{ tag.posts.length }}
        </v-col>
      </v-row>
    </v-col>
    <v-col cols="2">
      <v-btn
        icon
        @click="deleteTag(tag.id)"
      >
        <v-icon>
          mdi-trash-can-outline
        </v-icon>
      </v-btn>
    </v-col>
    <v-col cols="5">
      <TagFollowBtnGroup
        :tag="tag"
        class="float-right"
      />
    </v-col>
  </v-row>
</template>

<script>
import TagFollowBtnGroup from '~/components/molecules/tags/TagFollowBtnGroup'

export default {
  components: {
    TagFollowBtnGroup
  },
  props: {
    tag: {
      type: Object,
      default: () => {}
    }
  }
}
</script>
