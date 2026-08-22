<template>
  <div class="orders-page">
    <el-card class="filter-card" shadow="never">
      <template #header>
        <div class="card-header">
          <div>
            <div class="title">订单筛选</div>
            <div class="sub-title">按条件查找我的订单</div>
          </div>
          <el-space>
            <el-button type="primary" :icon="Search" @click="handleSearch"
              >查询</el-button
            >
            <el-button :icon="Refresh" @click="handleReset">重置</el-button>
          </el-space>
        </div>
      </template>

      <el-form
        :model="searchForm"
        label-width="80px"
        inline
        class="filter-form"
      >
        <el-form-item label="商品名称">
          <el-input
            v-model="searchForm.goodname"
            placeholder="输入商品关键词"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-form-item>
        <el-form-item label="联系人">
          <el-input
            v-model="searchForm.consignee"
            placeholder="输入联系人"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input
            v-model="searchForm.tel"
            placeholder="输入手机号"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-form-item>
        <el-form-item label="订单状态">
          <el-select v-model="searchForm.status" placeholder="全部" clearable>
            <el-option label="全部" value="" />
            <el-option
              v-for="s in uniqueStatuses"
              :key="s"
              :label="s"
              :value="s"
            />
          </el-select>
        </el-form-item>
      </el-form>
    </el-card>

    <div class="list-section">
      <el-skeleton v-if="loading" :rows="6" animated />

      <el-row v-else-if="filteredOrders.length" :gutter="16">
        <el-col
          v-for="order in filteredOrders"
          :key="order.id"
          :xs="24"
          :sm="24"
          :md="12"
          :lg="12"
        >
          <el-card shadow="hover" class="order-card">
            <div class="order-card__header">
              <div class="order-meta">
                <span class="order-id">订单号：{{ order.orderid }}</span>
                <span class="order-time">下单时间：{{ order.addtime }}</span>
              </div>
              <el-tag :type="statusTag(order.status)" effect="light">
                {{ order.status || "未知状态" }}
              </el-tag>
            </div>
            <div class="order-card__body">
              <ImageView v-model="order.picture" class="thumb" />
              <div class="info">
                <div class="name">{{ order.goodname }}</div>
                <div class="sub">分类：{{ order.fenlei || "暂无分类" }}</div>
                <div class="ship">
                  <span>{{ order.consignee }}</span>
                  <span>{{ order.tel }}</span>
                  <span>{{ order.address || "体育馆到场核验" }}</span>
                </div>
              </div>
              <div class="price">
                <div class="now">¥{{ order.price }}</div>
                <div class="qty">x {{ order.buynumber }}</div>
              </div>
              <div class="total">
                <div class="label">合计</div>
                <div class="amount">¥{{ order.total }}</div>
                <el-button type="primary" link @click="orderDetails(order)">
                  查看详情
                </el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <el-empty v-else description="未找到相关订单" :image-size="160" />
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from "vue";
import { useRouter, useRoute } from "vue-router";
import { Search, Refresh } from "@element-plus/icons-vue";
import requestApi from "@/utils/axios";
import ImageView from "@/components/ImageView/index.vue";
import { GetUserId, getUserData } from "@/utils/auth";

const searchForm = ref({
  goodname: "",
  consignee: "",
  tel: "",
  status: "",
});

const router = useRouter();
const route = useRoute();

const orderList = ref([]);
const loading = ref(true);

const fetchOrders = async () => {
  loading.value = true;
  searchForm.value.userid = await GetUserId();
  try {
    const { code, data } = await requestApi.post(
      "/api/orders/list",
      searchForm.value
    );
    if (code == 0) {
      orderList.value = (data || []).slice().reverse();
    }
  } catch (error) {
    console.error("获取订单数据失败:", error);
  } finally {
    loading.value = false;
  }
};

const handleSearch = () => fetchOrders();
const handleReset = () => {
  searchForm.value = { goodname: "", consignee: "", tel: "", status: "" };
  fetchOrders();
};

const statusTag = (status) => {
  if (status === "待支付" || status === "未支付") return "warning";
  if (status === "已支付") return "info";
  if (status === "已发货") return "warning";
  if (status === "已收货" || status === "已完成" || status === "已评价")
    return "success";
  if (status === "申请退款" || status === "退款中") return "danger";
  if (status === "已退款" || status === "已取消") return "info";
  return "default";
};

const filteredOrders = computed(() => {
  return orderList.value.filter((order) => {
    const nameMatch = searchForm.value.goodname
      ? order.goodname?.includes(searchForm.value.goodname)
      : true;
    const consigneeMatch = searchForm.value.consignee
      ? order.consignee?.includes(searchForm.value.consignee)
      : true;
    const telMatch = searchForm.value.tel
      ? order.tel?.includes(searchForm.value.tel)
      : true;
    const statusMatch = searchForm.value.status
      ? order.status === searchForm.value.status
      : true;
    return nameMatch && consigneeMatch && telMatch && statusMatch;
  });
});

const uniqueStatuses = computed(() => {
  const statuses = new Set(
    orderList.value.map((order) => order.status).filter(Boolean)
  );
  return Array.from(statuses);
});

const orderDetails = (order) => {
  router.push({
    path: "orderDetails",
    query: { orderId: order.id },
  });
};

onMounted(fetchOrders);
</script>

<style scoped>
.orders-page {
  padding: 20px;
  background: #f5f7fa;
  min-height: 100vh;
}

.filter-card {
  margin-bottom: 16px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.title {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
}

.sub-title {
  font-size: 12px;
  color: #909399;
}

.filter-form {
  margin-top: 12px;
}

.list-section {
  max-width: 1200px;
  margin: 0 auto;
}

.order-card {
  margin-bottom: 16px;
}

.order-card__header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.order-meta {
  display: flex;
  gap: 12px;
  color: #606266;
  font-size: 13px;
}

.order-card__body {
  display: grid;
  grid-template-columns: 120px 1fr 120px 140px;
  gap: 12px;
  align-items: center;
}

.thumb {
  width: 110px;
  height: 110px;
  border-radius: 6px;
  overflow: hidden;
}

.info .name {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.info .sub {
  color: #909399;
  margin: 4px 0;
}

.info .ship {
  display: flex;
  flex-direction: column;
  gap: 4px;
  color: #606266;
  font-size: 13px;
}

.price {
  text-align: right;
  color: #303133;
}

.price .now {
  font-size: 18px;
  font-weight: 700;
}

.price .qty {
  color: #909399;
}

.total {
  text-align: right;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.total .label {
  color: #909399;
}

.total .amount {
  color: #f56c6c;
  font-size: 18px;
  font-weight: 700;
}

@media (max-width: 768px) {
  .order-card__body {
    grid-template-columns: 1fr;
    grid-template-rows: repeat(4, auto);
  }
  .order-meta {
    flex-direction: column;
    align-items: flex-start;
  }
  .total {
    align-items: flex-start;
  }
}
</style>
