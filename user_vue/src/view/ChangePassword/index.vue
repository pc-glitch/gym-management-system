<template>
  <div class="change-password-page">
    <div class="bg-shapes">
      <div class="shape shape-1"></div>
      <div class="shape shape-2"></div>
    </div>

    <div class="page-container">
      <div class="glass-card form-card">
        <div class="card-header">
          <div class="icon-wrapper">
            <svg
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            >
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
              <path d="M7 11V7a5 5 0 0110 0v4" />
            </svg>
          </div>
          <h2>修改密码</h2>
          <p>为了您的账户安全，建议定期更换密码</p>
        </div>

        <el-form
          :model="passwordFormState"
          label-position="top"
          @submit.prevent
          class="custom-form"
        >
          <el-form-item label="新密码">
            <el-input
              v-model="passwordFormState.newPassword"
              type="password"
              show-password
              placeholder="请输入新密码"
              class="custom-input"
            />
          </el-form-item>

          <el-form-item label="确认密码">
            <el-input
              v-model="passwordFormState.confirmPassword"
              type="password"
              show-password
              placeholder="请再次输入新密码"
              class="custom-input"
            />
          </el-form-item>

          <el-form-item label="密码强度">
            <div class="strength-indicator">
              <el-progress
                :percentage="strengthLevel * 33.33"
                :status="progressStatus"
                :stroke-width="6"
                :show-text="false"
                class="strength-bar"
              />
              <span :class="['strength-text', strengthClass]">{{
                strengthText || "未输入"
              }}</span>
            </div>
            <ul class="strength-tips">
              <li :class="{ active: hasLength }">
                <span class="dot"></span> 至少 8 位字符
              </li>
              <li :class="{ active: hasCase }">
                <span class="dot"></span> 包含大小写字母
              </li>
              <li :class="{ active: hasNumber }">
                <span class="dot"></span> 包含数字或特殊符号
              </li>
            </ul>
          </el-form-item>

          <div class="form-actions">
            <el-button @click="resetForm" class="btn-reset">重置</el-button>
            <el-button
              type="primary"
              @click="submitForm"
              :loading="loading"
              class="btn-submit"
              :disabled="!isValid"
            >
              确认修改
            </el-button>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import requestApi from "@/utils/axios";
import Message from "@/components/MessageBox/index.js";
import { getUserData } from "@/utils/auth";
import { ElMessage } from "element-plus";

const loading = ref(false);
const passwordFormState = ref({
  newPassword: "",
  confirmPassword: "",
});

// 密码强度分析
const password = computed(() => passwordFormState.value.newPassword);
const hasLength = computed(() => password.value.length >= 8);
const hasCase = computed(
  () => /[a-z]/.test(password.value) && /[A-Z]/.test(password.value),
);
const hasNumber = computed(() => /[\d\W]/.test(password.value));

const strengthLevel = computed(() => {
  if (!password.value) return 0;
  let score = 0;
  if (hasLength.value) score++;
  if (hasCase.value) score++;
  if (hasNumber.value) score++;
  return score;
});

const strengthText = computed(() => {
  switch (strengthLevel.value) {
    case 1:
      return "弱";
    case 2:
      return "中";
    case 3:
      return "强";
    default:
      return "";
  }
});

const strengthClass = computed(() => {
  switch (strengthLevel.value) {
    case 1:
      return "text-danger";
    case 2:
      return "text-warning";
    case 3:
      return "text-success";
    default:
      return "";
  }
});

const progressStatus = computed(() => {
  if (strengthLevel.value === 3) return "success";
  if (strengthLevel.value === 2) return "warning";
  return "exception";
});

const isValid = computed(() => {
  return (
    passwordFormState.value.newPassword &&
    passwordFormState.value.newPassword ===
      passwordFormState.value.confirmPassword &&
    passwordFormState.value.newPassword.length >= 6
  );
});

