<template>
  <div>
    <p>{{ $store.state.uid }} : {{ $store.state.access_token }} : {{ $store.state.isAuthenticated ? 'true' : 'false' }}</p>
  </div>
</template>

<script>
const Cookie = process.client ? require('js-cookie') : undefined

export default {
  mounted() {
    if(Cookie.get("access-token")) {
      this.$store.state.isAuthenticated = true
    }
  }
}
</script>
