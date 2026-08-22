<template>
  <div class="qq-sharing">
    <button class="icon-btn" @click="qqShare" title="分享到QQ">
      <div class="icon" v-html="qqIcon"></div>
      <span class="text">QQ分享</span>
    </button>
  </div>
</template>

<script setup>
import { ref } from "vue";

// --- Props ---
// 组件依然只接收 title 这一个 prop
const props = defineProps({
  title: {
    type: String,
    required: true,
    default: "分享标题",
  },
});

// --- Data ---
const qqIcon = ref(
  `<svg t="1755157395229" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6925" width="20" height="20"><path d="M512 512m-512 0a512 512 0 1 0 1024 0 512 512 0 1 0-1024 0Z" fill="#4FB6F9" p-id="6926"></path><path d="M760.86731 655.819034c-8.968828 11.22869-32.591448-2.224552-50.564413-39.335724-4.484414 16.843034-15.713103 43.820138-41.595587 77.541518 42.725517 10.134069 53.954207 51.694345 40.465656 74.187034-10.098759 15.748414-32.591448 29.236966-71.927173 29.236966-70.797241 0-101.164138-19.102897-115.782621-32.626759-2.224552-3.354483-6.708966-4.484414-12.35862-4.484414-5.614345 0-8.968828 1.129931-12.358621 4.484414-13.453241 13.523862-44.950069 32.626759-115.74731 32.626759-39.335724 0-62.958345-13.488552-71.962483-29.236966-14.583172-22.49269-2.224552-64.052966 40.465655-74.151724-24.717241-33.75669-35.945931-60.733793-41.560276-77.576828-16.843034 37.075862-41.595586 51.694345-50.599724 39.335724-6.708966-10.098759-10.098759-31.461517-8.968827-46.11531 4.484414-56.143448 41.560276-103.353379 64.052965-128.105931-3.389793-6.708966-10.134069-48.304552 18.008276-76.446896v-2.224552C330.398897 291.663448 409.035034 211.862069 509.069241 211.862069c98.904276 0 178.740966 79.801379 178.740966 191.028965v2.259863c28.071724 28.142345 21.327448 69.702621 17.972965 76.482206 21.362759 24.717241 59.568552 71.891862 64.052966 128.105931 1.129931 14.618483-1.129931 35.981241-8.968828 46.08z" fill="#FFFFFF" p-id="6927"></path></svg>`
);

// --- Methods ---
const qqShare = () => {
  const baseUrl = "https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey";

  // 准备参数
  const params = {
    url: window.location.href,
    desc: props.title, // desc 使用 prop.title
    summary: "", // summary 为空
    title: props.title, // title 使用 prop.title
    style: "203",
    width: "98",
    height: "22",
  };

  // 将参数对象转换为查询字符串
  const queryString = Object.entries(params)
    .map(([key, value]) => `${key}=${value}`)
    .join("&");

  const urlPath = `${baseUrl}?${queryString}`;

  // 打开分享窗口
  window.open(
    urlPath,
    "qq-share",
    "width=760,height=580,location=no,menubar=no"
  );
};
</script>

<style scoped>
.qq-sharing {
  display: flex;
  gap: 16px;
}
.icon-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--secondary-color, #6c757d);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 14px;
  transition: color 0.25s ease;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.icon-btn .icon {
  fill: var(--secondary-color, #6c757d);
  transition: fill 0.25s ease;
  width: 20px;
  height: 20px;
}
.icon-btn:hover {
  color: var(--primary-color, #1e90ff);
}
.icon-btn:hover .icon {
  fill: var(--primary-color, #1e90ff);
}
</style>
