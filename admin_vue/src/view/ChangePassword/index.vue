<template>
  <div class="reset-page pattern-bg" v-loading="loading">
    <div class="reset-container">
      <div class="reset-header">
        <svg
          class="brand-logo"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
        <div class="header-title">设置新密码</div>

        <div class="steps">
          <div class="step-item finished">验证身份</div>
          <div class="step-divider"></div>
          <div class="step-item active">重置密码</div>
          <div class="step-divider"></div>
          <div class="step-item">完成</div>
        </div>
      </div>

      <div class="reset-body">
        <form @submit.prevent="submitForm">
          <div class="form-group">
            <label class="form-label" style="text-transform: none">新密码</label>
            <input
              v-model="passwordFormState.newPassword"
              type="password"
              class="form-input"
              placeholder="请输入8位以上强密码"
            />

            <div class="strength-meter" :class="strengthMeterClass">
              <div class="strength-seg"></div>
              <div class="strength-seg"></div>
              <div class="strength-seg"></div>
              <div class="strength-seg"></div>
            </div>

            <div class="rules-list">
              <div class="rule-item" :class="{ valid: ruleChecks.length }">
                <span class="rule-icon"></span>
                <span>至少 8 位字符</span>
              </div>
              <div class="rule-item" :class="{ valid: ruleChecks.upper }">
                <span class="rule-icon"></span>
                <span>包含大写字母</span>
              </div>
              <div class="rule-item" :class="{ valid: ruleChecks.number }">
                <span class="rule-icon"></span>
                <span>包含数字</span>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" style="text-transform: none">确认新密码</label>
            <input
              v-model="passwordFormState.confirmPassword"
              type="password"
              class="form-input"
              placeholder="再次输入新密码"
            />
          </div>

          <button type="submit" class="btn-submit">确认修改</button>

          <div class="auth-footer" style="margin-top: 18px">
            <span>{{ strengthText }}</span>
          </div>
        </form>
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

const strengthLevel = computed(() => {
  const password = passwordFormState.value.newPassword;
  if (!password) return 0;
  let score = 0;
  if (password.length >= 6) score++;
  if (password.length >= 10) score++;
  if (/[A-Z]/.test(password)) score++;
  if (/[0-9]/.test(password)) score++;
  if (/[^a-zA-Z0-9]/.test(password)) score++;
  return score;
});

const strengthClass = computed(() => {
  if (strengthLevel.value <= 2) return "weak";
  if (strengthLevel.value <= 4) return "medium";
  return "strong";
});

const strengthText = computed(() => {
  if (strengthLevel.value === 0) return "未输入";
  if (strengthLevel.value <= 2) return "弱";
  if (strengthLevel.value <= 4) return "中";
  return "强";
});

const strengthMeterClass = computed(() => {
  if (!passwordFormState.value.newPassword) return "";
  if (strengthClass.value === "weak") return "strength-weak";
  if (strengthClass.value === "medium") return "strength-medium";
  return "strength-strong";
});

const ruleChecks = computed(() => {
  const pwd = passwordFormState.value.newPassword || "";
  return {
    length: pwd.length >= 8,
    upper: /[A-Z]/.test(pwd),
    number: /[0-9]/.test(pwd),
  };
});

const submitForm = async () => {
  if (passwordFormState.value.newPassword.length < 6) {
    Message.error("密码长度不能小于6位");
    return;
  }
  if (
    passwordFormState.value.newPassword != passwordFormState.value.confirmPassword
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
    await requestApi.post("/api/admin/update", params);
    Message.success("密码已更新");
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

<style scoped></style>

