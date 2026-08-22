<template>
  <div class="login-page">
    <!-- 动态背景 -->
    <div class="bg-shapes">
      <div class="shape shape-1"></div>
      <div class="shape shape-2"></div>
      <div class="shape shape-3"></div>
    </div>

    <div class="login-container glass-effect">
      <!-- 左侧：品牌区 -->
      <div class="brand-panel">
        <div class="brand-content">
          <div class="logo-circle">
            <img src="/logo2.png" alt="logo" />
          </div>
          <h2>多功能体育馆管理平台</h2>
          <p class="subtitle">用户端</p>
        </div>
      </div>

      <!-- 右侧：表单区 -->
      <div class="form-panel">
        <div class="form-header">
          <h2>欢迎回来</h2>
          <p>请登录您的账户以继续</p>
        </div>

        <form @submit.prevent="handleLogin" class="login-form">
          <div class="input-group">
            <label>账号</label>
            <div class="input-wrapper">
              <input
                type="text"
                v-model="formData.username"
                placeholder="请输入用户名"
                required
              />
            </div>
          </div>

          <div class="input-group">
            <label>密码</label>
            <div class="input-wrapper">
              <input
                type="password"
                v-model="formData.password"
                placeholder="请输入密码"
                required
              />
            </div>
          </div>

          <div class="input-group">
            <label>验证码</label>
            <div class="captcha-row">
              <div class="input-wrapper">
                <input
                  type="text"
                  v-model="formData.captcha"
                  placeholder="验证码"
                  required
                />
              </div>
              <div
                class="captcha-box"
                @click="generateCaptcha"
                title="点击刷新"
              >
                <img v-if="captchaText" :src="captchaText" alt="验证码" />
                <span v-else>加载中...</span>
              </div>
            </div>
          </div>

          <div class="form-options">
            <label class="remember-me">
              <input type="checkbox" v-model="formData.rememberMe" />
              <span>记住我</span>
            </label>
          </div>

          <button type="submit" class="btn-submit">
            登录平台
            <span class="arrow">→</span>
          </button>
        </form>

        <div class="form-footer">
          还没有账号?
          <a href="#" @click.prevent="navigateTo('/register')">立即注册</a>
        </div>
      </div>
    </div>

    <!-- 重置密码弹窗 -->
    <Transition name="fade">
      <div
        v-if="showResetDialog"
        class="dialog-overlay"
        @click.self="closeResetDialog"
      >
        <div class="dialog-box glass-effect">
          <div class="dialog-header">
            <h3>重置密码</h3>
            <button @click="closeResetDialog" class="close-btn">×</button>
          </div>
          <div class="dialog-body">
            <p class="dialog-desc">请输入您的账号信息以重置密码。</p>
            <div class="input-group">
              <label>账号 ID</label>
              <div class="input-wrapper">
                <input
                  type="text"
                  v-model="resetForm.account"
                  placeholder="用户名"
                />
              </div>
            </div>
            <div class="input-group">
              <label>手机号 (可选)</label>
              <div class="input-wrapper">
                <input
                  type="text"
                  v-model="resetForm.phone"
                  placeholder="预留手机号"
                />
              </div>
            </div>
            <div class="input-group">
              <label>邮箱 (可选)</label>
              <div class="input-wrapper">
                <input
                  type="email"
                  v-model="resetForm.email"
                  placeholder="预留邮箱"
                />
              </div>
            </div>
          </div>
          <div class="dialog-footer">
            <button class="btn-text" @click="closeResetDialog">取消</button>
            <button
              class="btn-primary"
              :disabled="resetLoading"
              @click="handleResetPassword"
            >
              {{ resetLoading ? "处理中..." : "确认重置" }}
            </button>
          </div>
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import Message from "@/components/MessageBox/index.js";
import { setToken } from "@/utils/auth.js";
import { useRouter } from "vue-router";
import requestApi from "@/utils/axios";

const router = useRouter();
const formData = ref({
  username: "",
  password: "",
  captcha: "",
  role: "0",
  rememberMe: false,
});
const captchaText = ref("");
const captchaUUID = ref("");
const showResetDialog = ref(false);
const resetLoading = ref(false);
const resetForm = ref({
  account: "",
  phone: "",
  email: "",
});

