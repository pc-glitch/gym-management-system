<template>
  <div class="order-details-page">
    <el-skeleton v-if="loading" :rows="6" animated />

    <el-result
      v-else-if="!orderData"
      icon="warning"
      title="未找到订单信息"
      sub-title="请检查订单号是否正确，或稍后再试"
    />

    <div v-else class="content">
      <el-page-header content="订单与核验详情" @back="goBack" />

      <el-card class="status-card" shadow="never">
        <div class="status-left">
          <el-tag :type="statusInfo.tag" effect="dark" size="large">
            {{ orderData.status || "未知状态" }}
          </el-tag>
          <span class="order-id">订单号：{{ orderData.orderid }}</span>
          <el-button
            text
            :icon="DocumentCopy"
            @click="copyToClipboard(orderData.orderid)"
          >
            复制
          </el-button>
        </div>
        <div class="status-right">
            <el-descriptions :column="3" size="small" border>
              <el-descriptions-item label="下单时间">
                {{ orderData.addtime || "-" }}
              </el-descriptions-item>
              <el-descriptions-item label="支付方式">
                {{ orderData.type == "1" ? "在线支付" : "余额支付" }}
              </el-descriptions-item>
              <el-descriptions-item label="订单备注">
                {{ orderData.remark || "无" }}
              </el-descriptions-item>
          </el-descriptions>
        </div>
      </el-card>

      <el-row :gutter="16">
        <el-col :xs="24" :lg="16">
          <el-card shadow="never" class="card">
            <template #header>
              <div class="card-title">商品信息</div>
            </template>
            <div class="product-block">
              <ImageView v-model="orderData.picture" class="product-thumb" />
              <div class="product-info">
                <div class="name">{{ orderData.goodname || "未知商品" }}</div>
                <div class="meta">分类：{{ orderData.fenlei || "无分类" }}</div>
                <div class="meta">
                  商家：{{ orderData.shangjiazhanghao || "未知" }}
                </div>
              </div>
              <div class="price-box">
                <div class="price">¥{{ orderData.price || "0.00" }}</div>
                <div class="qty">x {{ orderData.buynumber || 0 }}</div>
                <div v-if="orderData.discounttotal > 0" class="discount">
                  优惠 -¥{{ orderData.discounttotal }}
                </div>
                <div class="total">合计 ¥{{ orderData.total || "0.00" }}</div>
              </div>
            </div>
          </el-card>

          <el-card shadow="never" class="card">
            <template #header>
              <div class="card-title">服务进度</div>
            </template>
            <div class="logistics">
              <el-timeline v-if="parsedLogistics.length">
                <el-timeline-item
                  v-for="(activity, index) in parsedLogistics"
                  :key="index"
                  :timestamp="activity.time"
                >
                  {{ activity.info }}
                </el-timeline-item>
              </el-timeline>
              <el-empty v-else description="暂无物流信息" :image-size="120" />
            </div>
          </el-card>
        </el-col>

        <el-col :xs="24" :lg="8">
          <el-card shadow="never" class="card">
            <template #header>
              <div class="card-title">联系人信息</div>
            </template>
            <el-descriptions :column="1" size="small" border>
              <el-descriptions-item label="联系人">{{
                orderData.consignee || "-"
              }}</el-descriptions-item>
              <el-descriptions-item label="联系电话">{{
                orderData.tel || "-"
              }}</el-descriptions-item>
              <el-descriptions-item label="到场地点">{{
                orderData.address || "体育馆到场核验"
              }}</el-descriptions-item>
            </el-descriptions>
          </el-card>

          <el-card shadow="never" class="card">
            <template #header>
              <div class="card-title">订单信息</div>
            </template>
            <el-descriptions :column="1" size="small" border>
              <el-descriptions-item label="支付方式">
                {{ orderData.type == "1" ? "在线支付" : "余额支付" }}
              </el-descriptions-item>
              <el-descriptions-item label="订单备注">{{
                orderData.remark || "无"
              }}</el-descriptions-item>
              <el-descriptions-item label="我的评价">{{
                orderData.evaluation || "暂无评价"
              }}</el-descriptions-item>
            </el-descriptions>
          </el-card>

          <div class="action-group">
            <el-button
              v-if="['已支付', '已发货'].includes(orderData.status)"
              type="danger"
              plain
              class="w-100"
              @click="applyRefund"
            >
              申请退款
            </el-button>
            <el-button
              v-if="orderData.status === '退款中'"
              type="warning"
              plain
              class="w-100"
              @click="confirmRefund"
            >
              确认退款到账
            </el-button>
            <el-button
              v-if="orderData.status === '已发货'"
              type="success"
              plain
              class="w-100"
              @click="confirmVerification"
            >
              确认收货
            </el-button>
            <el-button
              v-if="['已收货', '已完成'].includes(orderData.status)"
              type="primary"
              plain
              class="w-100"
              @click="startEvaluation"
            >
              评价订单
            </el-button>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from "vue";
