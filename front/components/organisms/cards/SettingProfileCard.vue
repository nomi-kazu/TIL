<template>
  <v-card width="800" class="mx-auto pt-10 pl-6 pb-8">
    <edit-profile-form :info="info" @save="save" />
  </v-card>
</template>

<script>
const EditProfileForm = () => import('~/components/organisms/form/EditProfileForm')

export default {
  components: {
    EditProfileForm,
  },

  props: {
    info: {
      type: Object,
      default: undefined
    }
  },

  methods: {
    save(userInfo) {
      this.$emit('save', userInfo)
    }
  }
}
</script>

<style>

</style>