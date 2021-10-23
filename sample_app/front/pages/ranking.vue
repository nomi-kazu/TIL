<template>
  <v-card>
    <v-card-title>
      <v-icon small color="#ffc400">
        mdi-trophy-outline
      </v-icon>
      <span class="pl-1">獲得経験値ランキング</span>
    </v-card-title>
    <v-card-subtitle>
      <v-tabs v-model="tab" grow>
        <v-tab
          v-for="item in items"
          :key="item.tab"
        >
          {{ item.tab }}
        </v-tab>
      </v-tabs>
    </v-card-subtitle>
    <v-card-text>
      <v-tabs-items v-model="tab">
        <v-tab-item>
          <WeeklyExpRanking />
        </v-tab-item>
        <v-tab-item>
          <MonthlyExpRanking />
        </v-tab-item>
        <v-tab-item>
          <AllExpRanking />
        </v-tab-item>
      </v-tabs-items>
    </v-card-text>
  </v-card>
</template>

<script>
import WeeklyExpRanking from '~/components/organisms/WeeklyExpRanking'
import MonthlyExpRanking from '~/components/organisms//MonthlyExpRanking'
import AllExpRanking from '~/components/organisms/AllExpRanking'
export default {
  components: {
    WeeklyExpRanking,
    MonthlyExpRanking,
    AllExpRanking
  },
  data () {
    return {
      tab: null,
      items: [
        { tab: '週間' },
        { tab: '月間' },
        { tab: '全て' }
      ]
    }
  }
}
</script>
