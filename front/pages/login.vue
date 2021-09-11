<template>
  <form-template>
    <template #form-card-content>
      <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
        <v-form>
          <TextFieldWithValidation
            v-model="email"
            label="メールアドレス"
            rules="required|email|max:30"
          />

          <TextFieldWithValidation
            v-model="password"
            label="パスワード"
            vid="password"
            rules="required|alpha_dash|min:8|max:72"
            :type="show ? 'text' : 'password'"
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show = !show"
          />

          <v-card-text class="px-0">
            <v-btn
              :disabled="invalid || loading"
              :loading="loading"
              block
              color="info"
              class="white--text"
              @click="login"
            >
              ログイン
            </v-btn>
          </v-card-text>

          <v-divider />

          <v-card-text class="px-0">
            <v-btn
              block
              color="primary"
              class="white--text"
              @click="guestLogin"
            >
              ゲストログイン
            </v-btn>
          </v-card-text>
        </v-form>
      </ValidationObserver>
    </template>
  </form-template>
</template>

<script>
import { mapActions } from 'vuex'
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import formTemplate from '~/components/template/top/formTemplate'

export default {
  components: {
    TextFieldWithValidation,
    formTemplate
  },

  middleware: 'authenticated',

  data () {
    return {
      loading: false,
      show: false,
      email: '',
      password: '',
      guest: {
        auth: {
          email: 'guestuser@example.com',
          password: 'guestuser'
        }
      }
    }
  },

  methods: {
    ...mapActions({
      userLogin: 'auth/login'
    }),

    login () {
      const isValid = this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true

      formData.append('auth[email]', this.email)
      formData.append('auth[password]', this.password)

      if (isValid) {
        this.userLogin(formData)
      }
      this.loading = false
    },

    guestLogin () {
      this.userLogin(this.guest)
    }
  }
}
</script>
