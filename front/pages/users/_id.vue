<template>
  <div>
    <v-card tile color="brown lighten-5">
      <v-row align="center" justify="center" no-gutters>
        <v-col xs="12" sm="10" md="8" lg="6">
          <v-layout class="py-3 pl-13" align-content-center>
            <v-list color="brown lighten-5">
              <v-list-item>
                <v-card-actions>
                  <v-avatar
                    v-if="user.image_url"
                    color="white"
                    size="65"
                  >
                    <v-img
                      :src="user.image_url"
                    />
                  </v-avatar>
                  <v-icon
                    v-else
                    size="65"
                  >
                    mdi-account-circle
                  </v-icon>
                  <span class="pl-2">{{ user.name }}</span>
                  <FollowBtnGroup
                    :user="user"
                    :followers="followers"
                  />
                </v-card-actions>
              </v-list-item>
              <v-list-item>
                <v-card-subtitle>
                  <FollowingsModal
                    :followings="followings"
                  />
                </v-card-subtitle>
                <v-card-subtitle>
                  <FollowersModal
                    :followers="followers"
                  />
                </v-card-subtitle>
              </v-list-item>
              <v-list-item>
                <v-col cols="12" lg="8">
                  <UserExpCard
                    :user="user"
                    :requiredExp="requiredExp"
                    :posts="posts"
                  />
                </v-col>
              </v-list-item>
            </v-list>
          </v-layout>

          <v-divider />

          <v-tabs
            v-model="tabTitle"
            class="d-none d-sm-inline"
            background-color="brown lighten-5"
            color="secondary"
            show-arrows
            centered
          >
            <v-tab
              v-for="title in titles"
              :key="title.name"
            >
              {{ title.name }}
            </v-tab>
          </v-tabs>
          <div class="d-inline d-sm-none py-0">
            <div class="text-center">
              <v-btn
                icon
                @click="show = !show"
              >
                <v-icon size="30">
                  {{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}
                </v-icon>
              </v-btn>
            </div>
          </div>

          <v-divider />

          <v-expand-transition>
            <div v-show="show">
              <v-tabs
                v-model="tabTitle"
                class="d-inline d-sm-none"
                background-color="brown lighten-5"
                color="secondary"
                fixed-tabs
                vertical
              >
                <v-tab
                  v-for="title in titles"
                  :key="title.name"
                >
                  {{ title.name }}
                </v-tab>
              </v-tabs>
            </div>
          </v-expand-transition>
        </v-col>
      </v-row>
    </v-card>

    <v-container>
      <v-tabs-items v-model="tabTitle">
        <v-tab-item>
          <v-container class="grey lighten-5">
            <v-card>
              <v-card-title>自己紹介</v-card-title>
              <v-divider />
              <v-card-text>
                {{ user.description }}
              </v-card-text>
              <v-card-title>登録したタグ</v-card-title>
              <v-divider />
              <v-card-text
                v-if="user.tags && user.tags.length > 0"
                class="pb-0"
              >
                <v-chip-group
                  active-class="primary--text"
                  column
                >
                  <v-chip
                    v-for="tag in user.tags"
                    :key="tag.id"
                    color="info"
                    outlined
                    small
                  >
                    <nuxt-link
                      :to="{ path: `/tags/${tag.id}` }"
                      style="color: inherit; text-decoration: none;"
                    >
                      {{ tag.name }}
                    </nuxt-link>
                  </v-chip>
                </v-chip-group>
              </v-card-text>
              <v-card-text v-else>
                なし
              </v-card-text>
              <v-card-title>
                ユーザーのトレンド
              </v-card-title>
              <v-divider />
              <template v-if="user.tag_ranking && user.tag_ranking.length > 0">
                <v-row justify="center" no-gutters>
                  <v-col>
                    <v-subheader>タグ</v-subheader>
                    <BarChart
                      class="my-4 mx-2"
                      :tags="user.tag_ranking"
                      :height="200"
                      :width="200"
                    />
                  </v-col>
                </v-row>
                <v-row justify="center">
                  <v-col>
                    <Heatmap
                      class="my-4 mx-2"
                      :height="200"
                      :width="200"
                      :posts="posts"
                    />
                  </v-col>
                </v-row>
              </template>
              <template v-else>
                <v-row justify="center" no-gutters>
                  <v-col class="my-4 mx-2">
                    <v-card>
                      <v-card-text>
                        タグをつけた投稿
                      </v-card-text>
                    </v-card>
                  </v-col>
                </v-row>
              </template>
            </v-card>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          <v-container class="grey lighten-5">
            <template v-if="posts && posts.length > 0">
              <v-card-text v-if="$auth.user.id == user.id">
                <v-btn
                  color="primary"
                  to="/posts/new"
                >
                  投稿作成
                </v-btn>
              </v-card-text>
              <PostsWithPagination
                :posts="posts"
              />
            </template>
            <template v-else>
              <v-card>
                <v-card-text>
                  投稿記事がありません
                </v-card-text>
                <div v-if="user.id==$auth.user.id">
                  <v-divider />
                  <v-card-text>
                    <v-btn
                      color="warning"
                      to="/posts/new"
                    >
                      投稿/レビューを行う
                    </v-btn>
                  </v-card-text>
                </div>
              </v-card>
            </template>
          </v-container>
        </v-tab-item>

        <v-tab-item>
          <v-container class="grey lighten-5">
            <template v-if="likedPosts && likedPosts.length > 0">
              <PostsWithPagination
                :posts="likedPosts"
              />
            </template>
            <template v-else>
              <v-card>
                <v-card-text>
                  お気に入り記事がありません
                </v-card-text>
              </v-card>
            </template>
          </v-container>
        </v-tab-item>
      </v-tabs-items>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import UserExpCard from '~/components/organisms/users/UserExpCard'
import BarChart from '~/components/organisms/users/BarChart'
import Heatmap from '~/components/molecules/Heatmap'
import FollowBtnGroup from '~/components/molecules/users/FollowBtnGroup'
import FollowersModal from '~/components/organisms/users/FollowersModal'
import FollowingsModal from '~/components/organisms/users/FollowingsModal'
import PostsWithPagination from '~/components/organisms/posts/PostsWithPagination'

export default {
  components: {
    UserExpCard,
    BarChart,
    Heatmap,
    FollowBtnGroup,
    FollowersModal,
    FollowingsModal,
    PostsWithPagination
  },

  data () {
    return {
      tabTitle: null,
      show: false,
      titles: [
        { name: 'プロフィール詳細' },
        { name: '投稿レビュー' },
        { name: 'お気に入りレビュー' }
      ]
    }
  },

  async fetch ({ $axios, params, store }) {
    await $axios.get(`/api/v1/users/${params.id}`)
      .then((response) => {
        store.commit('user/setUser', response.data.user, { root: true })
        store.commit('user/setFollowings', response.data.user.followings, { root: true })
        store.commit('user/setFollowers', response.data.user.followers, { root: true })
        store.commit('posts/setPosts', response.data.user.posts, { root: true })
        store.commit('posts/setLikedPosts', response.data.user.liked_posts, { root: true })
      })
      .catch((error) => {
        return error
      })
  },

  computed: {
    ...mapGetters({ user: 'user/user' }),
    ...mapGetters({ followings: 'user/followings' }),
    ...mapGetters({ followers: 'user/followers' }),
    ...mapGetters({ posts: 'posts/posts' }),
    ...mapGetters({ likedPosts: 'posts/likedPosts' }),
    ...mapGetters({ experience: 'experience/experience' }),
    ...mapGetters({ requiredExp: 'experience/requiredExp' })
  }
}
</script>
