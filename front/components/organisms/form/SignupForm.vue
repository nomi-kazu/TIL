<template>
  <v-form>
    <username-text-field />
    <email-text-field />
    <password-text-field />
    <orange-btn type="submit" />
  </v-form>
</template>

<script>
import UsernameTextField from '~/components/textFields/UsernameTextField'
import EmailTextField from '~/components/organisms/textFields/EmailTextField'
import PasswordTextField from '~/components/organisms/textFields/PasswordTextField'
import OrangeBtn from '~/components/atoms/btns/OrangeBtn'

export default {
  components: {
    UsernameTextField,
    EmailTextField,
    PasswordTextField,
    OrangeBtn
  }
}
</script>

<style scoped>

</style>