const navigateTo = (path) => {
  router.push(path);
};

const openResetDialog = () => {
  resetForm.value = { account: "", phone: "", email: "" };
  showResetDialog.value = true;
};

const closeResetDialog = () => {
  showResetDialog.value = false;
};

const generateCaptcha = async () => {
  try {
    const response = await requestApi.post("/api/captchaImage");
    captchaText.value = `data:image/png;base64,${response.data.img}`;
    captchaUUID.value = response.data.uuid;
  } catch (error) {
    Message.error("验证码加载失败");
  }
};

const handleLogin = async () => {
  if (
    !formData.value.username ||
    !formData.value.password ||
    !formData.value.captcha
  ) {
    Message.error("请填写完整信息");
    return;
  }
  formData.value.key = captchaUUID.value;
  try {
    const response = await requestApi.post("/api/user/login", formData.value);
    if (response.code == 0) {
      Message.success("登录成功");
      setToken(response.data.token);
      localStorage.setItem("userData", JSON.stringify(response.data));

      if (formData.value.rememberMe) {
        localStorage.setItem("rememberedUsername", formData.value.username);
        localStorage.setItem("rememberedPassword", formData.value.password);
        localStorage.setItem("rememberMeChecked", "true");
      } else {
        localStorage.removeItem("rememberedUsername");
        localStorage.removeItem("rememberedPassword");
        localStorage.removeItem("rememberMeChecked");
      }

      setTimeout(() => router.push("/"), 500);
    } else {
      Message.error(response.msg || "登录失败");
      generateCaptcha();
    }
  } catch (error) {
    Message.error("网络错误");
    generateCaptcha();
  }
};

const handleResetPassword = async () => {
  if (
    !resetForm.value.account &&
    !resetForm.value.phone &&
    !resetForm.value.email
  ) {
    Message.warning("请至少填写一项信息");
    return;
  }

  if (resetForm.value.phone && !/^1[3-9]\d{9}$/.test(resetForm.value.phone)) {
    Message.warning("请输入正确的11位手机号");
    return;
  }
  resetLoading.value = true;
  try {
    // 模拟重置逻辑，实际需根据后端接口调整
    const searchPayload = {
      page: 1,
      limit: 1,
      username: resetForm.value.account || undefined,
      phone: resetForm.value.phone || undefined,
      email: resetForm.value.email || undefined,
    };

    const searchRes = await requestApi.post("/api/user/page", searchPayload);
    if (searchRes.code == 0 && searchRes.data.list?.length > 0) {
      const user = searchRes.data.list[0];
      const resetRes = await requestApi.post("/api/user/resetPass", {
        id: user.id,
        username: user.username,
      });
      if (resetRes.code == 0) {
        Message.success("密码重置成功");
        closeResetDialog();
      } else {
        Message.error(resetRes.msg || "重置失败");
      }
    } else {
      Message.error("未找到匹配用户");
    }
  } catch (error) {
    Message.error("请求失败");
  } finally {
    resetLoading.value = false;
  }
};

onMounted(() => {
  generateCaptcha();
  const rUser = localStorage.getItem("rememberedUsername");
  const rPass = localStorage.getItem("rememberedPassword");
  const rCheck = localStorage.getItem("rememberMeChecked");
  if (rUser && rPass && rCheck === "true") {
    formData.value.username = rUser;
    formData.value.password = rPass;
    formData.value.rememberMe = true;
  }
});
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap");

.login-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  font-family: "Inter", sans-serif;
  position: relative;
  overflow: hidden;
}

