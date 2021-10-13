<template>
  <div>
    <!-- ログインしたユーザーに見せるもの -->
    <NoticeFeed />
    <LoginBar />
  </div>
</template>

<script>
import LoginBar from '~/components/molecules/top/LoginBar'
import NoticeFeed from '~/components/molecules/top/NoticeFeed'

export default {
  components: {
    LoginBar,
    NoticeFeed
  }
}
</script>
