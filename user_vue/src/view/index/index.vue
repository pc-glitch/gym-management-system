<template>
  <div class="app-layout">
    <AppHeader :isLoggedIn="areSignedIn" />

    <main class="main-content">
      <router-view v-slot="{ Component }">
        <transition name="fade" mode="out-in">
          <component :is="Component" />
        </transition>
      </router-view>
    </main>

    <footer class="footer-copyright">
      <div class="content-wrapper">
        <p>&copy; {{ projectName }}. All Rights Reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { getCurrentInstance, onMounted, ref, onUpdated } from "vue";
import { getToken, setToken, removeToken } from "@/utils/auth.js";
import { projectName } from "@/utils/data";
import requestApi from "@/utils/axios"; // 获取当前组件实例的代理对象
import AppHeader from "@/components/AppHeader/index.vue";

// 引入 Element Plus 的轮播图组件
// import { ElCarousel, ElCarouselItem } from "element-plus";
import { useRouter, useRoute } from "vue-router";
const router = useRouter(); // 获取路由器实例
const route = useRoute(); // 获取当前路由实例

const isLoggedIn = ref(false);

let areSignedIn = ref(false);
// const 判断是否登录
const determine = async () => {
  console.log("判断是否登录");
  // 获取浏览器缓存是否有token
  const token = getToken();

  if (!token) return;
  const response = await requestApi.post("/api/auth/isLogin", {});
  if (response.code == 0) {
    localStorage.setItem("areSignedIn", true);

    areSignedIn.value = true;
    // 10分钟执行一次是否登录
    setTimeout(() => {
      determine();
    }, 10 * 60 * 1000);
  } else {
    localStorage.setItem("areSignedIn", false);
    areSignedIn.value = false;
  }
};
determine();

onUpdated(() => {
  determine();
});
</script>

<style>
/* Global Styles */
:root {
  --background-light: #f5f5f7;
  --text-dark: #1d1d1f;
  --text-light: #f5f5f7;
  --text-secondary: #6e6e73;
  --accent-blue: #007aff;
  --footer-bg: #1d1d1f;
}

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
  line-height: 1.6;
  color: var(--text-dark);
  background-color: var(--background-light);
}

/* App Layout */
.app-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main-content {
  flex-grow: 1;
  width: 100%;
}

/* Router Transition */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Footer */
.footer-copyright {
  text-align: center;
  padding: 2rem 0;
  background-color: var(--footer-bg);
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.footer-copyright .content-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}
</style>
