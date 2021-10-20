<template>
  <v-dialog
    v-model="dialog"
    persisitent
    max-width="600"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
        color="info"
        v-on="on"
      >
        <v-icon left>
          mdi-comment-outline
        </v-icon>
        コメントする
      </v-btn>
    </template>

    <v-card>
      <v-banner
        class="grey lighten-5"
        sticky
        outlined
      >
        <v-btn
          class="float-right"
          text
          @click="dialog = false"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
      </v-banner>
      <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
        <v-container>
          <v-form>
            <v-card-text class="pb-0">
              <TextAreaWithValidation
                v-model="content"
                label="コメント"
                rules="required"
                outlined
              />
            </v-card-text>
          </v-form>
          <v-card-text>
            <v-btn
              :disabled="invalid || loading"
              :loading="loading"
              block
              color="warning"
              class="white--text"
              @click="postComment"
            >
              コメントする
            </v-btn>
          </v-card-text>
        </v-container>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
import TextAreaWithValidation from '~/components/atoms/TextAreaWithValidation'

export default {
  components: {
    TextAreaWithValidation
  },

  props: {
    post: {
      type: Object,
      default: null
    }
  },

  data () {
    return {
      content: '',
      dialog: false,
      loading: false,
      tab: null
    }
  },

  methods: {
    async postComment () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true
      if (isValid) {
        formData.append('comment[user_id]', this.$auth.user.id)
        formData.append('comment[post_id]', this.post.id)
        formData.append('comment[content]', this.content)
        await this.$axios.$post('/api/v1/comments', formData)
          .then(
            (response) => {
              this.$store.commit('comments/addComments', response, { root: true })
              this.content = ''
              this.$refs.form.reset()
            },
            (error) => {
              return error
            }
          )
      }
      this.loading = false
      this.dialog = false
    }
  }
}
</script>
