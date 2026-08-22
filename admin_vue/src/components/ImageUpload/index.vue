<template>
  <div class="image-upload-container">
    <input
      type="file"
      ref="fileInput"
      :accept="accept"
      :multiple="multiple"
      @change="handleFileChange"
      class="hidden-file-input"
    />

    <div class="upload-area" @click="triggerFileInput">
      <!-- 单文件模式下的预览 -->
      <template v-if="!multiple && currentPreviewUrl">
        <img
          :src="currentPreviewUrl"
          alt="图片预览"
          class="file-preview-image"
        />
        <div class="overlay">
          <el-icon class="overlay-icon" @click.stop="removeImage(0)"
            ><Delete
          /></el-icon>
        </div>
      </template>
      <!-- 多文件模式下的预览列表 -->
      <template v-else-if="multiple && uploadedFiles.length > 0">
        <div class="uploaded-images-grid">
          <div
            v-for="(file, index) in uploadedFiles"
            :key="file.url"
            class="uploaded-image-item"
          >
            <img
              :src="file.url"
              :alt="'图片' + (index + 1)"
              class="file-preview-image"
            />
            <div class="overlay">
              <el-icon class="overlay-icon" @click.stop="removeImage(index)"
                ><Delete
              /></el-icon>
            </div>
          </div>
          <div
            v-if="uploadedFiles.length < limit"
            class="upload-placeholder-item"
            @click.stop="triggerFileInput"
          >
            <el-icon><Plus /></el-icon>
            <p>上传图片</p>
          </div>
        </div>
      </template>
      <!-- 默认占位符 -->
      <template v-else>
        <div class="upload-placeholder">
          <el-icon><UploadFilled /></el-icon>
          <p>点击或拖拽文件到此处上传</p>
          <p class="text-sm text-gray-500">
            支持 {{ accept || "任意类型" }} 文件，最多 {{ limit }} 张，单张最大
            {{ maxSize }}MB
          </p>
        </div>
      </template>
    </div>

    <!-- 上传指示器 -->
    <div v-if="isUploading" class="uploading-indicator">
      <el-icon class="is-loading"><Loading /></el-icon>
      <span>上传中...</span>
    </div>
  </div>
</template>

<script setup>
import { ref, defineEmits, watch, computed } from "vue";
import axios from "axios"; // 直接引入 axios
import { ElIcon } from "element-plus";
import Message from "@/components/MessageBox/index.js";
import { UploadFilled, Plus, Delete, Loading } from "@element-plus/icons-vue"; // 导入 Element Plus 图标

const props = defineProps({
  // v-model 绑定，用于父组件获取图片 URL(s)
  // 单张图片时为 String，多张图片时为 Array<String>
  modelValue: {
    type: [String, Array],
    default: null, // 默认值为 null，避免引用 props.limit
  },
  // 允许上传的文件类型，默认为图片
  accept: {
    type: String,
    default: "image/*",
  },
  // 单张图片最大文件大小，单位 MB
  maxSize: {
    type: Number,
    default: 5,
  },
  // 上传接口的URL
  uploadUrl: {
    type: String,
    default: "/api/file/upload",
  },
  // 限制上传数量，不传默认为1 (单文件模式)
  limit: {
    type: Number,
    default: 1,
  },
});

const emit = defineEmits([
  "update:modelValue",
  "upload-success",
  "upload-error",
]);

const fileInput = ref(null);
const isUploading = ref(false);

// 根据 limit 属性判断是否为多文件上传模式
const multiple = computed(() => props.limit > 1);

// 单文件模式下的预览 URL
const currentPreviewUrl = ref("");
// 多文件模式下已上传文件的列表 [{ url: '...', id: '...' }]
const uploadedFiles = ref([]);

