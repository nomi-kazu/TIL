<template>
  <v-form>
    <preview-image-file-input />

    <!-- username, profileも追加したい -->
    <!-- コンポーネント名をAPIの名前と近いものにしたいので、コンポーネント未作成 -->
    
    <!-- snsに紐付ける -->
    <tie-sns-btn-group />
  </v-form>
</template>

<script>
import PreviewImageFileInput from '~/components/organisms/fileInputs/PreviewImageFileInput'
import TieSnsBtnGroup from '~/components/organisms/btnGroup/TieSnsBtnGroup'

export default {
  components: {
    PreviewImageFileInput,
    TieSnsBtnGroup
  }
}
</script>

<style scoped>

</style>