<template>
  <div class="glass-page">
    <div class="glass-header">
      <div class="header-content">
        <div class="header-tag">ABOUT US</div>
        <h2 class="header-title">关于我们</h2>
        <p class="header-desc">编辑企业简介内容并即时预览效果。</p>
      </div>
      <div class="header-actions">
        <el-button @click="getAboutUs" icon="Refresh">刷新</el-button>
        <el-button type="primary" @click="saveContent" icon="Check"
          >保存更改</el-button
        >
      </div>
    </div>

    <div class="glass-split">
      <!-- 预览面板 -->
      <div class="glass-card preview-panel">
        <div class="card-header">
          <div class="header-left">
            <span class="card-title">预览</span>
            <span class="card-subtitle">实时效果展示</span>
          </div>
          <span class="card-tag">PREVIEW</span>
        </div>

        <div class="card-body">
          <div class="preview-container">
            <div class="preview-cover">
              <el-image
                v-if="pageData.picture1"
                :src="pageData.picture1"
                fit="cover"
                class="cover-image"
              />
              <div v-else class="cover-empty">
                <span class="empty-icon"></span>
                <span>暂无封面图片</span>
              </div>
            </div>

            <div class="preview-content">
              <h3 class="preview-title">
                {{ pageData.title || "标题占位符" }}
              </h3>
              <p class="preview-subtitle">
                {{ pageData.subtitle || "副标题占位符" }}
              </p>
              <div class="preview-rich-text" v-html="pageData.content"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- 编辑面板 -->
      <div class="glass-card edit-panel">
        <div class="card-header">
          <div class="header-left">
            <span class="card-title">编辑</span>
            <span class="card-subtitle">内容配置</span>
          </div>
          <span class="card-tag">EDIT</span>
        </div>

        <div class="card-body">
          <el-form :model="pageData" label-position="top" class="glass-form">
            <el-form-item label="主标题">
              <el-input
                v-model="pageData.title"
                placeholder="请输入页面主标题"
              />
            </el-form-item>

            <el-form-item label="副标题">
              <el-input
                v-model="pageData.subtitle"
                type="textarea"
                :rows="2"
                placeholder="请输入页面副标题"
              />
            </el-form-item>

            <el-form-item label="封面图片">
              <ImageUpload v-model="pageData.picture1" />
            </el-form-item>

            <el-form-item label="正文详情">
              <RichTextEditor v-model="pageData.content" />
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, onMounted } from "vue";
import requestApi from "@/utils/axios";
import { ElMessage } from "element-plus";
import RichTextEditor from "@/components/RichTextEditor/index.vue";
import ImageUpload from "@/components/ImageUpload/index.vue";

const pageData = reactive({
  id: null,
  title: "",
  subtitle: "",
  content: "",
  picture1: "",
});

onMounted(() => {
  getAboutUs();
});

const saveContent = async () => {
  try {
    const saveData = {
      ...pageData,
      content: encodeURIComponent(pageData.content || ""),
    };
    const res = await requestApi.post("/api/aboutus/update", saveData);
    if (res.code == 0) {
      ElMessage.success("保存成功");
      getAboutUs();
    } else {
      ElMessage.error(res.message || "保存失败");
    }
  } catch (error) {
    console.error(error);
    ElMessage.error("网络错误");
  }
};

const getAboutUs = async () => {
  try {
    const res = await requestApi.post("/api/aboutus/list");
    if (res.code == 0 && res.data && res.data.length > 0) {
      const data = res.data[0];
      pageData.id = data.id;
      pageData.title = data.title;
      pageData.subtitle = data.subtitle;
      pageData.content = decodeURIComponent(data.content || "");
      pageData.picture1 = data.picture1;
    } else {
      ElMessage.warning("暂无配置数据");
    }
  } catch (error) {
    console.error(error);
    ElMessage.error("获取数据失败");
  }
};
</script>

<style scoped>
/* 工业玻璃主题基础类 */
.glass-page {
  display: flex;
  flex-direction: column;
  gap: 20px;
  animation: fade-in 0.5s ease;
}

.glass-header {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  border-radius: 16px;
  padding: 24px;
  border: 1px solid rgba(255, 255, 255, 0.6);
  box-shadow: var(--shadow-base);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-tag {
  font-size: 12px;
  color: var(--color-primary);
  font-weight: 700;
  letter-spacing: 1px;
  margin-bottom: 4px;
}

.header-title {
  font-size: 24px;
  font-weight: 700;
  color: var(--text-main);
  margin: 0 0 4px 0;
}

.header-desc {
  font-size: 14px;
  color: var(--text-secondary);
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.glass-split {
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 20px;
}

.glass-card {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.6);
  box-shadow: var(--shadow-base);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.card-header {
  padding: 16px 24px;
  border-bottom: 1px solid var(--border-color-light);
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: rgba(248, 250, 252, 0.5);
}

.card-title {
  font-weight: 600;
  color: var(--text-main);
  font-size: 16px;
}

.card-subtitle {
  font-size: 12px;
  color: var(--text-secondary);
  margin-left: 8px;
  padding-left: 8px;
  border-left: 1px solid var(--border-color);
}

.card-tag {
  font-size: 10px;
  padding: 2px 8px;
  border-radius: 99px;
  background: var(--color-primary-light);
  color: var(--color-primary);
  font-weight: 700;
  letter-spacing: 0.5px;
}

.card-body {
  padding: 24px;
}

/* 预览样式 */
.preview-container {
  border: 1px solid var(--border-color-light);
  border-radius: 12px;
  overflow: hidden;
  background: #fff;
}

.preview-cover {
  height: 200px;
  background: #f1f5f9;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.cover-image {
  width: 100%;
  height: 100%;
}

.cover-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: var(--text-placeholder);
  font-size: 12px;
}

.empty-icon {
  width: 32px;
  height: 32px;
  border: 2px dashed currentColor;
  border-radius: 8px;
  opacity: 0.5;
}

.preview-content {
  padding: 20px;
}

.preview-title {
  font-size: 18px;
  font-weight: 700;
  margin: 0 0 8px 0;
  color: var(--text-main);
}

.preview-subtitle {
  font-size: 14px;
  color: var(--text-secondary);
  margin: 0 0 16px 0;
  font-style: italic;
}

.preview-rich-text {
  font-size: 14px;
  line-height: 1.8;
  color: var(--text-regular);
}

/* 响应式 */
@media (max-width: 1024px) {
  .glass-split {
    grid-template-columns: 1fr;
  }
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
