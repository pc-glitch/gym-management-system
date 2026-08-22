<template>
  <div class="equipment-rental-page">
    <div class="page-header">
      <h1 class="page-title">器材租借</h1>
      <p class="page-subtitle">选择您需要的器材进行租借</p>
    </div>

    <div class="search-section">
      <el-card shadow="never" class="search-card">
        <el-form :model="queryParams" ref="queryFormRef" :inline="true" @submit.prevent="handleQuery">
          <el-form-item label="器材名称" prop="name">
            <el-input
              v-model="queryParams.name"
              placeholder="请输入器材名称"
              clearable
            />
          </el-form-item>
          <el-form-item label="器材分类" prop="classify">
            <el-input
              v-model="queryParams.classify"
              placeholder="请输入器材分类"
              clearable
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary"  @click="handleQuery"><el-icon><Search /></el-icon>搜索</el-button>
            <el-button  @click="resetQuery"><el-icon><Refresh /></el-icon>重置</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <div class="equipment-section">
      <el-card shadow="never" class="equipment-card">
        <template #header>
          <div class="card-header">
            <span>可租借器材</span>
            <el-tag type="info" effect="plain">{{ availableEquipmentCount }} 件可租借</el-tag>
          </div>
        </template>

        <div class="equipment-grid" v-loading="loading">
          <el-col
            v-for="equipment in equipmentList"
            :key="equipment.id"
            :xs="24" :sm="12" :md="8" :lg="6"
            class="equipment-item"
          >
            <el-card shadow="hover" class="equipment-card-item">
              <el-image
                v-if="equipment.photo"
                :src="equipment.photo"
                fit="cover"
                class="equipment-image"
              >
                <template #error>
                  <div class="image-slot">
                    <el-icon><Picture /></el-icon>
                  </div>
                </template>
              </el-image>
              <div class="equipment-info">
                <h3 class="equipment-name">{{ equipment.name }}</h3>
                <div class="equipment-attributes">
                  <div class="attribute-item">
                    <span class="attribute-label">分类:</span>
                    <span class="attribute-value">{{ equipment.classify }}</span>
                  </div>
                  <div class="attribute-item">
                    <span class="attribute-label">状态:</span>
                    <span class="attribute-value">{{ equipment.status }}</span>
                  </div>
                  <div class="attribute-item">
                    <span class="attribute-label">位置:</span>
                    <span class="attribute-value">{{ equipment.location }}</span>
                  </div>
                  <div class="attribute-item">
                    <span class="attribute-label">剩余数量:</span>
                    <span class="attribute-value">{{ equipment.remainingquantity }}</span>
                  </div>
                  <div class="attribute-item">
                    <span class="attribute-label">单价:</span>
                    <span class="attribute-value price">¥{{ equipment.price }}</span>
                  </div>
                </div>
                <div class="action-buttons">
                  <el-button
                    type="primary"
                    @click="handleRent(equipment)"
                    :disabled="equipment.remainingquantity <= 0"
                  >
                    立即租借
                  </el-button>
                </div>
              </div>
            </el-card>
          </el-col>
        </div>

        <el-empty v-if="!loading && equipmentList.length === 0" description="暂无可租借的器材" />

        <div class="pagination-container" v-if="total > 0">
          <el-pagination
            :current-page="queryParams.page"
            :page-size="queryParams.limit"
            :total="total"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
          />
        </div>
      </el-card>
    </div>

    <!-- 租借对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="器材租借"
      width="500px"
    >
      <el-form :model="rentForm" ref="rentFormRef" :rules="rentRules" label-width="100px">
        <el-form-item label="器材名称" prop="equipmentname">
          <el-input v-model="rentForm.equipmentname" disabled />
        </el-form-item>
        <el-form-item label="租借人" prop="username">
          <el-input v-model="rentForm.username" placeholder="请输入您的姓名" />
        </el-form-item>
        <el-form-item label="租借数量" prop="quantity">
          <el-input-number
            v-model="rentForm.quantity"
            :min="1"
            :max="maxRentQuantity"
            :step="1"
            placeholder="请输入租借数量"
          />
        </el-form-item>
        <el-form-item label="预计归还时间" prop="expectedreturntime">
          <el-date-picker
            v-model="rentForm.expectedreturntime"
            type="datetime"
            placeholder="请选择预计归还时间"
            value-format="YYYY-MM-DD HH:mm:ss"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="rentForm.remark"
            type="textarea"
            placeholder="请输入备注信息"
            :rows="3"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmitRent">确定租借</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from "vue";
import requestApi from "@/utils/axios.js";
import MessageBox from "@/components/MessageBox/index.js";
import { Search, Refresh, Picture } from '@element-plus/icons-vue';

// 响应式状态
const loading = ref(false);
const equipmentList = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
const rentFormRef = ref(null);
const queryFormRef = ref(null);

// 计算可租借器材数量
const availableEquipmentCount = computed(() => {
  return equipmentList.value.filter(item => item.remainingquantity > 0).length;
});

// 租借表单
const rentForm = reactive({
  equipmentid: null,
  equipmentname: '',
  userid: null,
  username: '',
  quantity: 1,
  expectedreturntime: new Date(),
  remark: ''
});

