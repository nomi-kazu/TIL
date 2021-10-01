<template>
  <div>
    <!-- ログインしたユーザーに見せるもの -->
    <NoticeFeed />
    <LoginBar />
  </div>
</template>

<script>
import LoginBar from '~/components/molecles/top/LoginBar'
import NoticeFeed from '~/components/molecles/top/NoticeFeed'

export default {
  components: {
    LoginBar,
    NoticeFeed
  }
}
</script>
