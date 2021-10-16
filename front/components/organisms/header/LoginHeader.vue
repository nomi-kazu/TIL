<template>
  <div>
    <!-- ログインしたユーザーに見せるもの -->
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
