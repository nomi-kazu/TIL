<template>
  <two-column-container :leftCols="8" :rightCols="4">
    <template #left>
      <view-file-card />
    </template>

    <template #right>
      <user-intro-card />
      <file-folder-list />
    </template>
  </two-column-container>
</template>

<script>
import TwoColumnContainer from '~/components/molecules/containers/TwoColumnContainer'
import FileFolderList from '~/components/organisms/list/FileFolderList'
import FolderBreadcrumbs from '~/components/organisms/breadcrumbs/FolderBreadcrumbs'
import UserIntroCard from '~/components/organisms/cards/UserIntroCard'
import ViewFileCard from '~/components/organisms/cards/ViewFileCard'

export default {
  components: {
    TwoColumnContainer,
    FileFolderList,
    FolderBreadcrumbs,
    UserIntroCard,
    ViewFileCard
  }
}
</script>

<style scoped>

</style>