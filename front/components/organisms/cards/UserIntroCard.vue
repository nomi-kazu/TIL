<template>
  <v-card>
    <!-- 画像 -->
    <!-- username -->
    <!-- profile -->
    <div>
      <!-- from  -->
      <user-sns-btn-group />
    </div>
  </v-card>
</template>

<script>
import UserSnsBtnGroup from '~/components/organisms/btnGroup/UserSnsBtnGroup'

export default {
  components: {
    UserSnsBtnGroup
  }
}
</script>