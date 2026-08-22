<template>
  <div class="favorites-page">
    <el-card shadow="never" class="header-card">
      <div class="header">
        <div>
          <div class="title">我的收藏</div>
          <div class="desc">收藏与点赞的会展示在这里</div>
        </div>
      </div>
      <el-tabs v-model="activeType" class="type-tabs">
        <el-tab-pane label="收藏" name="3" />
        <el-tab-pane label="点赞" name="4" />
      </el-tabs>
    </el-card>

    <el-skeleton v-if="loading" :rows="8" animated />

    <el-row v-else-if="list.length" :gutter="16">
      <el-col
        v-for="item in list"
        :key="item.id"
        :xs="24"
        :sm="12"
        :md="8"
        :lg="6"
      >
        <el-card shadow="hover" class="item-card">
          <div class="cover" @click="goDetail(item)">
            <el-image :src="normalizeUrl(item.picture)" fit="cover" class="img">
              <template #error>
                <div class="img-fallback">暂无图片</div>
              </template>
            </el-image>
          </div>
          <div class="body">
            <div class="name" @click="goDetail(item)">
              {{ item.name || "未命名" }}
            </div>
            <div class="meta">
              <span class="tag">{{ activeType == "3" ? "收藏" : "点赞" }}</span>
              <span class="time">{{ item.addtime || "" }}</span>
            </div>
            <div class="actions">
              <el-button type="primary" link @click="goDetail(item)"
                >查看</el-button
              >
              <el-button type="danger" link @click="removeItem(item)"
                >移除</el-button
              >
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-empty v-else description="暂无收藏/点赞" :image-size="140" />
  </div>
</template>

<script setup>
import { onMounted, ref, watch } from "vue";
import { useRouter } from "vue-router";
import requestApi from "@/utils/axios";
import Message from "@/components/MessageBox/index.js";
import { GetUserId } from "@/utils/auth";

const router = useRouter();
const activeType = ref("3");
const list = ref([]);
const loading = ref(false);

const normalizeUrl = (value) => {
  if (!value || typeof value !== "string") return "";
  const url = value.trim();
  if (!url) return "";
  if (/^https?:\/\//i.test(url)) return url;
  if (url.startsWith("//")) return url;
  if (url.startsWith("/")) return url;
  return `/${url}`;
};

const loadList = async () => {
  loading.value = true;
  try {
    const userid = await GetUserId();
    if (!userid) {
      list.value = [];
      return;
    }
    const res = await requestApi.post("/api/storeup/list", {
      userid,
      type: Number(activeType.value),
    });
    if (res.code == 0) {
      list.value = Array.isArray(res.data) ? res.data : [];
    } else {
      list.value = [];
      Message.error(res.msg || "获取列表失败");
    }
  } catch (e) {
    list.value = [];
    Message.error("获取列表失败");
  } finally {
    loading.value = false;
  }
};

const removeItem = async (row) => {
  try {
    const res = await requestApi.post("/api/storeup/delete", [row.id]);
    if (res.code == 0) {
      Message.success("已移除");
      loadList();
    } else {
      Message.error(res.msg || "移除失败");
    }
  } catch (e) {
    Message.error("移除失败");
  }
};

const goDetail = (item) => {
  if (!item.refid) return;
  router.push({
    path: item.tablename + `DetailPage`,
    query: { id: item.refid },
  });
};

const goShop = () => {
  router.push("/furnituregoodsListPage");
};

watch(activeType, () => {
  loadList();
});

onMounted(() => {
  loadList();
});
</script>

<style scoped>
.favorites-page {
  padding: 20px;
  background: #f5f7fa;
  min-height: 100vh;
}

.header-card {
  margin-bottom: 16px;
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.title {
  font-size: 18px;
  font-weight: 700;
  color: #303133;
}

.desc {
  font-size: 12px;
  color: #909399;
  margin-top: 4px;
}

.type-tabs {
  margin-top: 12px;
}

.item-card {
  margin-bottom: 16px;
  overflow: hidden;
}

.cover {
  cursor: pointer;
}

.img {
  width: 100%;
  height: 160px;
}

.img-fallback {
  width: 100%;
  height: 160px;
  display: grid;
  place-items: center;
  background: #f2f3f5;
  color: #909399;
  font-size: 12px;
}

.body {
  padding-top: 10px;
}

.name {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
  cursor: pointer;
  line-height: 1.4;
  min-height: 40px;
}

.meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 10px;
  gap: 12px;
}

.tag {
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 999px;
  background: #ecf5ff;
  color: #409eff;
}

.time {
  font-size: 12px;
  color: #909399;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  margin-top: 6px;
}
</style>
