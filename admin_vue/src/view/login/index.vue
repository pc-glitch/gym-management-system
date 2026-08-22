<template>
  <div class="auth-page">
    <!-- 背景装饰 -->
    <div class="bg-decoration">
      <div class="bg-circle bg-circle-1"></div>
      <div class="bg-circle bg-circle-2"></div>
      <div class="bg-circle bg-circle-3"></div>
      <div class="bg-grid"></div>
    </div>

    <!-- 登录卡片 -->
    <div class="auth-container">
      <div class="auth-header">
        <div class="logo-wrap">
          <img class="brand-logo" src="/logo2.png" alt="Logo" />
        </div>
        <div class="brand-name">{{ projectName || "猎户中心" }} </div>
      
      </div>

      <div class="auth-tabs" v-if="options.length > 1 && canRegister">
        <div class="auth-tab" :class="{ active: isLogin }" @click="isLogin = true">
          <span class="tab-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M16 11V7a4 4 0 0 0-8 0v4M5 9h14l1 12H4L5 9z"></path>
            </svg>
          </span>
          账密登录
        </div>
        <div class="auth-tab" :class="{ active: !isLogin }" @click="isLogin = false">
          <span class="tab-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M12 4v16m8-8H4"></path>
            </svg>
          </span>
          申请入驻
        </div>
      </div>

      <div class="auth-body">
        <form @submit.prevent="handleSubmit">
          <div v-if="errorMsg" class="form-error" :key="errorMsg">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
            </svg>
            {{ errorMsg }}
          </div>

          <div class="form-group" v-if="filteredOptions.length > 1">
            <label class="form-label">登录角色 (Role)</label>
            <div class="role-selector">
              <div
                v-for="(item, idx) in filteredOptions"
                :key="item.role"
                class="role-option"
                :class="{
                  selected: String(userInfo.formModel.role) === String(item.role),
                }"
                @click="userInfo.formModel.role = item.role"
              >
                <div class="role-icon">
                  <svg
                    v-if="idx % 3 === 0"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path
                      d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"
                    ></path>
                  </svg>
                  <svg
                    v-else-if="idx % 3 === 1"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <polyline points="16 18 22 12 16 6"></polyline>
                    <polyline points="8 6 2 12 8 18"></polyline>
                  </svg>
                  <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path
                      d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"
                    ></path>
                    <line x1="16" y1="13" x2="8" y2="13"></line>
                    <line x1="16" y1="17" x2="8" y2="17"></line>
                  </svg>
                </div>
                <span class="role-name">{{ item.label }}</span>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">账号 (Account ID)</label>
            <div class="input-wrapper">
              <svg class="input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
              <input
                v-model="userInfo.formModel.username"
                type="text"
                autocomplete="username"
                placeholder="请输入账号"
                class="form-input"
              />
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">密码 (Password)</label>
            <div class="input-wrapper">
              <svg class="input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
              </svg>
              <input
                v-model="userInfo.formModel.password"
                :type="showPassword ? 'text' : 'password'"
                autocomplete="current-password"
                placeholder="请输入密码"
                class="form-input"
              />
              <button
                type="button"
                class="toggle-password"
                @click="showPassword = !showPassword"
              >
                <svg v-if="!showPassword" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
                  <path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                </svg>
                <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M13.875 18.825A10.05 10.05 0 0 1 12 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 0 1 1.563-3.029m5.858.908a3 3 0 1 1 4.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0 1 12 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 0 1-4.132 5.411m0 0L21 21"></path>
                </svg>
              </button>
            </div>
          </div>

          <button type="submit" class="btn-submit" :disabled="isSubmitting">
            <span v-if="isSubmitting" class="btn-loading">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle class="spin" cx="12" cy="12" r="10" stroke-linecap="round"></circle>
              </svg>
            </span>
            <span v-else>{{ isLogin ? "立即登录" : "提交注册" }}</span>
          </button>

          <div class="auth-footer" v-if="options.length > 1 && canRegister">
            <span v-if="isLogin">
              没有账号？<span class="link" @click="isLogin = false">申请入驻</span>
            </span>
            <span v-else>
              已有账号？<span class="link" @click="isLogin = true">返回登录</span>
            </span>
          </div>
        </form>
      </div>

      <div class="auth-footer-bottom">
        <span>© {{ currentYear }} {{ projectName || "猎户中心" }}. All rights reserved.</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, computed, watch } from "vue";
import requestApi from "@/utils/axios";
import { setToken } from "@/utils/auth";
import { options } from "@/utils/Role";
import { useRouter } from "vue-router";
import Message from "@/components/MessageBox/index.js";
import { projectName } from "@/utils/data";

