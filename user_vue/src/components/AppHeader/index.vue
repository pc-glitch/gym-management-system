<template>
  <div class="lumiere-home">
    <header
      id="navbar"
      :class="[headerClass, { 'force-burger-mode': isOverCapacity }]"
    >
      <div class="nav-container glass-effect">
        <a href="#" @click.prevent="navigateTo('/')" class="logo">
          <div class="logo-text">
            {{ projectName || "HEIDELBERG" }}
          </div>
        </a>

        <ul class="nav-links desktop-nav" @mouseleave="closeAllDropdowns">
          <li v-for="item in allNavItems" :key="item.path || item.name">
            <template v-if="item.children && item.children.length">
              <div 
                class="dropdown-wrapper"
                @mouseenter="openDropdown(item.name)"
                @click="toggleDropdown(item.name)"
              >
                <button class="dropdown-toggle link-hover">
                  {{ item.name }}
                  <svg class="dropdown-arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <path d="M6 9l6 6 6-6"></path>
                  </svg>
                </button>
                <Transition name="dropdown">
                  <ul v-show="openedDropdown === item.name" class="dropdown-menu glass-effect">
                    <li v-for="child in item.children" :key="child.path">
                      <a
                        href="#"
                        @click.prevent="handleDropdownNavigate(child.path)"
                        :class="{
                          'router-link-active':
                            router.currentRoute.value.path === child.path,
                        }"
                        class="link-hover"
                      >
                        {{ child.name }}
                      </a>
                    </li>
                  </ul>
                </Transition>
              </div>
            </template>
            <template v-else>
              <a
                href="#"
                @click.prevent="navigateTo(item.path)"
                :class="{
                  'router-link-active':
                    router.currentRoute.value.path === item.path,
                }"
                class="link-hover"
              >
                {{ item.name }}
              </a>
            </template>
          </li>
        </ul>

        <div class="actions desktop-actions">
          <template v-if="!isLoggedIn">
            <button @click="navigateTo('/login')" class="btn-text">登录</button>
            <button @click="navigateTo('/register')" class="btn-primary">
              注册
            </button>
          </template>
          <div v-else class="user-actions">
            <span class="welcome-text">Hi, 用户</span>
            <button @click="logout" class="btn-text">退出</button>
          </div>
        </div>

        <div
          class="menu-toggle"
          @click="toggleMenu"
          :class="{ active: isMenuOpen }"
        >
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>

      <Transition name="drawer">
        <div v-if="isMenuOpen" class="mobile-drawer" @click.self="toggleMenu">
          <div class="drawer-content glass-effect">
            <ul class="mobile-links">
              <li v-for="item in allNavItems" :key="item.path || item.name">
                <template v-if="item.children && item.children.length">
                  <div class="mobile-dropdown">
                    <button 
                      class="mobile-dropdown-toggle"
                      @click="toggleMobileDropdown(item.name)"
                    >
                      {{ item.name }}
                      <svg 
                        class="mobile-dropdown-arrow" 
                        viewBox="0 0 24 24" 
                        fill="none" 
                        stroke="currentColor"
                        :class="{ expanded: mobileOpenedDropdown === item.name }"
                      >
                        <path d="M6 9l6 6 6-6"></path>
                      </svg>
                    </button>
                    <Transition name="mobile-dropdown">
                      <ul v-show="mobileOpenedDropdown === item.name" class="mobile-dropdown-menu">
                        <li v-for="child in item.children" :key="child.path">
                          <a
                            href="#"
                            @click.prevent="handleMobileNavigate(child.path)"
                            :class="{
                              active: router.currentRoute.value.path === child.path,
                            }"
                          >
                            {{ child.name }}
                          </a>
                        </li>
                      </ul>
                    </Transition>
                  </div>
                </template>
                <template v-else>
                  <a
                    href="#"
                    @click.prevent="handleMobileNavigate(item.path)"
                    :class="{
                      active: router.currentRoute.value.path === item.path,
                    }"
                  >
                    {{ item.name }}
                  </a>
                </template>
              </li>
            </ul>
            <div class="mobile-actions">
              <template v-if="!isLoggedIn">
                <button
                  @click="handleMobileNavigate('/login')"
                  class="btn-text full-width"
                >
                  登录
                </button>
                <button
                  @click="handleMobileNavigate('/register')"
                  class="btn-primary full-width"
                >
                  注册
                </button>
              </template>
              <button v-else @click="logout" class="btn-text full-width">
                退出登录
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </header>
    <!-- 占位符：非首页时显示，防止内容被遮挡 -->
    <div v-if="!isIndexPage" class="header-placeholder"></div>
  </div>
</template>

<script setup>
import {
  ref,
  computed,
  onMounted,
  onBeforeUnmount,
  onUnmounted,
  watch,
  nextTick,
} from "vue";
import { useRouter, useRoute } from "vue-router";
import { emptyTheCache } from "@/utils/auth";
import { navigation, personalCenter } from "./index";
import { projectName } from "@/utils/data";

