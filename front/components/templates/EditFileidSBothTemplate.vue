<template>
  <two-column-container :leftCols="6" :rightCols="6">
    <template #left>
      <edit-markdown />
    </template>

    <template #right>
      <view-file-card />
      <blue-btn />
    </template>
  </two-column-container>
</template>

<script>
import TwoColumnContainer from '~/components/molecules/containers/TwoColumnContainer'
import ViewFileCard from '~/components/organisms/cards/ViewFileCard'
import EditMarkdown from '~/components/organisms/markdown/EditMarkdown'
import BlueBtn from '~/components/atoms/btns/BlueBtn'

export default {
  components: {
    TwoColumnContainer,
    ViewFileCard,
    EditMarkdown,
    BlueBtn
  }
}
</script>

<style scoped>

</style>