const router = useRouter();
const currentYear = new Date().getFullYear();
const isLogin = ref(true);
const showPassword = ref(false);
const isSubmitting = ref(false);
const userInfo = reactive({
  formModel: { username: "", password: "", role: options[0]?.role || "0" },
});

const errorMsg = ref("");

const filteredOptions = computed(() => {
  if (isLogin.value) {
    return options;
  } else {
    return options.filter((option) => option.role != "0");
  }
});

const canRegister = computed(() => {
  return options.some((option) => option.role != "0");
});

const handleSubmit = () => {
  errorMsg.value = "";
  if (!userInfo.formModel.username || !userInfo.formModel.password) {
    errorMsg.value = "账号与密码不可为空";
    return;
  }
  isSubmitting.value = true;
  if (isLogin.value) {
    handleLogin();
  } else {
    handleRegister();
  }
};

const handleLogin = async () => {
  const selectedRole = options.find(
    (option) => option.role === userInfo.formModel.role
  );
  if (!selectedRole) {
    errorMsg.value = "请选择有效身份";
    isSubmitting.value = false;
    return;
  }
  const apiUrl = "/api/" + selectedRole.table + "/login";
  try {
    let response = await requestApi.post(apiUrl, userInfo.formModel);
    if (response.code != 0) {
      errorMsg.value = response.msg;
      isSubmitting.value = false;
      return;
    }
    setToken(response.data.token);
    localStorage.setItem("userData", JSON.stringify(response.data));
    router.replace("/index");
    window.location.reload();
  } catch (e) {
    errorMsg.value = "网络不通，请稍后再试";
    isSubmitting.value = false;
  }
};

const handleRegister = async () => {
  if (userInfo.formModel.role == 0) {
    errorMsg.value = "管理员不可注册";
    isSubmitting.value = false;
    return;
  }
  const selectedRole = options.find(
    (option) => option.role === userInfo.formModel.role
  );
  if (!selectedRole) {
    errorMsg.value = "无效的身份选择";
    isSubmitting.value = false;
    return;
  }
  try {
    let response = await requestApi.post(
      "/api/" + selectedRole.table + "/register",
      userInfo.formModel
    );
    if (response.code != 0) {
      errorMsg.value = response.msg;
      isSubmitting.value = false;
      return;
    }
    Message.success("注册成功，请登录");
    isLogin.value = true;
    isSubmitting.value = false;
  } catch (e) {
    errorMsg.value = "平台服务异常";
    isSubmitting.value = false;
  }
};

watch(isLogin, (newVal) => {
  userInfo.formModel.username = "";
  userInfo.formModel.password = "";
  errorMsg.value = "";
  if (newVal) {
    userInfo.formModel.role = "0";
  } else {
    const defaultRole = options.find((opt) => opt.role != "0");
    userInfo.formModel.role = defaultRole ? defaultRole.role : "";
  }
});
</script>

<style scoped>
/* 登录页面整体布局 */
.auth-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
  background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%);
}

/* 背景装饰 */
.bg-decoration {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  overflow: hidden;
}

.bg-circle {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.3;
  animation: float 15s ease-in-out infinite;
}

