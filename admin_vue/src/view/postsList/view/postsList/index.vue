<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form
      :model="queryParams"
      ref="queryForm"
      :inline="true"
      label-width="88px"
    >
      <el-form-item label="帖子标题" prop="postTitle">
        <el-input
          v-model="queryParams.postTitle"
          placeholder="请输入帖子标题"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否发布" prop="isPublished">
        <el-select
          style="width: 168px"
          v-model="queryParams.isPublished"
          placeholder="请选择状态"
          clearable
        >
          <el-option label="是" value="Y" />
          <el-option label="否" value="N" />
        </el-select>
      </el-form-item>
      <el-form-item label="是否审核" prop="isApproved">
        <el-select
          style="width: 168px"
          v-model="queryParams.isApproved"
          placeholder="请选择状态"
          clearable
        >
          <el-option label="是" value="Y" />
          <el-option label="否" value="N" />
        </el-select>
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
      <el-table-column label="帖子标题" align="center" prop="postTitle" />
      <el-table-column label="话题分类" align="center" prop="categoryId" />
      <el-table-column label="发帖地址" align="center" prop="postingAddress" />
      <el-table-column label="封面" align="center" prop="picture">
        <template #default="scope">
          <img
            v-if="scope.row.picture"
            :src="scope.row.picture"
            alt="封面"
            style="width: 100px; height: auto"
          />
          <span v-else>无</span>
        </template>
      </el-table-column>
      <el-table-column label="是否发布" align="center" prop="isPublished">
        <!-- Y是N否  静态显示 -->
        <template #default="scope">
          <el-tag v-if="scope.row.isPublished === 'Y'" type="success"
            >是</el-tag
          >
          <el-tag v-else type="danger">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="是否审核" align="center" prop="isApproved">
        <template #default="scope">
          <el-tag v-if="scope.row.isApproved === 'Y'" type="success">是</el-tag>
          <el-tag v-else type="danger">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发帖人" align="center" prop="username" />
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
      width="800px"
      append-to-body
      @close="cancel"
    >
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="帖子标题" prop="postTitle">
          <el-input v-model="form.postTitle" placeholder="请输入帖子标题" />
        </el-form-item>
        <el-form-item label="话题分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择话题分类">
            <el-option
              v-for="item in categories"
              :key="item.id"
              :label="item.categoryName"
              :value="item.categoryName"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="发帖地址" prop="postingAddress">
          <el-input
            v-model="form.postingAddress"
            placeholder="请输入发帖地址"
          />
        </el-form-item>
        <el-form-item label="封面" prop="picture">
          <ImageUpload v-model="form.picture" />
        </el-form-item>
        <el-form-item label="内容" prop="postContent">
          <RichTextEditor v-model="form.postContent" />
        </el-form-item>
        <el-form-item label="是否发布" prop="isPublished">
          <el-radio-group v-model="form.isPublished">
            <el-radio label="Y">是</el-radio>
            <el-radio label="N">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="是否审核" prop="isApproved">
          <el-radio-group v-model="form.isApproved">
            <el-radio label="Y">是</el-radio>
            <el-radio label="N">否</el-radio>
          </el-radio-group>
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
import ImageUpload from "@/components/ImageUpload/index.vue";
import RichTextEditor from "@/components/RichTextEditor/index.vue";

import { Search, Refresh, Plus, Delete } from "@element-plus/icons-vue";

// 初始表单状态
const getInitialForm = () => ({
  id: null,
  categoryId: "",
  postingAddress: "",
  picture: "",
  postTitle: "",
  postContent: "",
  isPublished: "N",
  isApproved: "N",
});

const data = reactive({
  loading: true,
  ids: [],
  multiple: true,
  total: 0,
  title: "",
  open: false,
  dataList: [],
  categories: [], // 话题分类
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    postTitle: undefined,
    isPublished: undefined,
    isApproved: undefined,
  },
  form: getInitialForm(),
  rules: {
    postTitle: [
      { required: true, message: "帖子标题不能为空", trigger: "blur" },
    ],
    categoryId: [
      { required: true, message: "话题分类不能为空", trigger: "change" },
    ],
    postContent: [{ required: true, message: "内容不能为空", trigger: "blur" }],
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
  categories,
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
      "/api/posts/page",
      queryParams.value
    );
    if (response.code == 0) {
      dataList.value = response.data.list.map((item) => {
        try {
          // 尝试解码，如果失败则使用原始内容
          item.postContent = decodeURIComponent(item.postContent);
        } catch (e) {
          // 内容不是有效的URI编码，无需处理
        }
        return item;
      });
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

/** 获取话题分类 */
async function getCategories() {
  try {
    const response = await requestApi.post("/api/postcategories/page", {
      page: 1,
      limit: 100,
    });
    if (response.code == 0) {
      categories.value = response.data.list;
    } else {
      Message.error(response.msg || "获取话题分类失败");
    }
  } catch (error) {
    console.error(error);
    Message.error("请求话题分类失败");
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
    postTitle: undefined,
    isPublished: undefined,
    isApproved: undefined,
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
  title.value = "添加帖子";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  const postData = { ...row };
  // 如果分类是名称，需要找到对应的id
  postData.categoryId = row.categoryId;
  try {
    postData.postContent = decodeURIComponent(postData.postContent);
  } catch (e) {
    // 内容不是有效的URI编码，无需处理
  }
  Object.assign(form.value, postData);
  open.value = true;
  title.value = "修改帖子";
}

/** 提交按钮 */
async function submitForm() {
  formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        if (form.value.id) {
          // 修改逻辑
          const response = await requestApi.post(
            "/api/posts/update",
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
          const response = await requestApi.post("/api/posts/save", form.value);
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
    ? `是否确认删除ID为"${row.id}"的数据项？`
    : `是否确认删除选中的${itemIds.length}条数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/posts/delete", itemIds);
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
  getCategories();
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
