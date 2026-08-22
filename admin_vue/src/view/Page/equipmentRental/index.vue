<template>
  <div class="equipment-rental-page">
    <div class="page-header">
      <el-card shadow="never" class="search-card">
        <el-form :model="queryParams" ref="queryFormRef" :inline="true" @submit.prevent="handleQuery">
          <el-form-item label="器材名称" prop="equipmentname">
            <el-input
              v-model="queryParams.equipmentname"
              placeholder="请输入器材名称"
              clearable
            />
          </el-form-item>
          <el-form-item label="租借人" prop="username">
            <el-input
              v-model="queryParams.username"
              placeholder="请输入租借人姓名"
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
            <el-button type="primary" plain @click="handleAdd"><el-icon><Plus /></el-icon>新增租借</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <div class="page-content">
      <el-card shadow="never" class="content-card">
        <template #header>
          <div class="card-header">
            <span>器材租借列表</span>
          </div>
        </template>
        
        <div class="table-container" v-loading="loading">
          <el-table
            v-loading="loading"
            :data="equipmentRentalList"
            style="width: 100%"
            border
            stripe
          >
            <el-table-column prop="id" label="ID" width="80" />
            <el-table-column prop="equipmentname" label="器材名称" />
            <el-table-column prop="username" label="租借人" />
            <el-table-column prop="quantity" label="租借数量" width="100" />
            <el-table-column prop="rentaltime" label="租借时间" width="180" />
            <el-table-column prop="expectedreturntime" label="预计归还时间" width="180" />
            <el-table-column prop="actualreturntime" label="实际归还时间" width="180" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="scope">
                <el-tag :type="scope.row.status === '已借出' ? 'warning' : 'success'">
                  {{ scope.row.status }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="remark" label="备注" />
            <el-table-column label="审批回复" width="200">
              <template #default="scope">
                {{ scope.row.approvalremark || '暂无' }}
              </template>
            </el-table-column>
            <el-table-column label="用户名" width="120">
              <template #default="scope">
                {{ scope.row.userUsername || scope.row.username || '暂无' }}
              </template>
            </el-table-column>
            <el-table-column prop="addtime" label="创建时间" width="180" />
            <el-table-column label="操作" width="300" fixed="right">
              <template #default="scope">
                <template v-for="action in auditActions" :key="action.status">
                  <el-button
                    size="small"
                    :type="action.type"
                    v-if="(scope.row.approvalstatus === '待审批' || !scope.row.approvalstatus) && scope.row.status === '待审批'"
                    @click="handleApprove(scope.row, action.status)"
                  >
                    {{ action.label }}
                  </el-button>
                </template>
                
                <el-button
                  size="small"
                  type="success"
                  @click="handleReturn(scope.row)"
                  :disabled="scope.row.status !== '已借出'"
                >
                  归还
                </el-button>
                <el-button
                  size="small"
                  type="danger"
                  @click="handleDelete(scope.row.id)"
                >
                  删除
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>

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

    <!-- 新增/编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
    >
      <el-form :model="formData" ref="formRef" :rules="rules" label-width="100px">
        <el-form-item label="选择器材" prop="equipmentid">
          <el-select v-model="formData.equipmentid" placeholder="请选择器材" style="width: 100%">
            <el-option
              v-for="equipment in equipmentList"
              :key="equipment.id"
              :label="equipment.name"
              :value="equipment.id"
            >
              <span style="float: left">{{ equipment.name }}</span>
              <span style="float: right; color: #999; font-size: 12px">
                剩余: {{ equipment.remainingquantity }}
              </span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="选择用户" prop="userid">
          <el-select v-model="formData.userid" placeholder="请选择用户" style="width: 100%">
            <el-option
              v-for="user in userList"
              :key="user.id"
              :label="user.username"
              :value="user.id"
            >
              <span style="float: left">{{ user.username }}</span>
              <span style="float: right; color: #999; font-size: 12px">
                {{ user.name }}
              </span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="租借数量" prop="quantity">
          <el-input v-model="formData.quantity" type="number" placeholder="请输入租借数量" />
        </el-form-item>
        <el-form-item label="归还时间" prop="expectedreturntime">
          <el-date-picker
            v-model="formData.expectedreturntime"
            type="datetime"
            placeholder="请选择预计归还时间"
            value-format="YYYY-MM-DD HH:mm:ss"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="formData.remark"
            type="textarea"
            placeholder="请输入备注"
            :rows="3"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 查看详情对话框 -->
    <el-dialog title="查看详情" v-model="viewOpen" width="700px" append-to-body>
      <div class="details-container">
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">器材名称:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.equipmentname) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">租借人:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.username) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">租借数量:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.quantity) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">租借时间:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.rentaltime) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">预计归还时间:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.expectedreturntime) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">实际归还时间:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.actualreturntime) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">状态:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.status) }}
              </div>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">审批状态:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.approvalstatus) }}
              </div>
            </div>
          </el-col>
          <el-col :span="24">
            <div class="detail-item">
              <div class="detail-label">审批回复:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.approvalremark) }}
              </div>
            </div>
          </el-col>
          <el-col :span="24">
            <div class="detail-item">
              <div class="detail-label">备注:</div>
              <div class="detail-value">
                {{ displayOrEmpty(viewForm.remark) }}
              </div>
            </div>
          </el-col>
        </el-row>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="viewOpen = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from "vue";
