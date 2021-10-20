<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="11" xs="12" sm="12" md="11">
        <v-card>
          <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
            <v-form ref="form">
              <v-container>
                <v-card-title class="pb-0">
                  <span v-if="editValue">
                    TILを編集する
                  </span>
                  <span v-else>
                    TILを記録する
                  </span>
                </v-card-title>
                <v-row
                  style="position: relative"
                >
                  <v-col
                    sm="3"
                    cols="5"
                    @click="datePicker = !datePicker"
                  >
                    <v-row justify="center" class="mt-5">
                      <span style="font-size: 1.4em">
                        {{ studyDate }}
                      </span>
                    </v-row>
                  </v-col>
                  <ValidationProvider
                    vid="学習日時"
                  >
                    <v-input
                      v-model="studyDate"
                      type="hidden"
                    />
                    <v-date-picker
                      v-if="datePicker"
                      v-model="studyDate"
                      locale="ja"
                      :allowed-dates="allowedDates"
                      @input="datePicker = false"
                    />
                  </ValidationProvider>
                  <v-col lg="2" sm="3" cols="4">
                    <AutoCompleteWithValidation
                      rules="max_value:23|validDate:@分 ,@学習日時"
                      v-model="studyDateHour"
                      label="時 "
                      :items="hours"
                    />
                  </v-col>
                  <v-col lg="2" cols="3">
                    <AutoCompleteWithValidation
                      rules="max_value:59|validDateMinutes:@時 ,@学習日時"
                      v-model="studyDateMinute"
                      label="分 "
                      :items="minutes"
                    />
                  </v-col>
                </v-row>
                <v-row>
                  <v-col sm="4" cols="6">
                    <AutoCompleteWithValidation
                      rules="validTime:@分"
                      v-model="hour"
                      label="学習時間"
                      :items="hours"
                    />
                  </v-col>
                  <v-col sm="4" cols="6">
                    <AutoCompleteWithValidation
                      rules="max_value:60|validTime:@学習時間"
                      v-model="minute"
                      label="分"
                      :items="minutes"
                    />
                  </v-col>
                </v-row>

                <TextAreaWithValidation
                  v-model="content"
                  label="メモ"
                  outlined
                />

                <InputTags
                  v-model="tags"
                />

                <InputImages
                  v-if="!editValue"
                  v-model="images"
                />

                <InputImages
                  v-else
                  v-model="images"
                  :images_url="editValue.images_data"
                  @deletelIds="deletelIdList"
                />

                <v-card-text class="px-0">
                  <v-btn
                    color="warning"
                    class="white--text"
                    :disabled="invalid || loading"
                    :loading="loading"
                    block
                    @click="record"
                  >
                    作成
                  </v-btn>
                </v-card-text>
              </v-container>
            </v-form>
          </ValidationObserver>
        </v-card>
      </v-col>
    </v-row>
    <ExpDownAlert
      :displayModal="displayAlert"
      @cancel="cancel"
      @understanding="understanding"
    />
  </v-container>
</template>

<script>
import AutoCompleteWithValidation from '~/components/molecules/AutoCompleteWithValidation'
import TextAreaWithValidation from '~/components/atoms/TextAreaWithValidation'
import InputTags from '~/components/atoms/InputTags'
import InputImages from '~/components/atoms/InputImages'
import ExpDownAlert from '~/components/organisms/ExpDownAlert'

