<template>
  <v-form>
    <preview-image-file-input />

    <!-- username, profileも追加したい -->

    <!-- snsに紐付ける -->
    <tie-sns-btn-group />
  </v-form>
</template>

<script>
import PreviewImageFileInput from '~/components/organisms/fileInputs/PreviewImageFileInput'
import TieSnsBtnGroup from '~/components/organisms/fileInputs/TieSnsBtnGroup'

export default {
  components: {
    PreviewImageFileInput,
    TieSnsBtnGroup
  }
}
</script>

<style scoped>

</style>