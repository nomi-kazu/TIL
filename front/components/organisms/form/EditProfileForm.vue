<template>
  <v-form>
    <div class="mb-8">
      <p>プロフィール画像</p>
      <div class="d-flex align-center">
        <img src="https://picsum.photos/510/300?random" class="mr-2" />
        <preview-image-file-input />
      </div>
    </div>

    <!-- username, profileも追加したい -->
    <!-- コンポーネント名をAPIの名前と近いものにしたいので、コンポーネント未作成 -->
    
    <!-- 各divをコンポーネントに切り出す -->
    <div class="mb-8">
      <p>ユーザー名</p>
      <v-text-field v-model="userName" outlined dense />
    </div>

    <div class="mb-8">
      <p>自己紹介</p>
      <v-text-area v-model="selfIntroduction" outlined heignt="80" />
    </div>

    <div class="mb-8">
      <p>出身</p>
      <v-text-field v-model="from" outlined dense />
    </div>

    <tie-sns-link-field />
  </v-form>
</template>

<script>
const PreviewImageFileInput = () => import('~/components/organisms/fileInputs/PreviewImageFileInput')
const TieSnsLinkField = () => import('~/components/organisms/textFields/TieSnsLinkField')

export default {
  components: {
    PreviewImageFileInput,
    TieSnsLinkField
  },

  props: {
    info: {
      type: Object,
      default: undefined
    }
  },

  data: () => ({
    userName: undefined,
    selfIntroduction: undefined,
    from: undefined
  }),

  created() {
    this.userName = this.info.attributes.name
    this.selfIntroduction = this.info.attributes.profile
    this.from = this.info.attributes.address
    console.log(this.info)
  }
}
</script>

<style>
.v-form {
  width: 80%;
  text-align: left;
}

img {
  width: 45px;
  height: 45px;
  object-fit: cover;
  border-radius: 50%;
}
</style>