<template>
  <div class="register-page">
    <!-- 动态背景 -->
    <div class="bg-shapes">
      <div class="shape shape-1"></div>
      <div class="shape shape-2"></div>
      <div class="shape shape-3"></div>
    </div>

    <div class="register-container glass-effect">
      <!-- 左侧：品牌区 -->
      <div class="brand-panel">
        <div class="brand-content">
          <h2>多功能体育馆管理平台</h2>
          <p class="subtitle">用户端</p>
         
          <div class="illustration-box">
            <img src="/logo2.png" alt="logo" />
          </div>
        </div>
      </div>

      <!-- 右侧：表单区 -->
      <div class="form-panel">
        <div class="form-header">
          <h2>创建账号</h2>
          <p>填写以下信息完成注册</p>
        </div>

        <form @submit.prevent="handleRegister" class="register-form">
          <div class="form-grid">
            <div class="input-group">
              <label>用户名</label>
              <div class="input-wrapper">
                <input
                  type="text"
                  v-model="registerForm.username"
                  placeholder="设置用户名"
                  required
                />
              </div>
            </div>

            <div class="input-group">
              <label>昵称</label>
              <div class="input-wrapper">
                <input
                  type="text"
                  v-model="registerForm.name"
                  placeholder="您的称呼"
                  required
                />
              </div>
            </div>

            <div class="input-group">
              <label>密码</label>
              <div class="input-wrapper">
                <input
                  type="password"
                  v-model="registerForm.password"
                  placeholder="••••••••"
                  required
                />
              </div>
            </div>

            <div class="input-group">
              <label>确认密码</label>
              <div class="input-wrapper">
                <input
                  type="password"
                  v-model="registerForm.configPassword"
                  placeholder="••••••••"
                  required
                />
              </div>
            </div>

            <div class="input-group">
              <label>手机号</label>
              <div class="input-wrapper">
                <input
                  type="tel"
                  v-model="registerForm.phone"
                  placeholder="11位手机号"
                  required
                />
              </div>
            </div>

            <div class="input-group">
              <label>邮箱</label>
              <div class="input-wrapper">
                <input
                  type="email"
                  v-model="registerForm.email"
                  placeholder="name@example.com"
                  required
                />
              </div>
            </div>
          </div>

          <button type="submit" class="btn-submit">
            立即注册
            <span class="arrow">→</span>
          </button>
        </form>

        <div class="form-footer">
          已有账号? <a href="#" @click.prevent="navigateToLogin">直接登录</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import Message from "@/components/MessageBox/index.js";
import requestApi from "@/utils/axios";
import { useRouter } from "vue-router";

const router = useRouter();

const registerForm = reactive({
  username: "",
  password: "",
  configPassword: "",
  name: "",
  email: "",
  phone: "",
});

const navigateToLogin = () => {
  router.push("/login");
};

const handleRegister = async () => {
  // 基础校验
  if (
    !registerForm.username ||
    !registerForm.password ||
    !registerForm.configPassword ||
    !registerForm.name ||
    !registerForm.email ||
    !registerForm.phone
  ) {
    Message.warning("请填写完整信息");
    return;
  }

  if (registerForm.password != registerForm.configPassword) {
    Message.warning("两次密码不一致");
    return;
  }

  if (!/^1[3-9]\d{9}$/.test(registerForm.phone)) {
    Message.warning("请输入正确的11位手机号");
    return;
  }

  registerForm.role = 1; // 默认角色(普通用户)

  try {
    let res = await requestApi.post("/api/user/register", registerForm);
    if (res.code == 0) {
      Message.success("注册成功，即将跳转登录");
      setTimeout(() => {
        router.push("/login");
      }, 1500);
    } else {
      Message.error(res.msg || "注册失败");
    }
  } catch (error) {
    Message.error("网络异常");
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap");

.register-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  font-family: "Inter", sans-serif;
  position: relative;
  overflow: hidden;
  padding: 20px;
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
  right: -15%;
  width: 600px;
  height: 600px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  animation-delay: 0s;
}

.shape-2 {
  bottom: -15%;
  left: -15%;
  width: 700px;
  height: 700px;
  background: linear-gradient(135deg, #00bcd4 0%, #009688 100%);
  animation-delay: -3s;
}

.shape-3 {
  top: 40%;
  left: 30%;
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

.register-container {
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

.illustration-box {
  margin: 40px auto;
  width: 130px;
  height: 130px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05));
  border-radius: 50%;
  box-shadow: 
    0 8px 32px rgba(102, 126, 234, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
}

.illustration-box img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
}

.brand-desc {
  font-size: 14px;
  opacity: 0.8;
  line-height: 1.6;
  max-width: 260px;
  margin: 0 auto;
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

.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}

.form-grid .input-group {
  animation: fadeInUp 0.5s ease-out backwards;
}

.form-grid .input-group:nth-child(1) { animation-delay: 0.1s; }
.form-grid .input-group:nth-child(2) { animation-delay: 0.15s; }
.form-grid .input-group:nth-child(3) { animation-delay: 0.2s; }
.form-grid .input-group:nth-child(4) { animation-delay: 0.25s; }
.form-grid .input-group:nth-child(5) { animation-delay: 0.3s; }
.form-grid .input-group:nth-child(6) { animation-delay: 0.35s; }

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
  margin-top: 32px;
  width: 100%;
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
  margin-top: 28px;
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

/* 响应式 */
@media (max-width: 900px) {
  .register-container {
    width: 100%;
    flex-direction: column;
    height: auto;
    min-height: 100vh;
    border-radius: 0;
  }
  .brand-panel {
    flex: 0 0 220px;
    padding: 40px 30px;
  }
  .form-panel {
    padding: 40px 30px;
    flex: 1;
  }
  .form-grid {
    grid-template-columns: 1fr;
    gap: 18px;
  }
  .btn-submit {
    margin-top: 28px;
  }
}

@media (max-width: 480px) {
  .brand-panel {
    flex: 0 0 180px;
    padding: 30px 20px;
  }
  .brand-panel h2 {
    font-size: 24px;
  }
  .illustration-box {
    width: 100px;
    height: 100px;
    margin: 24px auto;
  }
  .form-panel {
    padding: 30px 20px;
  }
  .form-header h2 {
    font-size: 24px;
  }
}
</style>
