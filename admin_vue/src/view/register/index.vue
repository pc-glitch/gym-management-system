<template>
  <main class="ed40-reg">
    <section class="ed40-card" aria-label="注册">
      <header class="ed40-card__head">
        <div class="ed40-kicker">REGISTER</div>
        <div class="ed40-title">创建账户</div>
        <div class="ed40-desc">完成基础信息后即可登录，资料可后续完善。</div>
      </header>

      <form @submit.prevent="handleRegister" class="ed40-form">
        <div class="ed40-grid">
          <div class="ed40-field">
            <label for="username">账号</label>
            <input
              id="username"
              type="text"
              v-model="registerForm.username"
              placeholder="请输入账号"
              autocomplete="username"
            />
          </div>

          <div class="ed40-field">
            <label for="name">昵称</label>
            <input
              id="name"
              type="text"
              v-model="registerForm.name"
              placeholder="用于展示的名称"
            />
          </div>

          <div class="ed40-field">
            <label for="password">密码</label>
            <input
              id="password"
              type="password"
              v-model="registerForm.password"
              placeholder="请输入密码"
              autocomplete="new-password"
            />
          </div>

          <div class="ed40-field">
            <label for="configPassword">确认密码</label>
            <input
              id="configPassword"
              type="password"
              v-model="registerForm.configPassword"
              placeholder="再次输入密码"
              autocomplete="new-password"
            />
          </div>

          <div class="ed40-field">
            <label for="email">邮箱</label>
            <input
              id="email"
              type="email"
              v-model="registerForm.email"
              placeholder="name@example.com"
              autocomplete="email"
            />
          </div>

          <div class="ed40-field">
            <label for="phone">手机号</label>
            <input
              id="phone"
              type="tel"
              v-model="registerForm.phone"
              placeholder="请输入手机号"
              autocomplete="tel"
            />
          </div>
        </div>

        <button type="submit" class="ed40-submit">完成注册</button>
      </form>

      <footer class="ed40-foot">
        <span class="ed40-foot__muted">已有账号？</span>
        <a href="/login" class="ed40-foot__link">去登录</a>
      </footer>
    </section>
  </main>
</template>

<script setup>
import { reactive } from "vue";
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

const handleRegister = () => {
  if (
    !registerForm.username ||
    !registerForm.password ||
    !registerForm.configPassword ||
    !registerForm.name ||
    !registerForm.email ||
    !registerForm.phone
  ) {
    alert("请填写所有必填项！");
    return;
  }

  if (!/^1[3-9]\d{9}$/.test(registerForm.phone)) {
    alert("请输入正确的11位手机号！");
    return;
  }

  if (registerForm.password != registerForm.configPassword) {
    alert("两次输入的密码不一致！");
    return;
  }

  console.log("注册成功，表单数据：", registerForm);
  alert("注册成功，请登录。");

  router.push("/login");
};
</script>

<style scoped>
.ed40-reg {
  min-height: min(760px, 100vh);
  display: grid;
  place-items: center;
  padding: 18px;
}

.ed40-card {
  width: min(860px, 100%);
  border-radius: var(--ed40-r-lg);
  border: 1px solid var(--ed40-line-2);
  background: rgba(255, 255, 255, 0.9);
  box-shadow: var(--ed40-shadow);
  overflow: hidden;
}

.ed40-card__head {
  padding: 16px;
  border-bottom: 1px solid var(--ed40-line-3);
  background: rgba(14, 165, 233, 0.08);
  text-align: left;
}

.ed40-kicker {
  font-size: 11px;
  font-weight: 950;
  letter-spacing: 1px;
  color: var(--ed40-muted-2);
  font-family: var(--ed40-font-mono);
}

.ed40-title {
  margin-top: 6px;
  font-size: 18px;
  font-weight: 950;
}

.ed40-desc {
  margin-top: 6px;
  font-size: 12px;
  line-height: 1.8;
  color: var(--ed40-muted);
  font-weight: 850;
}

.ed40-form {
  padding: 16px;
  display: grid;
  gap: 14px;
  text-align: left;
}

.ed40-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.ed40-field label {
  display: block;
  font-size: 12px;
  font-weight: 950;
  margin-bottom: 8px;
  color: var(--ed40-muted);
}

.ed40-field input {
  width: 100%;
  height: 46px;
  border-radius: var(--ed40-r-sm);
  border: 1px solid var(--ed40-line-2);
  background: rgba(255, 255, 255, 0.92);
  padding: 0 12px;
  outline: none;
  color: rgba(11, 18, 32, 0.9);
  font-weight: 900;
  transition: border-color 140ms ease, box-shadow 140ms ease, background 140ms ease;
}

.ed40-field input::placeholder {
  color: color-mix(in srgb, var(--ed40-muted) 72%, transparent);
}

.ed40-field input:focus {
  border-color: rgba(14, 165, 233, 0.85);
  box-shadow: var(--ed40-focus);
  background: #fff;
}

.ed40-submit {
  height: 48px;
  border-radius: var(--ed40-r-md);
  border: 1px solid rgba(14, 165, 233, 0.35);
  background: linear-gradient(
    90deg,
    rgba(14, 165, 233, 0.92),
    rgba(34, 197, 94, 0.82)
  );
  color: #fff;
  font-weight: 950;
  cursor: pointer;
  letter-spacing: 0.4px;
  box-shadow: var(--ed40-shadow-soft);
}

.ed40-submit:hover {
  transform: translateY(-1px);
}

.ed40-foot {
  padding: 12px 16px 14px;
  border-top: 1px solid var(--ed40-line-3);
  background: rgba(255, 255, 255, 0.76);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.ed40-foot__muted {
  font-size: 12px;
  color: var(--ed40-muted);
  font-weight: 900;
}

.ed40-foot__link {
  text-decoration: none;
  color: rgba(14, 165, 233, 0.95);
  font-weight: 950;
  border-bottom: 1px dashed rgba(14, 165, 233, 0.8);
}

@media (max-width: 860px) {
  .ed40-grid {
    grid-template-columns: 1fr;
  }
}
</style>

