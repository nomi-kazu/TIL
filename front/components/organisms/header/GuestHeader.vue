<template>
  <div>
    <!-- ログインしていないユーザーに見せるもの -->
    <LoginBtn />
    <SignupBtn />
  </div>
</template>

<script>
import LoginBtn from '~/components/atoms/LoginBtn'
import SignupBtn from '~/components/atoms/SignupBtn'

export default {
  components: {
    LoginBtn,
    SignupBtn
  }
}
</script>
