<template>
  <div>
    <!-- ログインしていないユーザーに見せる -->
    <header-action-btn text="ログイン" to="/user/login" />
  </div>
</template>

<script>
const HeaderActionBtn = () => ('~/components/molecules/btns/HeaderActionBtn')

export default {
  components: {
    HeaderActionBtn
  }
}
</script>