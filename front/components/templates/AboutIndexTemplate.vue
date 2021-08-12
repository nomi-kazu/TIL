<template>
  <div>
    <div class="top d-flex flex-column justify-center align-center mb-lg">
      <h1 class="text-center mb-10">TILを記録しよう</h1>
      <!-- <p><span class="hatena">?</span>TILとは</p> -->
    </div>

    <div class="text-center">
      <red-btn to="/signup">
        すぐに始める
      </red-btn>
    </div>

    <div class="text-center mb-lg">
      <h2>MarkDown形式で書ける</h2>
    </div>

    <div class="text-center mb-lg">
      <h2>フォルダ構成で管理</h2>
    </div>

    <div class="text-center mb-lg">
      <h2>他の人のTILも見れる</h2>
    </div>

    <div class="text-center mb-lg">
      <red-btn to="/signup">
        すぐに始める
      </red-btn>
    </div>
  </div>
</template>

<script>
import RedBtn from '~/components/atoms/btns/RedBtn'

export default {
  components: {
    RedBtn
  }
}
</script>

<style scoped>
h1, h2 {
  font-size: 2em;
  color: #2b486a;
}

.mb-md {
  margin-bottom: 50px;
}

.mb-lg {
  margin-bottom: 100px;
}

.top {
  height: 300px;
  background-color: #F6E58B;
}

.hatena {
  display: inline-block;
  text-align: center;
  height: 20px;
  width: 20px;
  border: 1px solid black;
  border-radius: 50%;
}
</style>