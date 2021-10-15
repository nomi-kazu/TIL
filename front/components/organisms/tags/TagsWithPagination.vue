<template>
  <div>
    <v-row v-if="loading">
      <v-col cols="12">
        <v-skeleton-loader
          type="article"
        />
      </v-col>
    </v-row>
    <Tag
      v-for="tag in displayTags"
      :key="tag.id"
      :tag="tag"
    />
    <v-pagination
      v-model="page"
      color="info"
      :length="TagsLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import Tag from '~/components/organisms/tags/Tag'

export default {
  components: {
    Tag
  },

  props: {
    tags: {
      type: Array,
      default: () => {}
    },

    loading: {
      type: Boolean,
      default: null
    }
  },

  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 10
    }
  },

  computed: {
    displayTags () {
      return this.tags.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },

    TagsLength () {
      return Math.ceil(this.tags.length / this.pageSize)
    }
  },

  methods: {
    pageChange (pageNumber) {
      this.displayTags.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
