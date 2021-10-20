<template>
  <v-container>
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-subtitle v-if="post.study_date">
            {{ studyDate }}
            <div
              v-if="$auth.loggedIn&&$auth.user.id==post.user_id||$auth.user.admin"
              class="float-right pt-0"
            >
              <v-btn
                :to="{ path: `/posts/edit/${post.id}` }"
                icon
              >
                <v-icon>
                  mdi-square-edit-outline
                </v-icon>
              </v-btn>
              <v-btn
                icon
                @click="deletePost(post.id)"
              >
                <v-icon>
                  mdi-trash-can-outline
                </v-icon>
              </v-btn>
            </div>
          </v-card-subtitle>

          <v-card-text>
            <v-row>
              <v-col>
                <v-card-title>
                  <v-icon small>
                    mdi-clock
                  </v-icon>
                  <h1>{{ studyHour }}</h1>
                  <span>時間</span>
                  <h1>
                    {{ studyMinute }}
                  </h1>
                  <span>分</span>
                </v-card-title>
              </v-col>
              <v-col>
                <v-card-title>
                  <v-icon small>
                    mdi-pencil
                  </v-icon>
                  <h1
                    v-if="post.experience_record"
                  >
                    {{ post.experience_record.obtained_exp }}
                  </h1>
                  <h3>
                    EXP
                  </h3>
                </v-card-title>
              </v-col>
            </v-row>
          </v-card-text>
          <v-carousel
            :continuous="false"
            :show-arrows="false"
            hide-delimiter-background
            delimiter-icon="mdi-minus"
            height="auto"
            align="center"
          >
            <v-carousel-item
              v-for="(image, i) in post.images_data"
              :key="i"
              :src="image.url"
              width="80%"
            />
          </v-carousel>
          <div
            class="mx-4 mt-5"
          >
            {{ post.content }}
          </div>

          <v-card-text
            v-if="post.tags"
            class="pb-0"
          >
            <v-chip-group
              active-class="primary--text"
              column
            >
              <v-chip
                v-for="tag in post.tags"
                :key="tag"
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

          <v-card-text class="py-0">
            <LikeBtnGroup
              v-if="$auth.loggedIn"
              :post="post"
            />
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="12">
        <v-card>
          <v-container>
            <v-card-actions>
              <v-avatar color="black" size="50" class="mr-1">
                <v-img
                  v-if="post.user.image_url"
                  :src="post.user.image_url"
                />
                <v-icon
                  v-else
                  color="white"
                  size="50"
                >
                  mdi-account-circle
                </v-icon>
              </v-avatar>
              <nuxt-link
                :to="{ path: `/users/${post.user.id}` }"
                style="color: inherit; text-decoration: none;"
              >
                <span class="pl-2">
                  {{ post.user.name }}
                </span>
              </nuxt-link>
              <FollowBtnGroup
                :user="post.user"
              />
            </v-card-actions>
            <v-card-text>
              {{ post.user.description }}
            </v-card-text>
          </v-container>
        </v-card>
      </v-col>
    </v-row>

    <v-card class="mt-5">
      <v-card-title>
        コメント一覧
      </v-card-title>
      <v-divider />
      <v-container>
        <v-row justify="center">
          <v-col
            v-if="comments && comments.length > 0"
            cols="12"
            sm="12"
            lg="10"
          >
            <Comment
              v-for="comment in comments"
              :key="comment.id"
              class="mt-4"
              :comment="comment"
            />
          </v-col>
          <v-col
            v-else
            cols="12"
          >
            <v-card-text>コメントがありません</v-card-text>
          </v-col>
          <v-col cols="12">
            <v-card-text
              v-if="$auth.loggedIn"
              class="px-0"
            >
              <CommentArea
                :post="post"
              />
            </v-card-text>
            <template
              v-else
            >
              <v-card-text class="pb-0">
                <v-btn
                  to="/signup"
                  color="warning"
                >
                  新規登録
                </v-btn>
              </v-card-text>
              <v-card-text>
                <span>すでにアカウントをお持ちですですか？</span>
                <nuxt-link to="/login">
                  ログインに移動
                </nuxt-link>
              </v-card-text>
            </template>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-container>
</template>

<script>
import Comment from '~/components/molecules/Comment'
import CommentArea from '~/components/molecules/CommentArea'
import LikeBtnGroup from '~/components/molecules/LikeBtnGroup'
import FollowBtnGroup from '~/components/molecules/FollowBtnGroup'

export default {
  components: {
    Comment,
    CommentArea,
    LikeBtnGroup,
    FollowBtnGroup
  },
  props: {
    post: {
      type: Object,
      default: () => {}
    },
    comments: {
      type: Array,
      default: () => []
    }
  },
  computed: {
    studyHour () {
      const time = new Date(this.post.study_time)
      return time.getHours()
    },
    studyMinute () {
      const time = new Date(this.post.study_time)
      return time.getMinutes()
    },
    studyDate () {
      const studyDate = this.post.study_date
      const date = studyDate.substr(0, 16).split('T')[0].replace(/(\d{4})-(\d{2})-(\d{2})/, '$1年$2月$3日')
      const time = studyDate.substr(0, 16).split('T')[1]
      return date + ' ' + time
    }
  },
  methods: {
    async deletePost (postId) {
      if (window.confirm('投稿を削除してもよろしいですか？')) {
        await this.$axios.$delete(`/api/v1/posts/${postId}`, { data: { user_id: this.$auth.user.id } })
          .then(
            (response) => {
              this.$store.commit('experience/setExperience', response.experience, { root: true })
              this.$store.commit('experience/setRequiredExp', response.required_exp, { root: true })
              this.$store.commit('posts/deletePost', postId, { root: true })
              this.$store.commit('posts/deleteLikedPost', postId, { root: true })
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'primary',
                  status: true
                },
                { root: true }
              )
              this.$router.push('/')
            },
            (error) => {
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
      }
    }
  }
}
</script>
