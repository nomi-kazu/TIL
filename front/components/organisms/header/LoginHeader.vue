<template>
  <div>
    <!-- ログインしたユーザーに見せるもの -->
    <Notification />
    <LoginBar />
  </div>
</template>

<script>
import LoginBar from '~/components/molecles/top/LoginBar'
import Notification from '~/components/molecles/top/Notification'

export default {
  components: {
    LoginBar,
    Notification
  }
}
</script>
