<template>
  <section class="recommended-section">
    <div class="content-wrapper">
      <h2 class="section-title">精选推荐</h2>
      <div class="recommended-list">
        <div v-for="item in items" :key="item.id" class="recommended-item">
          <div class="item-image">
            <img
              :src="
                item.imageUrl || item.photo || item.imageUrl || defaultImage
              "
              :alt="item.title"
              @error="handleImageError"
            />
          </div>
          <div class="item-content">
            <h3 class="item-title">{{ item.title || item.name }}</h3>
            <p class="item-description">
              <span v-if="item.detail" v-html="item.detail"></span>
              <span v-else v-html="item.details"></span>
            </p>
            <button @click="navigateToDetail(item)" class="btn-detail">
              查看详情
            </button>
          </div>
        </div>
        <div v-if="items.length == 0" class="no-items">暂无推荐内容。</div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, getCurrentInstance } from "vue";
import requestApi from "@/utils/axios";
// 引入获取用户信息与获取id
import { GetUserId, getUserData } from "@/utils/auth";
import { useRouter, useRoute } from "vue-router";
const router = useRouter();
const route = useRoute();

// 存储推荐项数据
const items = ref([]);

const defaultImage =
  "https://placehold.co/400x250/cccccc/333333?text=Recommended";

const mockRecommendedItems = [];

/**
 * @description 获取推荐项数据
 */
const fetchRecommendedItems = async () => {
  try {
    const userid = await GetUserId();
    const response = await requestApi.post(
      "/api/activityinformation/userCFRecommend",
      {
        id: userid,
      }
    );

    if (response.code == 0) {
      items.value = response.data;
      console.log("推荐内容数据已加载:", items.value);
    } else {
      console.warn("获取推荐内容失败或数据为空:", response.msg);
      items.value = mockRecommendedItems; // 使用模拟数据作为备用
    }
  } catch (error) {
    console.error("获取推荐内容失败:", error);
    items.value = mockRecommendedItems; // 请求失败时使用模拟数据
  }
};

// 处理图片加载失败
const handleImageError = (event) => {
  event.target.src = defaultImage;
};

// 跳转详情页面
const navigateToDetail = (item) => {
  router.push({
    path: "/detail",
    query: { id: item.id },
  });
};
// 组件挂载时获取数据
onMounted(() => {
  fetchRecommendedItems();
});
</script>

<style scoped>
/*
  推荐组件的样式
*/
.recommended-section {
  background-color: #fff;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  margin-bottom: 2rem;
}

.content-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  width: 100%;
}

.section-title {
  font-size: 1.8rem;
  color: #35495e;
  margin-bottom: 2rem;
  text-align: center;
  border-bottom: 1px solid #e2e8f0;
  padding-bottom: 1rem;
}

.recommended-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
}

.recommended-item {
  background-color: #f9fafb;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  display: flex;
  flex-direction: column;
}

.recommended-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
}

.item-image {
  width: 100%;
  /* 调整为响应式宽高比，而不是固定高度 */
  aspect-ratio: 16 / 9; /* 示例：16:9 宽高比 */
  overflow: hidden;
}

.item-image img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 确保图片覆盖整个区域 */
  display: block;
}

.item-content {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.item-title {
  font-size: 1.25rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 0.8rem;
}

.item-description {
  font-size: 0.9rem;
  color: #666;
  line-height: 1.6;
  margin-bottom: 1rem;
  flex-grow: 1; /* 描述占据剩余空间 */
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 3; /* 限制描述显示3行 */
  -webkit-box-orient: vertical;
}

.btn-detail {
  align-self: flex-start; /* 按钮靠左对齐 */
  padding: 0.6rem 1.2rem;
  background-color: #42b983; /* primary-color */
  color: #fff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
  transition: background-color 0.3s ease;
}

.btn-detail:hover {
  background-color: #35495e; /* secondary-color */
}

.no-items {
  text-align: center;
  padding: 2rem;
  color: #999;
  grid-column: 1 / -1; /* 占据所有列 */
}

/* 媒体查询：手机端适配 */
@media (max-width: 767px) {
  .content-wrapper {
    padding: 0 1rem; /* 调整内边距 */
  }
  .section-title {
    font-size: 1.5rem; /* 标题字体减小 */
    margin-bottom: 1.5rem;
  }
  .recommended-list {
    grid-template-columns: 1fr; /* 移动端单列显示 */
    gap: 1.5rem; /* 减小间距 */
  }
  .recommended-item {
    border-radius: 8px; /* 减小圆角 */
  }
  .item-content {
    padding: 1rem; /* 减小内边距 */
  }
  .item-title {
    font-size: 1.1rem; /* 标题字体减小 */
    margin-bottom: 0.5rem;
  }
  .item-description {
    font-size: 0.85rem; /* 描述字体减小 */
    margin-bottom: 0.8rem;
  }
  .btn-detail {
    padding: 0.5rem 1rem; /* 按钮内边距减小 */
    font-size: 0.9rem; /* 按钮字体减小 */
  }
}
</style>
