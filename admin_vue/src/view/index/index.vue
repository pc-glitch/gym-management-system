<template>
  <div class="orion-layout">
    <!-- 加载遮罩 -->
    <transition name="fade">
      <div v-if="isLoading" class="loading-mask">
        <div class="loading-content">
          <div class="loading-spinner"></div>
          <div class="loading-text">平台装载中...</div>
        </div>
      </div>
    </transition>

    <!-- 侧边栏 -->
    <aside class="sidebar">
      <div class="brand">
        <img src="/logo2.png" alt="Logo" class="brand-logo" />
        <span class="brand-name">{{ projectName || "猎户中心" }}</span>
      </div>

      <nav class="nav-menu">
        <template v-for="section in menuSections" :key="section.title">
          <div 
            class="nav-section-title" 
            @click="toggleMenu(section.title)"
            :class="{ expanded: openedMenu === section.title }"
          >
            <svg 
              class="nav-section-icon" 
              viewBox="0 0 24 24" 
              fill="none" 
              stroke="currentColor"
            >
              <path d="M6 9l6 6 6-6"></path>
            </svg>
            {{ section.title }}
          </div>
          <transition name="collapse">
            <div v-show="openedMenu === section.title" class="nav-section-content">
              <a
                v-for="item in section.items"
                :key="item.path"
                href="#"
                class="nav-item"
                :class="{ active: activePath === item.path }"
                @click.prevent="navigateTo(item)"
              >
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                  <circle cx="12" cy="12" r="5"></circle>
                </svg>
                {{ item.meta?.title || item.title }}
              </a>
            </div>
          </transition>
        </template>
      </nav>

      <div class="sidebar-footer">
        <div class="footer-user">
          <div class="footer-user-meta">
            <div class="footer-user-name">
              {{ userData.username || "管理员" }}
            </div>
            <div class="footer-user-role">
              {{ currentRoleInfo?.label || "用户" }}
            </div>
          </div>
          <div class="user-avatar" title="退出登录" @click="safeExit">
            <img
              :src="userData.avatarurl || defaultAvatar"
              alt="avatar"
              @error="(e) => (e.target.src = defaultAvatar)"
            />
          </div>
        </div>
      </div>
    </aside>

    <!-- 主内容区 -->
    <div class="main-wrapper">
      <header v-if="false" class="top-header">
        <div class="header-actions" style="margin-left: auto">
          <svg
            class="btn-icon"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
          >
            <path
              d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"
            ></path>
            <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
          </svg>
          <div class="user-avatar" title="用户">
            <img
              :src="userData.avatarurl || defaultAvatar"
              alt="avatar"
              @error="(e) => (e.target.src = defaultAvatar)"
            />
          </div>
          <button type="button" class="btn" @click="safeExit">退出</button>
        </div>
      </header>

      <div class="content-scroll-area">
        <div class="page-title-row">
          <div class="page-title">{{ pageTitle || "企业控制台" }}</div>
          <button
            v-if="openedTabs.length > 1"
            type="button"
            class="btn"
            @click="closeAllTabs"
          >
            清空标签
          </button>
        </div>

        <div v-if="openedTabs.length" class="orion-tabs">
          <button
            v-for="(tab, index) in openedTabs"
            :key="tab.path"
            type="button"
            class="orion-tab"
            :class="{ active: activePath === tab.path }"
            @click="changeTab(tab)"
          >
            <span class="orion-tab-title">{{ tab.title }}</span>
            <span
              v-if="openedTabs.length > 1"
              class="orion-tab-close"
              @click.stop="closeTab(tab, index)"
              aria-label="关闭"
              >×</span
            >
          </button>
        </div>

        <router-view v-slot="{ Component }">
          <transition name="fade-transform" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch, onUnmounted } from "vue";
import { useRouter, useRoute } from "vue-router";
import { emptyTheCache, getUserData } from "@/utils/auth";
import { options as roleOptions } from "@/utils/Role";
import { projectName } from "@/utils/data";
import defaultAvatar from "./user.png";

const router = useRouter();
const route = useRoute();

const currentRole = ref(null);
const activePath = ref(route.path);
const pageTitle = ref(route.meta.title || "仪表盘概览");
const openedMenu = ref(null);
const isLoading = ref(false);
const isProfileDropdownOpen = ref(false);
const isMobileMenuOpen = ref(false);
const openedTabs = ref([]);
const headerKeyword = ref("");
const userData = reactive({
  id: null,
  username: "管理员",
  avatarurl: "",
  role: null,
});