export default {
  components: {
    AutoCompleteWithValidation,
    TextAreaWithValidation,
    InputTags,
    InputImages,
    ExpDownAlert
  },

  middleware: 'loginAuth',
  props: {
    editValue: {
      type: Object,
      default: () => {}
    },
    initStudyDateHours: {
      type: String,
      default: new Date().getHours().toString()
    },
    initStudyDateMinutes: {
      type: String,
      default: new Date().getMinutes().toString()
    }
  },
  data () {
    return {
      hour: '',
      minute: '',
      studyDate: new Date().toLocaleDateString().replace(/\//g, '-'),
      studyDateHour: this.initStudyDateHours,
      studyDateMinute: this.initStudyDateMinutes,
      content: '',
      isEnter: false,
      loading: false,
      datePicker: false,
      displayAlert: false,
      tags: [],
      deleteIds: [],
      images: []
    }
  },

  async fetch ({ $axios, params, store }) {
    await $axios.get(`/api/v1/posts/${params.id}`)
      .then((response) => {
        store.commit('posts/setPost', response.data, { root: true })
      })
      .catch((error) => {
        return error
      })
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
    },
    studyDateProcessing () {
      return this.studyDate.toString() + ' ' + this.studyDateHour + ':' + this.studyDateMinute
    }
  },

  mounted () {
    if (this.editValue) {
      const time = new Date(this.editValue.study_time)
      const hour = time.getHours()
      const minute = time.getMinutes()
      const studyDate = new Date(this.editValue.study_date)
      this.hour = hour.toString()
      this.minute = minute.toString()
      this.content = this.editValue.content
      this.studyDate = this.dateFormat(studyDate)
    } else {
      this.hour = '0'
      this.minute = '1'
    }
  },
  methods: {
    record () {
      const isValid = this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true

      if (isValid) {
        formData.append('post[study_time]', this.timeProcess)
        formData.append('post[study_date]', this.studyDateProcessing)
        formData.append('post[user_id]', this.$auth.user.id)
        if (this.content) {
          formData.append('post[content]', this.content)
        }
        if (this.tags) {
          this.tags.forEach((tag) => {
            formData.append('post[tags][]', tag)
          })
        }
        if (this.images) {
          this.images.forEach((image) => {
            formData.append('images[]', image)
          })
        }
        if (this.deleteIds) {
          this.deleteIds.forEach((deleteId) => {
            formData.append('post[delete_ids][]', deleteId)
          })
        }
        if (this.editValue) {
          // 経験値が減る場合は警告を出す
          const oldExp = this.editValue.experience_record.obtained_exp
          const nexExp = Number(this.hour) * 60 + Number(this.minute)
          if (oldExp > nexExp) {
            this.displayAlert = true
          } else {
            this.$emit('record', { formData })
          }
        } else {
          this.$emit('record', { formData })
          this.hour = '0'
          this.minute = '1'
          this.content = ''
          this.tags = []
          this.images = []
          this.studyDate = this.dateFormat(new Date())
          this.studyDateHour = new Date().getHours().toString()
          this.studyDateMinute = new Date().getMinutes().toString()
          this.$refs.form.reset()
        }
      }
      this.loading = false
    },
    cancel () {
      this.displayAlert = false
    },
    understanding () {
      const formData = new FormData()
      formData.append('post[study_time]', this.timeProcess)
      formData.append('post[study_date]', this.studyDateProcessing)
      formData.append('post[user_id]', this.$auth.user.id)
      formData.append('post[content]', this.content)
      if (this.tags) {
        this.tags.forEach((tag) => {
          formData.append('post[tags][]', tag)
        })
      }
      if (this.images) {
        this.images.forEach((image) => {
          formData.append('images[]', image)
        })
      }
      this.displayAlert = false
      this.$emit('record', { formData })
    },
    allowedDates (val) {
      const today = new Date()
      let week = []
      week.unshift(new Date(today))
      for (let i = 0; i < 7; i++) {
        week.unshift(new Date(today.setDate(today.getDate() - 1)))
      }
      const that = this
      week = week.map((dt) => {
        return that.dateFormat(dt)
      })
      return week.includes(val)
    },
    dateFormat (dt) {
      const [year, month, day] = dt.toLocaleDateString().split('/')
      const monthStr = ('0' + month).slice(-2)
      const dayStr = ('0' + day).slice(-2)
      return `${year}-${monthStr}-${dayStr}`
    },
    deletelIdList (id) {
      this.deleteIds.push(id)
    }
  }
}
</script>
