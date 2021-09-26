<template>
  <v-list class="h-100 pos-relative">
    <v-list-item-group color="primary">
      <component v-for="(data, key) in datas" :is="getComponentName(data)" :key="key" :data="data" />
    </v-list-item-group>
  </v-list>
</template>

<script>
import SidebarService from '~/src/domain/services/sidebarService'
import HomeSidebarListItem from '~/components/organisms/list/HomeSidebarListItem'
import BaseSidebarListItem from '~/components/organisms/list/BaseSidebarListItem'

const NAME = 'login'
const Sidebar = new SidebarService(NAME)
const ImportComponents = Sidebar.importComponents

export default {
  components: {
    ImportComponents,
    HomeSidebarListItem,
    BaseSidebarListItem
  },

  computed: {
    datas: () => Sidebar.datas,
    getComponentName () {
      return data => Sidebar.componentName(data)
    }
  }
}
</script>
