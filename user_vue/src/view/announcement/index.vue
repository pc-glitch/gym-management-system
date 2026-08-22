<template>
  <div class="announcement-page" v-loading="loading">
    <el-card shadow="never" class="page-card">
      <div class="card-header">
        <div>
          <div class="sub">NEWS & UPDATES</div>
          <div class="title">平台公告</div>
        </div>
      </div>

      <el-row :gutter="16">
        <el-col :span="8" :xs="24" v-for="item in noticeList" :key="item.id">
          <el-card class="notice-card" shadow="hover" @click="showDetail(item)">
            <el-image :src="item.picture || defaultImg" fit="cover" class="thumb">
              <template #error>
                <div class="thumb placeholder">无图</div>
              </template>
            </el-image>
            <div class="notice-title">{{ item.title }}</div>
            <div class="notice-sub">{{ item.introduction }}</div>
            <div class="notice-footer">
              <el-tag type="info" size="small">{{ formatDate(item.addtime) }}</el-tag>
              <el-link type="primary">阅读全文</el-link>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <div class="pagination" v-if="total > 0">
        <el-pagination
          :current-page="currentPage"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total"
          @current-change="handlePageChange"
        />
      </div>
    </el-card>

    <el-dialog v-model="dialogVisible" title="公告详情" width="720px" append-to-body>
      <div v-if="selectedNotice">
        <h3>{{ selectedNotice.title }}</h3>
        <div class="detail-meta">{{ formatDate(selectedNotice.addtime) }}</div>
        <div class="detail-content" v-html="selectedNotice.content"></div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import requestApi from "@/utils/axios";
import { ElMessage } from "element-plus";

const noticeList = ref([]);
const total = ref(0);
const currentPage = ref(1);
const pageSize = ref(6);
const dialogVisible = ref(false);
const selectedNotice = ref(null);
const loading = ref(false);
const defaultImg =
  "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80";

const formatDate = (val) => {
  if (!val) return "-";
  return new Date(val).toLocaleString();
};

const fetchNotices = async (page = 1) => {
  loading.value = true;
  try {
    const response = await requestApi.post("/api/news/list", {
      page,
      limit: pageSize.value,
    });
    if (response.code == 0) {
      noticeList.value = response.data;
      total.value = response.count;
      currentPage.value = page;
    }
  } catch (error) {
    ElMessage.error("获取公告失败");
  } finally {
    loading.value = false;
  }
};

const handlePageChange = (page) => {
  fetchNotices(page);
  window.scrollTo({ top: 0, behavior: "smooth" });
};

const showDetail = (notice) => {
  selectedNotice.value = notice;
  dialogVisible.value = true;
};

onMounted(() => {
  fetchNotices(1);
});
</script>

<style scoped>
.announcement-page {
  padding: 10px;
}

.page-card {
  border: none;
}

.card-header .sub {
  color: #909399;
  font-size: 12px;
}

.card-header .title {
  font-size: 20px;
  font-weight: 700;
}

.notice-card {
  margin-bottom: 16px;
  cursor: pointer;
}

.thumb {
  width: 100%;
  height: 160px;
  border-radius: 6px;
}

.thumb.placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
  color: #909399;
}

.notice-title {
  font-weight: 700;
  margin: 8px 0 4px;
}

.notice-sub {
  color: #909399;
  height: 38px;
  overflow: hidden;
}

.notice-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 6px;
}

.pagination {
  margin-top: 16px;
  display: flex;
  justify-content: center;
}

.detail-meta {
  color: #909399;
  margin-bottom: 8px;
}

.detail-content {
  line-height: 1.7;
}

.detail-content :deep(img) {
  max-width: 100%;
}
</style>
