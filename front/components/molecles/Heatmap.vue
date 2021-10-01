<template>
  <VuejsHeatmap
    :tooltip-unit="tooltipUnit"
    :locale="locale"
    :tooltip-enabled="true"
    :max="max"
    :entries="entries"
    :color-range="colorRange"
  >
</VuejsHeatmap>
</template>

<script>
import VuejsHeatmap from 'vuejs-heatmap'

export default {
  components: {
    VuejsHeatmap
  },
  data () {
    return {
      tooltipUnit: 'EXP',
      locale: {
        months: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        days: ['日', '月', '火', '水', '木', '金', '土'],
        No: 'No',
        on: 'on',
        Less: 'Less',
        More: 'More'
      },
      colorRange: ['#F5F5F5', '#AED581', '#9CCC65', '#7CB342', '#689F38', '#33691E', '#215715'], // 0, 1, 30, 60, 150, 300, 300以上の時の色です。
      max: 300,
      /* eslint-disable */
      entries: [
        {
          'counting': 350,
          'created_at': '2020-06-21'
        },
        {
          'counting': 1,
          'created_at': '2020-06-22'
        },
        {
        'counting': 60,
        'created_at': '2020-06-23'
        }
      ]
      /* eslint-disable */
    }
  }
}
</script>
