<template>
  <div class="page-container">
    <!-- 主容器 -->
    <div class="main-card">
      <!-- 左侧：选择区域 -->
      <div class="left-column">
        <!-- 头部 -->
        <div class="header-section">
          <div class="header-text">
            <h1>账户充值</h1>
            <p>安全、快捷的在线充值服务</p>
          </div>
          <!-- 余额展示 -->
          <div class="balance-card">
            <div class="balance-icon">
              <i class="fas fa-wallet"></i>
            </div>
            <div class="balance-info">
              <div class="balance-label">当前余额</div>
              <div class="balance-value">
                ¥ {{ Number(userInfo.money || 0).toFixed(2) }}
              </div>
            </div>
          </div>
        </div>

        <!-- 金额网格 -->
        <div class="amount-section">
          <h3 class="section-title">
            <span class="title-indicator"></span>
            选择充值金额
          </h3>
          <div class="amount-grid">
            <div
              v-for="item in quickAmounts"
              :key="item.value"
              class="amount-card"
              :class="{
                selected: rechargeForm.amount === item.value && !isCustomAmount,
              }"
              @click="selectAmount(item.value)"
            >
              <div
                v-if="item.tag"
                class="badge-discount"
                :class="item.tagClass"
              >
                {{ item.tag }}
              </div>
              <div class="amount-content">
                <span class="amount-num">{{ item.value }}</span>
                <span class="amount-unit">元</span>
              </div>
              <div
                class="amount-desc"
                :class="{
                  'highlight-desc': rechargeForm.amount === item.value,
                }"
              >
                {{ item.desc }}
              </div>
            </div>

            <!-- 自定义金额 -->
            <div
              class="amount-card custom-card"
              :class="{ selected: isCustomAmount }"
              @click="focusCustomInput"
            >
              <input
                ref="customInputRef"
                type="number"
                placeholder="自定义金额"
                class="custom-input"
                v-model.number="rechargeForm.customAmount"
                @input="handleCustomInput"
              />
            </div>
          </div>
        </div>

        <!-- 说明文字 -->
        <div class="footer-tips">
          <div class="tip-col">
            <h4>充值说明：</h4>
            <p>1. 充值金额即时到账，特殊情况可能有1-5分钟延迟。</p>
            <p>2. 赠送金额仅限站内消费，不可提现。</p>
          </div>
          <div class="tip-col">
            <h4>遇到问题？</h4>
            <p>客服电话：400-123-4567</p>
            <p>工作时间：09:00 - 22:00</p>
          </div>
        </div>
      </div>

      <!-- 右侧：支付收银台 -->
      <div class="right-column">
        <div class="payment-details">
          <h3 class="payment-title">支付详情</h3>

          <!-- 订单信息 -->
          <div class="order-summary-box">
            <div class="summary-row">
              <span class="label">充值金额</span>
              <span class="value"
                >¥ {{ Number(rechargeForm.amount || 0).toFixed(2) }}</span
              >
            </div>
            <div class="summary-row">
              <span class="label">平台赠送</span>
              <span class="value bonus-text"
                >+ ¥ {{ Number(currentBonus).toFixed(2) }}</span
              >
            </div>
            <div class="divider-dashed"></div>
            <div class="summary-row total-row">
              <span class="label">应付总额</span>
              <span class="total-value">{{
                Number(rechargeForm.amount || 0).toFixed(2)
              }}</span>
            </div>
          </div>

          <!-- 支付方式 -->
          <div class="payment-methods">
            <div
              class="method-item"
              :class="{ active: paymentMethod === 'wechat' }"
              @click="paymentMethod = 'wechat'"
            >
              <i class="fab fa-weixin text-green"></i> 微信支付
            </div>
            <div
              class="method-item"
              :class="{ active: paymentMethod === 'alipay' }"
              @click="paymentMethod = 'alipay'"
            >
              <i class="fab fa-alipay text-blue"></i> 支付宝
            </div>
          </div>

          <!-- 支付按钮区域 -->
          <div class="pay-action-area">
            <el-button type="primary" class="pay-button" @click="handleRecharge">
              立即支付 ¥{{ Number(rechargeForm.amount || 0).toFixed(2) }}
            </el-button>
            <div class="pay-agreement">
              支付即代表同意 <a href="#">《充值服务协议》</a>
            </div>
          </div>
        </div>

        <!-- 底部状态条 -->
        <div class="security-bar">
          <i class="fas fa-shield-alt"></i> 128位 SSL 安全加密支付
        </div>
      </div>
    </div>

    <el-dialog
      v-model="dialogVisible"
      :title="isLoading ? '支付处理中' : '请输入支付密码'"
      width="420px"
      :show-close="!isLoading"
      :close-on-click-modal="!isLoading"
      :close-on-press-escape="!isLoading"
      :before-close="handleDialogBeforeClose"
      @closed="closeDialog"
    >
      <div class="modal-content">
        <div v-if="isLoading" class="loading-state">
          <div class="spinner"></div>
          <p class="loading-text">正在安全支付中...</p>
        </div>

        <div v-else>
          <p class="pay-amount-display">
            ¥ {{ Number(rechargeForm.amount).toFixed(2) }}
          </p>
          <p class="pay-desc">
            正在使用{{ paymentMethod === "wechat" ? "微信" : "支付宝" }}充值
          </p>

          <div class="password-input-wrapper" @click="focusPasswordInput">
            <div class="password-box" v-for="i in 6" :key="i">
              <span v-if="password.length >= i" class="dot"></span>
            </div>
            <input
              ref="passwordInputRef"
              type="tel"
              maxlength="6"
              class="hidden-input"
              v-model="password"
              @input="handlePasswordInput"
            />
          </div>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, nextTick } from "vue";
