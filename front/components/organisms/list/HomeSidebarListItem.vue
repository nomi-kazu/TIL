<template>
  <BaseSidebarListItem
    :data="newData"
  />
</template>

<script>
import BaseSidebarListItem from '~/components/organisms/list/BaseSidebarListItem'

export default {
  components: {
    BaseSidebarListItem
  },

  props: {
    data: {
      type: Object,
      required: true
    }
  },
  computed: {
    newData () {
      const data = Object.assign({}, this.data)
      data.to = `/${this.username}`
      return data
    },
    username () {
      return this.$auth.user.name
    }
  }
}
</script>