// 监听 modelValue 的变化，同步组件内部的预览状态
watch(
  () => props.modelValue,
  (newValue) => {
    console.log("--- Watch 监听 modelValue 变化 ---"); // 调试日志
    console.log("newValue (来自父组件的 v-model):", newValue); // 调试日志
    if (multiple.value) {
      // 多文件模式：modelValue 期望是 URL 数组或逗号分隔的字符串
      if (Array.isArray(newValue)) {
        uploadedFiles.value = newValue.map((url) => ({ url, id: url })); // 使用 URL 作为 ID
      } else if (typeof newValue === "string" && newValue) {
        // 兼容性处理：如果多文件模式下传入了字符串，将其分割成数组
        uploadedFiles.value = newValue
          .split(",")
          .filter((url) => url)
          .map((url) => ({ url, id: url }));
      } else {
        uploadedFiles.value = []; // 处理 null, undefined, 或空值
      }
      console.log(
        "多文件模式下 uploadedFiles.value 更新为:",
        uploadedFiles.value
      ); // 调试日志
    } else {
      // 单文件模式：modelValue 期望是单个 URL 字符串
      currentPreviewUrl.value = newValue || ""; // 处理 null, undefined, 或空值
      console.log(
        "单文件模式下 currentPreviewUrl.value 更新为:",
        currentPreviewUrl.value
      ); // 调试日志
    }
  },
  { immediate: true }
); // 立即执行一次，确保初始值同步

// 触发文件选择框点击事件
const triggerFileInput = () => {
  if (isUploading.value) {
    Message.warning("文件正在上传中，请稍候！");
    return;
  }
  // 如果是多文件模式且已达到限制，则不触发文件选择
  if (multiple.value && uploadedFiles.value.length >= props.limit) {
    Message.warning(`最多只能上传 ${props.limit} 张图片！`);
    return;
  }
  fileInput.value.click();
};

// 处理文件选择事件
const handleFileChange = (event) => {
  const files = event.target.files;
  console.log("--- handleFileChange 文件选择事件触发 ---"); // 调试日志
  console.log("选择的文件:", files); // 调试日志
  if (!files || files.length == 0) {
    // 如果没有选择文件，清空 input 的值并返回
    event.target.value = "";
    return;
  }

  // 根据多文件模式处理文件
  const filesToUpload = multiple.value ? Array.from(files) : [files[0]];

  // 检查文件数量是否超出限制（仅在多文件模式下）
  if (
    multiple.value &&
    uploadedFiles.value.length + filesToUpload.length > props.limit
  ) {
    Message.error(`最多只能上传 ${props.limit} 张图片！`);
    event.target.value = ""; // 清空 input 的值
    return;
  }

  // 自动上传所选文件
  uploadFiles(filesToUpload);
  event.target.value = ""; // 清空 input 的值，以便下次可以选择相同文件
};

// 核心上传逻辑，支持单文件和多文件
const uploadFiles = async (files) => {
  if (files.length == 0) return;

  isUploading.value = true;
  console.log("--- uploadFiles 开始上传 ---"); // 调试日志
  console.log("上传前 uploadedFiles.value:", uploadedFiles.value); // 调试日志

  const uploadPromises = files.map((file) => {
    // 检查文件类型
    if (
      props.accept &&
      !new RegExp(props.accept.replace(/\*/g, ".*")).test(file.type)
    ) {
      Message.error(`文件 "${file.name}" 类型不符合要求 (${props.accept})！`);
      return Promise.reject(`文件类型不符合要求: ${file.name}`);
    }
    // 检查文件大小
    if (file.size > props.maxSize * 1024 * 1024) {
      Message.error(`文件 "${file.name}" 大小超过 ${props.maxSize}MB！`);
      return Promise.reject(`文件大小超出限制: ${file.name}`);
    }

    const formData = new FormData();
    formData.append("file", file); // 后端接收文件字段名通常为 'file'

    return axios.post(props.uploadUrl, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
        // 后端认证
        // 'Authorization': `Bearer ${yourAuthToken}`
      },
      onUploadProgress: (progressEvent) => {
        const percentCompleted = Math.round(
          (progressEvent.loaded * 100) / progressEvent.total
        );
        console.log(`文件 "${file.name}" 上传进度: ${percentCompleted}%`);
      },
    });
  });

  try {
    const responses = await Promise.allSettled(uploadPromises);
    let allSuccess = true;
    let newUploadedUrls = [];

    responses.forEach((result, index) => {
      if (result.status === "fulfilled" && result.value.data.code == 0) {
        const uploadedData = result.value.data.data;
        newUploadedUrls.push(uploadedData.url);
        // 更新单文件模式下的预览
        if (!multiple.value) {
          currentPreviewUrl.value = uploadedData.url;
        }
        Message.success(`文件 "${files[index].name}" 上传成功！`);
        emit("upload-success", uploadedData); // 触发单个文件上传成功事件
      } else {
        allSuccess = false;
        const errorMessage =
          result.status === "rejected"
            ? result.reason
            : result.value?.data?.msg || "未知错误";
        Message.error(`文件 "${files[index].name}" 上传失败: ${errorMessage}`);
        emit("upload-error", errorMessage); // 触发单个文件上传失败事件
      }
    });

    if (multiple.value) {
      console.log("多文件模式：新上传的URL:", newUploadedUrls); // 调试日志
      const currentUrls = uploadedFiles.value.map((f) => f.url);
      console.log(
        "多文件模式：合并前的当前URL (来自 uploadedFiles.value):",
        currentUrls
      ); // 调试日志
      const combinedUrls = [...currentUrls, ...newUploadedUrls];
      // 核心修复：直接使用 combinedUrls 进行 join，因为它已经是字符串数组
      uploadedFiles.value = combinedUrls.map((url) => ({ url, id: url })); // 更新内部列表
      console.log(
        "多文件模式：合并后的 uploadedFiles.value:",
        uploadedFiles.value
      ); // 调试日志
      emit("update:modelValue", combinedUrls.join(",")); // 更新 v-model 为逗号分隔的字符串
      console.log(
        "多文件模式：emit update:modelValue:",
        combinedUrls.join(",")
      ); // 调试日志
    } else {
      emit("update:modelValue", newUploadedUrls[0] || ""); // 确保返回单个 URL
    }

    if (allSuccess) {
    }
  } catch (error) {
    console.error("文件上传过程中发生错误:", error); // 调试日志
    Message.error("文件上传过程中发生错误，请重试！");
    emit("upload-error", error);
  } finally {
    isUploading.value = false;
  }
};