/* 动态背景形状 */
.bg-shapes {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.bg-shapes .shape {
  position: absolute;
  border-radius: 50%;
  filter: blur(100px);
  z-index: 0;
  opacity: 0.5;
  animation: float 8s ease-in-out infinite;
}

.shape-1 {
  top: -15%;
  left: -15%;
  width: 600px;
  height: 600px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  animation-delay: 0s;
}

.shape-2 {
  bottom: -15%;
  right: -15%;
  width: 700px;
  height: 700px;
  background: linear-gradient(135deg, #00bcd4 0%, #009688 100%);
  animation-delay: -3s;
}

.shape-3 {
  top: 40%;
  left: 50%;
  width: 400px;
  height: 400px;
  background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%);
  animation-delay: -5s;
}

/* 背景网格 */
.bg-grid {
  position: absolute;
  inset: 0;
  background-image: 
    linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
  background-size: 50px 50px;
  z-index: 0;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0) rotate(0deg);
  }
  50% {
    transform: translateY(-30px) rotate(5deg);
  }
}

/* 玻璃容器 */
.glass-effect {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.15);
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

.login-container {
  width: 1000px;
  border-radius: 28px;
  display: flex;
  overflow: hidden;
  z-index: 1;
  position: relative;
  min-height: 600px;
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

/* 左侧品牌区 */
.brand-panel {
  flex: 0 0 380px;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.3) 0%, rgba(118, 75, 162, 0.3) 100%);
  color: white;
  padding: 60px 40px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  position: relative;
  overflow: hidden;
  text-align: center;
}

.brand-panel::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: url("data:image/svg+xml,%3Csvg width='40' height='40' viewBox='0 0 40 40' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23ffffff' fill-opacity='0.05' fill-rule='evenodd'%3E%3Cpath d='M0 40L40 0H20L0 20M40 40V20L20 40'/%3E%3C/g%3E%3C/svg%3E");
}

.brand-content {
  position: relative;
  z-index: 2;
}

.logo-circle {
  width: 130px;
  height: 130px;
  background: linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 40px auto;
  box-shadow: 
    0 8px 32px rgba(102, 126, 234, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
}

.logo-circle img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
}

.brand-panel h2 {
  font-size: 30px;
  font-weight: 800;
  margin-bottom: 12px;
  line-height: 1.1;
  letter-spacing: -1px;
  text-shadow: 0 2px 10px rgba(0,0,0,0.2);
}

.subtitle {
  font-size: 16px;
  opacity: 0.85;
  margin-bottom: 40px;
  font-weight: 400;
}

.features-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 14px;
  font-size: 14px;
  font-weight: 500;
  opacity: 0.9;
}

.check-icon {
  width: 28px;
  height: 28px;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.5), rgba(118, 75, 162, 0.5));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

/* 右侧表单区 */
.form-panel {
  flex: 1;
  padding: 60px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
}

.form-header {
  margin-bottom: 36px;
  text-align: center;
}

.form-header h2 {
  font-size: 30px;
  color: #ffffff;
  margin-bottom: 8px;
  font-weight: 700;
  letter-spacing: -0.5px;
}

.form-header p {
  color: rgba(255, 255, 255, 0.6);
  font-size: 14px;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.input-group {
  animation: fadeInUp 0.5s ease-out backwards;
}

.input-group:nth-child(1) { animation-delay: 0.1s; }
.input-group:nth-child(2) { animation-delay: 0.2s; }
.input-group:nth-child(3) { animation-delay: 0.3s; }
.input-group:nth-child(4) { animation-delay: 0.4s; }

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.input-group label {
  display: block;
  font-size: 13px;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.8);
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.input-wrapper {
  position: relative;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 14px;
  padding: 14px 16px;
  transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}

.input-wrapper::before {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: 14px;
  padding: 1px;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.5), rgba(118, 75, 162, 0.5));
  -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
  mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
  -webkit-mask-composite: xor;
  mask-composite: exclude;
  opacity: 0;
  transition: opacity 0.35s;
  pointer-events: none;
}

.input-wrapper:focus-within {
  border-color: rgba(102, 126, 234, 0.5);
  box-shadow: 
    0 0 0 3px rgba(102, 126, 234, 0.1),
    0 4px 20px rgba(102, 126, 234, 0.15);
}

.input-wrapper:focus-within::before {
  opacity: 1;
}

.input-wrapper input {
  width: 100%;
  border: none;
  outline: none;
  font-size: 14px;
  color: #ffffff;
  background: transparent;
}

.input-wrapper input::placeholder {
  color: rgba(255, 255, 255, 0.4);
}

