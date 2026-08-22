<template>
  <div class="tieba-sharing">
    <button class="icon-btn" @click="tiebaShare" title="分享到贴吧">
      <div class="icon" v-html="tiebaIcon"></div>
      <span class="text">贴吧分享</span>
    </button>
  </div>
</template>

<script setup>
import { ref } from "vue";

// --- Props ---
const props = defineProps({
  title: {
    type: String,
    required: true,
    default: "分享标题",
  },
});

// --- Data ---
// 百度贴吧 SVG 图标
const tiebaIcon = ref(
  `<svg t="1755158821316" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="10871" width="20" height="20"><path d="M512 7.68C233.472 7.68 8.192 233.472 8.192 512s225.792 503.808 503.808 503.808 503.808-225.792 503.808-503.808c0-278.528-225.28-504.32-503.808-504.32z m0 187.392" fill="#3385FF" p-id="10872"></path><path d="M472.576 273.408H329.728c-40.448 0-71.168 30.72-71.168 71.168v297.472c0 7.168 4.608 11.776 11.776 11.776h23.552c7.168 0 11.776-4.608 11.776-11.776V330.752c0-4.608 4.608-9.728 9.728-9.728h123.904c4.608 0 9.728 4.608 9.728 9.728v311.808c0 7.168 4.608 11.776 11.776 11.776h23.552c7.168 0 11.776-4.608 11.776-11.776V297.472c0.512-12.288-9.216-24.064-23.552-24.064z m14.336 452.096c-9.728-2.56-23.552-9.728-45.056-23.552-45.056-35.84-43.008-71.168-43.008-71.168V380.416c0-7.168-4.608-11.776-11.776-11.776H363.52c-7.168 0-11.776 4.608-11.776 11.776l-2.56 249.856s0 47.616-33.28 73.728c-18.944 11.776-37.888 18.944-47.616 21.504-4.608 0-9.728 4.608-9.728 9.728v23.552c0 7.168 7.168 11.776 14.336 11.776 16.896-2.56 43.008-7.168 59.392-18.944 37.888-23.552 45.056-47.616 45.056-47.616s7.168 21.504 47.616 45.056c21.504 14.336 43.008 18.944 57.344 18.944 7.168 0 14.336-4.608 14.336-11.776v-23.552c0-2.56-5.12-4.608-9.728-7.168z m259.584-214.016h-107.008V392.704h107.008c7.168 0 11.776-4.608 11.776-11.776v-23.552c0-7.168-4.608-11.776-11.776-11.776h-107.008V285.184c0-7.168-4.608-11.776-11.776-11.776H604.16c-7.168 0-11.776 4.608-11.776 11.776v225.792h-35.84c-7.168 0-11.776 4.608-11.776 11.776v238.08c0 7.168 4.608 11.776 11.776 11.776h131.072c40.448 0 71.168-33.28 71.168-71.168v-178.688c-0.512-6.656-5.632-11.264-12.288-11.264z m-35.84 190.464c0 14.336-11.776 23.552-23.552 23.552H599.04c-4.608 0-7.168-2.56-7.168-7.168v-152.064c0-4.608 2.56-7.168 7.168-7.168h104.448c4.608 0 7.168 2.56 7.168 7.168v135.68z m0 0" fill="#FFFFFF" p-id="10873"></path></svg>`
);

// --- Methods ---
const tiebaShare = () => {
  const baseUrl = "http://tieba.baidu.com/f/commit/share/openShareApi";

  // 准备贴吧分享所需的核心参数
  const params = {
    title: props.title,
    url: window.location.href,
    comment: props.title, // 将分享内容也设为标题
    to: "tieba",
    type: "text",
    sign: "on",
  };

  // 将参数对象转换为查询字符串
  const queryString = Object.entries(params)
    .map(([key, value]) => `${key}=${value}`)
    .join("&");

  const urlPath = `${baseUrl}?${queryString}`;

  // 打开分享窗口
  window.open(
    urlPath,
    "tieba-share",
    "width=760,height=600,location=no,menubar=no"
  );
};
</script>

<style scoped>
/* 样式与之前的 QQ 分享组件完全复用 */
.tieba-sharing {
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
  width: 20px;
  height: 20px;
}
.icon-btn:hover {
  color: var(--primary-color, #0066ff); /* 贴吧主题蓝 */
}
/* v-html 插入的SVG，需要用 :deep() 或 全局样式才能修改hover颜色，
   这里为了组件独立性，直接在 SVG 的 path 上设置了颜色，
   因此 hover 效果只改变文字颜色。*/
</style>
