<template>
  <div class="rental-list-page">
    <div class="page-header">
      <h1 class="page-title">我的租借记录</h1>
      <p class="page-subtitle">查看和管理您的器材租借记录</p>
    </div>

    <div class="search-section">
      <el-card shadow="never" class="search-card">
        <el-form :model="queryParams" ref="queryFormRef" :inline="true" @submit.prevent="handleQuery">
          <el-form-item label="器材名称" prop="equipmentname">
            <el-input
              v-model="queryParams.equipmentname"
              placeholder="请输入器材名称"
              clearable
            />
          </el-form-item>
          <el-form-item label="租借状态" prop="status">
            <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
              <el-option label="待审批" value="待审批" />
              <el-option label="已借出" value="已借出" />
              <el-option label="已归还" value="已归还" />
              <el-option label="已拒绝" value="已拒绝" />
            </el-select>
          </el-form-item>
          <el-form-item label="审批状态" prop="approvalstatus">
            <el-select v-model="queryParams.approvalstatus" placeholder="请选择审批状态" clearable>
              <el-option label="待审批" value="待审批" />
              <el-option label="已通过" value="已通过" />
              <el-option label="已拒绝" value="已拒绝" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary"  @click="handleQuery"><el-icon><Search /></el-icon>搜索</el-button>
            <el-button  @click="resetQuery"><el-icon><Refresh /></el-icon>重置</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <div class="list-section">
      <el-card shadow="never" class="list-card">
        <template #header>
          <div class="card-header">
            <span>租借记录列表</span>
            <el-tag type="info" effect="plain">{{ rentalList.length }} 条记录</el-tag>
          </div>
        </template>

        <div class="table-container" v-loading="loading">
          <el-table
            v-loading="loading"
            :data="rentalList"
            style="width: 100%"
            border
            stripe
          >
            <el-table-column prop="id" label="ID" width="80" />
            <el-table-column prop="equipmentname" label="器材名称" />
            <el-table-column prop="quantity" label="租借数量" width="100" />
            <el-table-column prop="rentaltime" label="租借时间" width="180" />
            <el-table-column prop="expectedreturntime" label="预计归还时间" width="180" />
            <el-table-column prop="actualreturntime" label="实际归还时间" width="180" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="scope">
                <el-tag :type="getStatusType(scope.row.status)">
                  {{ scope.row.status }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="审批回复" width="200">
              <template #default="scope">
                {{ scope.row.approvalremark || '暂无' }}
              </template>
            </el-table-column>
            <el-table-column prop="remark" label="备注" />
          </el-table>
        </div>

        <el-empty v-if="!loading && rentalList.length === 0" description="暂无租借记录" />

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
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import requestApi from "@/utils/axios.js";
import MessageBox from "@/components/MessageBox/index.js";
import { Search, Refresh } from '@element-plus/icons-vue';

// 响应式状态
const loading = ref(false);
const rentalList = ref([]);
const total = ref(0);
const queryFormRef = ref(null);

// 查询参数
const queryParams = reactive({
  page: 1,
  limit: 10,
  equipmentname: undefined,
  status: undefined,
  approvalstatus: undefined
});

// 获取租借记录列表
const fetchRentalList = async () => {
  loading.value = true;
  try {
    // 从localStorage获取用户信息
    const userData = JSON.parse(localStorage.getItem('userData'));
    if (userData) {
      queryParams.userid = userData.id;
    }
    
    const response = await requestApi.post("/api/equipmentRental/page", queryParams);
    if (response.code == 0) {
      rentalList.value = response.data.list;
      total.value = parseInt(response.data.total) || 0;
    } else {
      rentalList.value = [];
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
  fetchRentalList();
}

// 重置操作
function resetQuery() {
  if (queryFormRef.value) {
    queryFormRef.value.resetFields();
  }
  Object.keys(queryParams).forEach(key => {
      if (key !== 'page' && key !== 'limit' && key !== 'userid') {
          queryParams[key] = undefined;
      }
  });
  handleQuery();
}

// 分页大小改变
function handleSizeChange(val) {
  queryParams.limit = val;
  fetchRentalList();
}

// 当前页改变
function handleCurrentChange(val) {
  queryParams.page = val;
  fetchRentalList();
}

// 根据状态获取标签类型
function getStatusType(status) {
  switch (status) {
    case '待审批':
      return 'info';
    case '已借出':
      return 'warning';
    case '已归还':
      return 'success';
    case '已拒绝':
      return 'danger';
    default:
      return '';
  }
}

// 根据审批状态获取标签类型
function getApprovalStatusType(approvalstatus) {
  switch (approvalstatus) {
    case '待审批':
      return 'info';
    case '已通过':
      return 'success';
    case '已拒绝':
      return 'danger';
    default:
      return '';
  }
}

// 初始化
onMounted(() => {
  fetchRentalList();
});
</script>

<style scoped>
.rental-list-page {
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

.list-section {
  margin-bottom: 30px;
}

.list-card {
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

.table-container {
  margin-bottom: 20px;
}

.pagination-container {
  margin-top: 30px;
  display: flex;
  justify-content: flex-end;
}

@media (max-width: 768px) {
  .rental-list-page {
    padding: 10px;
  }
  
  .page-title {
    font-size: 24px;
  }
}
</style>