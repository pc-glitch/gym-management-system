<template>
  <div class="address-page">
    <!-- 顶部导航（样式参考：webhtml/地址列表.html） -->
    <nav class="navbar">
      <div class="nav-content">
        <el-button link class="back-link" @click.prevent="handleBack">
          返回
        </el-button>
        <div class="page-title">地址管理</div>
        <el-button type="primary" @click="openAddressDialog('add')">
          新增地址
        </el-button>
      </div>
    </nav>

    <div class="container">
      <div class="header-actions">
        <div>
          <div class="title">我的收货地址</div>
          <div class="sub">管理常用地址，支持快捷设为默认</div>
        </div>
        <el-button type="primary" @click="openAddressDialog('add')">
          新增地址
        </el-button>
      </div>

      <el-skeleton v-if="loading" :rows="4" animated />

      <template v-else>
        <el-empty
          v-if="!addressList.length"
          description="暂无收货地址"
          :image-size="140"
        >
          <el-button type="primary" @click="openAddressDialog('add')">
            新增地址
          </el-button>
        </el-empty>

        <div v-else class="address-grid">
          <div
            v-for="addr in addressList"
            :key="addr.id"
            :class="['addr-card', { default: addr.isdefault === '是' }]"
          >
            <div v-if="addr.isdefault === '是'" class="badge-default">默认</div>

            <div class="card-top">
              <div class="user-info">
                <span>{{ addr.name }}</span>
              </div>
              <div class="user-phone">{{ addr.phone }}</div>
            </div>

            <div class="addr-text">{{ addr.address }}</div>

            <div class="actions">
              <el-button link type="primary" @click="openAddressDialog('edit', addr)">
                修改
              </el-button>
              <el-popconfirm
                title="确定删除该地址吗？"
                confirm-button-text="删除"
                cancel-button-text="取消"
                confirm-button-type="danger"
                @confirm="handleDeleteAddress(addr.id)"
              >
                <template #reference>
                  <el-button link type="danger">删除</el-button>
                </template>
              </el-popconfirm>
            </div>
          </div>
        </div>
      </template>
    </div>

    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="520px"
      destroy-on-close
    >
      <el-form :model="form" :rules="rules" ref="formRef" label-width="90px">
        <el-form-item label="收货人" prop="name">
          <el-input v-model="form.name" placeholder="请输入收货人姓名" />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入手机号" />
        </el-form-item>
        <el-form-item label="所在地区" prop="firstAddress">
          <AddressSelector v-model="form.firstAddress" />
        </el-form-item>
        <el-form-item label="详细地址" prop="secondAddress">
          <el-input
            v-model="form.secondAddress"
            type="textarea"
            :rows="2"
            placeholder="街道、门牌号等"
          />
        </el-form-item>
        <el-form-item>
          <el-checkbox v-model="isDefault">设为默认地址</el-checkbox>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSaveAddress">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import requestApi from "@/utils/axios.js";
import { getUserData } from "@/utils/auth.js";
import Message from "@/components/MessageBox/index.js";
import AddressSelector from "@/components/AddressSelector/index.vue";

const addressList = ref([]);
const loading = ref(true);

const dialogVisible = ref(false);
const dialogType = ref("add");
const dialogTitle = computed(() =>
  dialogType.value === "add" ? "新增收货地址" : "修改收货地址"
);

const formRef = ref(null);
const form = reactive({
  id: null,
  name: "",
  phone: "",
  firstAddress: "",
  secondAddress: "",
  isdefault: "否",
  address: "",
  userid: "",
});
const isDefault = ref(false);

const rules = {
  name: [{ required: true, message: "请输入收货人", trigger: "blur" }],
  phone: [
    { required: true, message: "请输入手机号", trigger: "blur" },
    {
      validator: (rule, value, callback) => {
        if (value && !/^1[3-9]\d{9}$/.test(value)) {
          callback(new Error("请输入正确的11位手机号"));
        } else {
          callback();
        }
      },
      trigger: "blur",
    },
  ],
  firstAddress: [{ required: true, message: "请选择地区", trigger: "change" }],
  secondAddress: [
    { required: true, message: "请输入详细地址", trigger: "blur" },
  ],
};

const openAddressDialog = (type, address = null) => {
  dialogType.value = type;
  if (type === "edit" && address) {
    Object.assign(form, address);
    const parts = (address.address || "").split("-");
    form.secondAddress = parts.pop();
    form.firstAddress = parts.join("-");
    isDefault.value = address.isdefault === "是";
  } else {
    resetForm();
  }
  dialogVisible.value = true;
};

const resetForm = () => {
  form.id = null;
  form.name = "";
  form.phone = "";
  form.firstAddress = "";
  form.secondAddress = "";
  isDefault.value = false;
};

