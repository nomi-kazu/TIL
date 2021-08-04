<template>
  <v-list-item-group>
    <component v-for="(data, key) in datas" :is="getComponentName(data)" :key="key" :data="data" />
  </v-list-item-group>
</template>

<script>
import { getDatas, importComponents, getComponentName } from '~/utils/services/sidebarService'
const NAME = 'login'

export default {
  components: importComponents(NAME),

  computed: {
    datas: () => getDatas(NAME),

    getComponentName() {
      return (data) => getComponentName(data)
    }
  },
}
</script>

<style>

</style>