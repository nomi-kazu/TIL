<template>
  <div>
    <p>{{ $store.state.uid }} : {{ $store.state.access_token }}</p>
    <p>{{ getCookie() }}</p>
  </div>
</template>

<script>
const Cookie = process.client ? require('js-cookie') : undefined

export default {
  methods: {
    getCookie() {
      return Cookie.get('access-token')
    }
  }
}
</script>
