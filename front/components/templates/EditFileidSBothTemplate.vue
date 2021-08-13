<template>
  <two-column-container justify="center" :leftCols="6" :rightCols="6">
    <template #left>
      <edit-markdown v-model="md" />
    </template>

    <template #right>
      <view-file-card :md="md" />
      <blue-btn />
    </template>
  </two-column-container>
</template>

<script>
const TwoColumnContainer = () => import('~/components/molecules/containers/TwoColumnContainer')
const ViewFileCard = () => import('~/components/organisms/cards/ViewFileCard')
const EditMarkdown = () => import('~/components/organisms/markdown/EditMarkdown')
const BlueBtn = () => import('~/components/atoms/btns/BlueBtn')

export default {
  components: {
    TwoColumnContainer,
    ViewFileCard,
    EditMarkdown,
    BlueBtn
  },

  props: {
    md: {
      get() {
        return this.value
      },

      set(newVal) {
        return this.$emit('input', newVal)
      }
    }
  }
}
</script>

<style scoped>

</style>