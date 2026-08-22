<template>
  <div class="settlement-page">
    <nav class="navbar">
      <div class="nav-content">
        <div class="brand">支付结算</div>
        <div class="steps">
          <span class="step active">确认订单</span>
          <span class="step">支付</span>
          <span class="step">完成</span>
        </div>
      </div>
    </nav>

    <div class="container">
      <el-row :gutter="20" class="layout">
      <el-col :xs="24" :lg="16" class="content-col">
        <el-card class="block-card" shadow="never">
          <template #header>
            <div class="card-header">
              <div>
                <div class="card-title">确认您的订单</div>
                <div class="card-subtitle">请核对收货信息与商品数量</div>
              </div>
            </div>
          </template>

          <div class="section">
            <div class="section-title">到场信息</div>
            <ReceiptInformation v-model="selectedReceipt" />
            <el-form label-width="90px" class="mt-16">
              <el-form-item label="订单备注">
                <el-input
                  v-model="remark"
                  type="textarea"
                  :rows="2"
                  placeholder="如需现场核验说明，请在此填写"
                  maxlength="100"
                  show-word-limit
                />
              </el-form-item>
            </el-form>
          </div>

          <el-divider />

          <div class="section">
            <div class="section-title">支付方式</div>
            <el-radio-group v-model="payType" class="pay-group">
              <el-card
                v-for="(method, index) in paymentMethods"
                :key="index"
                class="pay-card"
                :class="{ active: payType === index }"
                shadow="hover"
                @click="payType = index"
              >
                <div class="pay-card-body">
                  <div class="pay-card-title">{{ method.name }}</div>
                  <div class="pay-card-desc">{{ method.desc }}</div>
                  <el-radio :label="index" class="pay-radio" />
                </div>
              </el-card>
            </el-radio-group>
          </div>

          <el-divider />

          <div class="section">
            <div class="section-title">商品清单</div>
            <el-empty v-if="!products.length" description="暂无商品" />
            <el-space v-else direction="vertical" fill size="medium">
              <el-card
                v-for="(item, index) in products"
                :key="item.goodid"
                class="product-card"
                shadow="never"
              >
                <div class="product-row">
                  <div class="product-thumb">
                    <ImageView v-model="item.picture" />
                  </div>
                  <div class="product-info">
                    <div class="product-name">{{ item.goodname }}</div>
                    <div class="product-meta">
                      <span v-if="item.fenlei">分类：{{ item.fenlei }}</span>
                      <span v-if="item.shangjiazhanghao"
                        >店铺：{{ item.shangjiazhanghao }}</span
                      >
                    </div>
                    <div class="product-price">¥{{ item.price }}</div>
                  </div>
                  <div class="product-ops">
                    <el-input-number
                      v-model="item.buynumber"
                      :min="1"
                      :max="maximumNumber"
                      @change="() => validateQuantity(index)"
                      size="small"
                    />
                    <div class="product-subtotal">
                      小计：¥{{ (item.price * item.buynumber).toFixed(2) }}
                    </div>
                  </div>
                </div>
              </el-card>
            </el-space>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :lg="8" class="summary-col">
        <el-card class="summary-card" shadow="hover">
          <template #header>
            <div class="card-title">订单总览</div>
          </template>
          <div class="summary-line">
            <span>商品总价</span>
            <span>¥{{ totalPayable.toFixed(2) }}</span>
          </div>
          <div class="summary-line">
            <span>运费</span>
            <span>¥0.00</span>
          </div>
          <div class="summary-line is-muted">
            <span>账户余额</span>
            <span>¥{{ accountBalance.toFixed(2) }}</span>
          </div>
          <el-divider />
          <div class="summary-line total">
            <span>应付总额</span>
            <span class="summary-amount">¥{{ totalPayable.toFixed(2) }}</span>
          </div>
          <el-button
            type="primary"
            class="w-100 mt-16"
            size="large"
            @click="confirmPay"
          >
            立即支付
          </el-button>
        </el-card>
      </el-col>
      </el-row>
    </div>

    <el-dialog
      v-model="showConfirmDialog"
      title="请确认支付信息"
      width="500px"
      destroy-on-close
    >
      <el-descriptions :column="1" size="small" border>
        <el-descriptions-item label="联系人">{{
          consignee
        }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ tel }}</el-descriptions-item>
        <el-descriptions-item label="到场地点">{{
          address
        }}</el-descriptions-item>
        <el-descriptions-item label="支付方式">
          {{ paymentMethods[payType]?.name }}
        </el-descriptions-item>
        <el-descriptions-item label="支付金额">
          <span class="summary-amount">¥{{ totalPayable.toFixed(2) }}</span>
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <el-button @click="cancelPay">取消</el-button>
        <el-button type="primary" @click="submitOrder">确认支付</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, ref, watch } from "vue";