import requestApi from "@/utils/axios.js";
import MessageBox from "@/components/MessageBox/index.js";
import { Search, Refresh, Plus } from '@element-plus/icons-vue';
import { getUserData } from "@/utils/auth.js";

// 审批操作按钮配置数组
const auditActions = [
  { label: "通过", status: "已通过", type: "success" },
  { label: "拒绝", status: "已拒绝", type: "danger" },
];

// 响应式状态
const loading = ref(false);
const equipmentRentalList = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
const dialogTitle = ref('新增租借');
const formRef = ref(null);
const queryFormRef = ref(null);
const viewOpen = ref(false);
const viewForm = ref({});
const userInfo = ref({});

// 用户列表
const userList = ref([]);

// 表单数据
const formData = reactive({
  id: null,
  equipmentid: null,
  userid: null,
  username: '',
  quantity: 1,
  expectedreturntime: new Date(),
  remark: ''
});

// 验证规则
const rules = {
  equipmentid: [{ required: true, message: '请选择器材', trigger: 'blur' }],
  userid: [{ required: true, message: '请选择用户', trigger: 'blur' }],
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
  equipmentname: undefined,
  username: undefined,
  status: undefined,
  approvalstatus: undefined
});

// 后台空值统一显示“暂无”
const hasValue = (value) => {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value)) return value.length > 0;
  if (typeof value === "string") return value.trim() !== "";
  return true;
};
const displayOrEmpty = (value) => (hasValue(value) ? value : "暂无");

// 获取审批状态类型
function getApprovalStatusType(status) {
  if (status === '待审批') {
    return 'info';
  } else if (status === '已通过') {
    return 'success';
  } else {
    return 'danger';
  }
}

// 器材列表
const equipmentList = ref([]);

// 获取器材列表
const fetchEquipmentList = async () => {
  try {
    const response = await requestApi.post("/api/equipment/list");
    if (response.code == 0) {
      equipmentList.value = response.data.filter(item => item.remainingquantity > 0);
    }
  } catch (error) {
    console.error("获取器材列表失败:", error);
  }
};

// 获取用户列表
const fetchUserList = async () => {
  try {
    const response = await requestApi.post("/api/user/list", {});
    if (response.code == 0) {
      userList.value = response.data;
    }
  } catch (error) {
    console.error("获取用户列表失败:", error);
  }
};

