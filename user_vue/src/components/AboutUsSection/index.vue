<template>
  <div class="heidelberg-garage">
    <!-- Hero Section -->
    <header id="home" class="hero">
      <div class="hero-bg"></div>
      <div class="hero-overlay"></div>
      <div class="hero-content">
        <h1 class="hero-title">
          <span class="highlight"></span> 多功能体育馆管理平台
        </h1>
        <p class="hero-subtitle">
          覆盖场地预约、赛事报名、活动发布、器材租赁、商城服务与在线客服。<br />
          让体育服务从查询到履约一站式完成。
        </p>
        <div class="hero-actions">
          <button class="btn-primary" onclick="location.href='/venueinformationListPage'">立即体验</button>
          <button class="btn-outline" onclick="location.href='/announcement'">了解更多</button>
        </div>
      </div>
    </header>

    <!-- Stats Section -->
    <section class="stats-bar">
      <div class="stat-item">
        <span class="stat-num">50,000+</span>
        <span class="stat-label">累计预约人次</span>
      </div>
      <div class="stat-item">
        <span class="stat-num">99.9%</span>
        <span class="stat-label">预约处理稳定率</span>
      </div>
      <div class="stat-item">
        <span class="stat-num">24/7</span>
        <span class="stat-label">在线服务响应</span>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
      <div class="section-header">
        <h2>智慧场馆，由此开启</h2>
        <p>多角色协同闭环，覆盖用户端端到管理端的核心流程</p>
      </div>

      <div class="feature-grid">
        <div
          class="feature-card"
          v-for="(item, index) in features"
          :key="index"
        >
          <div class="icon-box" v-html="item.icon"></div>
          <h3>{{ item.title }}</h3>
          <p>{{ item.desc }}</p>
        </div>
      </div>
    </section>

    <!-- Vision / Big Image Section -->
    <section id="about" class="vision">
      <div class="vision-content">
        <h2>不仅是预约，<br />更是校园体育生态升级</h2>
        <p>
          平台围绕用户、管理员与服务人员构建完整业务链路，支持公告通知、赛事活动、场地预约、订单核验与互动社区，确保每一次操作都可追踪、可处理、可反馈。
        </p>
        <ul class="vision-list">
          <li>预约申请、审核处理、结果回显闭环</li>
          <li>余额支付、订单核验、评价反馈闭环</li>
          <li>论坛互动、客服会话、通知触达闭环</li>
        </ul>
      </div>
      <div class="vision-image">
        <img
          src="@/components/AboutUsSection/4.jpg"
          alt="Smart Sports Venue"
        />
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";

const isScrolled = ref(false);

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50;
};

onMounted(() => {
  window.addEventListener("scroll", handleScroll);
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});

const features = [
  {
    title: "场地预约闭环",
    desc: "用户提交预约后自动进入管理端审核，审核结果与处理人实时回写用户端预约记录。",
    icon: `<svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 7h18M3 17h18M5 7v10M19 7v10M9 12h6"/></svg>`,
  },
  {
    title: "赛事活动联动",
    desc: "赛事信息与活动公告统一发布，用户可直接发起报名，管理员可在同一列表完成审核与管理。",
    icon: `<svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4M12 8h.01"/></svg>`,
  },
  {
    title: "余额支付核验",
    desc: "商城订单采用余额支付，管理端可跟踪订单状态并执行核验，用户端同步查看进度与评价。",
    icon: `<svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>`,
  },
  {
    title: "在线客服会话",
    desc: "前台与后台均支持会话列表与消息回溯，保证咨询双方都能在各自窗口持续沟通。",
    icon: `<svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>`,
  },
];
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap");

.heidelberg-garage {
  font-family: "Inter", system-ui, -apple-system, sans-serif;
  color: #333;
  width: 100%;
  overflow-x: hidden;
  background: #f8f9fa;
}

/* Navbar */
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 50px;
  z-index: 1000;
  transition: all 0.3s ease;
  color: white;
}

.navbar.scrolled {
  background: rgba(255, 255, 255, 0.95);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  padding: 15px 50px;
  color: #1a1a1a;
}

.logo {
  font-size: 24px;
  font-weight: 800;
  letter-spacing: -0.5px;
  text-transform: uppercase;
}

.nav-links a {
  margin-left: 30px;
  text-decoration: none;
  color: inherit;
  font-weight: 500;
  font-size: 14px;
  transition: color 0.3s;
}

.nav-links a:hover {
  color: #007aff;
}

