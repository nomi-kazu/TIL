<template>
  <div v-if="notices && notices.length > 0">
    <Notice
      v-for="(notice, index) in displayNotices"
      :key="index"
      dense
      :notice="notice"
    />
    <v-pagination
      v-model="page"
      color="info"
      :length="NoticesLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import Notice from '~/components/molecules/Notice'

export default {
  components: {
    Notice
  },
  props: {
    notices: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 5
    }
  },
  computed: {
    displayNotices () {
      return this.notices.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    NoticesLength () {
      return Math.ceil(this.notices.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayNotices.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