let observer = null;
const collectionGrid = ref(null);
const serviceList = ref(null);

const props = defineProps({ isLoggedIn: Boolean });
const router = useRouter();
const route = useRoute();

const isLoggedIn = computed(() => props.isLoggedIn);
const isMenuOpen = ref(false);
const isScrolled = ref(false);
const openedDropdown = ref(null);
const mobileOpenedDropdown = ref(null);

// 判断是否为首页
const isIndexPage = computed(() => {
  return route.path === "/" || route.path === "/index";
});

const allNavItems = computed(() => {
  const baseNav = navigation || [
    { name: "首页", path: "/" },
    { name: "系列", path: "/collections" },
    { name: "品牌", path: "/brand" },
  ];
  const items = [...baseNav];
  if (isLoggedIn.value && personalCenter) {
    items.push(...personalCenter);
  }
  return items;
});

const isOverCapacity = computed(() => {
  const countItems = (arr) => {
    return arr.reduce((acc, item) => {
      if (item.children && item.children.length) {
        return acc + 1 + item.children.length;
      }
      return acc + 1;
    }, 0);
  };
  return countItems(allNavItems.value) > 6;
});

const navigateTo = (path) => {
  router.push(path);
};

const handleMobileNavigate = (path) => {
  isMenuOpen.value = false;
  navigateTo(path);
};

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value;
};

const openDropdown = (name) => {
  openedDropdown.value = name;
};

const closeAllDropdowns = () => {
  openedDropdown.value = null;
};

const toggleDropdown = (name) => {
  openedDropdown.value = openedDropdown.value === name ? null : name;
};

const handleDropdownNavigate = (path) => {
  openedDropdown.value = null;
  navigateTo(path);
};

const toggleMobileDropdown = (name) => {
  mobileOpenedDropdown.value = mobileOpenedDropdown.value === name ? null : name;
};

const logout = () => {
  if (typeof emptyTheCache === "function") {
    emptyTheCache();
  }
  navigateTo("/");
  window.location.reload();
};

const headerClass = computed(() => {
  return {
    scrolled: isScrolled.value,
    "menu-open": isMenuOpen.value,
  };
});

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50;
};

onMounted(() => {
  window.addEventListener("scroll", handleScroll);
  handleScroll();
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});
</script>

<style scoped>
.glass-effect {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.5);
}

.lumiere-home {
  position: relative;
}

#navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

#navbar:not(.scrolled) {
  background: transparent;
}

#navbar.scrolled {
  background: rgba(255, 255, 255, 0.98);
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.08);
}

.nav-container {
  max-width: 1300px;
  margin: 0 auto;
  padding: 0 32px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 80px;
}

.logo {
  text-decoration: none;
  display: flex;
  align-items: center;
  gap: 12px;
}

.logo-text {
  font-size: 22px;
  font-weight: 800;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #00bcd4 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  letter-spacing: -0.5px;
  text-shadow: 0 2px 10px rgba(102, 126, 234, 0.3);
}

.nav-links {
  display: flex;
  align-items: center;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 8px;
}

.nav-links a,
.dropdown-toggle {
  position: relative;
  padding: 10px 20px;
  text-decoration: none;
  color: #2c3e50;
  font-size: 15px;
  font-weight: 500;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.link-hover::after {
  content: "";
  position: absolute;
  bottom: 6px;
  left: 50%;
  width: 0;
  height: 3px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 3px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  transform: translateX(-50%);
}

.link-hover:hover {
  color: #667eea;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  transform: translateY(-2px);
}

.link-hover:hover::after {
  width: 60%;
}

.router-link-active {
  color: #667eea;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.15), rgba(118, 75, 162, 0.15));
}

.router-link-active::after {
  content: "";
  position: absolute;
  bottom: 6px;
  left: 50%;
  width: 60%;
  height: 3px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 3px;
  transform: translateX(-50%);
}

.dropdown-wrapper {
  position: relative;
}

.dropdown-toggle {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 10px 16px;
}

.dropdown-toggle:hover {
  color: #667eea;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
}

.dropdown-arrow {
  width: 14px;
  height: 14px;
  stroke-width: 2;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.dropdown-wrapper:hover .dropdown-arrow,
.dropdown-wrapper:focus-within .dropdown-arrow {
  transform: rotate(180deg);
}

.dropdown-menu {
  position: absolute;
  top: calc(100% + 12px);
  left: 0;
  min-width: 200px;
  padding: 12px;
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 4px;
  border-radius: 16px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
  overflow: hidden;
}

.dropdown-menu::before {
  content: "";
  position: absolute;
  top: -8px;
  left: 20px;
  width: 16px;
  height: 16px;
  background: rgba(255, 255, 255, 0.85);
  transform: rotate(45deg);
  border-top: 1px solid rgba(255, 255, 255, 0.5);
  border-left: 1px solid rgba(255, 255, 255, 0.5);
}

.dropdown-menu li a {
  display: block;
  padding: 12px 16px;
  font-size: 14px;
  border-radius: 10px;
}

.dropdown-menu li a:hover {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.15), rgba(118, 75, 162, 0.15));
}