.btn-login {
  padding: 8px 20px;
  border: 1px solid currentColor;
  border-radius: 4px;
}

/* Hero */
.hero {
  position: relative;
  height: 90vh;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: white;
}

.hero-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url("https://images.unsplash.com/photo-1575361204480-aadea25e6e68?q=80&w=2670&auto=format&fit=crop");
  background-size: cover;
  background-position: center;
  z-index: 1;
}

.hero-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(0, 0, 50, 0.8), rgba(0, 0, 0, 0.6));
  z-index: 2;
}

.hero-content {
  position: relative;
  z-index: 3;
  max-width: 800px;
  padding: 20px;
}

.hero-title {
  font-size: 64px;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 24px;
  letter-spacing: -2px;
}

.hero-title .highlight {
  color: #007aff; /* Tech Blue */
  background: linear-gradient(90deg, #007aff, #00c6ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 20px;
  color: rgba(255, 255, 255, 0.8);
  line-height: 1.6;
  margin-bottom: 40px;
  font-weight: 300;
}

.hero-actions {
  display: flex;
  gap: 20px;
  justify-content: center;
}

button {
  cursor: pointer;
  padding: 16px 40px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 8px;
  transition: all 0.3s;
  border: none;
}

.btn-primary {
  background: #007aff;
  color: white;
}

.btn-primary:hover {
  background: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(0, 122, 255, 0.3);
}

.btn-outline {
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: white;
  backdrop-filter: blur(5px);
}

.btn-outline:hover {
  background: white;
  color: #1a1a1a;
}

/* Stats */
.stats-bar {
  display: flex;
  justify-content: space-around;
  padding: 40px 0;
  background: #fff;
  border-bottom: 1px solid #eee;
  position: relative;
  z-index: 4;
  margin-top: -60px;
  width: 80%;
  margin-left: auto;
  margin-right: auto;
  border-radius: 12px;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.05);
}

.stat-item {
  text-align: center;
}

.stat-num {
  display: block;
  font-size: 36px;
  font-weight: 800;
  color: #1a1a1a;
}

.stat-label {
  font-size: 14px;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 1px;
}

/* Features */
.features {
  padding: 100px 50px;
  background: #f8f9fa;
  text-align: center;
}

.section-header h2 {
  font-size: 40px;
  font-weight: 700;
  margin-bottom: 16px;
  color: #1a1a1a;
}

.section-header p {
  color: #666;
  font-size: 18px;
  margin-bottom: 60px;
}

.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  max-width: 1200px;
  margin: 0 auto;
}

.feature-card {
  background: white;
  padding: 40px;
  border-radius: 20px;
  text-align: left;
  transition: all 0.3s ease;
  border: 1px solid #eee;
}

.feature-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
  border-color: #007aff;
}

.icon-box {
  width: 60px;
  height: 60px;
  background: #e6f2ff;
  color: #007aff;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

.feature-card h3 {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 12px;
}

.feature-card p {
  color: #666;
  line-height: 1.6;
}

/* Vision */
.vision {
  display: flex;
  align-items: stretch;
  background: #111;
  color: white;
  min-height: 600px;
}

.vision-content {
  flex: 1;
  padding: 100px 80px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.vision-content h2 {
  font-size: 42px;
  line-height: 1.2;
  margin-bottom: 30px;
}

.vision-content p {
  font-size: 18px;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 40px;
  line-height: 1.8;
  max-width: 500px;
}

.vision-list li {
  font-size: 18px;
  margin-bottom: 16px;
  font-weight: 500;
}

.vision-image {
  flex: 1;
}

.vision-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Footer */
.footer {
  background: #000;
  color: white;
  padding: 60px 50px;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1200px;
  margin: 0 auto;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 40px;
}

.footer-brand h3 {
  font-size: 24px;
  margin-bottom: 8px;
}

.footer-brand p {
  color: #666;
  font-size: 14px;
}

.footer-links a {
  color: #888;
  text-decoration: none;
  margin-left: 20px;
  transition: color 0.2s;
}

.footer-links a:hover {
  color: white;
}

/* Responsive */
@media (max-width: 768px) {
  .hero-title {
    font-size: 40px;
  }
  .vision {
    flex-direction: column;
  }
  .vision-content {
    padding: 60px 20px;
  }
  .stats-bar {
    width: 90%;
    flex-direction: column;
    gap: 20px;
    padding: 20px;
  }
  .navbar {
    padding: 15px 20px;
  }
  .nav-links {
    display: none; /* Simplified for mobile */
  }
}
</style>