const todayText = computed(() => {
  try {
    return new Date().toLocaleDateString("zh-CN", {
      year: "numeric",
      month: "long",
      day: "numeric",
    });
  } catch (e) {
    return new Date().toLocaleDateString();
  }
});

router.beforeEach((to, from, next) => {
  isLoading.value = true;
  next();
});

router.afterEach(() => {
  setTimeout(() => {
    isLoading.value = false;
  }, 500);
});

const toggleMenu = (parentTitle) => {
  openedMenu.value = openedMenu.value === parentTitle ? null : parentTitle;
};

const toggleProfileDropdown = () => {
  isProfileDropdownOpen.value = !isProfileDropdownOpen.value;
};

const handleGlobalClick = (e) => {
  const userCard = document.querySelector(".user-profile");
  if (userCard && !userCard.contains(e.target)) {
    isProfileDropdownOpen.value = false;
  }
};

onMounted(async () => {
  window.addEventListener("click", handleGlobalClick);
  await obtainCurrentUserIdentity();

  const storedTabs = sessionStorage.getItem("openedTabs");
  if (storedTabs) {
    try {
      const parsedTabs = JSON.parse(storedTabs);
      if (Array.isArray(parsedTabs)) openedTabs.value = parsedTabs;
    } catch (e) {
      sessionStorage.removeItem("openedTabs");
    }
  }

  addCurrentRouteToTabs();

  if (openedTabs.value.length == 0 && processedRoutes.value.length > 0) {
    const firstNavigableRoute = getFirstNavigableRoute();
    if (firstNavigableRoute && firstNavigableRoute.path) {
      openedTabs.value.push({
        path: firstNavigableRoute.path,
        title: firstNavigableRoute.meta.title,
      });
      if (route.path === "/" || route.path != firstNavigableRoute.path) {
        router.replace({ path: firstNavigableRoute.path });
      }
    }
  }

  activePath.value = route.path;
  pageTitle.value = route.meta.title || "仪表盘概览";
});

onUnmounted(() => {
  window.removeEventListener("click", handleGlobalClick);
});

watch(route, (newRoute) => {
  activePath.value = newRoute.path;
  pageTitle.value = newRoute.meta.title || "仪表盘概览";
  isProfileDropdownOpen.value = false;
  isMobileMenuOpen.value = false;
  addCurrentRouteToTabs();
});

watch(
  openedTabs,
  (newValue) => {
    sessionStorage.setItem("openedTabs", JSON.stringify(newValue));
  },
  { deep: true }
);

const obtainCurrentUserIdentity = async () => {
  let data = await getUserData();
  if (data && data.role) {
    currentRole.value = data.role;
    Object.assign(userData, data);
  }
};

const currentRoleInfo = computed(() => {
  const roleInfo = roleOptions.find(
    (option) => option.role === currentRole.value
  );
  if (roleInfo && roleInfo.routes) {
    const newRoleInfo = JSON.parse(JSON.stringify(roleInfo));
    newRoleInfo.routes = newRoleInfo.routes.filter(
      (route) => route.meta?.checkFlag != false
    );
    return newRoleInfo;
  }
  return roleInfo;
});

const processedRoutes = computed(() => {
  if (!currentRoleInfo.value) return [];
  const routes = currentRoleInfo.value.routes;
  const flattened = [];

  const visit = (list) => {
    if (!Array.isArray(list)) return;
    list.forEach((route) => {
      if (!route) return;

      if (route.path) {
        const { children, ...routeWithoutChildren } = route;
        flattened.push(routeWithoutChildren);
      }

      if (Array.isArray(route.children) && route.children.length > 0) {
        visit(route.children);
      }
    });
  };

  visit(routes);
  return flattened;
});

const menuSections = computed(() => {
  const groups = {};

  processedRoutes.value.forEach((menu) => {
    if (!menu || !menu.path) return;
    
    const parentTitle = menu.meta?.parentTitle || "其他功能";
    
    if (!groups[parentTitle]) {
      groups[parentTitle] = [];
    }
    groups[parentTitle].push(menu);
  });

  return Object.entries(groups)
    .map(([title, items]) => ({ title, items, _index: 0 }))
    .sort((a, b) => {
      const order = ["个人中心", "系统管理", "用户管理", "论坛管理", "订单管理", "数据中心", "赛事活动", "商品管理", "场地管理", "器材管理"];
      const aIndex = order.indexOf(a.title);
      const bIndex = order.indexOf(b.title);
      if (aIndex === -1) return 1;
      if (bIndex === -1) return -1;
      return aIndex - bIndex;
    });
});

