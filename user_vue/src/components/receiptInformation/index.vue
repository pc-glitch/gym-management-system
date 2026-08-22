<template>
  <div class="receipt-information-container">
    <div class="component-header">
      <h5>选择地址</h5>
      <div class="actions">
        <button @click="getAddressList" class="btn-refresh">刷新</button>
        <button @click="handleAddNewAddress" class="btn-add">新增地址</button>
      </div>
    </div>
    <div class="address-scroll-wrapper">
      <div
        v-for="addr in addressList"
        :key="addr.id"
        class="address-card"
        :class="{ selected: selectedAddress && selectedAddress.id === addr.id }"
        @click="handleSelectAddress(addr)"
      >
        <div class="card-header">
          <span class="name">{{ addr.name }}</span>
          <span v-if="addr.isdefault === '是'" class="default-tag">默认</span>
        </div>
        <div
          v-if="selectedAddress && selectedAddress.id === addr.id"
          class="selected-tick"
        >
          ✓
        </div>
        <div class="card-body">
          <p class="phone">{{ addr.phone }}</p>
          <p class="address">{{ addr.address }}</p>
        </div>
      </div>
      <p v-if="!addressList.length" class="no-address-tip">
        没有可用的收货地址。
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import requestApi from "@/utils/axios.js"; // 确保路径正确
import { getUserData } from "@/utils/auth.js";
import { useRouter, useRoute } from "vue-router";
const router = useRouter();
const route = useRoute();

// --- v-model ---
const props = defineProps({
  modelValue: {
    type: Object,
    default: null,
  },
});

const emit = defineEmits(["update:modelValue"]);

const selectedAddress = computed({
  get: () => props.modelValue,
  set: (value) => {
    emit("update:modelValue", value);
  },
});
// --- v-model end ---

const addressList = ref([]);

// 获取地址列表
const getAddressList = async () => {
  try {
    const userData = await getUserData();
    const userid = userData?.userid || userData?.id;

    if (!userid) {
      // alert("请先登录"); // 最好由父组件处理未登录状态
      return;
    }

    const res = await requestApi.post("/api/address/list", { userid });

    if (res?.code == 0 && Array.isArray(res.data)) {
      addressList.value = res.data;
    } else {
      console.error("获取地址列表失败:", res?.msg || "返回数据格式不正确");
      addressList.value = []; // 清空旧数据
    }
  } catch (error) {
    console.error("请求地址列表异常:", error);
    addressList.value = []; // 请求异常时清空
  }

  // 更新逻辑：在获取数据后，统一处理默认选中
  // 仅在父组件未提供有效选中值(selectedAddress.value 为 null 或 undefined)
  // 并且地址列表不为空时，才设置默认值
  if (!selectedAddress.value && addressList.value.length > 0) {
    const defaultAddress = addressList.value.find(
      (addr) => addr.isdefault === "是"
    );
    // 使用 v-model 的 set 方法来更新值并触发 emit
    const addressToSelect = defaultAddress || addressList.value[0];
    if (addressToSelect) {
      selectedAddress.value = addressToSelect;
    }
  }
};

// 点击卡片时，更新选中的地址
const handleSelectAddress = (address) => {
  selectedAddress.value = address;
};

// 点击新增地址时，通知父组件
const handleAddNewAddress = () => {
  router.push({ path: "addressList" });
};

// 组件挂载后执行
onMounted(() => {
  getAddressList();
});
</script>

<style scoped>
.receipt-information-container {
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
}

.component-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.component-header h5 {
  margin: 0;
  font-size: 16px;
  color: #333;
}

.component-header .actions {
  display: flex;
  gap: 10px;
}

.actions button {
  padding: 5px 15px;
  border-radius: 4px;
  cursor: pointer;
  border: 1px solid #dcdfe6;
  background-color: #fff;
  transition: all 0.2s ease;
}
.actions button:hover {
  border-color: #409eff;
  color: #409eff;
}

.actions .btn-add {
  background-color: #409eff;
  color: white;
  border-color: #409eff;
}
.actions .btn-add:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
  color: white;
}

.address-scroll-wrapper {
  display: flex;
  overflow-x: auto;
  padding-bottom: 15px; /* 为滚动条留出空间 */
  gap: 15px; /* 卡片之间的间距 */
  padding-top: 15px;
}

/* 美化滚动条 */
.address-scroll-wrapper::-webkit-scrollbar {
  height: 6px;
}
.address-scroll-wrapper::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}
.address-scroll-wrapper::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 3px;
}
.address-scroll-wrapper::-webkit-scrollbar-thumb:hover {
  background: #aaa;
}

.address-card {
  flex: 0 0 280px; /* 固定宽度，不缩放不增长 */
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  padding: 15px;
  cursor: pointer;
  transition: all 0.3s ease;
  background-color: #fff;
  position: relative; /* 为绝对定位的 tick 做准备 */
}

.address-card:hover {
  border-color: #409eff;
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.address-card.selected {
  border: 2px solid #ff4500; /* 更显眼的边框颜色 */
  background-color: #fff5e6; /* 更鲜明的背景色 */
  box-shadow: 0 6px 16px rgba(255, 69, 0, 0.3); /* 更强的阴影 */
  transform: translateY(-5px); /* 向上浮动更明显 */
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  padding-bottom: 10px;
  border-bottom: 1px solid #f0f0f0;
}

.name {
  font-weight: bold;
  font-size: 16px;
  color: #333;
}

.default-tag {
  background-color: #f56c6c;
  color: white;
  padding: 3px 8px;
  margin-right: 30px;
  font-size: 12px;
  border-radius: 4px;
}

.card-body p {
  margin: 5px 0;
  font-size: 14px;
  color: #666;
  line-height: 1.5;
}

.no-address-tip {
  width: 100%;
  text-align: center;
  color: #999;
  padding: 20px;
}

.selected-tick {
  position: absolute;
  top: 10px;
  right: 10px;
  width: 24px;
  height: 24px;
  background-color: #ff4500;
  color: white;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 16px;
  font-weight: bold;
}
</style>
