<template>
  <div>
    <!-- 各ユーザーのsnsへのリンク -->
    <twitter-icon fab v-if="twitterLinkIsExists" />
    <github-btn fab v-if="githubLinkIsExists" />
  </div>
</template>

<script>
const TwitterBtn = () => import('~/components/molecules/btns/TwitterBtn')
const GithubBtn = () => import('~/components/molecules/btns/GithubBtn')

export default {
  components: {
    TwitterBtn,
    GithubBtn
  },

  computed: {
    twitterLinkIsExists() {
      // リンクが存在したら、trueを返す
      return false
    },

    githubLinkIsExists() {
      // リンクが存在したら、trueを返す
      return false
    },
  }
}
</script>

<style scoped>

</style>