<template>
  <div class="community-page">
    <!-- Page Header -->
    <div class="page-header">
      <div class="header-content">
        <h1 class="main-title">社区中心</h1>
        <p class="subtitle">一个分享知识、交流想法的开放平台</p>
        <div class="controls-wrapper">
          <el-input
            v-model="searchQuery"
            placeholder="探索精彩内容..."
            class="search-input"
            @keyup.enter="handleSearch"
            clearable
          >
            <template #prepend>
              <el-button @click="handleSearch" class="search-button">
                <el-icon><Search /></el-icon>
              </el-button>
            </template>
          </el-input>
          <div class="buttons-group">
            <el-button class="action-button" @click="handleMyPosts"
              >我的帖子</el-button
            >
            <el-button
              type="primary"
              class="action-button create-button"
              @click="handleCreatePost"
              >发布新帖</el-button
            >
          </div>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <!-- Categories Filter -->
      <div class="categories-wrapper">
        <span
          class="category-tag"
          :class="{ active: activeCategory === '全部' }"
          @click="activeCategory = '全部'"
        >
          全部
        </span>
        <span
          v-for="categoryName in displayCategories"
          :key="categoryName"
          class="category-tag"
          :class="{ active: activeCategory === categoryName }"
          @click="activeCategory = categoryName"
        >
          {{ categoryName }}
        </span>
      </div>

      <div v-if="filteredPosts.length == 0" class="empty-state">
        <el-empty description="这里空空如也，期待您的第一篇分享！"></el-empty>
      </div>
      <div v-else class="post-grid">
        <div
          v-for="(post, index) in filteredPosts"
          :key="post.id"
          class="post-card"
          :style="{ animationDelay: index * 0.05 + 's' }"
          @click="showPostDetail(post)"
        >
          <div v-if="post.picture" class="card-image-wrapper">
            <img :src="post.picture" class="card-image" alt="帖子封面" />
          </div>
          <div class="card-content">
            <div class="card-header">
              <h3 class="post-title">{{ post.postTitle }}</h3>
              <el-tag
                class="post-card-category"
                size="small"
                effect="plain"
                round
                >{{ post.categoryId }}</el-tag
              >
            </div>
            <div class="card-body">
              <p class="post-excerpt">
                <span v-html="getPartialContent(post.postContent)"></span>
              </p>
            </div>
            <div class="card-footer">
              <div class="author-info">
                <span class="username">{{ post.username }}</span>
                <el-tag
                  :type="post.isApproved === 'Y' ? 'success' : 'warning'"
                  size="small"
                  effect="light"
                  round
                >
                  {{ post.isApproved === "Y" ? "已审核" : "待审核" }}
                </el-tag>
              </div>
              <span class="post-time">{{ post.addtime }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Post Detail Dialog -->
    <el-dialog
      v-model="dialogVisible"
      :title="selectedPost?.postTitle"
      width="75%"
      top="8vh"
      class="detail-dialog"
      :before-close="closeDetail"
      append-to-body
    >
      <div v-if="selectedPost" class="detail-container">
        <header class="detail-header">
          <h2 class="detail-title">{{ selectedPost.postTitle }}</h2>
          <div class="detail-meta">
            <span>作者: {{ selectedPost.username }}</span>
            <span class="separator">|</span>
            <span>发布于: {{ selectedPost.addtime }}</span>
          </div>
        </header>

        <div v-if="selectedPost.picture" class="detail-image-wrapper">
          <img
            :src="selectedPost.picture"
            class="detail-image"
            alt="帖子封面"
          />
        </div>

        <div class="detail-content" v-html="decodedContent"></div>

        <el-divider content-position="left">参与讨论</el-divider>
        <CommentComponent :refid="selectedPost.id" />
      </div>
      <template #footer>
        <el-button type="primary" @click="closeDetail" round>关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import Message from "@/components/MessageBox/index.js";
import { Search } from "@element-plus/icons-vue";
import { useRouter, useRoute } from "vue-router";

import requestApi from "@/utils/axios";

const router = useRouter(); // 获取路由器实例
const route = useRoute(); // 获取当前路由实例

const postList = ref([]);
const categories = ref([]);
const activeCategory = ref("全部");
const searchQuery = ref("");
const dialogVisible = ref(false);
const selectedPost = ref(null);

onMounted(() => {
  getPostData();
  getPostCategories();
});

const getPostData = async () => {
  try {
    let response = await requestApi.post("/api/posts/list", {
      isPublished: "Y",
      isApproved: "Y",
    });
    postList.value = response.data;
  } catch (error) {
    console.error("获取帖子列表失败:", error);
  }
};

const getPostCategories = async () => {
  try {
    const response = await requestApi.post("/api/postcategories/page", {
      page: 1,
      limit: 10,
    });
    if (response.code == 0 && response.data && response.data.list) {
      categories.value = response.data.list;
    }
  } catch (error) {
    console.error("获取帖子分类失败:", error);
  }
};

const displayCategories = computed(() => {
  const apiCategories = categories.value.map((c) => c.categoryName);
  const postCategories = postList.value.map((p) => p.categoryId);
  const allCategories = [...apiCategories, ...postCategories];
  // 使用 Set 去重并返回数组
  return [...new Set(allCategories)];
});

/**
 * 模糊匹配函数
 * @param {string} pattern - 搜索模式串
 * @param {string} text - 被搜索的文本
 * @returns {boolean} - 是否匹配
 */
const fuzzyMatch = (pattern, text) => {
  if (!pattern) return true;
  if (!text) return false;

  const patternChars = pattern.toLowerCase().split("");
  const textChars = text.toLowerCase().split("");

  let patternIndex = 0;
  let textIndex = 0;

  while (patternIndex < patternChars.length && textIndex < textChars.length) {
    if (patternChars[patternIndex] === textChars[textIndex]) {
      patternIndex++;
    }
    textIndex++;
  }

  return patternIndex === patternChars.length;
};

const filteredPosts = computed(() => {
  let posts = postList.value;

  // Filter by category
  if (activeCategory.value !== "全部") {
    posts = posts.filter((post) => post.categoryId === activeCategory.value);
  }

  // Filter by search query using fuzzy match
  if (searchQuery.value) {
    posts = posts.filter((post) =>
      fuzzyMatch(searchQuery.value, post.postTitle)
    );
  }

  return posts;
});

const decodedContent = computed(() => {
  if (selectedPost.value?.postContent) {
    try {
      return decodeURIComponent(selectedPost.value.postContent);
    } catch (e) {
      return selectedPost.value.postContent;
    }
  }
  return "";
});

const getPartialContent = (content) => {
  if (!content) return "";
  try {
    const decoded = decodeURIComponent(content);
    const textOnly = decoded.replace(/<[^>]+>/g, "");
    return textOnly.length > 100
      ? textOnly.substring(0, 100) + "..."
      : textOnly;
  } catch (e) {
    return "内容解析错误...";
  }
};

const showPostDetail = (post) => {
  selectedPost.value = post;
  dialogVisible.value = true;
};

const closeDetail = () => {
  dialogVisible.value = false;
  selectedPost.value = null;
};

const handleSearch = () => {
  if (searchQuery.value) {
    Message.info(`正在搜索: ${searchQuery.value}`);
  } else {
    Message.info(`已重置搜索`);
  }
};

const handleMyPosts = () => {
  router.push("/myPost");
};

const handleCreatePost = () => {
  router.push("/issuePost");
};
</script>

<style scoped>
/* --- Base & Layout --- */
.community-page {
  background-color: #f4f6f9;
  min-height: 100vh;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
}

.page-header {
  background: #ffffff;
  padding: 40px 20px;
  border-bottom: 1px solid #e5e7eb;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
  display: flex;
  justify-content: center;
  align-items: center;
}

.header-content {
  max-width: 900px;
  width: 100%;
  text-align: center;
}

.main-content {
  max-width: 1400px;
  margin: 40px auto;
  padding: 0 20px;
}

/* --- Header Elements --- */
.main-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
}

