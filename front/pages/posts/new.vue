<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="11" xs="12" sm="12" md="11">
        <v-card>
          <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
            <v-form ref="form">
              <v-card-title>記事の詳細</v-card-title>
                <AutoCompleteWithValidation
                  rules="validTime:@分"
                  v-model="hour"
                  label="時"
                  :items="hours"
                />
                <AutoCompleteWithValidation
                  rules="max_value:60|validTime:@時"
                  v-model="minute"
                  label="分"
                  :items="minutes"
                />
              <TextFieldWithValidation
                v-model="title"
                laber="タイトル"
                placeholder="記事のタイトル"
                :counter="50"
                rules="max:50|required"
                outlined
              />

              <InputImages
                v-model="images"
              />

              <InputContent
                v-model="content"
                label="本文"
                rules="required"
              />

              <v-card-subtitle>タグを入力</v-card-subtitle>
              <InputTags
                v-model="tags"
              />

              <v-card-text class="px-0">
                <v-btn
                  color="warning"
                  class="white--text"
                  :disabled="invalid || loading"
                  :loading="loading"
                  block
                  @click="createPost"
                >
                  作成
                </v-btn>
              </v-card-text>
            </v-form>
          </ValidationObserver>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AutoCompleteWithValidation from '~/components/molecles/input/AutoCompleteWithValidation'
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import InputImages from '~/components/atoms/input/InputImages'
import InputContent from '~/components/atoms/input/InputContent'
import InputTags from '~/components/atoms/input/InputTags'

export default {
  components: {
    AutoCompleteWithValidation,
    TextFieldWithValidation,
    InputImages,
    InputContent,
    InputTags
  },

  middleware: 'loginAuth',

  data () {
    return {
      hour: '',
      minute: '',
      study_time: '',
      title: '',
      content: '',
      isEnter: false,
      loading: false,
      showImages: [],
      images: [],
      tags: []
    }
  },

  computed: {
    timeProcess () {
      return this.hour + ':' + this.minute
    },

    hours () {
      const hours = []
      for (let i = 0; i < 24; i++) { hours.push(i.toString()) }
      return hours
    },

    minutes () {
      const minutes = []
      for (let i = 0; i < 60; i++) { minutes.push(i.toString()) }
      return minutes
    }
  },

  methods: {
    async createPost () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true

      if (isValid) {
        formData.append('post[study_time]', this.timeProcess)
        formData.append('post[user_id]', this.$auth.user.id)
        formData.append('post[title]', this.title)
        formData.append('post[content]', this.content)
        if (this.images) {
          this.images.forEach((image) => {
            formData.append('images[]', image)
          })
        }
        if (this.tags) {
          this.tags.forEach((tag) => {
            formData.append('post[tags][]', tag)
          })
        }
        await this.$axios.$post('/api/v1/posts', formData)
          .then(
            (response) => {
              this.$store.commit('experience/setExperience', response.experience, { root: true })
              this.$store.commit('experience/setRequiredExp', response.required_exp, { root: true })
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'success',
                  status: true
                },
                { root: true }
              )
              this.study_time = ''
              this.title = ''
              this.content = ''
              this.images = []
              this.$refs.form.reset()
              this.$router.push(`/posts/${response.post.id}`)
            },
            (error) => {
              console.log(error)
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: error,
                  color: 'error',
                  status: true
                },
                { root: true }
              )
              return error
            }
          )
        this.loading = false
      }
    }
  }
}
</script>