// 移除已上传的图片
const removeImage = (index) => {
  if (multiple.value) {
    const newFiles = [...uploadedFiles.value];
    const removedUrl = newFiles[index]?.url; // 获取被移除的URL
    newFiles.splice(index, 1);
    uploadedFiles.value = newFiles;
    const updatedModelValue = newFiles.map((f) => f.url).join(",");
    emit("update:modelValue", updatedModelValue); // 更新 v-model 为逗号分隔的字符串
    Message.success(`图片 "${removedUrl}" 已移除。`);
  } else {
    // 单文件模式
    currentPreviewUrl.value = "";
    emit("update:modelValue", "");
    Message.success("图片已移除。");
  }
  // 清空 input 的值，以便下次可以选择相同文件
  if (fileInput.value) {
    fileInput.value.value = "";
  }
};

// 如果需要，暴露方法给父组件
defineExpose({
  triggerFileInput,
  removeImage,
  // 如果需要手动上传，可以暴露 uploadFiles 方法
});
</script>

<style scoped>
.image-upload-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  border: 1px dashed #dcdfe6;
  border-radius: 8px;
  background-color: #fafafa;
}

.hidden-file-input {
  display: none;
}

.upload-area {
  width: 100%;
  min-height: 150px;
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  cursor: pointer;
  background-color: #f5f7fa;
  border-radius: 6px;
  transition: background-color 0.3s ease;
  overflow: hidden; /* 确保图片不会溢出 */
  position: relative; /* 用于 overlay 定位 */
}

.upload-area:hover {
  background-color: #e9eef3;
}

.upload-placeholder {
  text-align: center;
  color: #909399;
  padding: 1rem;
}

.upload-placeholder .el-icon {
  font-size: 48px;
  color: #c0c4cc;
  margin-bottom: 0.5rem;
}

.upload-placeholder p {
  margin: 0;
  font-size: 14px;
}

.file-preview-image {
  max-width: 100%;
  max-height: 150px; /* 限制预览图高度 */
  object-fit: contain; /* 保持图片比例 */
  border-radius: 6px;
  display: block; /* 避免图片下方有空白 */
}

.uploaded-images-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  padding: 10px;
  box-sizing: border-box;
  width: 100%;
  overflow: hidden;
}

.uploaded-image-item,
.upload-placeholder-item {
  flex: 0 0 120px;
  width: 120px;
  height: 90px;
  border-radius: 6px;
  background-color: #e9eef3;
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
}

.uploaded-image-item img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.upload-placeholder-item .el-icon {
  font-size: 30px;
  color: #c0c4cc;
  margin-bottom: 0.5rem;
}

.uploaded-image-item .overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.uploaded-image-item:hover .overlay {
  opacity: 1;
}

.overlay-icon {
  color: #fff;
  font-size: 24px;
  cursor: pointer;
}

.uploading-indicator {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #409eff; /* Element Plus primary color */
  font-size: 14px;
}
.uploading-indicator .el-icon {
  font-size: 16px;
}
</style>
