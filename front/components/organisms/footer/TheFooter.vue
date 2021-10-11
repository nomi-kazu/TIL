<template>
  <div :style="{ marginTop: `${height}px`}">
    <v-footer
      absolute
      dark
      padless
      color="amber lighten-2"
      :height="height"
    >
      <v-row justify="center" algin="center">
        <v-col cols="3" lg="1" sm="2">
          <nuxt-link
            to="/about"
            style="color: inherit; text-decoration: none;"
            class="text--secondary"
          >
            About
          </nuxt-link>
        </v-col>
        <v-col cols="3" lg="1" sm="2">
          <nuxt-link
            to="/contact"
            style="color: inherit; text-decoration: none;"
            class="text--secondary"
          >
            お問い合わせ
          </nuxt-link>
        </v-col>
        <v-col cols="3" lg="1" sm="2">
          <nuxt-link
            to="/rules"
            style="color: inherit; text-decoration: none;"
            class="text--secondary"
          >
            利用規約
          </nuxt-link>
        </v-col>
        <v-col cols="3" lg="2" sm="3">
          <nuxt-link
            to="/privacy"
            style="color: inherit; text-decoration: none;"
            class="text--secondary"
          >
            プライバシーポリシー
          </nuxt-link>
        </v-col>
        <v-col cols="12" class="p-0">
          <div class="text-center text--secondary">
            &copy;{{ copyRightYear }}
            <strong>{{ appName }}</strong>
          </div>
        </v-col>
      </v-row>
    </v-footer>
  </div>
</template>

<script>
export default {
  data ({ $config: { appName } }) {
    return {
      appName,
      height: 100
    }
  },

  computed: {
    copyRightYear () {
      const beginningYear = 2021
      const thisYear = new Date().getFullYear()
      return (beginningYear < thisYear)
        ? `${beginningYear} - ${thisYear}`
        : beginningYear
    }
  }
}
</script>
