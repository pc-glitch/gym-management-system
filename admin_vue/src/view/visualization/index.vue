<template>
  <div class="dashboard-page">
    <div class="summary-grid">
      <div class="summary-card">
        <div class="summary-title">场地预约总数</div>
        <div class="summary-value">{{ stats.totalReservations }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-title">赛事报名总数</div>
        <div class="summary-value">{{ stats.totalRegistrations }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-title">商城订单总数</div>
        <div class="summary-value">{{ stats.totalOrders }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-title">器材总数</div>
        <div class="summary-value">{{ stats.totalEquipment }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-title">器材剩余数量</div>
        <div class="summary-value">{{ stats.remainingEquipment }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-title">器材租借数量</div>
        <div class="summary-value">{{ stats.rentedEquipment }}</div>
      </div>
    </div>
    <div class="chart-grid">
      <div class="chart-card">
        <div class="chart-title">场地预约统计</div>
        <div ref="venueChartRef" class="chart-box"></div>
      </div>
      <div class="chart-card">
        <div class="chart-title">预约审核分布</div>
        <div ref="auditChartRef" class="chart-box"></div>
      </div>
      <div class="chart-card">
        <div class="chart-title">订单状态分布</div>
        <div ref="orderChartRef" class="chart-box"></div>
      </div>
      <div class="chart-card">
        <div class="chart-title">器材状态分布</div>
        <div ref="equipmentChartRef" class="chart-box"></div>
      </div>
    </div>
  </div>
</template>

<script setup>
import * as echarts from "echarts";
import requestApi from "@/utils/axios";
import { onMounted, onUnmounted, reactive, ref } from "vue";

const venueChartRef = ref(null);
const auditChartRef = ref(null);
const orderChartRef = ref(null);
const equipmentChartRef = ref(null);
const chartInstances = [];

const stats = reactive({
  totalReservations: 0,
  totalRegistrations: 0,
  totalOrders: 0,
  totalEquipment: 0,
  remainingEquipment: 0,
  rentedEquipment: 0,
  currentMonthReservations: 0,
});

const fetchAllRecords = async (url, extraParams = {}) => {
  const limit = 200;
  let page = 1;
  let list = [];
  let hasNext = true;
  while (hasNext) {
    const res = await requestApi.post(url, {
      page,
      limit,
      order: "addtime",
      ...extraParams,
    });
    const currentList = res?.data?.list || [];
    list = list.concat(currentList);
    if (currentList.length < limit) {
      hasNext = false;
    } else {
      page += 1;
    }
  }
  return list;
};

const groupCount = (list, keyGetter) => {
  const map = {};
  list.forEach((item) => {
    const key = keyGetter(item) || "未分类";
    map[key] = (map[key] || 0) + 1;
  });
  return Object.entries(map).map(([name, value]) => ({ name, value }));
};

const buildVenueChart = (data) => {
  const chart = echarts.init(venueChartRef.value);
  chart.setOption({
    tooltip: { trigger: "axis" },
    grid: { left: "4%", right: "4%", bottom: "4%", containLabel: true },
    xAxis: {
      type: "category",
      data: data.map((item) => item.name),
      axisLabel: { interval: 0, rotate: data.length > 6 ? 25 : 0 },
    },
    yAxis: { type: "value", minInterval: 1 },
    series: [
      {
        name: "预约数",
        type: "bar",
        data: data.map((item) => item.value),
        itemStyle: { color: "#409EFF", borderRadius: [8, 8, 0, 0] },
        label: { show: true, position: "top" },
      },
    ],
  });
  chartInstances.push(chart);
};

const buildAuditChart = (data) => {
  const chart = echarts.init(auditChartRef.value);
  chart.setOption({
    tooltip: { trigger: "item" },
    legend: { top: "bottom" },
    series: [
      {
        type: "pie",
        radius: ["40%", "65%"],
        data,
        label: { formatter: "{b}\n{c}" },
      },
    ],
  });
  chartInstances.push(chart);
};

const buildOrderChart = (data) => {
  const chart = echarts.init(orderChartRef.value);
  const colors = ["#5470c6", "#91cc75", "#fac858", "#ee6666", "#73c0de", "#3ba272", "#fc8452", "#9a60b4"];
  chart.setOption({
    tooltip: { 
      trigger: "item",
      formatter: "{b}: {c} ({d}%)"
    },
    legend: { 
      top: "bottom",
      itemWidth: 12,
      itemHeight: 12,
      textStyle: { fontSize: 12 }
    },
    series: [
      {
        type: "pie",
        radius: ["35%", "60%"],
        center: ["50%", "45%"],
        avoidLabelOverlap: false,
        itemStyle: {
          borderRadius: 6,
          borderColor: "#fff",
          borderWidth: 2
        },
        label: { 
          show: true,
          formatter: "{b}\n{c}",
          fontSize: 12
        },
        labelLine: {
          smooth: true,
          length: 10,
          length2: 5
        },
        data: data.map((item, index) => ({
          ...item,
          itemStyle: { color: colors[index % colors.length] }
        })),
      },
    ],
  });
  chartInstances.push(chart);
};

const buildEquipmentChart = (data) => {
  const chart = echarts.init(equipmentChartRef.value);
  const colors = ["#5470c6", "#91cc75", "#fac858", "#ee6666", "#73c0de", "#3ba272", "#fc8452", "#9a60b4"];
  chart.setOption({
    tooltip: { 
      trigger: "axis",
      axisPointer: { type: "shadow" }
    },
    legend: { 
      data: ["数量", "已借数量", "剩余数量"],
      top: "bottom",
      itemWidth: 12,
      itemHeight: 12,
      textStyle: { fontSize: 12 }
    },
    grid: { 
      left: "4%", 
      right: "4%", 
      bottom: "15%", 
      containLabel: true 
    },
    xAxis: {
      type: "category",
      data: data.map((item) => item.name),
      axisLabel: { 
        interval: 0, 
        rotate: data.length > 5 ? 30 : 0,
        fontSize: 11
      },
      axisTick: { alignWithLabel: true }
    },
    yAxis: { type: "value", minInterval: 1 },
    series: [
      {
        name: "数量",
        type: "bar",
        barWidth: "20%",
        data: data.map((item) => item.quantity),
        itemStyle: { color: colors[0], borderRadius: [4, 4, 0, 0] },
      },
      {
        name: "已借数量",
        type: "bar",
        barWidth: "20%",
        data: data.map((item) => item.borrowedquantity),
        itemStyle: { color: colors[2], borderRadius: [4, 4, 0, 0] },
      },
      {
        name: "剩余数量",
        type: "bar",
        barWidth: "20%",
        data: data.map((item) => item.remainingquantity),
        itemStyle: { color: colors[1], borderRadius: [4, 4, 0, 0] },
      },
    ],
  });
  chartInstances.push(chart);
};

const handleResize = () => {
  chartInstances.forEach((chart) => chart.resize());
};

const statusMap = {
  "待核验": "已发货",
  "已核验": "已收货",
};

const getOrderStatus = (status) => {
  return statusMap[status] || status || "待处理";
};

const getData = async () => {
  const [reservations, registrations, orders, equipment] = await Promise.all([
    fetchAllRecords("/api/venuereservation/page"),
    fetchAllRecords("/api/eventregistration/page"),
    fetchAllRecords("/api/orders/page"),
    fetchAllRecords("/api/equipment/page"),
  ]);

  stats.totalReservations = reservations.length;
  stats.totalRegistrations = registrations.length;
  stats.totalOrders = orders.length;
  stats.totalEquipment = equipment.reduce((sum, item) => sum + Number(item.quantity || 0), 0);
  stats.rentedEquipment = equipment.reduce((sum, item) => sum + Number(item.borrowedquantity || 0), 0);
  stats.remainingEquipment = equipment.reduce((sum, item) => sum + Number(item.remainingquantity || 0), 0);

  const now = new Date();
  const currentMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  stats.currentMonthReservations = reservations.filter((item) =>
    String(item.addtime || "").startsWith(currentMonth)
  ).length;

  const venueStats = groupCount(reservations, (item) => item.name).sort(
    (a, b) => b.value - a.value
  );
  const auditStats = groupCount(
    reservations,
    (item) => item.shenhe || "待审核"
  ).sort((a, b) => b.value - a.value);
  const orderStats = groupCount(
    orders,
    (item) => getOrderStatus(item.status)
  ).sort((a, b) => b.value - a.value);
  const equipmentStats = equipment.map((item) => ({
    name: item.name || item.equipmentno || "未知器材",
    quantity: Number(item.quantity || 0),
    borrowedquantity: Number(item.borrowedquantity || 0),
    remainingquantity: Number(item.remainingquantity || 0),
  })).sort((a, b) => b.quantity - a.quantity).slice(0, 8);

  buildVenueChart(venueStats.slice(0, 12));
  buildAuditChart(auditStats);
  buildOrderChart(orderStats);
  buildEquipmentChart(equipmentStats);
};

onMounted(async () => {
  await getData();
  window.addEventListener("resize", handleResize);
});

onUnmounted(() => {
  window.removeEventListener("resize", handleResize);
  while (chartInstances.length) {
    const chart = chartInstances.pop();
    chart.dispose();
  }
});
</script>

<style scoped>
.dashboard-page {
  padding: 20px;
  background: #f5f7fa;
  min-height: 100vh;
}

.summary-grid {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 16px;
  margin-bottom: 16px;
}

.summary-card {
  background: #fff;
  border-radius: 10px;
  padding: 18px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.summary-title {
  color: #909399;
  font-size: 13px;
}

.summary-value {
  margin-top: 10px;
  font-size: 30px;
  line-height: 1;
  color: #303133;
  font-weight: 700;
}

.chart-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}

.chart-card {
  background: #fff;
  border-radius: 10px;
  padding: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.chart-title {
  font-size: 15px;
  font-weight: 600;
  color: #303133;
}

.chart-box {
  height: 360px;
}

@media (max-width: 1200px) {
  .summary-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  .chart-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .summary-grid {
    grid-template-columns: 1fr;
  }
  .chart-box {
    height: 320px;
  }
}
</style>
