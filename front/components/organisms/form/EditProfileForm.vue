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
      <p>名前</p>
      <v-text-field v-model="user.userInfo.name" outlined dense />
    </div>

    <div class="mb-8">
      <p>自己紹介</p>
      <v-text-area v-model="user.userInfo.profile" outlined heignt="80" />
    </div>

    <div class="mb-8">
      <p>出身</p>
      <v-text-field v-model="user.userInfo.address" outlined dense />
    </div>

    <tie-sns-link-field />

    <div class="d-flex justify-center mt-5">
      <orange-btn @onClick="onClick">保存する</orange-btn>
    </div>
  </v-form>
</template>

<script>
const PreviewImageFileInput = () => import('~/components/organisms/fileInputs/PreviewImageFileInput')
const TieSnsLinkField = () => import('~/components/organisms/textFields/TieSnsLinkField')
const OrangeBtn = () => import('~/components/atoms/btns/OrangeBtn')

class User {
  constructor() {
    this.userInfo = {
      name: "",
      profile: "",
      address: ""
    }
  }

  infoToUserInfo(info) {
    this.name = this.info && this.info.attributes && this.info.attributes.name
    this.profile = this.info && this.info.attributes && this.info.attributes.profile
    this.address = this.info && this.info.attributes && this.info.attributes.address
  }
}

export default {
  components: {
    PreviewImageFileInput,
    TieSnsLinkField,
    OrangeBtn
  },

  props: {
    info: {
      type: Object,
      default: undefined
    }
  },

  data: () => ({
    user: new User
  }),

  created() {
    this.user.infoToUserInfo(this.info)
  },

  methods: {
    onClick() {
      this.$emit('save', this.user.userInfo)
    }
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