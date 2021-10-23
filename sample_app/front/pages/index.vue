<template>
  <div>
    <v-img
      dark
      src="images/top_img.jpg"
      gradient="to top right, rgba(201, 214, 255, 0.6), rgba(226, 226, 226, 0.9)"
      :height="imgHeight"
    >
      <v-container>
        <v-row
          align="center"
          justify="center"
          :style="{ height: `${imgHeight}px`}"
        >
          <v-col
            cols="12"
            class="text-center"
          >
            <h1
              class="display-1 mb-4"
              :style="{ letterSpacing: '15px' }"
            >
              TILを記録しよう
            </h1>
            <h3
              class="subheading"
              :style="{ letterSpacing: '5px' }"
            >
              subtitle
            </h3>
          </v-col>
        </v-row>
      </v-container>
    </v-img>
    <div>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-card-text class="text-h6 font-weight-bold">
              注目記事
            </v-card-text>
            <FamousPosts
              :posts="famousPosts"
              :loading="loading"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import FamousPosts from '~/components/organisms/FamousPosts'

export default {
  components: {
    FamousPosts
  },

  data () {
    return {
      loading: false,
      model: [],
      imgHeight: 250
    }
  },

  computed: {
    ...mapGetters({ famousPosts: 'posts/famousPosts' })
  },

  async mounted () {
    this.loading = true
    await this.$axios.get('/api/v1/top')
      .then((response) => {
        this.$store.commit('posts/setFamousPosts', response.data.posts, { root: true })
      })
      .catch((error) => {
        return error
      })
    setTimeout(this.stopLoading, 500)
  },

  methods: {
    stopLoading () {
      this.loading = false
    }
  }
}
</script>