.actions {
  display: flex;
  align-items: center;
  gap: 16px;
}

.btn-text {
  padding: 10px 20px;
  background: none;
  border: 2px solid transparent;
  color: #5a6672;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-text:hover {
  color: #667eea;
  background: rgba(102, 126, 234, 0.08);
  border-color: rgba(102, 126, 234, 0.2);
}

.btn-primary {
  position: relative;
  padding: 12px 28px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  color: white;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
}

.btn-primary::before {
  content: "";
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s ease;
}

.btn-primary:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.btn-primary:hover::before {
  left: 100%;
}

.user-actions {
  display: flex;
  align-items: center;
  gap: 16px;
}

.welcome-text {
  font-size: 14px;
  color: #5a6672;
  font-weight: 500;
}

.menu-toggle {
  display: none;
  flex-direction: column;
  gap: 6px;
  padding: 10px;
  cursor: pointer;
  border-radius: 10px;
  transition: background 0.2s ease;
}

.menu-toggle:hover {
  background: rgba(0, 0, 0, 0.05);
}

.menu-toggle span {
  width: 26px;
  height: 2.5px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 2px;
  transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}

.menu-toggle.active span:nth-child(1) {
  transform: rotate(45deg) translate(6px, 6px);
}

.menu-toggle.active span:nth-child(2) {
  opacity: 0;
  transform: translateX(-10px);
}

.menu-toggle.active span:nth-child(3) {
  transform: rotate(-45deg) translate(8px, -7px);
}

.mobile-drawer {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: rgba(0, 0, 0, 0.6);
  z-index: 1001;
  backdrop-filter: blur(4px);
}

.drawer-content {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  width: 320px;
  padding: 32px;
  display: flex;
  flex-direction: column;
}

.mobile-links {
  list-style: none;
  padding: 0;
  margin: 0;
  flex: 1;
}

.mobile-links li {
  margin-bottom: 4px;
}

.mobile-links a {
  display: block;
  padding: 14px 20px;
  text-decoration: none;
  color: #2c3e50;
  font-size: 17px;
  font-weight: 500;
  border-radius: 14px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.mobile-links a:hover {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
}

.mobile-links a.active {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.15), rgba(118, 75, 162, 0.15));
  color: #667eea;
}

.mobile-dropdown {
  margin-bottom: 4px;
}

.mobile-dropdown-toggle {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  background: none;
  border: none;
  padding: 14px 20px;
  font-size: 17px;
  color: #2c3e50;
  font-weight: 500;
  cursor: pointer;
  border-radius: 14px;
  text-align: left;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.mobile-dropdown-toggle:hover {
  background: rgba(102, 126, 234, 0.08);
}

.mobile-dropdown-arrow {
  width: 18px;
  height: 18px;
  stroke-width: 2;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.mobile-dropdown-arrow.expanded {
  transform: rotate(180deg);
}

.mobile-dropdown-menu {
  list-style: none;
  padding: 8px 0;
  margin: 0 0 0 16px;
}

.mobile-dropdown-menu li {
  margin-bottom: 4px;
}

.mobile-dropdown-menu a {
  font-size: 15px;
  padding: 12px 16px;
  color: #5a6672;
  font-weight: 400;
}

.mobile-dropdown-menu a.active {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.15), rgba(118, 75, 162, 0.15));
  color: #667eea;
}

.mobile-actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding-top: 24px;
  border-top: 1px solid rgba(0, 0, 0, 0.08);
}

.full-width {
  width: 100%;
}

.header-placeholder {
  height: 80px;
}

.drawer-enter-active .drawer-content {
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.drawer-leave-active .drawer-content {
  transition: transform 0.35s ease-in;
}

.drawer-enter-from .drawer-content,
.drawer-leave-to .drawer-content {
  transform: translateX(100%);
}

.dropdown-enter-active,
.dropdown-leave-active {
  transition: opacity 0.25s, transform 0.25s;
}

.dropdown-enter-from,
.dropdown-leave-to {
  opacity: 0;
  transform: translateY(-10px) scale(0.95);
}

.mobile-dropdown-enter-active,
.mobile-dropdown-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
}

.mobile-dropdown-enter-from,
.mobile-dropdown-leave-to {
  opacity: 0;
  max-height: 0;
}

.mobile-dropdown-enter-to,
.mobile-dropdown-leave-from {
  opacity: 1;
  max-height: 500px;
}

@media (max-width: 900px) {
  .desktop-nav,
  .desktop-actions {
    display: none;
  }

  .menu-toggle {
    display: flex;
  }

  .nav-container {
    padding: 0 20px;
    height: 70px;
  }

  .logo-text {
    font-size: 20px;
  }

  .header-placeholder {
    height: 70px;
  }
}

@media (max-width: 480px) {
  .nav-container {
    padding: 0 16px;
  }

  .logo-text {
    font-size: 18px;
  }
}
</style>