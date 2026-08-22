<template>
  <div></div>
</template>

<script setup>
import { ref, reactive, computed, watch, onMounted } from "vue";
// import { } from '@/';

import Message from "@/components/MessageBox/index.js";

// 使用 onMounted 钩子
onMounted(() => {
  // 这里可以执行在组件挂载后需要进行的操作

  Message.success("百度地图组件等待开发");
});

let data = reactive({});
</script>

<style scoped>
/* 百度地图key */
/* //   <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=obLxgJcTsjWVG3kzdmNm0Tj0SmjO9ecx"></script> */
</style>
