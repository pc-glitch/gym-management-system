<template>
  <div style="min-height: 60vh; display: flex; align-items: center; justify-content: center">
    <div
      style="
        width: 480px;
        background: #fff;
        border: 1px solid var(--border-color);
        border-radius: 4px;
        box-shadow: var(--shadow-base);
        overflow: hidden;
      "
    >
      <div class="auth-header">
        <svg
          class="brand-logo"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="8" x2="12" y2="12"></line>
          <line x1="12" y1="16" x2="12.01" y2="16"></line>
        </svg>
        <div class="brand-name">页面未找到</div>
        <div class="brand-slogan">你访问的地址不存在，可能已被移动或删除</div>
      </div>

      <div class="auth-body" style="text-align: center">
        <div style="font-size: 56px; font-weight: 800; color: var(--text-main)">404</div>
        <div style="margin-top: 6px; color: var(--text-secondary); font-size: 13px">
          {{ countdown }} 秒后自动回到首页
        </div>
        <div style="margin-top: 18px">
          <button type="button" class="btn primary" @click="goHome">返回首页</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import { useRouter } from "vue-router";

const router = useRouter();
const countdown = ref(5);
let timer = null;

const goHome = () => {
  clearInterval(timer);
  router.push("/index");
};

onMounted(() => {
  timer = setInterval(() => {
    countdown.value--;
    if (countdown.value <= 0) {
      goHome();
    }
  }, 1000);
});

onUnmounted(() => {
  clearInterval(timer);
});
</script>

<style scoped></style>

