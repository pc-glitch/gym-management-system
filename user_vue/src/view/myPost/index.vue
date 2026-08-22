<template>
  <div class="my-posts-page">
    <div class="page-container">
      <!-- Page Header -->
      <div class="page-header">
        <h1 class="page-title">我的创作</h1>
        <p class="page-subtitle">管理您发布的所有内容</p>
      </div>

      <!-- Posts Table -->
      <div class="table-container">
        <el-table
          v-loading="isLoading"
          :data="myPostsList"
          style="width: 100%"
          class="posts-table"
          :header-cell-style="{ background: '#fafbfe', color: '#606266' }"
        >
          <el-table-column prop="postTitle" label="帖子标题" min-width="250">
            <template #default="scope">
              <span class="post-title-cell">{{ scope.row.postTitle }}</span>
            </template>
          </el-table-column>
          <el-table-column
            prop="addtime"
            label="发布时间"
            align="center"
            width="180"
          />
          <el-table-column label="审核状态" align="center" width="120">
            <template #default="scope">
              <el-tag
                :type="scope.row.isApproved === 'Y' ? 'success' : 'warning'"
                effect="light"
                round
              >
                {{ scope.row.isApproved === "Y" ? "已审核" : "待审核" }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="发布状态" align="center" width="120">
            <template #default="scope">
              <el-tag
                :type="scope.row.isPublished === 'Y' ? 'primary' : 'info'"
                effect="light"
                round
              >
                {{ scope.row.isPublished === "Y" ? "已发布" : "草稿" }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="220">
            <template #default="scope">
              <el-button
                text
                type="primary"
                size="small"
                @click="handleView(scope.row)"
                >详情</el-button
              >
              <el-button
                text
                type="primary"
                size="small"
                @click="handleEdit(scope.row)"
                >编辑</el-button
              >
              <el-button
                text
                type="danger"
                size="small"
                @click="handleDelete(scope.row)"
                >删除</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>

    <!-- View Post Dialog -->
    <el-dialog
      v-model="dialogVisible"
      :title="selectedPost?.postTitle"
      width="75%"
      top="8vh"
      class="detail-dialog"
      :before-close="closeDetail"
    >
      <div v-if="selectedPost" class="detail-container">
        <header class="detail-header">
          <h2 class="detail-title">{{ selectedPost.postTitle }}</h2>
          <div class="detail-meta">
            <span>作者: {{ selectedPost.username }}</span>
            <span class="separator">|</span>
            <span>发布于: {{ selectedPost.addtime }}</span>
            <span class="separator">|</span>
            <el-tag size="small" type="info" effect="plain" round>{{
              selectedPost.categoryId
            }}</el-tag>
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
      </div>
      <template #footer>
        <el-button type="primary" @click="closeDetail" round>关闭</el-button>
      </template>
    </el-dialog>

    <!-- Edit Post Dialog -->
    <el-dialog
      v-model="editDialogVisible"
      title="编辑帖子"
      width="75%"
      top="8vh"
      class="detail-dialog"
      :before-close="closeEditDialog"
    >
      <div class="edit-form-container">
        <el-form
          :model="editingPost"
          :rules="rules"
          ref="editFormRef"
          label-position="top"
        >
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="帖子标题" prop="postTitle">
                <el-input
                  v-model="editingPost.postTitle"
                  size="large"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="帖子类型" prop="categoryId">
                <el-select
                  v-model="editingPost.categoryId"
                  placeholder="请选择分类"
                  size="large"
                  style="width: 100%"
                >
                  <el-option
                    v-for="category in categories"
                    :key="category.id"
                    :label="category.categoryName"
                    :value="category.categoryName"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="帖子封面" prop="picture">
            <ImageUpload v-model="editingPost.picture" />
          </el-form-item>
          <el-form-item label="帖子内容" prop="postContent">
            <div class="editor-wrapper">
              <RichTextEditor v-model="editingPost.postContent" />
            </div>
          </el-form-item>
          <el-form-item label="发布设置" prop="isPublished">
            <el-switch
              v-model="editingPost.isPublished"
              active-text="立即发布"
              inactive-text="存为草稿"
              active-value="Y"
              inactive-value="N"
              inline-prompt
            ></el-switch>
          </el-form-item>
        </el-form>
      </div>
      <template #footer>
        <el-button @click="closeEditDialog" round>取消</el-button>
        <el-button type="primary" @click="handleSaveEdit" round
          >保存修改</el-button
        >
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, reactive, onMounted } from "vue";
import { ElMessageBox } from "element-plus";

import Message from "@/components/MessageBox/index.js";
import requestApi from "@/utils/axios";
import { getUserData } from "@/utils/auth.js";

const isLoading = ref(false);
const myPostsList = ref([]);
const userData = ref(null);
const categories = ref([]);

const dialogVisible = ref(false);
const selectedPost = ref(null);

const editDialogVisible = ref(false);
const editFormRef = ref(null);
const editingPost = reactive({
  id: "",
  postTitle: "",
  isPublished: "",
  postContent: "",
  categoryId: "",
  picture: "",
});
const rules = reactive({
  postTitle: [{ required: true, message: "帖子标题不能为空", trigger: "blur" }],
  categoryId: [
    { required: true, message: "请选择帖子分类", trigger: "change" },
  ],
  postContent: [
    { required: true, message: "帖子内容不能为空", trigger: "blur" },
  ],
});

onMounted(async () => {
  const data = await getUserData();
  userData.value = data;
  if (userData.value) {
    getPostData();
  }
  getPostCategories();
});

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

const decodedContent = computed(() => {
  if (selectedPost.value?.postContent) {
    try {
      return decodeURIComponent(selectedPost.value.postContent);
    } catch (e) {
      console.error("Failed to decode URI component:", e);
      return selectedPost.value.postContent;
    }
  }
  return "";
});

const getPostData = async () => {
  if (!userData.value) return;
  isLoading.value = true;
  try {
    let response = await requestApi.post("/api/posts/list", {
      userid: userData.value.id,
    });
    myPostsList.value = response.data;
  } catch (error) {
    console.error("获取帖子数据失败:", error);
    Message.error("获取帖子数据失败");
  } finally {
    isLoading.value = false;
  }
};

const handleView = (post) => {
  selectedPost.value = post;
  dialogVisible.value = true;
};

const handleEdit = (post) => {
  Object.assign(editingPost, post);
  editDialogVisible.value = true;
};

const handleSaveEdit = async () => {
  if (!editFormRef.value) return;
  await editFormRef.value.validate((valid) => {
    if (valid) {
      const index = myPostsList.value.findIndex((p) => p.id === editingPost.id);
      if (index !== -1) {
        const originalPost = myPostsList.value[index];
        const modifiedPost = { ...editingPost };

        const titleChanged = originalPost.postTitle !== modifiedPost.postTitle;
        const contentChanged =
          originalPost.postContent !== modifiedPost.postContent;
        const categoryChanged =
          originalPost.categoryId !== modifiedPost.categoryId;
        const pictureChanged = originalPost.picture !== modifiedPost.picture;

        if (
          titleChanged ||
          contentChanged ||
          categoryChanged ||
          pictureChanged
        ) {
          modifiedPost.isApproved = "N";
        }
        modifyThePost(modifiedPost);
      }
      closeEditDialog();
    } else {
      Message.error("请检查表单输入项！");
    }
  });
};

const modifyThePost = async (data) => {
  try {
    let res = await requestApi.post("/api/posts/update", data);
    if (res.code == 0) {
      Message.success("帖子修改成功");
      getPostData();
    } else {
      Message.error(res.message || "帖子修改失败");
    }
  } catch (error) {
    Message.error(error.message || "请求失败");
  }
};

const handleDelete = (post) => {
  ElMessageBox.confirm(`确定要删除帖子 "${post.postTitle}" 吗?`, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        let res = await requestApi.post("/api/posts/delete", [post.id]);
        if (res.code == 0) {
          Message.success("删除成功!");
          getPostData();
        } else {
          Message.error(res.message || "删除失败");
        }
      } catch (error) {
        Message.error(error.message || "请求失败");
      }
    })
    .catch(() => {
      Message.info("已取消删除");
    });
};

