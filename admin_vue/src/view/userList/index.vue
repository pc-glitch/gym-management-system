<template>
  <div v-loading="loading">
    <div class="page-title-row">
      <div class="page-title">用户管理</div>
      <div style="display: flex; gap: 12px">
        <button type="button" class="btn primary" @click="handleAdd">新增用户</button>
        <button
          type="button"
          class="btn danger"
          :disabled="!ids.length"
          @click="handleDelete()"
        >
          批量删除
        </button>
      </div>
    </div>

    <div class="list-panel" style="margin-bottom: 24px">
      <div class="panel-header">
        <div class="panel-title">筛选</div>
        <div style="display: flex; gap: 8px">
          <button type="button" class="btn" @click="handleQuery">查询</button>
          <button type="button" class="btn" @click="resetQuery">清空</button>
        </div>
      </div>
      <div class="editor-body">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px">
          <div class="form-group">
            <label class="form-label" style="text-transform: none">用户名</label>
            <input
              v-model="queryParams.username"
              class="form-input"
              type="text"
              placeholder="例如：admin"
              @keyup.enter="handleQuery"
            />
          </div>
          <div class="form-group">
            <label class="form-label" style="text-transform: none">昵称</label>
            <input
              v-model="queryParams.name"
              class="form-input"
              type="text"
              placeholder="例如：张三"
              @keyup.enter="handleQuery"
            />
          </div>
        </div>
      </div>
    </div>

    <div class="list-panel">
      <div class="panel-header">
        <div class="panel-title">用户列表</div>
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
              <th>用户</th>
              <th style="width: 160px">手机号</th>
              <th style="width: 240px">邮箱</th>
              <th style="width: 180px">加入时间</th>
              <th style="text-align: right; width: 260px">操作</th>
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
              <td>
                <div style="display: flex; align-items: center; gap: 12px; min-width: 0">
                  <div class="user-avatar" style="width: 32px; height: 32px">
                    <img
                      :src="row.avatarurl || defaultAvatar"
                      alt="avatar"
                      @error="(e) => (e.target.src = defaultAvatar)"
                    />
                  </div>
                  <div style="min-width: 0">
                    <div style="font-weight: 700; color: var(--text-main); white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
                      {{ row.name || "-" }}
                    </div>
                    <div style="font-size: 12px; color: var(--text-secondary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
                      @{{ row.username }}
                    </div>
                  </div>
                </div>
              </td>
              <td style="color: var(--text-secondary)">{{ row.phone || "-" }}</td>
              <td style="color: var(--text-secondary)">{{ row.email || "-" }}</td>
              <td style="color: var(--text-secondary)">{{ row.addtime || "-" }}</td>
              <td style="text-align: right">
                <button
                  type="button"
                  class="btn"
                  style="padding: 6px 10px; font-size: 12px"
                  @click="resetUserPassword(row)"
                >
                  重置密码
                </button>
                <button
                  type="button"
                  class="btn primary"
                  style="padding: 6px 10px; font-size: 12px; margin-left: 8px"
                  @click="handleUpdate(row)"
                >
                  编辑
                </button>
                <button
                  type="button"
                  class="btn danger"
                  style="padding: 6px 10px; font-size: 12px; margin-left: 8px"
                  @click="handleDelete(row)"
                >
                  删除
                </button>
              </td>
            </tr>
            <tr v-if="!dataList.length && !loading">
              <td colspan="6" style="padding: 16px; text-align: center; color: var(--text-tertiary)">
                暂无用户数据
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
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <el-dialog :title="title" v-model="open" width="640px" @close="cancel">
      <el-form ref="formRef" :model="form" label-position="top">
        <el-form-item label="头像">
          <ImageUpload v-model="form.avatarurl" />
        </el-form-item>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="form.username" :disabled="!!form.id" required />
          </el-form-item>
          <el-form-item label="昵称" prop="name">
            <el-input v-model="form.name" required />
          </el-form-item>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px">
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="form.phone" />
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input v-model="form.email" />
          </el-form-item>
        </div>
      </el-form>

      <template #footer>
        <div style="display: flex; justify-content: flex-end; gap: 12px">
          <el-button @click="cancel">取消</el-button>
          <el-button type="primary" @click="submitForm">确定</el-button>
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
import defaultAvatar from "./user.png";