import { useRouter, useRoute } from "vue-router";
import { DocumentCopy } from "@element-plus/icons-vue";
import requestApi from "@/utils/axios";
import Message from "@/components/MessageBox/index.js";
import ImageView from "@/components/ImageView/index.vue";

const router = useRouter();
const route = useRoute();

const orderId = ref(route.query.orderId);
const orderData = ref(null);
const loading = ref(true);

const getOrderDetail = async () => {
  loading.value = true;
  try {
    const res = await requestApi.post(`/api/orders/info`, {
      id: orderId.value,
    });
    orderData.value = res.data;
  } catch (e) {
    console.error("获取订单详情失败", e);
    orderData.value = null;
  } finally {
    loading.value = false;
  }
};

const statusInfo = computed(() => {
  const status = orderData.value?.status;
  if (status === "待支付" || status === "未支付") return { tag: "warning" };
  if (status === "已支付") return { tag: "info" };
  if (status === "已发货") return { tag: "warning" };
  if (status === "已收货" || status === "已完成" || status === "已评价")
    return { tag: "success" };
  if (status === "申请退款" || status === "退款中") return { tag: "danger" };
  if (status === "已退款" || status === "已取消") return { tag: "info" };
  return { tag: "default" };
});

const parsedLogistics = computed(() => {
  if (!orderData.value?.logistics) return [];
  try {
    const arr = JSON.parse(orderData.value.logistics);
    return Array.isArray(arr) ? arr : [];
  } catch (e) {
    console.error("物流字段解析失败", e);
    return [];
  }
});

const goBack = () => router.back();

const copyToClipboard = async (text) => {
  try {
    await navigator.clipboard.writeText(text);
    Message.success("复制成功");
  } catch (err) {
    Message.error("复制失败");
  }
};

const startEvaluation = async () => {
  const evaluation = prompt("请输入评价");
  if (!evaluation) return;
  const res = await requestApi.post("/api/orders/update", {
    id: orderId.value,
    evaluation,
    status: "已评价",
  });
  if (res.code == 0) {
    Message.success("提交成功");
    getOrderDetail();
  }
};

const applyRefund = async () => {
  if (!confirm("是否确认申请退款？")) return;
  const res = await requestApi.post("/api/orders/update", {
    id: orderId.value,
    status: "申请退款",
  });
  if (res.code == 0) {
    Message.success("退款申请已提交");
    getOrderDetail();
  }
};

const confirmRefund = async () => {
  if (!confirm("是否确认已收到退款？")) return;
  await requestApi.post("/api/orders/refund", { id: orderData.value.id });
  const res = await requestApi.post("/api/orders/update", {
    id: orderId.value,
    status: "已退款",
  });
  if (res.code == 0) {
    Message.success("退款已完成");
    getOrderDetail();
  }
};

const confirmVerification = async () => {
  if (!confirm("是否确认已收到商品？")) return;
  const res = await requestApi.post("/api/orders/update", {
    id: orderId.value,
    status: "已收货",
  });
  if (res.code == 0) {
    Message.success("收货完成");
    getOrderDetail();
  }
};

onMounted(() => {
  getOrderDetail(orderId.value);
});
</script>

<style scoped>
.order-details-page {
  padding: 20px;
  background: #f5f7fa;
  min-height: 100vh;
}

.content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.status-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.status-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.order-id {
  color: #606266;
}

.status-right {
  width: 100%;
  margin-top: 12px;
}

.card {
  margin-bottom: 16px;
}

.card-title {
  font-weight: 600;
  color: #303133;
}

.product-block {
  display: grid;
  grid-template-columns: 120px 1fr 180px;
  gap: 12px;
  align-items: center;
}

.product-thumb {
  width: 110px;
  height: 110px;
  border-radius: 6px;
  overflow: hidden;
}

.product-info .name {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.product-info .meta {
  color: #909399;
  margin-top: 4px;
}

.price-box {
  text-align: right;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.price {
  font-size: 18px;
  font-weight: 700;
}

.qty {
  color: #909399;
}

.discount {
  color: #f56c6c;
}

.total {
  font-size: 18px;
  font-weight: 700;
  color: #f56c6c;
}

.logistics {
  max-height: 360px;
  overflow-y: auto;
  padding-right: 8px;
}

.action-group {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: 8px;
}

.w-100 {
  width: 100%;
}

@media (max-width: 768px) {
  .product-block {
    grid-template-columns: 1fr;
  }
}
</style>
