<template>
  <div>
    <v-card tile color="greyLight4">
      <v-row align="center" justify="center" no-gutters>
        <v-col xs="12" sm="10" md="8" lg="6">
          <v-layout class="py-3 pl-13" align-content-center>
            <v-avarar v-if="user.image_url" color="white" size="65">
              <v-img :src="user.image_url" />
            </v-avarar>
            <v-avatar v-else color="black" size="65">
              <v-icon color="white" size="80">
                mdi-account-circle
              </v-icon>
            </v-avatar>
            <v-list color="greyLight4">
              <v-list-item class="py-0 form-inline">
                {{ user.name }}
                <div v-if="$auth.loggedIn && user.id !== $auth.user.id">
                  <v-btn
                    class="ml-2"
                    color="info"
                    rounded
                  >
                    アンフォロー
                  </v-btn>
                  <v-btn
                    class="ml-2"
                    color="warning"
                    rounded
                  >
                    フォロー
                  </v-btn>
                </div>
              </v-list-item>
              <v-list-item>
                <v-card-subtitle class="pa-0">
                  フォロー
                </v-card-subtitle>
                <v-card-subtitle>
                  フォワー
                </v-card-subtitle>
              </v-list-item>
            </v-list>
          </v-layout>

          <v-divider />

          <v-tabs
            v-model="tabTitle"
            class="d-none d-sm-inline"
            background-color="greyLight4"
            color="info"
            centered
          >
            <v-tab v-for="title in titles" :key="title.name">
              {{ title.name }}
            </v-tab>
          </v-tabs>
          <v-tabs
            v-model="tabTitle"
            class="d-inline d-sm-none"
            background-color="greyLight4"
            fixed-tabs
            color="info"
            vertical
          >
            <v-tab v-for="title in titles" :key="title.name">
              {{ title.name }}
            </v-tab>
          </v-tabs>
        </v-col>
      </v-row>
    </v-card>

    <v-container>
      <v-tabs-items v-model="tabTitle">
        <v-tab-item>
          <v-card class="mx-1 my-10">
            <v-card-title>自己紹介</v-card-title>
            <v-divider />
            <v-card-text>
              <p>{{ user.description }}</p>
            </v-card-text>
            <v-card-subtitle>登録したタグ</v-card-subtitle>
            <v-card-text>
              {{ user.tags }}
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>{{ $auth.user }}</v-tab-item>
      </v-tabs-items>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      tabTitle: null,
      titles: [
        { name: 'プロフィール詳細' },
        { name: '投稿レビュー' },
        { name: 'お気に入りツール' },
        { name: 'イベント' }
      ]
    }
  },

  async fetch ({ $axios, params, store }) {
    await $axios.get(`/api/v1/users/${params.id}`)
      .then((response) => {
        store.commit('user/setUser', response.data, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },

  computed: {
    ...mapGetters({ user: 'user/user' })
  }
}
</script>