import { useRouter } from "vue-router";
import requestApi from "@/utils/axios.js";
import { GetUserId, getUserData } from "@/utils/auth";
import { useDataStore } from "@/utils/dataStore";
import Message from "@/components/MessageBox/index.js";

// 业务组件
import ReceiptInformation from "@/components/ReceiptInformation/index.vue";
import ImageView from "@/components/ImageView/index.vue";

const store = useDataStore();
const router = useRouter();

const consignee = ref("");
const tel = ref("");
const address = ref("");
const remark = ref("");
const payType = ref(0);
const selectedReceipt = ref(null);

const goodsList = ref();
const userId = ref(null);
const accountBalance = ref(0);
const maximumNumber = ref(99);
const products = ref([]);
const showConfirmDialog = ref(false);

const paymentMethods = ref([
  { name: "余额支付", desc: "使用账户余额快速支付", value: 0 },
]);

onMounted(async () => {
  userId.value = await GetUserId();
  goodsList.value = store.sharedData;
  dataProcessing(goodsList.value || []);
  getBalance();
});

const getBalance = async () => {
  const userdata = await getUserData();
  accountBalance.value = Number(userdata.money || 0);
};

// 统一商品字段，便于下单
const dataProcessing = (dataArray) => {
  products.value = [];
  dataArray.forEach((item) => {
    products.value.push({
      userid: userId.value,
      goodid: item.goodid || item.id,
      goodname: item.goodname || item.name || item.title,
      picture:
        item.picture || item.img || item.img_url || item.imgUrl || item.photo,
      buynumber: item.buynumber || 1,
      price: item.price || item.price_now || item.price_old || 0,
      total:
        (item.price || item.price_now || item.price_old || 0) *
        (item.buynumber || 1),
      discounttotal: item.discounttotal || 0,
      type: payType.value,
      status: "待支付",
      address: address.value,
      tel: tel.value,
      consignee: consignee.value,
      remark: remark.value,
      shangjiazhanghao:
        item.shangjiazhanghao || item.addusername || item.username,
      fenlei: item.fenlei || item.classification,
    });
  });
};

watch(selectedReceipt, (newAddress) => {
  if (newAddress) {
    consignee.value = newAddress.name;
    tel.value = newAddress.phone;
    address.value = newAddress.address;
  }
});

const totalPayable = computed(() =>
  products.value.reduce((sum, item) => sum + item.price * item.buynumber, 0)
);

function validateQuantity(index) {
  const product = products.value[index];
  if (!product.buynumber || product.buynumber < 1) {
    product.buynumber = 1;
  } else if (product.buynumber > maximumNumber.value) {
    product.buynumber = maximumNumber.value;
  }
}

function confirmPay() {
  if (!consignee.value || !tel.value || !address.value) {
    Message.warning("请填写完整的到场信息");
    return;
  }
  showConfirmDialog.value = true;
}

function cancelPay() {
  showConfirmDialog.value = false;
}

// 提交订单
async function submitOrder() {
  const tablename = "orders";
  const orderData = products.value.map((item) => ({
    tablename,
    userid: userId.value,
    goodid: item.goodid,
    goodname: item.goodname,
    picture: item.picture,
    buynumber: item.buynumber,
    price: item.price,
    total: item.price * item.buynumber,
    discounttotal: item.discounttotal || 0,
    type: payType.value,
    status: "待支付",
    address: address.value,
    tel: tel.value,
    consignee: consignee.value,
    remark: remark.value,
    shangjiazhanghao: item.shangjiazhanghao,
    fenlei: item.fenlei,
  }));

  try {
    if (payType.value == 0 && totalPayable.value > accountBalance.value) {
      Message.warning("账户余额不足，请先充值");
      return;
    }
    const res = await requestApi.post("/api/orders/save", orderData);
    if (res.code != 0) {
      Message.error("支付出现问题，请联系管理员");
      return;
    }
    await requestApi.post("/api/orders/balancePay", res.data);
    showConfirmDialog.value = false;
    Message.success("支付成功");
    setTimeout(() => {
      router.push({ path: "myOrder" });
    }, 500);
  } catch (error) {
    console.error("订单提交失败:", error);
    Message.error("订单提交失败，请重试");
  }
}
</script>