import Message from "@/components/MessageBox/index.js";
import requestApi from "@/utils/axios";
import { getUserData } from "@/utils/auth.js";

const userInfo = ref({});
const dialogVisible = ref(false);
const isLoading = ref(false);
const paymentMethod = ref("wechat");
const customInputRef = ref(null);
const passwordInputRef = ref(null);
const password = ref("");
const isCustomAmount = ref(false);

// 配置金额选项
const quickAmounts = [
  { value: 10, desc: "无赠送", tag: "", tagClass: "" },
  { value: 50, desc: "赠送 2元", tag: "赠2元", tagClass: "bg-red" },
  { value: 100, desc: "赠送 5元", tag: "热销", tagClass: "bg-orange" },
  { value: 200, desc: "赠送 12元", tag: "推荐", tagClass: "bg-blue" },
  { value: 500, desc: "赠送 35元", tag: "", tagClass: "" },
];

const rechargeForm = reactive({
  amount: 50, // 默认选中50
  customAmount: "",
});

// 计算当前赠送金额
const currentBonus = computed(() => {
  if (isCustomAmount.value) return 0;
  const item = quickAmounts.find((i) => i.value === rechargeForm.amount);
  // 简单解析 desc 中的数字，实际开发可以用字段存
  if (item && item.desc.includes("赠送")) {
    const match = item.desc.match(/(\d+)元/);
    return match ? Number(match[1]) : 0;
  }
  return 0;
});

onMounted(async () => {
  await getRechargeData();
});

const getRechargeData = async () => {
  try {
    let userData = await getUserData();
    // 刷新一次最新数据
    let res = await requestApi.post("/api/user/info", {
      id: userData.userid || userData.id,
    });
    if (res.code == 0) {
      localStorage.setItem("userData", JSON.stringify(res.data));
      userInfo.value = res.data;
      userInfo.value.money = res.data.money || 0;
    } else {
      userInfo.value = userData; // 降级使用缓存
    }
  } catch (error) {
    console.log(error);
  }
};

