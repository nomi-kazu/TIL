<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card>
          <v-toolbar
            color="amber lighten-2"
            flat
          >
            <v-toolbar-title class="text--secondary">
              <v-icon>
                mdi-bell-outline
              </v-icon>
              <span>通知一覧</span>
            </v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-row>
              <v-col v-if="loading" cols="12">
                <v-skeleton-loader
                  v-for="n in 5"
                  :key="n.id"
                  class="mx-auto"
                  type="card"
                />
              </v-col>
              <v-col cols="12">
                <NoticesWithPagination
                  class="mb-4"
                  :notices="notices"
                />
                <v-row>
                  <v-col
                    v-if="!notices.length"
                    cols="12"
                    class="text-center"
                  >
                    <span>通知がありません</span>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import NoticesWithPagination from '~/components/organisms/NoticesWithPagination'

export default {
  components: {
    NoticesWithPagination
  },

  props: {
    notices: {
      type: Array,
      required: true
    },
    loading: {
      type: null,
      default: ''
    }
  }
}
</script>
