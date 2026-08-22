<template>
  <div class="file-upload-container">
    <el-upload
      ref="uploadRef"
      class="file-uploader"
      :action="uploadUrl"
      :multiple="multiple"
      :limit="limit"
      :accept="accept"
      :before-upload="handleBeforeUpload"
      :on-success="handleSuccess"
      :on-error="handleError"
      :on-exceed="handleExceed"
      :on-remove="handleRemove"
      :file-list="fileList"
      list-type="text"
    >
      <el-button type="primary">
        <el-icon class="el-icon--left"><Upload /></el-icon>
        点击上传文件
      </el-button>
      <template #tip>
        <div class="el-upload__tip">
          可上传
          {{ accept === "*/*" ? "任意类型" : accept }} 文件，单个文件不超过
          {{ maxSize }}MB，最多上传 {{ limit }} 个文件。
        </div>
      </template>
    </el-upload>
  </div>
</template>

<script setup>
import { ref, defineEmits, watch, computed } from "vue";
import { ElButton, ElUpload, ElIcon } from "element-plus";
import { Upload } from "@element-plus/icons-vue";
import Message from "@/components/MessageBox/index.js";

const props = defineProps({
  // v-model 绑定，逗号分隔的字符串
  modelValue: {
    type: [String, Array], // 兼容数组以提高容错性
    default: "",
  },
  // 允许上传的文件类型
  accept: {
    type: String,
    default: "*/*",
  },
  // 单个文件最大大小，单位 MB
  maxSize: {
    type: Number,
    default: 20, // 文件默认限制大一点
  },
  // 上传接口的URL
  uploadUrl: {
    type: String,
    default: "/api/file/upload", // 通用文件上传接口
  },
  // 限制上传数量
  limit: {
    type: Number,
    default: 5,
  },
});

const emit = defineEmits(["update:modelValue"]);

const uploadRef = ref(null);
const fileList = ref([]);

// 根据 limit 属性判断是否为多文件上传模式
const multiple = computed(() => props.limit > 1);

// 将外部传入的 URL 数组 (modelValue) 转换为 el-upload 所需的 fileList 格式
const urlsToFiles = (urls) => {
  return urls.map((url) => ({
    name: url.substring(url.lastIndexOf("/") + 1), // 从 URL 中提取文件名
    url: url,
    status: "success", // 标记为已成功
  }));
};

// 将内部的 fileList 格式转换为 URL 数组 (string[]) 并 emit 出去
const filesToUrls = (files) => {
  return files.map((file) => file.url).filter(Boolean); // 过滤掉无效 url
};

// 监听 modelValue 的变化，从外部同步 fileList
watch(
  () => props.modelValue,
  (newValue) => {
    let incomeUrls = [];
    if (Array.isArray(newValue)) {
      // 兼容数组类型输入
      incomeUrls = newValue;
    } else if (typeof newValue === "string" && newValue) {
      // 标准字符串类型输入
      incomeUrls = newValue.split(",").filter(Boolean);
    }

    const currentUrls = filesToUrls(fileList.value);

    // 只有当传入的 URL 列表和当前的 URL 列表不一致时才更新
    if (JSON.stringify(incomeUrls) !== JSON.stringify(currentUrls)) {
      fileList.value = urlsToFiles(incomeUrls);
    }
  },
  { immediate: true, deep: true }
);

// 上传前的校验
const handleBeforeUpload = (rawFile) => {
  const isSizeOk = rawFile.size / 1024 / 1024 < props.maxSize;
  if (!isSizeOk) {
    Message.error(`文件大小不能超过 ${props.maxSize}MB!`);
    return false;
  }
  return true;
};

// 上传成功的回调
const handleSuccess = (response, uploadFile, uploadFiles) => {
  if (response.code == 0) {
    // 关键：用后端返回的真实 URL 替换掉临时的 blob URL
    const uploadedFileIndex = uploadFiles.findIndex(
      (f) => f.uid === uploadFile.uid
    );
    if (uploadedFileIndex > -1) {
      uploadFiles[uploadedFileIndex].url = response.data.url;
    }

    // 更新内部 fileList 的状态
    fileList.value = [...uploadFiles];

    // 触发 v-model 更新
    const newUrls = filesToUrls(fileList.value);
    emit("update:modelValue", newUrls.join(","));
    Message.success("上传成功");
  } else {
    Message.error(response.msg || "上传失败");
    // 从列表中移除上传失败的文件
    const failedFileIndex = uploadFiles.findIndex(
      (f) => f.uid === uploadFile.uid
    );
    if (failedFileIndex > -1) {
      uploadFiles.splice(failedFileIndex, 1);
    }
    fileList.value = [...uploadFiles];
  }
};

// 上传失败的回调
const handleError = (error, uploadFile, uploadFiles) => {
  Message.error("文件上传失败，请检查网络或联系管理员");
};

// 文件数量超出限制的回调
const handleExceed = (files, uploadFiles) => {
  Message.warning(
    `当前限制选择 ${props.limit} 个文件，本次选择了 ${
      files.length
    } 个文件，共选择了 ${files.length + uploadFiles.length} 个文件`
  );
};

// 移除文件的回调
const handleRemove = (uploadFile, uploadFiles) => {
  // 更新内部 fileList
  fileList.value = [...uploadFiles];

  // 触发 v-model 更新
  const newUrls = filesToUrls(fileList.value);
  emit("update:modelValue", newUrls.join(","));
  Message.success("文件已移除");
};
</script>

<style scoped>
.file-upload-container {
  width: 100%;
  padding: 10px;
  border: 1px dashed #dcdfe6;
  border-radius: 6px;
  background-color: #fafafa;
}

.file-uploader {
  width: 100%;
}

.el-upload__tip {
  color: #909399;
  font-size: 12px;
  margin-top: 7px;
}
</style>