const submitForm = async () => {
  if (passwordFormState.value.newPassword.length < 6) {
    Message.error("密码长度不能少于6位");
    return;
  }
  if (
    passwordFormState.value.newPassword !=
    passwordFormState.value.confirmPassword
  ) {
    Message.error("两次输入的密码不一致");
    return;
  }

  const userData = await getUserData();
  if (!userData) {
    Message.error("无法识别身份，请重新登录");
    return;
  }

  const params = {
    id: userData.id,
    password: passwordFormState.value.newPassword,
    adduserid: userData.id,
    addusername: userData.username,
  };

  try {
    loading.value = true;
    await requestApi.post("/api/user/update", params);
    Message.success("密码已更新，下次登录请使用新密码");
    resetForm();
  } catch (error) {
    ElMessage.error("更新失败，请稍后再试");
  } finally {
    loading.value = false;
  }
};

const resetForm = () => {
  passwordFormState.value.newPassword = "";
  passwordFormState.value.confirmPassword = "";
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap");

.change-password-page {
  min-height: calc(100vh - 60px);
  background: #f5f7fa;
  font-family: "Inter", sans-serif;
  padding: 40px 20px;
  position: relative;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  overflow: hidden;
}

/* 背景装饰 */
.bg-shapes .shape {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  z-index: 0;
}
.shape-1 {
  top: 10%;
  right: 10%;
  width: 400px;
  height: 400px;
  background: rgba(64, 158, 255, 0.1);
}
.shape-2 {
  bottom: 10%;
  left: 10%;
  width: 300px;
  height: 300px;
  background: rgba(230, 162, 60, 0.1);
}

.page-container {
  width: 100%;
  max-width: 500px;
  position: relative;
  z-index: 1;
  margin-top: 40px;
}

/* 玻璃卡片 */
.glass-card {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: 24px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
  padding: 40px;
}

.card-header {
  text-align: center;
  margin-bottom: 40px;
}

.icon-wrapper {
  width: 56px;
  height: 56px;
  background: #ecf5ff;
  color: #409eff;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px;
}

.card-header h2 {
  font-size: 24px;
  font-weight: 700;
  color: #303133;
  margin-bottom: 8px;
}

.card-header p {
  color: #909399;
  font-size: 14px;
}

/* 表单样式 */
.custom-form :deep(.el-form-item__label) {
  font-weight: 600;
  color: #606266;
  padding-bottom: 8px;
}

.custom-input :deep(.el-input__wrapper) {
  background: #f5f7fa;
  box-shadow: none;
  border: 1px solid transparent;
  border-radius: 12px;
  padding: 8px 16px;
  transition: all 0.3s;
}

.custom-input :deep(.el-input__wrapper.is-focus) {
  background: white;
  border-color: #409eff;
  box-shadow: 0 0 0 3px rgba(64, 158, 255, 0.1);
}

/* 密码强度 */
.strength-indicator {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
}

.strength-bar {
  flex: 1;
}

.strength-text {
  font-size: 14px;
  font-weight: 600;
  width: 40px;
  text-align: right;
  color: #909399;
}

.text-danger {
  color: #f56c6c;
}
.text-warning {
  color: #e6a23c;
}
.text-success {
  color: #67c23a;
}

.strength-tips {
  list-style: none;
  padding: 0;
  margin: 0;
  font-size: 12px;
  color: #909399;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.strength-tips li {
  display: flex;
  align-items: center;
  gap: 8px;
  transition: color 0.3s;
}

.strength-tips li.active {
  color: #67c23a;
}

.strength-tips .dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #dcdfe6;
  transition: background 0.3s;
}

.strength-tips li.active .dot {
  background: #67c23a;
}

/* 按钮组 */
.form-actions {
  display: flex;
  gap: 16px;
  margin-top: 40px;
}

.btn-reset,
.btn-submit {
  flex: 1;
  padding: 12px;
  border-radius: 12px;
  font-weight: 600;
  font-size: 16px;
}

.btn-reset {
  background: #f5f7fa;
  border: none;
  color: #606266;
}

.btn-reset:hover {
  background: #e6e8eb;
}

.btn-submit {
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
  transition: all 0.3s;
}

.btn-submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(64, 158, 255, 0.4);
}

/* 响应式 */
@media (max-width: 600px) {
  .glass-card {
    padding: 30px 20px;
  }
}
</style>
