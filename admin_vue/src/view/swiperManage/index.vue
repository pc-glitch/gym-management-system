<template>
  <div v-loading="loading" style="min-height: 60vh">
    <div class="page-title-row">
      <div class="page-title">轮播图配置</div>
      <div style="display: flex; gap: 12px">
        <button type="button" class="btn primary" @click="handleAdd">新增轮播</button>
        <button
          type="button"
          class="btn danger"
          :disabled="selectedIds.length === 0"
          @click="handleBulkDelete"
        >
          删除选中
        </button>
      </div>
    </div>

    <div class="stats-row">
      <div class="stat-card">
        <div class="stat-info">
          <h4>轮播总数</h4>
          <div class="num">{{ total }}</div>
        </div>
        <div class="stat-icon">🖼</div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h4>已选记录</h4>
          <div class="num">{{ selectedIds.length }}</div>
        </div>
        <div class="stat-icon">✔</div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h4>当前预览</h4>
          <div class="num" style="font-size: 14px">{{ currentRow?.name || "-" }}</div>
        </div>
        <div class="stat-icon">👁</div>
      </div>
    </div>

    <div class="workspace">
      <!-- 左侧列表 -->
      <div class="list-panel">
        <div class="panel-header">
          <div class="panel-title">轮播列表</div>
          <input
            v-model="searchKeyword"
            class="form-input"
            style="height: 32px; padding: 6px 10px; font-size: 13px; width: 220px"
            placeholder="搜索名称/地址..."
          />
        </div>

        <div class="banner-table-wrap">
          <table class="banner-table">
            <thead>
              <tr>
                <th style="width: 56px">选择</th>
                <th style="width: 110px">缩略图</th>
                <th>名称</th>
                <th style="width: 180px">创建时间</th>
                <th style="text-align: right; width: 90px">操作</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="row in filteredList"
                :key="row.id"
                :class="{ 'active-edit': currentRow && currentRow.id === row.id }"
                @click="currentRow = row"
              >
                <td @click.stop>
                  <input
                    v-model="selectedIds"
                    :value="row.id"
                    type="checkbox"
                    style="width: 14px; height: 14px"
                  />
                </td>
                <td>
                  <img
                    v-if="row.value"
                    :src="row.value"
                    class="thumb-preview"
                    alt="thumb"
                    @error="(e) => (e.target.style.display = 'none')"
                  />
                  <div
                    v-else
                    class="thumb-preview"
                    style="display: flex; align-items: center; justify-content: center"
                  >
                    <span style="font-size: 11px; color: var(--text-tertiary)">无图</span>
                  </div>
                </td>
                <td style="font-weight: 600; color: var(--text-main)">
                  {{ row.name || "-" }}
                </td>
                <td style="color: var(--text-secondary)">{{ row.addtime || "-" }}</td>
                <td style="text-align: right" @click.stop>
                  <button type="button" class="btn link" @click="handleDelete(row)">
                    删除
                  </button>
                </td>
              </tr>
              <tr v-if="!filteredList.length && !loading">
                <td colspan="5" style="padding: 16px; text-align: center; color: var(--text-tertiary)">
                  暂无轮播数据
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div
          v-if="total > 0"
          style="padding: 12px 16px; display: flex; justify-content: flex-end"
        >
          <el-pagination
            :current-page="queryParams.page"
            :page-size="queryParams.limit"
            :page-sizes="[10, 20, 50, 100]"
            :total="total"
            layout="total, prev, pager, next, sizes"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>

      <!-- 右侧编辑/预览 -->
      <div class="editor-panel">
        <div class="panel-header">
          <div class="panel-title">预览与上传</div>
          <button type="button" class="btn primary" @click="handleAdd">上传</button>
        </div>

        <div class="editor-body">
          <div v-if="currentRow">
            <div style="margin-bottom: 16px">
              <img
                v-if="currentRow.value"
                :src="currentRow.value"
                alt="preview"
                style="
                  width: 100%;
                  border: 1px solid var(--border-color);
                  border-radius: 4px;
                  background: #f4f5f7;
                  object-fit: cover;
                "
                @error="(e) => (e.target.style.display = 'none')"
              />
              <div
                v-else
                style="
                  width: 100%;
                  height: 160px;
                  background: #f4f5f7;
                  border: 1px solid var(--border-color);
                  border-radius: 4px;
                  display: flex;
                  align-items: center;
                  justify-content: center;
                  color: var(--text-tertiary);
                "
              >
                暂无图片
              </div>
            </div>

            <div class="form-group">
              <label class="form-label" style="text-transform: none">名称</label>
              <input class="form-input" :value="currentRow.name || ''" disabled />
            </div>
            <div class="form-group">
              <label class="form-label" style="text-transform: none">地址</label>
              <input class="form-input" :value="currentRow.value || ''" disabled />
            </div>
          </div>
          <div v-else style="color: var(--text-tertiary); font-size: 13px">
            从左侧选择一条轮播图记录进行预览。
          </div>
        </div>
      </div>
    </div>

    <el-dialog
      v-model="open"
      title="上传轮播图"
      width="500px"
      @close="handleDialogClose"
      append-to-body
    >
      <ImageUpload
        ref="imageUploadRef"
        :limit="1"
        @upload-success="handleUploadSuccess"
      />
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs, computed } from "vue";
import request from "@/utils/axios";
import { ElMessage, ElMessageBox } from "element-plus";
import ImageUpload from "@/components/ImageUpload/index.vue";