// 选择固定金额
const selectAmount = (val) => {
  isCustomAmount.value = false;
  rechargeForm.amount = val;
  rechargeForm.customAmount = "";
};

// 聚焦自定义输入
const focusCustomInput = () => {
  isCustomAmount.value = true;
  rechargeForm.amount = 0; // 暂时清零显示
  nextTick(() => {
    customInputRef.value.focus();
  });
};

// 处理自定义输入
const handleCustomInput = (e) => {
  const val = Number(e.target.value);
  rechargeForm.amount = val;
};

// 点击支付
const handleRecharge = () => {
  if (rechargeForm.amount <= 0 || rechargeForm.amount > 999999) {
    Message.error("请输入有效的充值金额 (1-999999元)");
    return;
  }
  // 打开密码弹窗
  password.value = "";
  dialogVisible.value = true;
  isLoading.value = false;
  nextTick(() => {
    if (passwordInputRef.value) {
      passwordInputRef.value.focus();
    }
  });
};

const closeDialog = () => {
  if (isLoading.value) return; // 支付中禁止关闭
  dialogVisible.value = false;
  password.value = "";
};

const handleDialogBeforeClose = (done) => {
  if (isLoading.value) return;
  done();
};

const focusPasswordInput = () => {
  if (!isLoading.value && passwordInputRef.value) {
    passwordInputRef.value.focus();
  }
};

// 监听密码输入
const handlePasswordInput = async () => {
  // 限制只能输入数字
  password.value = password.value.replace(/[^\d]/g, "");

  if (password.value.length === 6) {
    // 密码输入完成，触发支付
    await confirmRecharge();
  }
};

// 确认充值逻辑
const confirmRecharge = async () => {
  try {
    isLoading.value = true; // 开始加载

    // 模拟 2秒 支付加载时间
    await new Promise((resolve) => setTimeout(resolve, 2000));

    let numberSize = Number(rechargeForm.amount) + Number(userInfo.value.money);

    // 如果有赠送，也加上 (仅做前端演示，实际后端计算)
    numberSize += currentBonus.value;

    const payload = {
      money: numberSize,
      id: userInfo.value.userid || userInfo.value.id,
    };

    let res = await requestApi.post("/api/user/update", payload);

    // 支付完成
    isLoading.value = false;

    if (res.code == 0) {
      dialogVisible.value = false;
      Message.success("支付成功！资金已到账");
      await getRechargeData(); // 刷新余额
    } else {
      Message.error(res.msg || "充值失败，请稍后再试");
      password.value = ""; // 清空密码重试
    }
  } catch (error) {
    isLoading.value = false;
    console.error(error);
    Message.error("支付确认失败！");
    password.value = "";
  }
};
</script>

<style scoped>
/* 引入 FontAwesome */
@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css");

.page-container {
  min-height: 100vh;
  background-color: #f3f4f6; /* bg-gray-100 */
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
  color: #374151;
}

.main-card {
  width: 100%;
  max-width: 1152px; /* max-w-6xl */
  background: #fff;
  border-radius: 1rem;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
    0 10px 10px -5px rgba(0, 0, 0, 0.04);
  display: flex;
  overflow: hidden;
  min-height: 600px;
}

/* 左侧栏 */
.left-column {
  flex: 1;
  padding: 3rem;
  display: flex;
  flex-direction: column;
}

.header-section {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 2rem;
}

.header-text h1 {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0 0 0.25rem 0;
}
.header-text p {
  color: #9ca3af;
  font-size: 0.875rem;
  margin: 0;
}

