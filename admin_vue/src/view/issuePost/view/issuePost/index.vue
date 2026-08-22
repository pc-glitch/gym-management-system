<template>
  <div class="create-post-page">
    <el-card class="post-form-card">
      <template #header>
        <div class="card-header">
          <span class="form-title">发布新帖子</span>
        </div>
      </template>

      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
        class="post-form"
      >
        <el-form-item label="帖子标题" prop="postTitle">
          <el-input v-model="form.postTitle" placeholder="请输入帖子标题" />
        </el-form-item>
        <el-form-item label="话题分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择话题分类">
            <el-option
              v-for="item in categories"
              :key="item.id"
              :label="item.categoryName"
              :value="item.id"
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
        <el-form-item>
          <el-button type="primary" @click="submitForm">发布帖子</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs } from "vue";
import requestApi from "@/utils/axios";
import { ElMessage } from "element-plus";
import Message from "@/components/MessageBox/index.js";
import ImageUpload from "@/components/ImageUpload/index.vue";
import RichTextEditor from "@/components/RichTextEditor/index.vue";

// 初始表单状态
const getInitialForm = () => ({
  id: null,
  categoryId: "",
  postingAddress: "",
  picture: "",
  postTitle: "",
  postContent: "",
  isPublished: "Y",
  isApproved: "Y", // 后台帖子默认需要审核
});

const data = reactive({
  categories: [], // 话题分类
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

const { categories, form, rules } = toRefs(data);

const formRef = ref(null); // 表单引用

/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
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

/** 提交按钮 */
async function submitForm() {
  formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const response = await requestApi.post("/api/posts/save", form.value);
        if (response.code == 0) {
          Message.success("新增成功");
          resetForm();
        } else {
          Message.error(response.msg || "操作失败");
        }
      } catch (error) {
        console.error(error);
        Message.error("请求失败");
      }
    }
  });
}

onMounted(() => {
  getCategories();
});
</script>

<style scoped>
.create-post-page {
  display: flex;
  justify-content: center;
  align-items: flex-start; /* 居中对齐 */
  min-height: 100vh;
  background-color: #f7f9fc;
  padding: 40px 20px;
}

.post-form-card {
  width: 100%;
  max-width: 900px;
  border-radius: 12px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.card-header {
  font-size: 1.5em;
  font-weight: bold;
}

.post-form {
  margin-top: 20px;
}

/* 调整输入框和选择框的宽度 */
.el-input,
.el-select,
.el-textarea {
  width: 100%;
}
</style>