const data = reactive({
  loading: true,
  open: false,
  total: 0,
  swiperList: [],
  queryParams: { page: 1, limit: 10 },
});

const { loading, open, total, swiperList, queryParams } = toRefs(data);

const searchKeyword = ref("");
const positionFilter = ref("");
const selectedIds = ref([]);
const imageUploadRef = ref(null);
const currentRow = ref(null);
const tableRef = ref(null);

const filteredList = computed(() => {
  const kw = (searchKeyword.value || "").trim().toLowerCase();
  const list = swiperList.value || [];
  if (!kw) return list;
  return list.filter((item) => {
    const name = String(item?.name || "").toLowerCase();
    const value = String(item?.value || "").toLowerCase();
    return name.includes(kw) || value.includes(kw);
  });
});

async function getList() {
  loading.value = true;
  try {
    const response = await request.post("/api/config/page", queryParams.value);
    if (response.code == 0) {
      swiperList.value = response.data.list || [];
      total.value = parseInt(response.data.total) || 0;
      currentRow.value = swiperList.value.length ? swiperList.value[0] : null;
      const currentIds = new Set((swiperList.value || []).map((item) => item.id));
      selectedIds.value = selectedIds.value.filter((id) => currentIds.has(id));
    } else {
      ElMessage.error(response.msg || "获取列表失败");
    }
  } catch (error) {
    console.error("获取轮播图列表失败:", error);
    ElMessage.error("获取轮播图列表失败");
  } finally {
    loading.value = false;
  }
}

function handleAdd() {
  open.value = true;
}

async function handleUploadSuccess(response) {
  const { name, url } = response;
  const payload = { name, value: url, adduserid: "1", addusername: "管理员" };
  const res = await request.post("/api/config/save", payload);
  if (res.code == 0) {
    ElMessage.success("上传成功");
    open.value = false;
    getList();
  } else {
    ElMessage.error(res.msg || "上传失败");
  }
}

function handleDialogClose() {
  if (imageUploadRef.value) {
    imageUploadRef.value.reset?.();
  }
}

async function handleDelete(row) {
  ElMessageBox.confirm("确认删除该轮播图吗？", "提示", {
    type: "warning",
  })
    .then(async () => {
      await request.post("/api/config/delete", [row.id]);
      ElMessage.success("删除成功");
      getList();
    })
    .catch(() => {});
}

async function handleBulkDelete() {
  if (selectedIds.value.length == 0) return;
  ElMessageBox.confirm(`确认删除选中的 ${selectedIds.value.length} 条记录吗？`, "提示", {
    type: "warning",
  })
    .then(async () => {
      await request.post("/api/config/delete", selectedIds.value);
      ElMessage.success("删除成功");
      getList();
    })
    .catch(() => {});
}

const handleSizeChange = (val) => {
  queryParams.value.limit = val;
  getList();
};

const handleCurrentChange = (val) => {
  queryParams.value.page = val;
  getList();
};

onMounted(getList);
</script>

<style scoped></style>