const getInitialForm = () => ({
  id: null,
  username: "",
  password: "",
  name: "",
  avatarurl: "",
  phone: "",
  email: "",
  money: 0,
});

const data = reactive({
  loading: true,
  ids: [],
  total: 0,
  title: "",
  open: false,
  dataList: [],
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    username: undefined,
    name: undefined,
  },
  form: getInitialForm(),
});

const { loading, ids, total, title, open, dataList, queryParams, form } =
  toRefs(data);
const formRef = ref(null);

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

function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.resetFields();
  }
}

async function getList() {
  loading.value = true;
  try {
    const params = { ...queryParams.value };
    for (const key in params) {
      if (params[key] === "" || params[key] === undefined) {
        delete params[key];
      }
    }
    const response = await requestApi.post("/api/user/page", params);
    if (response.code == "0") {
      dataList.value = response.data.list || [];
      total.value = parseInt(response.data.total) || 0;
      const currentIds = new Set((dataList.value || []).map((item) => item.id));
      ids.value = ids.value.filter((id) => currentIds.has(id));
    } else {
      ElMessage.error(response.msg || "获取列表失败");
    }
  } catch (error) {
    ElMessage.error("请求失败");
  } finally {
    loading.value = false;
  }
}

function handleQuery() {
  queryParams.value.page = 1;
  getList();
}

function resetQuery() {
  queryParams.value.username = undefined;
  queryParams.value.name = undefined;
  handleQuery();
}

function handleAdd() {
  resetForm();
  open.value = true;
  title.value = "添加新用户";
}

function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改用户信息";
}

async function submitForm() {
  if (!form.value.phone) {
    ElMessage.error("请输入手机号");
    return;
  }

  if (!/^1[3-9]\d{9}$/.test(form.value.phone)) {
    ElMessage.error("请输入正确的11位手机号");
    return;
  }

  try {
    const requestData = { ...form.value };
    if (!requestData.password) delete requestData.password;
    const url = form.value.id ? "/api/user/update" : "/api/user/save";
    const response = await requestApi.post(url, requestData);
    if (response.code == 0) {
      ElMessage.success(form.value.id ? "修改成功" : "新增成功");
      open.value = false;
      getList();
    } else {
      ElMessage.error(response.msg || "操作失败");
    }
  } catch (error) {
    ElMessage.error("请求失败");
  }
}

async function handleDelete(row) {
  const itemIds = row && row.id ? [row.id] : ids.value;
  if (itemIds.length == 0) return;

  const titleText = "确认删除";
  const messageText =
    row && row.id
      ? `您确定要删除用户 \"${row.username}\" 吗？此操作无法撤销。`
      : `您确定要删除选中的 ${itemIds.length} 条用户数据吗？此操作无法撤销。`;

  try {
    await ElMessageBox.confirm(messageText, titleText, {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    });
    await requestApi.post("/api/user/delete", itemIds);
    ElMessage.success("删除成功");
    getList();
  } catch (error) {
    if (error != "cancel") {
      ElMessage.error("删除失败");
    }
  }
}

function cancel() {
  open.value = false;
  resetForm();
}

async function resetUserPassword(row) {
  try {
    await ElMessageBox.confirm(
      `您确定要将用户 \"${row.username}\" 的密码重置为默认值吗？`,
      "确认重置密码",
      {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }
    );

    const response = await requestApi.post("/api/user/resetPass", {
      id: row.id,
      username: row.username,
    });

    if (response.code == 0) {
      ElMessage.success(response.data || "密码已重置为默认值");
    } else {
      ElMessage.error(response.msg || "重置失败");
    }
  } catch (error) {
    if (error != "cancel") {
      ElMessage.error("请求失败");
    }
  }
}

function handleSizeChange(val) {
  queryParams.value.limit = val;
  getList();
}

function handleCurrentChange(val) {
  queryParams.value.page = val;
  getList();
}

onMounted(getList);
</script>

<style scoped></style>