.bg-circle-1 {
  width: 600px;
  height: 600px;
  background: linear-gradient(135deg, #3b82f6, #8b5cf6);
  top: -200px;
  left: -100px;
  animation-delay: 0s;
}

.bg-circle-2 {
  width: 500px;
  height: 500px;
  background: linear-gradient(135deg, #ec4899, #f43f5e);
  bottom: -150px;
  right: -100px;
  animation-delay: -5s;
}

.bg-circle-3 {
  width: 400px;
  height: 400px;
  background: linear-gradient(135deg, #06b6d4, #10b981);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation-delay: -10s;
}

.bg-grid {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: 
    linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
  background-size: 50px 50px;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0) scale(1);
  }
  50% {
    transform: translateY(-30px) scale(1.05);
  }
}

/* 登录卡片 */
.auth-container {
  width: 420px;
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 20px;
  box-shadow: 
    0 25px 50px -12px rgba(0, 0, 0, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
  overflow: hidden;
  position: relative;
  z-index: 10;
  animation: slideUp 0.6s ease-out;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 头部区域 */
.auth-header {
  padding: 24px 32px 20px;
  text-align: center;
  position: relative;
}

.logo-wrap {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 80px;
  height: 80px;
  background: transparent;
  border-radius: 20px;
  margin-bottom: 16px;
  transition: transform 0.3s ease;
}

.logo-wrap:hover {
  transform: scale(1.05);
}

.brand-logo {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.brand-name {
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  letter-spacing: -0.5px;
  margin-bottom: 8px;
}

.brand-slogan {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.6);
}

/* 标签切换 */
.auth-tabs {
  display: flex;
  padding: 0 24px;
  gap: 12px;
  margin-bottom: 24px;
}

.auth-tab {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 12px 16px;
  font-size: 14px;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.5);
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 1px solid transparent;
}

.auth-tab:hover {
  background: rgba(255, 255, 255, 0.1);
  color: rgba(255, 255, 255, 0.8);
}

.auth-tab.active {
  background: linear-gradient(135deg, #3b82f6, #8b5cf6);
  color: #fff;
  box-shadow: 0 8px 24px rgba(59, 130, 246, 0.35);
  border-color: rgba(255, 255, 255, 0.2);
}

.tab-icon svg {
  width: 18px;
  height: 18px;
}

/* 主体内容 */
.auth-body {
  padding: 0 32px 24px;
}

/* 错误提示 */
.form-error {
  display: flex;
  align-items: center;
  gap: 10px;
  background: rgba(239, 68, 68, 0.15);
  border: 1px solid rgba(239, 68, 68, 0.3);
  color: #fca5a5;
  padding: 12px 16px;
  border-radius: 12px;
  font-size: 13px;
  margin-bottom: 20px;
  animation: shake 0.3s ease;
}

.form-error svg {
  width: 16px;
  height: 16px;
  flex-shrink: 0;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-5px); }
  75% { transform: translateX(5px); }
}

/* 表单组 */
.form-group {
  margin-bottom: 20px;
}

.form-label {
  display: block;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 8px;
  color: rgba(255, 255, 255, 0.8);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* 输入框包装器 */
.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-icon {
  position: absolute;
  left: 14px;
  width: 18px;
  height: 18px;
  color: rgba(255, 255, 255, 0.4);
  transition: color 0.3s ease;
}

.form-input {
  width: 100%;
  padding: 14px 16px 14px 48px;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 12px;
  font-size: 14px;
  color: #fff;
  transition: all 0.3s ease;
  outline: none;
}

.form-input::placeholder {
  color: rgba(255, 255, 255, 0.35);
}

.form-input:focus {
  background: rgba(255, 255, 255, 0.1);
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
}

.form-input:focus + .input-icon,
.form-input:focus ~ .input-icon {
  color: #3b82f6;
}

/* 密码切换按钮 */
.toggle-password {
  position: absolute;
  right: 12px;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.4);
  transition: color 0.3s ease;
  padding: 0;
}

.toggle-password:hover {
  color: rgba(255, 255, 255, 0.8);
}

.toggle-password svg {
  width: 18px;
  height: 18px;
}

/* 角色选择器 */
.role-selector {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-top: 8px;
}

.role-option {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px 12px;
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  color: rgba(255, 255, 255, 0.6);
}

.role-option:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);
}

.role-option.selected {
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(139, 92, 246, 0.2));
  border-color: #3b82f6;
  color: #fff;
  box-shadow: 0 8px 20px rgba(59, 130, 246, 0.25);
}

.role-icon {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 8px;
  background: rgba(255, 255, 255, 0.08);
  border-radius: 10px;
}

.role-option.selected .role-icon {
  background: rgba(59, 130, 246, 0.3);
}

.role-icon svg {
  width: 18px;
  height: 18px;
}

.role-name {
  font-size: 12px;
  font-weight: 600;
}

/* 提交按钮 */
.btn-submit {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
  color: #fff;
  border: none;
  border-radius: 12px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  box-shadow: 0 8px 24px rgba(59, 130, 246, 0.35);
  position: relative;
  overflow: hidden;
}

.btn-submit::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.6s ease;
}

.btn-submit:hover::before {
  left: 100%;
}

.btn-submit:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(59, 130, 246, 0.45);
}

.btn-submit:active:not(:disabled) {
  transform: translateY(-1px);
}

.btn-submit:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

.btn-loading svg {
  width: 18px;
  height: 18px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* 页脚链接 */
.auth-footer {
  margin-top: 24px;
  text-align: center;
  font-size: 13px;
  color: rgba(255, 255, 255, 0.5);
}

.link {
  color: #3b82f6;
  cursor: pointer;
  font-weight: 600;
  transition: color 0.3s ease;
  margin-left: 4px;
}

.link:hover {
  color: #60a5fa;
  text-decoration: underline;
}

/* 底部版权 */
.auth-footer-bottom {
  padding: 20px 32px;
  text-align: center;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.3);
  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

/* 响应式调整 */
@media (max-width: 480px) {
  .auth-container {
    width: 90%;
    margin: 0 16px;
  }
  
  .auth-header {
    padding: 32px 24px 24px;
  }
  
  .auth-body {
    padding: 0 24px 20px;
  }
  
  .role-selector {
    gap: 8px;
  }
  
  .role-option {
    padding: 12px 8px;
  }
}
</style>