const closeDetail = () => {
  dialogVisible.value = false;
  selectedPost.value = null;
};

const closeEditDialog = () => {
  editDialogVisible.value = false;
  if (editFormRef.value) {
    editFormRef.value.resetFields();
  }
};
</script>

<style scoped>
/* --- Base & Layout --- */
.my-posts-page {
  background-color: #f4f6f9;
  min-height: 100vh;
  padding: 40px 20px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
}

.page-container {
  width: 100%;
  max-width: 1400px;
  margin: 0 auto;
  background: #ffffff;
  padding: 32px 40px;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
}

/* --- Header --- */
.page-header {
  margin-bottom: 24px;
  padding-bottom: 24px;
  border-bottom: 1px solid #e5e7eb;
}

.page-title {
  font-size: 2.2rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
}

.page-subtitle {
  font-size: 1rem;
  color: #6b7280;
  margin-top: 8px;
}

/* --- Table --- */
.table-container {
  border-radius: 12px;
  overflow: hidden;
}

.posts-table {
  border: 1px solid #e5e7eb;
  border-radius: 12px;
}

.posts-table :deep(th) {
  font-weight: 500;
  color: #374151 !important;
}

.posts-table :deep(td),
.posts-table :deep(th) {
  padding: 16px 0;
}

.post-title-cell {
  font-weight: 500;
  color: #111827;
  cursor: pointer;
  transition: color 0.2s;
}
.post-title-cell:hover {
  color: #409eff;
}

/* --- Dialogs --- */
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
  text-align: right;
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
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.detail-meta .separator {
  color: #d1d5db;
}

.detail-image-wrapper {
  margin: 24px 0;
  text-align: center;
}
.detail-image {
  max-width: 100%;
  max-height: 400px;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.detail-content {
  font-size: 1.05rem;
  line-height: 1.8;
  color: #374151;
}

/* --- Edit Form --- */
.edit-form-container {
  padding: 0 10px;
}
.edit-form-container :deep(.el-form-item__label) {
  font-weight: 500;
}
.editor-wrapper {
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 5px;
}
</style>