.subtitle {
  font-size: 1.1rem;
  color: #6b7280;
  margin-top: 8px;
  margin-bottom: 24px;
}

.controls-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.search-input {
  max-width: 450px;
  flex-grow: 1;
}

.search-input :deep(.el-input__wrapper) {
  border-radius: 30px !important;
  padding-left: 15px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  transition: box-shadow 0.3s;
}
.search-input :deep(.el-input__wrapper:hover) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}
.search-input :deep(.el-input-group__prepend) {
  background: transparent;
  box-shadow: none;
}
.search-button {
  color: #4b5563;
}

.buttons-group {
  display: flex;
  gap: 12px;
}

.action-button {
  border-radius: 20px;
  font-weight: 500;
}
.create-button {
  box-shadow: 0 2px 6px rgba(66, 153, 225, 0.4);
}

/* --- Categories --- */
.categories-wrapper {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 32px;
  padding-bottom: 24px;
  border-bottom: 1px solid #e5e7eb;
}

.category-tag {
  padding: 8px 16px;
  border-radius: 20px;
  background-color: #fff;
  color: #4b5563;
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  border: 1px solid #e5e7eb;
}

.category-tag:hover {
  border-color: #409eff;
  color: #409eff;
}

.category-tag.active {
  background-color: #409eff;
  color: #fff;
  border-color: #409eff;
  box-shadow: 0 2px 6px rgba(66, 153, 225, 0.3);
}

