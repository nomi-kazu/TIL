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
      <v-text-field v-model="name" outlined dense />
    </div>

    <div class="mb-8">
      <p>自己紹介</p>
      <v-text-area v-model="profile" outlined heignt="80" />
    </div>

    <div class="mb-8">
      <p>出身</p>
      <v-text-field v-model="address" outlined dense />
    </div>

    <tie-sns-link-field />

    <div class="d-flex justify-center mt-5">
      <orange-btn @onClick="save">保存する</orange-btn>
    </div>
  </v-form>
</template>

<script>
const PreviewImageFileInput = () => import('~/components/organisms/fileInputs/PreviewImageFileInput')
const TieSnsLinkField = () => import('~/components/organisms/textFields/TieSnsLinkField')
const OrangeBtn = () => import('~/components/atoms/btns/OrangeBtn')

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
    name: undefined,
    profile: undefined,
    address: undefined
  }),

  created() {
    this.name = this.info.attributes.name
    this.profile = this.info.attributes.profile
    this.address = this.info.attributes.address
  },

  methods: {
    async save() {
      try {
        await this.$axios.put(`/api/v1/auth`, {
          name: this.name,
          profile: this.profile,
          address: this.address
        })
      } catch (e) {
        console.error(e)
      }
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