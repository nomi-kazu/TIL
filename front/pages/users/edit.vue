<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col sm="8" xs="12" md="7" lg="6">
        <v-card>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            color="secondary"
            background-color="brown lighten-5"
          >
            <v-tab>
              <v-icon>mdi-account-edit</v-icon>
              プロフィール
            </v-tab>
            <v-tab>
              <v-icon>mdi-account-lock</v-icon>
              パスワード
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item>
              <v-container>
                <EditUser />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <EditPassword />
              </v-container>
            </v-tab-item>
          </v-tabs-items>
          <v-divider />
          <DeleteUserBtn
            v-if="$auth.user.name!='guestuser'"
          />
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import EditUser from '~/components/organisms/users/EditUser'
import EditPassword from '~/components/organisms/users/EditPassword'
import DeleteUserBtn from '~/components/atoms/DeleteUserBtn'

export default {
  components: {
    EditUser,
    EditPassword,
    DeleteUserBtn
  },

  middleware: 'loginAuth',

  data () {
    return {
      tab: null
    }
  }
}
</script>
