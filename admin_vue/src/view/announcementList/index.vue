<template>
  <div v-loading="loading">
    <div class="page-title-row">
      <div class="page-title">公告管理</div>
      <div style="display: flex; gap: 12px">
        <button type="button" class="btn" @click="resetQuery">清空</button>
        <button
          type="button"
          class="btn danger"
          :disabled="ids.length === 0"
          @click="handleDelete()"
        >
          批量删除
        </button>
        <button type="button" class="btn primary" @click="handleAdd">新建公告</button>
      </div>
    </div>

    <div style="display: flex; gap: 12px; align-items: center; margin-bottom: 16px">
      <div class="search-box" style="width: 360px">
        <svg
          class="search-icon"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <circle cx="11" cy="11" r="7"></circle>
          <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        <input
          v-model="queryParams.title"
          type="text"
          placeholder="搜索公告标题..."
          @keyup.enter="handleQuery"
        />
      </div>
      <button type="button" class="btn" @click="handleQuery">搜索</button>
    </div>

    <div class="list-panel">
      <div class="panel-header">
        <div class="panel-title">公告列表</div>
        <div style="font-size: 12px; color: var(--text-secondary)">共 {{ total }} 条</div>
      </div>

      <div class="banner-table-wrap">
        <table class="banner-table">
          <thead>
            <tr>
              <th style="width: 56px">
                <input
                  type="checkbox"
                  :checked="allSelected"
                  @change="toggleAll"
                  style="width: 14px; height: 14px"
                  aria-label="全选"
                />
              </th>
              <th>标题</th>
              <th>简介</th>
              <th style="width: 180px">发布时间</th>
              <th style="text-align: right; width: 120px">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="row in dataList" :key="row.id">
              <td>
                <input
                  v-model="ids"
                  :value="row.id"
                  type="checkbox"
                  style="width: 14px; height: 14px"
                  aria-label="选择"
                />
              </td>
              <td style="font-weight: 600; color: var(--text-main)">{{ row.title }}</td>
              <td style="color: var(--text-secondary)">{{ row.introduction }}</td>
              <td style="color: var(--text-secondary)">{{ row.addtime }}</td>
              <td style="text-align: right">
                <button type="button" class="btn link" @click="handleUpdate(row)">
                  编辑
                </button>
                <button
                  type="button"
                  class="btn link"
                  style="color: var(--danger-color); margin-left: 10px"
                  @click="handleDelete(row)"
                >
                  删除
                </button>
              </td>
            </tr>
            <tr v-if="!dataList.length && !loading">
              <td colspan="5" style="padding: 16px; text-align: center; color: var(--text-tertiary)">
                暂无公告数据
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div
        class="panel-footer"
        style="padding: 12px 16px; display: flex; justify-content: flex-end"
        v-if="total > 0"
      >
        <el-pagination
          :current-page="queryParams.page"
          :page-size="queryParams.limit"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <el-dialog
      v-model="open"
      :title="form.id ? '编辑公告' : '新增公告'"
      width="700px"
      append-to-body
      @close="cancel"
    >
      <el-form :model="form" :rules="rules" ref="formRef" label-position="top">
        <el-form-item label="公告标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入引人注目的标题" />
        </el-form-item>

        <el-form-item label="简介摘要" prop="introduction">
          <el-input
            v-model="form.introduction"
            type="textarea"
            :rows="3"
            placeholder="简要描述公告的核心内容..."
          />
        </el-form-item>

        <el-form-item label="封面图片" prop="picture">
          <ImageUpload v-model="form.picture" :limit="1" />
        </el-form-item>

        <el-form-item label="详细内容" prop="content">
          <RichTextEditor v-model="form.content" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div style="display: flex; justify-content: flex-end; gap: 12px">
          <el-button @click="cancel">取消</el-button>
          <el-button type="primary" @click="submitForm">确认保存</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs, computed } from "vue";
import requestApi from "@/utils/axios";
import { ElMessage, ElMessageBox } from "element-plus";
import ImageUpload from "@/components/ImageUpload/index.vue";
import RichTextEditor from "@/components/RichTextEditor/index.vue";

const data = reactive({
  loading: false,
  ids: [],
  total: 0,
  open: false,
  dataList: [],
  queryParams: { page: 1, limit: 10, title: undefined },
  form: getInitialForm(),
});

const rules = {
  title: [{ required: true, message: "请输入标题", trigger: "blur" }],
  introduction: [{ required: true, message: "请输入简介", trigger: "blur" }],
  content: [{ required: true, message: "请输入内容", trigger: "blur" }],
};

const { loading, ids, total, open, dataList, queryParams, form } = toRefs(data);
const formRef = ref(null);

function getInitialForm() {
  return {
    id: null,
    title: "",
    introduction: "",
    picture: "",
    content: "",
  };
}

const allSelected = computed(() => {
  const list = dataList.value || [];
  if (!list.length) return false;
  return list.every((item) => ids.value.includes(item.id));
});

const toggleAll = () => {
  if (allSelected.value) {
    ids.value = [];
    return;
  }
  ids.value = (dataList.value || []).map((item) => item.id);
};

const getList = async () => {
  loading.value = true;
  try {
    const params = { ...queryParams.value };
    const res = await requestApi.post("/api/news/page", params);
    if (res.code == 0 || res.code == 0) {
      dataList.value = res.data.list || [];
      total.value = parseInt(res.data.total) || 0;
      const currentIds = new Set((dataList.value || []).map((item) => item.id));
      ids.value = ids.value.filter((id) => currentIds.has(id));
    } else {
      ElMessage.error(res.msg || "获取列表失败");
    }
  } catch (error) {
    ElMessage.error("请求失败");
  } finally {
    loading.value = false;
  }
};

const handleQuery = () => {
  queryParams.value.page = 1;
  getList();
};

const resetQuery = () => {
  queryParams.value.title = undefined;
  handleQuery();
};

const handleSizeChange = (val) => {
  queryParams.value.limit = val;
  getList();
};

const handleCurrentChange = (val) => {
  queryParams.value.page = val;
  getList();
};

const handleAdd = () => {
  form.value = getInitialForm();
  open.value = true;
};

const handleUpdate = (row) => {
  requestApi.post("/api/news/info", { id: row.id }).then((response) => {
    if (response.code == 0) {
      form.value = { ...response.data };
      open.value = true;
    } else {
      ElMessage.error(response.msg || "获取信息失败");
    }
  });
};

const submitForm = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) return;
    const url = form.value.id ? "/api/news/update" : "/api/news/save";
    try {
      const res = await requestApi.post(url, form.value);
      if (res.code == 0) {
        ElMessage.success("保存成功");
        open.value = false;
        getList();
      } else {
        ElMessage.error(res.msg || "保存失败");
      }
    } catch (error) {
      ElMessage.error("请求失败");
    }
  });
};

const handleDelete = (row) => {
  const itemIds = row && row.id ? [row.id] : ids.value;
  if (!itemIds.length) return;
  ElMessageBox.confirm(`是否确认删除选中的 ${itemIds.length} 条记录？`, "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      await requestApi.post("/api/news/delete", itemIds);
      ElMessage.success("删除成功");
      getList();
    })
    .catch(() => {});
};

const cancel = () => {
  open.value = false;
  form.value = getInitialForm();
};

onMounted(() => {
  getList();
});
</script>

<style scoped></style>

