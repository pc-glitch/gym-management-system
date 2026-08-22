<template>
  <section class="recommended-section">
    <div class="content-wrapper">
      <h2 class="section-title">场地信息 推荐</h2>

      <!-- 条件渲染：已登录显示推荐列表，未登录显示提示 -->
      <div v-if="isLoggedIn" class="recommended-list">
        <div v-for="item in items" :key="item.id" class="recommended-item">
          <div          v-if="item.imageUrl || item.photo || item.imageUrl" class="item-image">
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
            <div class="item-attributes">
              
                
              
                
                  <p v-if="item.name" class="attribute-item">
                    <strong>场地名称:</strong> {{ item.name }}
                  </p>
                
              
                
                  <p v-if="item.clubname" class="attribute-item">
                    <strong>俱乐部名称:</strong> {{ item.clubname }}
                  </p>
                
              
                
                  <p v-if="item.classify" class="attribute-item">
                    <strong>用途类型:</strong> {{ item.classify }}
                  </p>
                
              
                
                  <p v-if="item.yardstate" class="attribute-item">
                    <strong>场地状态:</strong> {{ item.yardstate }}
                  </p>
                
              
                
              
                
              
                
              
                
              
                
              
                
              
                
              
                
              
                
              
                
              
            </div>
            <button @click="navigateToDetail(item)" class="btn-detail">
              查看详情
            </button>
          </div>
        </div>
        <div v-if="items.length == 0 && !isLoading" class="no-items">
          暂无推荐内容。
        </div>
      </div>
      <div v-else class="login-prompt">
        <p>登录后才能查看个性化推荐哦</p>
        <button @click="goToLogin" class="btn-login">立即登录</button>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from "vue";
import requestApi from "@/utils/axios";
import { GetUserId } from "@/utils/auth";
import { useRouter } from "vue-router";

const router = useRouter();

// 状态管理
const items = ref([]);
const isLoggedIn = ref(false);
const isLoading = ref(true);

const defaultImage =
  "https://placehold.co/400x250/cccccc/333333?text=Recommended";

/**
 * @description 获取推荐项数据
 * @param {string} userId - The user ID to fetch recommendations for.
 */
const fetchRecommendedItems = async (userId) => {
  isLoading.value = true;
  try {
    const response = await requestApi.post(
      "/api/venueinformation/userCFRecommend",
      { id: userId } // 使用传入的 userId
    );
    if (response.code == 0 && response.data) {
      items.value = response.data;
    } else {
      console.warn("获取推荐内容失败或数据为空:", response.msg);
    }
  } catch (error) {
    console.error("获取推荐内容失败:", error);
  } finally {
    isLoading.value = false;
  }
};

// 处理图片加载失败
const handleImageError = (event) => {
  event.target.src = defaultImage;
};

// 跳转详情页面
const navigateToDetail = (item) => {
  router.push({
    path: "/venueinformationDetailPage",
    query: { id: item.id },
  });
};

// 跳转到登录页
const goToLogin = () => {
  router.push("/login");
};

// 组件挂载时的逻辑
onMounted(async () => {
  try {
    // 异步获取用户ID
    const userId = await GetUserId();
    if (userId) {
      // 如果成功获取ID，则视为已登录
      isLoggedIn.value = true;
      // 并用这个ID去获取推荐数据
      await fetchRecommendedItems(userId);
    } else {
      // 如果GetUserId()返回null或undefined
      isLoggedIn.value = false;
    }
  } catch (error) {
    // 如果GetUserId()抛出错误（例如token无效），也视为未登录
    console.warn("获取用户ID失败，视为未登录:", error);
    isLoggedIn.value = false;
  } finally {
    isLoading.value = false;
  }
});
</script>

<style scoped>
/*
  推荐组件的样式
*/
.login-prompt {
  text-align: center;
  padding: 3rem 1rem;
  border: 1px dashed #e2e8f0;
  border-radius: 10px;
  background-color: #f9fafb;
}
.login-prompt p {
  font-size: 1.1rem;
  color: #555;
  margin-bottom: 1.5rem;
}
.btn-login {
  padding: 0.8rem 2rem;
  background-color: #42b983;
  color: #fff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 500;
  font-size: 1rem;
  transition: background-color 0.3s ease, transform 0.2s ease;
}
.btn-login:hover {
  background-color: #35495e;
  transform: translateY(-2px);
}
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

.item-attributes {
  font-size: 0.9rem;
  color: #666;
  line-height: 1.6;
  margin-bottom: 1rem;
  flex-grow: 1;
}
.attribute-item {
  margin-bottom: 5px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.item-description {
  display: none; /* 隐藏旧的描述字段 */
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
