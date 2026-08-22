<template>
  <div class="issue-post-page">
    <div class="form-container">
      <div class="form-header">
        <h1 class="form-title">创作新内容</h1>
        <p class="form-subtitle">分享您的见解，与社区一同成长</p>
      </div>

      <el-form
        :model="postForm"
        :rules="rules"
        ref="postFormRef"
        label-position="top"
        class="post-form"
      >
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="帖子标题" prop="postTitle">
              <el-input
                v-model="postForm.postTitle"
                placeholder="起一个吸引人的标题吧"
                size="large"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="帖子类型" prop="categoryId">
              <el-select
                v-model="postForm.categoryId"
                placeholder="为您的内容选择一个分类"
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

        <el-form-item label="发布地址" prop="postingAddress">
          <AddressSelector v-model="postForm.postingAddress" size="large" />
        </el-form-item>

        <el-form-item label="帖子封面" prop="picture">
          <ImageUpload v-model="postForm.picture" />
          <p class="form-item-tip">一张精美的封面图可以吸引更多读者哦</p>
        </el-form-item>

        <el-form-item label="帖子正文" prop="postContent">
          <div class="editor-wrapper">
            <RichTextEditor v-model="postForm.postContent" />
          </div>
        </el-form-item>

        <el-form-item label="发布设置" prop="isPublished">
          <el-switch
            v-model="postForm.isPublished"
            active-text="立即发布"
            inactive-text="存为草稿"
            active-value="Y"
            inactive-value="N"
            inline-prompt
            style="
              --el-switch-on-color: #13ce66;
              --el-switch-off-color: #ff4949;
            "
          ></el-switch>
        </el-form-item>

        <el-form-item class="form-actions">
          <el-button type="primary" @click="handlePublish" size="large" round
            >确认发布</el-button
          >
          <el-button @click="resetForm" size="large" round>清空内容</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import Message from "@/components/MessageBox/index.js";
import requestApi from "@/utils/axios";
import { getUserData } from "@/utils/auth.js";
import { useRouter, useRoute } from "vue-router";
const router = useRouter(); // 获取路由器实例
const route = useRoute(); // 获取当前路由实例
const postFormRef = ref(null);
const categories = ref([]); // 存储帖子分类

const postForm = reactive({
  postTitle: "",
  categoryId: "",
  isPublished: "Y",
  postingAddress: "",
  picture: "",
  postContent: "",
});

const rules = reactive({
  postTitle: [
    { required: true, message: "请输入帖子标题", trigger: "blur" },
    { min: 3, max: 50, message: "长度在 3 到 50 个字符", trigger: "blur" },
  ],
  categoryId: [
    { required: true, message: "请选择帖子类型", trigger: "change" },
  ],
  postingAddress: [
    { required: true, message: "请输入发布地址", trigger: "blur" },
  ],
  postContent: [{ required: true, message: "请输入帖子内容", trigger: "blur" }],
});

onMounted(() => {
  getPostCategories();
});

/**
 * @description: 获取帖子分类
 */
const getPostCategories = async () => {
  try {
    const response = await requestApi.post("/api/postcategories/page", {
      page: 1,
      limit: 1000,
      order: "addtime",
    });
    if (response.code == 0 && response.data && response.data.list) {
      categories.value = response.data.list;
    } else {
      Message.error("获取帖子分类失败");
    }
  } catch (error) {
    console.error("获取帖子分类失败:", error);
    Message.error("获取帖子分类失败");
  }
};

/**
 * @description: 处理发布帖子的逻辑
 */
const handlePublish = () => {
  postFormRef.value.validate(async (valid) => {
    if (valid) {
      //用户信息
      const mockData = await getUserData();

      // 模拟帖子内容编码，并去除图片url
      const finalPostContent = encodeURIComponent(
        `<p>${postForm.postContent}</p>`
      );

      // 最终要打印的对象
      const finalPost = {
        postContent: postForm.postContent,
        postTitle: postForm.postTitle,
        categoryId: postForm.categoryId,
        isPublished: postForm.isPublished,
        postingAddress: postForm.postingAddress,
        picture: postForm.picture,
        isApproved: "N",
        userid: mockData.userid,
        username: mockData.username,
      };

      console.log("即将发布的帖子数据:", finalPost);

      submitPost(finalPost);

      // resetForm();
    } else {
      Message.error("请检查表单填写是否完整和正确。");
      return false;
    }
  });
};

// const 提交帖子数据
const submitPost = async (data) => {
  try {
    let response = await requestApi.post("/api/posts/save", data);

    if (response.code == 0) {
      Message.success("发布成功，等待审核");
      router.push("/myPost");
    }
  } catch (error) {
    console.error("发布失败:", error);
  }
};
/**
 * @description: 重置表单
 */
const resetForm = () => {
  postFormRef.value.resetFields();
};
</script>

<style scoped>
/* --- Base & Layout --- */
.issue-post-page {
  background-color: #f4f6f9;
  min-height: 100vh;
  padding: 40px 20px;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
}

.form-container {
  width: 100%;
  max-width: 1000px;
  background: #ffffff;
  padding: 40px 50px;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
}

/* --- Form Header --- */
.form-header {
  text-align: center;
  margin-bottom: 32px;
}

.form-title {
  font-size: 2.2rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
}

.form-subtitle {
  font-size: 1rem;
  color: #6b7280;
  margin-top: 8px;
}

/* --- Form Elements --- */
.post-form {
  margin-top: 20px;
}

.post-form :deep(.el-form-item__label) {
  font-size: 0.95rem;
  font-weight: 500;
  color: #374151;
  margin-bottom: 8px !important;
}

.post-form :deep(.el-input__wrapper),
.post-form :deep(.el-select__wrapper) {
  border-radius: 8px !important;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
  transition: box-shadow 0.2s;
}
.post-form :deep(.el-input__wrapper:hover),
.post-form :deep(.el-select__wrapper:hover) {
  box-shadow: 0 1px 5px rgba(0, 0, 0, 0.08);
}

.form-item-tip {
  color: #9ca3af;
  font-size: 0.85rem;
  margin-top: 4px;
}

.editor-wrapper {
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 5px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
  transition: border-color 0.2s, box-shadow 0.2s;
}
.editor-wrapper:hover {
  border-color: #c0c4cc;
}
.editor-wrapper :deep(.w-e-toolbar),
.editor-wrapper :deep(.w-e-text-container) {
  border: none !important;
}
.editor-wrapper :deep(.w-e-text-container) {
  min-height: 300px;
}

.form-actions {
  margin-top: 32px;
  border-top: 1px solid #f3f4f6;
  padding-top: 24px;
}
.form-actions :deep(.el-form-item__content) {
  justify-content: center;
  gap: 16px;
}

/* --- Responsive --- */
@media (max-width: 768px) {
  .form-container {
    padding: 30px 25px;
  }
  .el-row {
    flex-direction: column;
  }
  .el-col {
    max-width: 100%;
    width: 100%;
  }
}
</style>
