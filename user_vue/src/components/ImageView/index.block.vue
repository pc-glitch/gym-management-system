<template>
  <div v-if="modelValue" class="image-viewer-container">
    <template v-if="displayImages.length > 0">
      <div class="thumbnail-list">
        <div
          v-for="(image, index) in displayImages"
          :key="image.url"
          class="thumbnail-item"
          @click="openImageViewer(index, $event)"
        >
          <img
            :src="image.url"
            :alt="'图片' + (index + 1)"
            class="thumbnail-img"
          />
          <div class="thumbnail-overlay">
            <el-icon class="view-icon"><View /></el-icon>
          </div>
        </div>
      </div>
    </template>
    <template v-else>
      <div class="no-images-placeholder">
        <el-icon><Picture /></el-icon>
        <p>暂无图片</p>
      </div>
    </template>

    <!-- 图片查看器 -->
    <el-image-viewer
      :hide-on-click-modal="true"
      :show-progress="true"
      :close-on-press-escape="true"
      v-if="showViewer"
      :url-list="viewerUrlList"
      :initial-index="viewerInitialIndex"
      @close="closeImageViewer"
    />
  </div>
</template>

<script setup>
import { ref, watch, computed } from "vue";

import { View, Picture } from "@element-plus/icons-vue"; // 引入 Element Plus 图标

const props = defineProps({
  // v-model 绑定，接收单个图片 URL (String) 或逗号分隔的多个图片 URL (String)
  modelValue: {
    type: String,
    default: "",
  },
  // 缩略图的尺寸 (可选，用于 CSS 样式控制)
  thumbnailSize: {
    type: String,
    default: "100px", // 例如 '80px', '120px'
  },
});

// 内部处理后的图片列表，用于渲染缩略图和传递给 ElImageViewer
// 格式为 [{ url: '...', id: '...' }]
const displayImages = ref([]);

// 图片查看器相关状态
const showViewer = ref(false); // 控制图片查看器的显示/隐藏
const viewerUrlList = computed(() => {
  // 用于图片查看器的 URL 列表
  return displayImages.value.map((image) => image.url);
});
const viewerInitialIndex = ref(0); // 图片查看器初始索引

// 监听 modelValue 的变化，同步组件内部的预览状态
watch(
  () => props.modelValue,
  (newValue) => {
    if (typeof newValue === "string" && newValue) {
      // 如果图片包含http，则直接不处理
      if (newValue.includes("http")) {
        displayImages.value = [{ url: newValue }];
        return;
      }
      // 如果不包含http，则证明是后台上传 开始处理
      // 将逗号分隔的字符串转换为图片对象数组
      displayImages.value = newValue
        .split(",")
        .filter((url) => url.trim() != "") // 过滤空字符串
        .map((url) => ({ url: url.trim(), id: url.trim() }));
      console.log(displayImages.value);
    } else {
      displayImages.value = [];
    }
  },
  { immediate: true }
); // 立即执行一次，确保初始值同步

// 打开图片查看器
const openImageViewer = (index, event) => {
  // 接收 event 对象

  // 显式阻止事件冒泡 (尽管 .stop.capture 已经做了)
  if (event && typeof event.stopPropagation === "function") {
    event.stopPropagation();
  }

  // 进一步阻止立即传播，防止同一元素上的其他监听器被触发
  if (event && typeof event.stopImmediatePropagation === "function") {
    event.stopImmediatePropagation();
  }

  if (displayImages.value.length == 0) return;
  viewerInitialIndex.value = index;
  showViewer.value = true;
};

// 关闭图片查看器
const closeImageViewer = () => {
  showViewer.value = false;
};
</script>

<style scoped>
.image-viewer-container {
  padding: 1rem;
  border-radius: 8px;
  /* 移除固定高度和宽度，让内容撑开 */
  /* min-height: 100px; */
  /* min-width: 10px; */
  /* 移除默认边框和背景，让容器更灵活 */
  /* border: 1px solid #e0e0e0; */
  /* background-color: #f9f9f9; */
  display: flex;
  align-items: center;
  justify-content: flex-start; /* 保持内容左对齐 */
  width: fit-content; /* 宽度适应内容 */
  max-width: 100%; /* 防止超出父容器 */
}

.thumbnail-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px; /* 缩略图之间的间距 */
  /* width: 100%; */ /* 移除固定宽度，让其适应内容 */
  justify-content: flex-start;
}

.thumbnail-item {
  position: relative;
  width: v-bind(thumbnailSize); /* 使用 prop 绑定的尺寸 */
  height: v-bind(thumbnailSize); /* 使用 prop 绑定的尺寸 */
  overflow: hidden;
  border-radius: 6px;
  background-color: #e9eef3;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.thumbnail-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.thumbnail-img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 裁剪图片以填充容器 */
  display: block;
}

.thumbnail-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.thumbnail-item:hover .thumbnail-overlay {
  opacity: 1;
}

.view-icon {
  color: #fff;
  font-size: 24px;
}

.no-images-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #909399;
  font-size: 14px;
  padding: 1rem; /* 为占位符添加一些内边距，确保即使无图片也有最小可见区域 */
  border: 1px dashed #e0e0e0; /* 为无图片占位符添加虚线边框 */
  background-color: #f9f9f9; /* 为无图片占位符添加背景色 */
  border-radius: 8px; /* 保持圆角 */
}

.no-images-placeholder .el-icon {
  font-size: 36px;
  margin-bottom: 0.5rem;
}
</style>