.captcha-row {
  display: flex;
  gap: 14px;
}

.captcha-row .input-wrapper {
  flex: 1;
}

.captcha-box {
  width: 130px;
  height: 52px;
  border-radius: 14px;
  overflow: hidden;
  cursor: pointer;
  border: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.05);
  transition: all 0.3s;
}

.captcha-box:hover {
  border-color: rgba(102, 126, 234, 0.5);
  transform: scale(1.02);
}

.captcha-box img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.captcha-box span {
  color: rgba(255, 255, 255, 0.5);
  font-size: 12px;
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13px;
}

.remember-me {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.7);
}

.remember-me input[type="checkbox"] {
  appearance: none;
  width: 18px;
  height: 18px;
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 6px;
  background: rgba(255, 255, 255, 0.05);
  cursor: pointer;
  position: relative;
  transition: all 0.3s;
}

.remember-me input[type="checkbox"]:checked {
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-color: transparent;
}

.remember-me input[type="checkbox"]:checked::after {
  content: "✓";
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  font-size: 11px;
  font-weight: bold;
}

.forgot-link {
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s;
}

.forgot-link:hover {
  color: #764ba2;
}

.btn-submit {
  position: relative;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 16px;
  border-radius: 14px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
  overflow: hidden;
}

.btn-submit::before {
  content: "";
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.6s ease;
}

.btn-submit:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 30px rgba(102, 126, 234, 0.5);
}

.btn-submit:hover::before {
  left: 100%;
}

.arrow {
  transition: transform 0.35s;
}

.btn-submit:hover .arrow {
  transform: translateX(6px);
}

.form-footer {
  margin-top: 30px;
  text-align: center;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.6);
}

.form-footer a {
  color: #667eea;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s;
}

.form-footer a:hover {
  color: #764ba2;
}

/* 弹窗样式 */
.dialog-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(8px);
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: center;
}

.dialog-box {
  width: 420px;
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(20px);
  border-radius: 24px;
  padding: 36px;
  box-shadow: 0 25px 60px rgba(0, 0, 0, 0.4);
  border: 1px solid rgba(255, 255, 255, 0.1);
  animation: dialogPop 0.3s ease-out;
}

@keyframes dialogPop {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.dialog-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 28px;
}

.dialog-header h3 {
  margin: 0;
  font-size: 20px;
  color: #ffffff;
  font-weight: 700;
}

.close-btn {
  background: rgba(255, 255, 255, 0.1);
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.6);
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s;
}

.close-btn:hover {
  background: rgba(255, 255, 255, 0.2);
  color: #ffffff;
}

.dialog-body {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.dialog-desc {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.6);
  margin-bottom: 8px;
}

.dialog-body .input-group {
  animation: none;
}

.dialog-body .input-wrapper {
  background: rgba(255, 255, 255, 0.06);
}

.dialog-body .input-wrapper input {
  color: #ffffff;
}

.dialog-footer {
  margin-top: 32px;
  display: flex;
  justify-content: flex-end;
  gap: 14px;
}

.btn-text {
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: rgba(255, 255, 255, 0.8);
  cursor: pointer;
  padding: 10px 20px;
  border-radius: 10px;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s;
}

.btn-text:hover {
  background: rgba(255, 255, 255, 0.15);
}

.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 10px 24px;
  border-radius: 10px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: all 0.3s;
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(102, 126, 234, 0.4);
}

.btn-primary:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* 响应式 */
@media (max-width: 900px) {
  .login-container {
    width: 100%;
    height: 100vh;
    border-radius: 0;
    flex-direction: column;
  }
  .brand-panel {
    flex: 0 0 220px;
    padding: 40px 30px;
    text-align: center;
  }
  .logo-circle {
    margin: 0 auto 20px;
  }
  .features-list {
    display: none;
  }
  .form-panel {
    padding: 40px 30px;
    flex: 1;
  }
  .form-header h2 {
    font-size: 26px;
  }
  .captcha-row {
    flex-direction: column;
  }
  .captcha-box {
    width: 100%;
    height: 48px;
  }
  .dialog-box {
    width: 90%;
    padding: 24px;
  }
}

/* 动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.35s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