/* --- Post Grid & Cards --- */
.post-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 24px;
}

.post-card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  display: flex;
  flex-direction: column;
  opacity: 0;
  animation: card-fade-in 0.5s ease-out forwards;
}

.post-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}

.card-image-wrapper {
  width: 100%;
  height: 160px;
  overflow: hidden;
}

.card-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}
.post-card:hover .card-image {
  transform: scale(1.05);
}

.card-content {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 20px 20px 12px;
  gap: 12px;
}

.post-title {
  font-size: 1.2rem;
  font-weight: 600;
  color: #111827;
  margin: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  flex-grow: 1;
}

.post-card-category {
  flex-shrink: 0;
}

.card-body {
  padding: 0 20px 16px;
  flex-grow: 1;
}

.post-excerpt {
  font-size: 0.95rem;
  color: #4b5563;
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  min-height: 44px;
}

.card-footer {
  padding: 12px 20px;
  background-color: #f9fafb;
  border-top: 1px solid #f3f4f6;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.8rem;
}

.author-info {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #374151;
  font-weight: 500;
}

.post-time {
  color: #9ca3af;
}

/* --- Empty State --- */
.empty-state {
  padding: 80px 0;
}

/* --- Detail Dialog --- */
.detail-dialog :deep(.el-dialog) {
  border-radius: 16px;
}
.detail-dialog :deep(.el-dialog__header) {
  padding: 24px 32px;
  margin-right: 0;
  border-bottom: 1px solid #e5e7eb;
}
.detail-dialog :deep(.el-dialog__title) {
  font-size: 1.5rem;
  font-weight: 600;
  color: #1f2937;
}
.detail-dialog :deep(.el-dialog__body) {
  padding: 24px 32px;
  max-height: 70vh;
  overflow-y: auto;
}
.detail-dialog :deep(.el-dialog__footer) {
  padding: 16px 32px;
  border-top: 1px solid #e5e7eb;
}

.detail-header {
  text-align: center;
  margin-bottom: 24px;
}
.detail-title {
  font-size: 2.2rem;
  font-weight: 700;
  color: #111827;
  margin-bottom: 12px;
}
.detail-meta {
  color: #6b7280;
  font-size: 0.9rem;
}
.detail-meta .separator {
  margin: 0 8px;
}

.detail-image-wrapper {
  margin: 24px 0;
  text-align: center;
}
.detail-image {
  max-width: 100%;
  max-height: 500px;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.detail-content {
  font-size: 1.05rem;
  line-height: 1.8;
  color: #374151;
}
.detail-content :deep(p) {
  margin-bottom: 1em;
}
.detail-content :deep(img) {
  max-width: 100%;
  border-radius: 8px;
}

/* --- Animations --- */
@keyframes card-fade-in {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* --- Responsive --- */
@media (max-width: 768px) {
  .main-title {
    font-size: 2rem;
  }
  .controls-wrapper {
    flex-direction: column;
  }
  .detail-dialog {
    width: 90% !important;
  }
}
</style>
