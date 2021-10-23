<template>
  <VuejsHeatmap
    :tooltip-unit="tooltipUnit"
    :locale="locale"
    :tooltip-enabled="true"
    :max="max"
    :entries="entries"
    :color-range="colorRange"
  />
</template>

<script>
import VuejsHeatmap from 'vuejs-heatmap'

export default {
  components: {
    VuejsHeatmap
  },
  props: {
    posts: {
      type: Array,
      required: true
    }
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
      colorRange: ['#F5F5F5', '#AED581', '#9CCC65', '#7CB342', '#689F38', '#33691E', '#215715'], // 0, 1, 30, 60, 150, 300, 300以上のEXPの時の色です。
      max: 300
    }
  },
  computed: {
    // postsを日付ごとにグループ化して返す
    entries () {
      const entries = this.posts.map((value) => {
        return {
          counting: value.experience_record.obtained_exp,
          created_at: value.study_date.split('T')[0]
        }
      })
      const group = entries.reduce((result, current) => {
        const element = result.find((pre) => {
          return pre.created_at === current.created_at
        })
        if (element) {
          element.counting += current.counting
        } else {
          result.push({
            counting: current.counting,
            created_at: current.created_at
          })
        }
        return result
      }, [])
      return group
    }
  }
}
</script>