<style scoped>
.settlement-page {
  --primary-color: #ff6b00; /* 活力橙 */
  --primary-hover: #e65100;
  --text-main: #333333;
  --text-secondary: #666666;
  --text-light: #999999;
  --bg-body: #f4f6f9;
  --bg-card: #ffffff;
  --border-color: #e6e6e6;
  --success-color: #52c41a;
  --error-color: #ff4d4f;
  --warning-color: #faad14;
  --radius-md: 12px;
  --radius-sm: 6px;
  --shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
  --shadow-hover: 0 8px 20px rgba(0, 0, 0, 0.06);

  --el-color-primary: var(--primary-color);
  --el-border-color: var(--border-color);
  --el-border-color-light: var(--border-color);

  padding: 0;
  background: var(--bg-body);
  min-height: 100vh;
}

.settlement-page,
.settlement-page * {
  box-sizing: border-box;
}

/* 顶部导航（样式参考：webhtml/支付结算.html） */
.navbar {
  background: var(--bg-card);
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 100;
  height: 64px;
}

.nav-content {
  max-width: 1200px;
  margin: 0 auto;
  height: 100%;
  padding: 0 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.brand {
  font-size: 1.2rem;
  font-weight: 700;
  color: var(--text-main);
}

.steps {
  display: flex;
  gap: 20px;
  font-size: 0.9rem;
  color: var(--text-secondary);
}

.step.active {
  color: var(--primary-color);
  font-weight: 600;
}

/* 页面容器 */
.container {
  max-width: 1200px;
  margin: 30px auto;
  padding: 0 24px;
}

.layout {
  margin: 0;
}

.block-card {
  margin-bottom: 24px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 1rem;
  font-weight: 600;
  color: var(--text-main);
}

.card-subtitle {
  font-size: 13px;
  color: var(--text-secondary);
  margin-top: 4px;
}

.section {
  margin-bottom: 16px;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 12px;
  color: var(--text-main);
}

.mt-16 {
  margin-top: 16px;
}

.pay-group {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 12px;
}

.pay-card {
  cursor: pointer;
  border: 2px solid var(--border-color);
  border-radius: var(--radius-sm);
  box-shadow: none;
  transition: all 0.2s;
}

.pay-card-body {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.pay-card-title {
  font-weight: 600;
  color: var(--text-main);
}

.pay-card-desc {
  font-size: 13px;
  color: var(--text-light);
}

.pay-radio {
  position: absolute;
  top: 0;
  right: 0;
}

.pay-card.active {
  border-color: var(--primary-color);
  background-color: #fffbf6;
}

.pay-card:hover {
  border-color: #d9d9d9;
}

.product-card {
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
}

.product-row {
  display: flex;
  gap: 12px;
  align-items: center;
}

.product-thumb {
  width: 80px;
  height: 80px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f7f7f7;
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.product-info {
  flex: 1;
  min-width: 0;
}

.product-name {
  font-size: 15px;
  font-weight: 600;
}

.product-meta {
  display: flex;
  gap: 12px;
  color: var(--text-secondary);
  font-size: 12px;
  margin: 4px 0;
}

.product-price {
  color: var(--text-main);
  font-weight: 600;
}

.product-ops {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 8px;
}

.product-subtotal {
  color: var(--primary-color);
  font-weight: 600;
}

.summary-card {
  position: sticky;
  top: 84px;
}

.summary-line {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  color: var(--text-secondary);
}

.summary-line.is-muted {
  color: var(--text-secondary);
}

.summary-line.total {
  font-weight: 700;
  font-size: 16px;
}

.summary-amount {
  color: var(--primary-color);
  font-weight: 700;
}

.w-100 {
  width: 100%;
  border-radius: 30px;
  font-weight: 600;
  box-shadow: 0 4px 10px rgba(255, 107, 0, 0.3);
  background: var(--primary-color) !important;
  border-color: var(--primary-color) !important;
}

.w-100:hover:not(:disabled) {
  background: var(--primary-hover) !important;
  border-color: var(--primary-hover) !important;
  transform: translateY(-1px);
  box-shadow: 0 6px 15px rgba(255, 107, 0, 0.4);
}

@media (max-width: 992px) {
  .summary-card {
    position: static;
    margin-top: 12px;
  }
}

@media (min-width: 1200px) {
  .summary-col {
    flex: 0 0 380px;
    max-width: 380px;
  }

  .content-col {
    flex: 1 1 auto;
    max-width: calc(100% - 404px);
  }
}

/* Element Plus 卡片内边距对齐原型 */
.block-card,
.summary-card {
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow);
}

.summary-card {
  box-shadow: var(--shadow-hover);
}

.block-card :deep(.el-card__header),
.summary-card :deep(.el-card__header) {
  padding: 16px 24px;
  border-bottom: 1px solid var(--border-color);
}

.block-card :deep(.el-card__body),
.summary-card :deep(.el-card__body) {
  padding: 24px;
}
</style>