const getMenuIcon = (routeItem) => {
  const title = String(routeItem?.meta?.title || "").toLowerCase();
  const path = String(routeItem?.path || "").toLowerCase();
  const key = `${title} ${path}`;

  if (/(dashboard|仪表盘|首页|index)/.test(key)) return "fa-solid fa-gauge-high";
  if (/(用户|user)/.test(key)) return "fa-solid fa-users";
  if (/(公告|news|通知|announcement)/.test(key)) return "fa-solid fa-bullhorn";
  if (/(轮播|banner|swiper)/.test(key)) return "fa-regular fa-images";
  if (/(个人|profile|center)/.test(key)) return "fa-solid fa-user-gear";
  if (/(密码|pass)/.test(key)) return "fa-solid fa-lock";
  if (/(设置|setting|config)/.test(key)) return "fa-solid fa-gear";
  return "fa-regular fa-circle";
};

const openedGroup = computed(() => {
  if (!openedMenu.value) return null;
  return processedRoutes.value.find(
    (m) => m.children && m.parentTitle === openedMenu.value
  );
});

const isParentActive = (menu) => {
  return (
    menu.children &&
    menu.children.some((child) => child.path === activePath.value)
  );
};

const getFirstNavigableRoute = () => {
  if (processedRoutes.value.length == 0) return null;
  const direct = processedRoutes.value.find((r) => !r.children && r.path);
  if (direct) return direct;
  const firstGroup = processedRoutes.value.find(
    (r) => Array.isArray(r.children) && r.children.length > 0
  );
  return firstGroup ? firstGroup.children.find((child) => child.path) : null;
};

const addCurrentRouteToTabs = () => {
  if (route.meta && route.meta.title && route.path != "/") {
    const tabExists = openedTabs.value.some((tab) => tab.path === route.path);
    if (!tabExists) {
      openedTabs.value.push({ path: route.path, title: route.meta.title });
    }
  }
};

const changeTab = (tab) => {
  router.push({ path: tab.path });
};

const closeTab = (tab, index) => {
  if (openedTabs.value.length <= 1) return;
  openedTabs.value.splice(index, 1);
  if (activePath.value === tab.path) {
    const newActiveTab = openedTabs.value[index] || openedTabs.value[index - 1];
    if (newActiveTab) router.push({ path: newActiveTab.path });
  }
};

const navigateTo = (item) => {
  if (!item || !item.path) return;
  if (item.path != route.path) {
    router.push({ path: item.path });
  }
};

const closeAllTabs = () => {
  const fallbackRoute = getFirstNavigableRoute();
  openedTabs.value = [];
  if (fallbackRoute && fallbackRoute.path) {
    openedTabs.value.push({
      path: fallbackRoute.path,
      title: fallbackRoute.meta.title,
    });
    if (route.path !== fallbackRoute.path)
      router.push({ path: fallbackRoute.path });
  } else {
    router.push({ path: "/" });
  }
};

const safeExit = () => {
  emptyTheCache();
  router.push({ path: "/login" });
};
</script>

<style scoped>
.loading-mask {
  position: fixed;
  inset: 0;
  z-index: 50;
  background: rgba(244, 245, 247, 0.85);
  backdrop-filter: blur(2px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.loading-content {
  text-align: center;
}

.loading-spinner {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  border: 3px solid #dfe1e6;
  border-top-color: var(--primary-color);
  animation: spin 1s linear infinite;
  margin: 0 auto;
}

.loading-text {
  margin-top: 12px;
  font-size: 13px;
  font-weight: 600;
  color: var(--text-secondary);
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.orion-tabs {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding-bottom: 12px;
  margin-bottom: 16px;
}

.orion-tab {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 10px;
  font-size: 12px;
  font-weight: 600;
  border: 1px solid var(--border-color);
  background: #fff;
  border-radius: 4px;
  color: var(--text-secondary);
  cursor: pointer;
  transition: all 0.2s;
  white-space: nowrap;
}

.orion-tab:hover {
  background: #f4f5f7;
  color: var(--text-main);
}

.orion-tab.active {
  background: var(--primary-light);
  border-color: var(--primary-color);
  color: var(--primary-color);
}

.orion-tab-close {
  width: 18px;
  height: 18px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  color: var(--text-tertiary);
}

.orion-tab-close:hover {
  background: #fff;
  color: var(--danger-color);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.fade-transform-enter-active,
.fade-transform-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}
.fade-transform-enter-from {
  opacity: 0;
  transform: translateX(-8px);
}
.fade-transform-leave-to {
  opacity: 0;
  transform: translateX(8px);
}
.top-header {
  display: none !important;
}
</style>
