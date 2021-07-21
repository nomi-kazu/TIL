<template>
  <div>
    <p>{{ $store.state.uid }} : {{ $store.state.access_token }}</p>
  </div>
</template>

<script>
const Cookie = process.client ? require('js-cookie') : undefined

export default {
  methods: {
  }
}
</script>
