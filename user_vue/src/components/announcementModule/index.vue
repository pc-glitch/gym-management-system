<template>
  <div class="announcement-section">
    <div class="section-container">
      <div class="header-group">
        <div class="header-left">
          <span class="sub-title">LATEST NEWS</span>
          <h2 class="main-title">最新动态</h2>
        </div>
        <button class="btn-glass" @click="navigateTo('/announcement')">
          查看全部
        </button>
      </div>

      <div class="news-grid" v-loading="loading">
        <div
          v-for="item in announcements"
          :key="item.id"
          class="news-card glass-effect"
          @click="navigateTo('/announcement')"
        >
          <div class="img-wrapper">
            <img
              :src="item.picture || defaultImg"
              class="news-img"
              alt="News"
              @error="handleImageError"
            />
            <div class="date-badge glass-effect">
              {{ formatDate(item.addtime) }}
            </div>
          </div>

          <div class="news-content">
            <h3 class="news-title">{{ item.title }}</h3>
            <div class="read-more">
              <span>Read More</span>
              <svg
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path d="M5 12h14M12 5l7 7-7 7" />
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div
        v-if="!announcements.length && !loading"
        class="empty-state glass-effect"
      >
        <span class="empty-text">暂无公告</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import requestApi from "@/utils/axios";
import { useRouter } from "vue-router";

const router = useRouter();
const announcements = ref([]);
const loading = ref(false);
const defaultImg =
  "https://images.unsplash.com/photo-1515377905703-c4788e51af15?q=80&w=1000&auto=format&fit=crop";

const fetchLatestAnnouncements = async () => {
  loading.value = true;
  try {
    const response = await requestApi.post("/api/news/list", {
      page: 1,
      limit: 3,
    });
    if (response.code == 0) {
      announcements.value = (response.data || []).reverse();
    }
  } catch (error) {
    console.error("获取最新公告失败:", error);
  } finally {
    loading.value = false;
  }
};

const navigateTo = (path) => {
  router.push(path);
};

const formatDate = (datetime) => {
  if (!datetime) return "";
  return datetime.split(" ")[0];
};

const handleImageError = (e) => {
  e.target.src = defaultImg;
};

onMounted(fetchLatestAnnouncements);
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap");

.announcement-section {
  /* 亮色背景，可以是浅灰或渐变，这里用浅灰白 */
  background: #f5f7fa;
  padding: 80px 20px;
  font-family: "Inter", sans-serif;
  position: relative;
  overflow: hidden;
}

/* 背景装饰圆 */
.announcement-section::before {
  content: "";
  position: absolute;
  top: -10%;
  right: -5%;
  width: 400px;
  height: 400px;
  background: radial-gradient(
    circle,
    rgba(64, 158, 255, 0.1) 0%,
    rgba(255, 255, 255, 0) 70%
  );
  border-radius: 50%;
  z-index: 0;
}

.section-container {
  max-width: 1200px;
  margin: 0 auto;
  position: relative;
  z-index: 1;
}

/* 头部样式 */
.header-group {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 40px;
}

.sub-title {
  display: block;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.1em;
  color: #409eff;
  margin-bottom: 8px;
  text-transform: uppercase;
}

.main-title {
  font-size: 36px;
  color: #303133;
  font-weight: 700;
  margin: 0;
  line-height: 1.2;
}

/* 玻璃按钮 */
.btn-glass {
  padding: 10px 24px;
  border: 1px solid rgba(255, 255, 255, 0.6);
  background: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(10px);
  border-radius: 50px;
  color: #606266;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.btn-glass:hover {
  background: #fff;
  color: #409eff;
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(64, 158, 255, 0.15);
}

/* 网格布局 */
.news-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
}

/* 玻璃卡片 */
.glass-effect {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.05);
}

.news-card {
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  display: flex;
  flex-direction: column;
}

.news-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
  background: rgba(255, 255, 255, 0.9);
}

.img-wrapper {
  position: relative;
  width: 100%;
  height: 220px;
  overflow: hidden;
}

.news-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.news-card:hover .news-img {
  transform: scale(1.1);
}

.date-badge {
  position: absolute;
  top: 16px;
  right: 16px;
  padding: 6px 14px;
  border-radius: 30px;
  font-size: 12px;
  font-weight: 600;
  color: #303133;
  background: rgba(255, 255, 255, 0.85);
}

.news-content {
  padding: 24px;
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.news-title {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 16px;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.read-more {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  font-weight: 600;
  color: #409eff;
  transition: gap 0.3s ease;
}

.news-card:hover .read-more {
  gap: 10px;
}

/* 空状态 */
.empty-state {
  padding: 60px;
  text-align: center;
  border-radius: 20px;
  color: #909399;
}

/* 响应式 */
@media (max-width: 768px) {
  .news-grid {
    grid-template-columns: 1fr;
  }

  .header-group {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }
}
</style>
