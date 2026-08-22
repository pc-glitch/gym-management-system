<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form
      :model="queryParams"
      ref="queryForm"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="分类名称" prop="categoryName">
        <el-input
          v-model="queryParams.categoryName"
          placeholder="请输入分类名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" :icon="Search" @click="handleQuery">
          搜索</el-button
        >
        <el-button :icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          :icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          >删除</el-button
        >
      </el-col>
    </el-row>

    <!-- 数据表格 -->
    <el-table
      v-loading="loading"
      :data="dataList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" width="180" />
      <el-table-column label="分类名称" align="center" prop="categoryName" />
      <el-table-column label="创建人" align="center" prop="username" />
      <el-table-column
        label="创建时间"
        align="center"
        prop="addtime"
        width="180"
      />
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        fixed="right"
        width="150"
      >
        <template #default="scope">
          <el-button type="primary" link @click="handleUpdate(scope.row)">
            修改
          </el-button>
          <el-button type="danger" link @click="handleDelete(scope.row)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div class="pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getList"
      />
    </div>

    <!-- 添加或修改对话框 -->
    <el-dialog
      :title="title"
      v-model="open"
      width="600px"
      append-to-body
      @close="cancel"
    >
      <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="分类名称" prop="categoryName">
          <el-input v-model="form.categoryName" placeholder="请输入分类名称" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs } from "vue";
import requestApi from "@/utils/axios";
import { ElMessage, ElMessageBox } from "element-plus";
import Message from "@/components/MessageBox/index.js";
import { getUserData } from "@/utils/auth";
import { Search, Refresh, Plus, Delete } from "@element-plus/icons-vue";

// 初始表单状态
const getInitialForm = () => ({
  id: null,
  categoryName: "",
});

const data = reactive({
  loading: true,
  ids: [],
  multiple: true,
  total: 0,
  title: "",
  open: false,
  dataList: [],
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    categoryName: undefined,
  },
  form: getInitialForm(),
  rules: {
    categoryName: [
      { required: true, message: "分类名称不能为空", trigger: "blur" },
    ],
  },
});

const {
  loading,
  ids,
  multiple,
  total,
  title,
  open,
  dataList,
  queryParams,
  form,
  rules,
} = toRefs(data);

const formRef = ref(null); // 表单引用

/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
  }
}

/** 查询列表 */
async function getList() {
  loading.value = true;
  try {
    const response = await requestApi.post(
      "/api/postcategories/page",
      queryParams.value
    );
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取列表失败");
    }
  } catch (error) {
    console.error(error);
    Message.error("请求失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  const defaultQueryParams = {
    page: 1,
    limit: 10,
    order: "addtime",
    categoryName: undefined,
  };
  Object.assign(queryParams.value, defaultQueryParams);
  handleQuery();
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.id);
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  resetForm();
  open.value = true;
  title.value = "添加分类";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改分类";
}

/** 提交按钮 */
async function submitForm() {
  formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        if (form.value.id) {
          // 修改逻辑
          const response = await requestApi.post(
            "/api/postcategories/update",
            form.value
          );
          if (response.code == 0) {
            Message.success("修改成功");
            open.value = false;
            getList();
          } else {
            Message.error(response.msg || "操作失败");
          }
        } else {
          // 新增逻辑

          let userdata = await getUserData();
          form.value.username = userdata.username;
          const response = await requestApi.post(
            "/api/postcategories/save",
            form.value
          );
          if (response.code == 0) {
            Message.success("新增成功");
            open.value = false;
            getList();
          } else {
            Message.error(response.msg || "操作失败");
          }
        }
      } catch (error) {
        console.error(error);
        Message.error("请求失败");
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const itemIds = row.id ? [row.id] : ids.value;
  const confirmMessage = row.id
    ? `是否确认删除ID为"${row.id}"的分类？`
    : `是否确认删除选中的${itemIds.length}条分类？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post(
          "/api/postcategories/delete",
          itemIds
        );
        if (response.code == 0) {
          Message.success("删除成功");
          getList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error(error);
        Message.error("请求失败");
      }
    })
    .catch(() => {});
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  resetForm();
}

onMounted(() => {
  getList();
});
</script>

<style scoped>
.app-container {
  padding: 20px;
}
.mb8 {
  margin-bottom: 10px;
}
.dialog-footer {
  text-align: right;
}
.pagination-container {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
