<template>
  <div>
    <!-- ログインしたユーザーに見せるもの -->
    <n-link to="/search" style="text-decoration: none;">
      <v-icon class="mr-2" size="24">
        mdi-magnify
      </v-icon>
    </n-link>
    <NoticeFeed />
    <LoginBar />
  </div>
</template>

<script>
import LoginBar from '~/components/molecules/LoginBar'
import NoticeFeed from '~/components/molecules/NoticeFeed'

export default {
  components: {
    LoginBar,
    NoticeFeed
  }
}
</script>