// 获取器材租借列表
const fetchEquipmentRentalList = async () => {
  loading.value = true;
  try {
    const response = await requestApi.post("/api/equipmentRental/page", queryParams);
    if (response.code == 0) {
      equipmentRentalList.value = response.data.list;
      total.value = parseInt(response.data.total) || 0;
      console.log("Equipment Rental List:", equipmentRentalList.value);
      // 检查第一个元素的结构
      if (equipmentRentalList.value.length > 0) {
        console.log("First item structure:", Object.keys(equipmentRentalList.value[0]));
        console.log("First item approvalstatus:", equipmentRentalList.value[0].approvalstatus);
        console.log("First item approvalStatus:", equipmentRentalList.value[0].approvalStatus);
        console.log("First item userUsername:", equipmentRentalList.value[0].userUsername);
        console.log("First item userid:", equipmentRentalList.value[0].userid);
      }
    } else {
      equipmentRentalList.value = [];
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
  fetchEquipmentRentalList();
}

// 重置操作
function resetQuery() {
  if (queryFormRef.value) {
    queryFormRef.value.resetFields();
  }
  Object.keys(queryParams).forEach(key => {
      if (key !== 'page' && key !== 'limit') {
          queryParams[key] = undefined;
      }
  });
  handleQuery();
}

// 分页大小改变
function handleSizeChange(val) {
  queryParams.limit = val;
  fetchEquipmentRentalList();
}

// 当前页改变
function handleCurrentChange(val) {
  queryParams.page = val;
  fetchEquipmentRentalList();
}

// 新增租借
function handleAdd() {
  resetForm();
  dialogTitle.value = '新增租借';
  dialogVisible.value = true;
  fetchEquipmentList();
  fetchUserList();
}

// 重置表单
function resetForm() {
  if (formRef.value) {
    formRef.value.resetFields();
  }
  Object.assign(formData, {
    id: null,
    equipmentid: null,
    userid: null,
    username: '',
    quantity: 1,
    expectedreturntime: new Date(),
    remark: ''
  });
}

// 提交表单
async function handleSubmit() {
  if (!formRef.value) return;
  await formRef.value.validate(async (valid) => {
    if (valid) {
      // 根据用户ID获取用户信息
      const selectedUser = userList.value.find(u => u.id === formData.userid);
      if (selectedUser) {
        formData.username = selectedUser.name || selectedUser.username;
      }
      try {
        const response = await requestApi.post("/api/equipmentRental/rent", formData);
        if (response.code == 0) {
          MessageBox.success("操作成功");
          dialogVisible.value = false;
          fetchEquipmentRentalList();
        } else {
          MessageBox.error(response.msg || "操作失败");
        }
      } catch (error) {
        console.error("操作失败:", error);
        MessageBox.error("操作失败");
      }
    }
  });
}

// 器材归还
async function handleReturn(row) {
  try {
    const response = await requestApi.post("/api/equipmentRental/return", { id: row.id });
    if (response.code == 0) {
      MessageBox.success("归还成功");
      fetchEquipmentRentalList();
    } else {
      MessageBox.error(response.msg || "归还失败");
    }
  } catch (error) {
    console.error("归还失败:", error);
    MessageBox.error("归还失败");
  }
}

// 查看详情按钮操作
function handleView(row) {
  viewForm.value = row;
  viewOpen.value = true;
}

// 审批
function handleApprove(row, targetStatus) {
  MessageBox.confirm(
    `是否确认将ID为"${row.id}"的数据项状态修改为 "${targetStatus}"？`,
    "审批确认",
    {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    }
  )
    .then(async () => {
      let updateData = { ...row, approvalstatus: targetStatus };
      updateData.approvalremark = targetStatus == "已通过" ? "器材租借审批通过，请按时归还。" : "器材租借审批未通过，请完善信息后重新提交。";
      try {
        const response = await requestApi.post("/api/equipmentRental/approve", {
          id: row.id,
          approvalStatus: targetStatus,
          approvalremark: updateData.approvalremark
        }, {
          headers: {
            isToken: true
          }
        });
        if (response.code == 0) {
          MessageBox.success("审批成功");
          fetchEquipmentRentalList();
        } else {
          MessageBox.error(response.msg || "审批失败");
        }
      } catch (error) {
        console.error("审批失败:", error);
        MessageBox.error("审批失败");
      }
    })
    .catch(() => {
      MessageBox.info("已取消操作");
    });
}



// 删除
async function handleDelete(id) {
  try {
    const response = await requestApi.post("/api/equipmentRental/delete", [id]);
    if (response.code == 0) {
      MessageBox.success("删除成功");
      fetchEquipmentRentalList();
    } else {
      MessageBox.error(response.msg || "删除失败");
    }
  } catch (error) {
    console.error("删除失败:", error);
    MessageBox.error("删除失败");
  }
}

// 初始化
onMounted(async() => {
  userInfo.value = (await getUserData()) || {};
  fetchEquipmentRentalList();
  fetchEquipmentList();
});
</script>

<style scoped>
.equipment-rental-page {
  padding: 20px;
  background-color: #f4f5f7;
  min-height: 100vh;
}

.search-card {
  margin-bottom: 20px;
  border: none;
}

.content-card {
  border-radius: 8px;
  overflow: hidden;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.table-container {
  margin-bottom: 20px;
}

.pagination-container {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}

.dialog-footer {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>