// 最大可租借数量
const maxRentQuantity = ref(1);

// 验证规则
const rentRules = {
  username: [{ required: true, message: '请输入您的姓名', trigger: 'blur' }],
  quantity: [
    { required: true, message: '请输入租借数量', trigger: 'blur' },
    { type: 'number', min: 1, message: '租借数量必须大于0', trigger: 'blur' }
  ],
  expectedreturntime: [{ required: true, message: '请选择预计归还时间', trigger: 'blur' }]
};

// 查询参数
const queryParams = reactive({
  page: 1,
  limit: 10,
  name: undefined,
  classify: undefined,
  status: '正常'
});

// 获取器材列表
const fetchEquipmentList = async () => {
  loading.value = true;
  try {
    const params = {
      ...queryParams,
      status: '正常'
    };
    
    const response = await requestApi.post("/api/equipment/page", params);
    if (response.code == 0) {
      equipmentList.value = response.data.list.filter(item => item.remainingquantity > 0);
      total.value = parseInt(response.data.total) || 0;
    } else {
      equipmentList.value = [];
      total.value = 0;
      MessageBox.error(response.msg || "获取列表失败");
    }
  } catch (error) {
    console.error("获取列表失败:", error);
    MessageBox.error("获取列表失败");
  } finally {
    loading.value = false;
  }
};

// 搜索操作
function handleQuery() {
  queryParams.page = 1;
  fetchEquipmentList();
}

// 重置操作
function resetQuery() {
  if (queryFormRef.value) {
    queryFormRef.value.resetFields();
  }
  Object.keys(queryParams).forEach(key => {
      if (key !== 'page' && key !== 'limit' && key !== 'status') {
          queryParams[key] = undefined;
      }
  });
  handleQuery();
}

// 分页大小改变
function handleSizeChange(val) {
  queryParams.limit = val;
  fetchEquipmentList();
}

// 当前页改变
function handleCurrentChange(val) {
  queryParams.page = val;
  fetchEquipmentList();
}

// 打开租借对话框
function handleRent(equipment) {
  rentForm.equipmentid = equipment.id;
  rentForm.equipmentname = equipment.name;
  rentForm.quantity = 1;
  maxRentQuantity.value = equipment.remainingquantity;
  dialogVisible.value = true;
}

// 提交租借
async function handleSubmitRent() {
  if (!rentFormRef.value) return;
  await rentFormRef.value.validate(async (valid) => {
    if (valid) {
      try {
        // 从localStorage获取用户信息
        const userData = JSON.parse(localStorage.getItem('userData'));
        if (userData) {
          rentForm.userid = userData.id;
        }
        
        const response = await requestApi.post("/api/equipmentRental/rent", rentForm);
        if (response.code == 0) {
          MessageBox.success("租借成功");
          dialogVisible.value = false;
          fetchEquipmentList();
        } else {
          MessageBox.error(response.msg || "租借失败");
        }
      } catch (error) {
        console.error("租借失败:", error);
        MessageBox.error("租借失败");
      }
    }
  });
}

// 初始化
onMounted(() => {
  fetchEquipmentList();
});
</script>

<style scoped>
.equipment-rental-page {
  padding: 20px;
  background-color: #f4f5f7;
  min-height: 100vh;
}

.page-header {
  text-align: center;
  margin-bottom: 30px;
}

.page-title {
  font-size: 28px;
  font-weight: 600;
  margin: 0 0 10px;
  color: #303133;
}

.page-subtitle {
  font-size: 16px;
  color: #606266;
  margin: 0;
}

.search-section {
  margin-bottom: 20px;
}

.search-card {
  border: none;
}

.equipment-section {
  margin-bottom: 30px;
}

.equipment-card {
  border-radius: 8px;
  overflow: hidden;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 16px;
  font-weight: 500;
}

.equipment-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  margin-top: 20px;
}

.equipment-item {
  flex: 1 1 250px;
  min-width: 250px;
}

.equipment-card-item {
  height: 100%;
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.equipment-card-item:hover {
  transform: translateY(-5px);
  box-shadow: var(--el-box-shadow-light);
}

.equipment-image {
  width: 100%;
  height: 180px;
  border-radius: 4px;
  background-color: #f0f2f5;
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  font-size: 30px;
  color: #c0c4cc;
}

.equipment-info {
  padding: 14px 0 0;
}

.equipment-name {
  font-size: 16px;
  font-weight: 500;
  margin: 0 0 10px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.equipment-attributes {
  font-size: 13px;
  color: #606266;
  margin-bottom: 15px;
}

.attribute-item {
  margin-bottom: 6px;
  display: flex;
  justify-content: space-between;
}

.attribute-label {
  font-weight: 500;
  margin-right: 6px;
}

.attribute-value.price {
  color: #f56c6c;
  font-weight: 500;
}

.action-buttons {
  margin-top: 15px;
}

.pagination-container {
  margin-top: 30px;
  display: flex;
  justify-content: flex-end;
}

.dialog-footer {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

@media (max-width: 768px) {
  .equipment-item {
    flex: 1 1 100%;
  }
}
</style>