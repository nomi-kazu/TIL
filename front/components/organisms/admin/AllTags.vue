<template>
  <div>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchTags"
    />
    <TagsWithPagination
      v-if="tags && tags.length > 0"
      :tags="tags"
      :loading="loading"
    />
  </div>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import TagsWithPagination from '~/components/organisms/tags/TagsWithPagination'

export default {
  components: {
    TextFieldWithValidation,
    TagsWithPagination
  },

  data () {
    return {
      loading: false,
      tags: [],
      keyword: ''
    }
  },

  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/tags')
      .then((response) => {
        this.tags = response.data
      })
      .catch((error) => {
        return error
      })
    this.loading = false
  },

  methods: {
    async searchTags () {
      this.loading = true
      await this.$axios.get('api/v1/admin/tags', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.tags = response.data
      }).catch((error) => {
        return error
      })
      this.loading = false
    },

    async deleteTag (tagId) {
      if (window.confirm('削除してもよろしいですか？')) {
        await this.$axios.delete(`/api/v1/tags/${tagId}/delete_tag`)
          .then((response) => {
            this.tags = this.tags.filter(tag => tag.id !== tagId)
          })
          .catch((error) => {
            return error
          })
      }
    }
  }
}
</script>