.balance-card {
  background: linear-gradient(135deg, #1f2937 0%, #374151 100%);
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: 0.75rem;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  gap: 1rem;
}

.balance-icon {
  width: 2.5rem;
  height: 2.5rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.125rem;
}

.balance-info {
  display: flex;
  flex-direction: column;
}

.balance-label {
  font-size: 0.75rem;
  opacity: 0.7;
}

.balance-value {
  font-size: 1.25rem;
  font-weight: 700;
  letter-spacing: 0.025em;
}

/* 金额选择区 */
.amount-section {
  margin-bottom: 2rem;
}

.section-title {
  font-weight: 700;
  color: #1f2937;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  font-size: 1.1rem;
}

.title-indicator {
  width: 0.25rem;
  height: 1.5rem;
  background-color: #dc2626;
  border-radius: 9999px;
  margin-right: 0.75rem;
}

.amount-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.25rem;
}

.amount-card {
  background: #fff;
  border: 2px solid #f3f4f6;
  border-radius: 0.75rem;
  padding: 1.5rem;
  cursor: pointer;
  position: relative;
  transition: all 0.2s ease;
  overflow: hidden;
}

.amount-card:hover {
  border-color: #e5e7eb;
  transform: translateY(-2px);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.amount-card.selected {
  border-color: #dc2626;
  background-color: #fef2f2;
  color: #dc2626;
  box-shadow: 0 4px 12px rgba(220, 38, 38, 0.1);
}

.amount-content {
  text-align: center;
}

.amount-num {
  font-size: 1.5rem;
  font-weight: 700;
}

.amount-unit {
  font-size: 0.875rem;
  margin-left: 2px;
}

.amount-desc {
  font-size: 0.75rem;
  color: #9ca3af;
  margin-top: 0.5rem;
  text-align: center;
  transition: color 0.2s;
}

.amount-card:hover .amount-desc {
  color: #ef4444;
}

.badge-discount {
  position: absolute;
  top: -1px;
  right: -1px;
  background: #ef4444;
  color: white;
  font-size: 0.75rem;
  padding: 2px 8px;
  border-bottom-left-radius: 0.5rem;
  border-top-right-radius: 0.375rem;
}
.bg-red {
  background-color: #ef4444;
}
.bg-orange {
  background-color: #f97316;
}
.bg-blue {
  background-color: #3b82f6;
}

/* 自定义输入框 */
.custom-card {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
}

.custom-input {
  width: 100%;
  height: 100%;
  padding: 1.5rem;
  text-align: center;
  background: transparent;
  border: none;
  font-size: 1.125rem;
  font-weight: 700;
  color: #1f2937;
  outline: none;
}
.custom-input::placeholder {
  color: #9ca3af;
  font-weight: normal;
  font-size: 1rem;
}

/* 底部说明 */
.footer-tips {
  margin-top: auto;
  padding-top: 1.5rem;
  border-top: 1px solid #f3f4f6;
  display: flex;
  gap: 2rem;
}

.tip-col {
  flex: 1;
}

.tip-col h4 {
  font-weight: 700;
  color: #6b7280;
  font-size: 0.75rem;
  margin-bottom: 0.25rem;
}

.tip-col p {
  font-size: 0.75rem;
  color: #9ca3af;
  line-height: 1.5;
  margin: 0;
}

/* 右侧栏 */
.right-column {
  width: 24rem; /* w-96 */
  background-color: #f9fafb;
  border-left: 1px solid #e5e7eb;
  display: flex;
  flex-direction: column;
  position: relative;
  box-shadow: -4px 0 20px rgba(0, 0, 0, 0.02);
}

.payment-details {
  padding: 2rem;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.payment-title {
  font-weight: 700;
  color: #1f2937;
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
}

.order-summary-box {
  background: #fff;
  border-radius: 0.75rem;
  padding: 1rem;
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  margin-bottom: 1.5rem;
  border: 1px solid #f3f4f6;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 0.5rem;
  font-size: 0.875rem;
}

.summary-row .label {
  color: #6b7280;
}

.summary-row .value {
  font-weight: 700;
  color: #1f2937;
}

.bonus-text {
  color: #ef4444;
}

.divider-dashed {
  border-top: 1px dashed #e5e7eb;
  margin: 0.75rem 0;
}

.total-row {
  margin-bottom: 0;
  align-items: flex-end;
}

.total-value {
  font-size: 1.875rem;
  font-weight: 700;
  color: #dc2626;
  line-height: 1;
}

.total-value::before {
  content: "¥";
  font-size: 0.875rem;
  margin-right: 2px;
}

/* 支付方式 */
.payment-methods {
  background: #e5e7eb;
  padding: 0.25rem;
  border-radius: 0.5rem;
  display: flex;
  margin-bottom: auto; /* Push content up */
}

.method-item {
  flex: 1;
  padding: 0.5rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: #6b7280;
  border-radius: 0.375rem;
  text-align: center;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.method-item:hover {
  color: #374151;
}

.method-item.active {
  background: #fff;
  color: #1f2937;
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
}

.text-green {
  color: #10b981;
}
.text-blue {
  color: #3b82f6;
}

/* 支付操作区 */
.pay-action-area {
  margin-top: 2rem;
  text-align: center;
}

.pay-button {
  width: 100%;
  background-color: #dc2626;
  color: white;
  font-weight: 700;
  padding: 1rem;
  border-radius: 0.5rem;
  border: none;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.2s, transform 0.2s;
  box-shadow: 0 4px 6px -1px rgba(220, 38, 38, 0.2);
}

.pay-button:hover {
  background-color: #b91c1c;
  transform: translateY(-1px);
}
.pay-button:active {
  transform: translateY(0);
}

.pay-agreement {
  font-size: 0.75rem;
  color: #9ca3af;
  margin-top: 0.75rem;
}
.pay-agreement a {
  color: #6b7280;
  text-decoration: underline;
}

.security-bar {
  background: #1f2937;
  color: #fff;
  padding: 1rem;
  text-align: center;
  font-size: 0.75rem;
}
.security-bar i {
  color: #4ade80;
  margin-right: 0.5rem;
}

/* 弹窗样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(2px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-box {
  background: #fff;
  width: 100%;
  max-width: 400px;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  animation: slide-up 0.3s ease-out;
}

@keyframes slide-up {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #f3f4f6;
}

.modal-header h3 {
  margin: 0;
  font-size: 1rem;
  color: #1f2937;
}

.close-btn {
  background: none;
  border: none;
  font-size: 1.5rem;
  color: #9ca3af;
  cursor: pointer;
  line-height: 1;
}

.modal-content {
  padding: 2rem;
  text-align: center;
  min-height: 250px; /* 保证高度一致，避免加载时抖动 */
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.pay-amount-display {
  font-size: 2.5rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0 0 0.5rem 0;
}

.pay-desc {
  font-size: 0.875rem;
  color: #6b7280;
  margin-bottom: 2rem;
}

/* 6位密码输入框样式 */
.password-input-wrapper {
  display: flex;
  gap: 10px;
  justify-content: center;
  position: relative;
  cursor: text;
}

.password-box {
  width: 45px;
  height: 45px;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  transition: border-color 0.2s;
}

.password-input-wrapper:hover .password-box {
  border-color: #9ca3af;
}

.dot {
  width: 10px;
  height: 10px;
  background: #1f2937;
  border-radius: 50%;
}

.hidden-input {
  position: absolute;
  opacity: 0;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

/* 加载动画样式 */
.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.spinner {
  width: 50px;
  height: 50px;
  border: 4px solid #f3f4f6;
  border-top: 4px solid #dc2626;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 1.5rem;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.loading-text {
  font-size: 1rem;
  color: #6b7280;
  font-weight: 500;
}

/* 响应式调整 */
@media (max-width: 992px) {
  .main-card {
    flex-direction: column;
    height: auto;
  }
  .right-column {
    width: 100%;
    border-left: none;
    border-top: 1px solid #e5e7eb;
  }
  .left-column {
    padding: 2rem;
  }
}
</style>