const getAddressList = async () => {
  loading.value = true;
  try {
    const userData = await getUserData();
    const userid = userData?.userid || userData?.id;
    if (!userid) {
      Message.warning("请先登录");
      return;
    }
    form.userid = userid;
    const res = await requestApi.post("/api/address/list", { userid });
    addressList.value = res?.code == 0 ? res.data || [] : [];
  } catch (error) {
    console.error("请求地址列表异常:", error);
    addressList.value = [];
  } finally {
    loading.value = false;
  }
};

const handleSaveAddress = async () => {
  if (!formRef.value) return;
  formRef.value.validate(async (valid) => {
    if (!valid) return;
    const payload = { ...form };
    payload.isdefault = isDefault.value ? "是" : "否";
    payload.address = `${payload.firstAddress}-${payload.secondAddress}`;
    const apiUrl = payload.id ? "/api/address/update" : "/api/address/save";
    try {
      const res = await requestApi.post(apiUrl, payload);
      if (res?.code == 0) {
        Message.success("地址保存成功");
        dialogVisible.value = false;
        await getAddressList();
      } else {
        Message.error(`地址保存失败: ${res?.msg || "未知错误"}`);
      }
    } catch (error) {
      console.error("请求保存地址异常:", error);
      Message.error("地址保存失败，请稍后重试");
    }
  });
};

const handleDeleteAddress = async (addressId) => {
  try {
    const res = await requestApi.post("/api/address/delete", [addressId]);
    if (res?.code == 0) {
      Message.success("删除成功");
      await getAddressList();
    } else {
      Message.error("删除失败: " + (res?.msg || ""));
    }
  } catch (error) {
    console.error("请求删除地址异常:", error);
    Message.error("删除失败，请稍后重试");
  }
};

onMounted(() => {
  getAddressList();
});

const handleBack = () => {
  window.history.back();
};
</script>

<style scoped>
.address-page {
  --primary-color: #ff6b00;
  --primary-hover: #e65100;
  --text-main: #333333;
  --text-secondary: #666666;
  --text-light: #999999;
  --bg-body: #f4f6f9;
  --bg-card: #ffffff;
  --border-color: #e6e6e6;
  --danger-color: #ff4d4f;
  --radius-md: 12px;
  --radius-sm: 6px;
  --shadow: 0 4px 12px rgba(0, 0, 0, 0.03);

  background-color: var(--bg-body);
  min-height: 100vh;
  padding: 0;
}

.address-page,
.address-page * {
  box-sizing: border-box;
}

/* 顶部导航 */
.navbar {
  background: var(--bg-card);
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
  height: 64px;
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-content {
  max-width: 1000px;
  margin: 0 auto;
  height: 100%;
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
}

.back-link {
  text-decoration: none;
  color: var(--text-main);
  font-size: 1rem;
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 500;
}

.back-link:hover {
  color: var(--primary-color);
}

.page-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--text-main);
  flex: 1;
  text-align: center;
}

/* 主容器 */
.container {
  max-width: 1000px;
  margin: 30px auto;
  padding: 0 20px;
}

.header-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  gap: 16px;
}

.title {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--text-main);
}

.sub {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-top: 6px;
}

.btn-primary {
  background: var(--primary-color);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 20px;
  cursor: pointer;
  font-size: 0.95rem;
  font-weight: 500;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  transition: all 0.2s;
  box-shadow: 0 2px 8px rgba(255, 107, 0, 0.2);
  white-space: nowrap;
}

.btn-primary:hover {
  background: var(--primary-hover);
  transform: translateY(-1px);
}

/* 地址网格 */
.address-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

/* 地址卡片 */
.addr-card {
  background: var(--bg-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--border-color);
  padding: 20px;
  position: relative;
  transition: all 0.2s;
  box-shadow: var(--shadow);
}

.addr-card:hover {
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.06);
  transform: translateY(-2px);
}

.addr-card.default {
  border-color: var(--primary-color);
  background-color: #fffbf6;
}

.badge-default {
  position: absolute;
  top: 0;
  right: 0;
  background: var(--primary-color);
  color: white;
  font-size: 0.75rem;
  padding: 4px 8px;
  border-bottom-left-radius: 8px;
  border-top-right-radius: var(--radius-md);
}

.card-top {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
  gap: 10px;
}

.user-info {
  font-size: 1.05rem;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 8px;
  color: var(--text-main);
}

.user-phone {
  font-size: 0.9rem;
  color: var(--text-secondary);
  white-space: nowrap;
}

.addr-text {
  color: var(--text-main);
  font-size: 0.95rem;
  line-height: 1.5;
  min-height: 44px;
  margin-bottom: 16px;
}

.actions {
  display: flex;
  gap: 12px;
}

.btn-text {
  color: var(--primary-color);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 0.9rem;
  padding: 0;
}

.btn-text:hover {
  text-decoration: underline;
}

.btn-danger {
  color: var(--danger-color);
}
</style>
