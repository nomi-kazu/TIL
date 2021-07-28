<template>
  <div>
    <p>パラメータ：{{ params }}</p>
    <p>ディレクトリ：{{ getDirArr }}</p>
    <p>拡張子：{{ getExt }}</p>
    <p>ファイル名：{{ getFilename }}</p>
    <p>ファイルかどうか：{{ isFile }}</p>

    <username-file-template v-if="isDir" />
    <username-folder-template v-if="isFile" />
  </div>
</template>

<script>
import { getDirArr, getExt, getFilename, isDir, isFile } from '~/utils/path'
import UsernameFileTemplate from '~/components/templates/UsernameFileTemplate'
import UsernameFolderTemplate from '~/components/templates/UsernameFolderTemplate'

export default {
  components: {
    UsernameFileTemplate,
    UsernameFolderTemplate
  },

  computed: {
    params() {
      return thid.$route.params
    },
    getDirArr() {
      return getDirArr(this.params.pathMatch)
    },
    getExt() {
      return getExt(this.params.pathMatch)
    },
    getFilename() {
      return getFilename(this.params.pathMatch)
    },
    isDir() {
      return isDir(this.params.pathMatch)
    },
    isFile() {
      return isFile(this.params.pathMatch)
    }
  },
}
</script>

<style scoped lang="scss">

</style>