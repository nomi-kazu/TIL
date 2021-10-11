<template>
  <div>
    <!-- ログインしていないユーザーに見せるもの -->
    <LoginBtn />
    <SignupBtn />
  </div>
</template>

<script>
import LoginBtn from '~/components/atoms/top/LoginBtn'
import SignupBtn from '~/components/atoms/top/SignupBtn'

export default {
  components: {
    LoginBtn,
    SignupBtn
  }
}
</script>
