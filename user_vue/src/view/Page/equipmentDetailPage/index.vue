<template>
  <div class="detail-page-container">
    <el-container>
      <el-main>
        <el-card class="detail-card" shadow="never" v-loading="loading">
          <template v-if="!loading && equipment">
            <div class="detail-header">
              <h2 class="equipment-name">{{ equipment.name }}</h2>
              <div class="equipment-status" :class="getStatusClass(equipment.status)">
                {{ equipment.status }}
              </div>
            </div>

            <div class="detail-content">
              <el-row :gutter="20">
                <el-col :span="8">
                  <div class="image-container">
                    <el-image
                      v-if="equipment.photo"
                      :src="equipment.photo"
                      fit="cover"
                      class="main-image"
                    >
                      <template #error>
                        <div class="image-slot">
                          <el-icon><Picture /></el-icon>
                        </div>
                      </template>
                    </el-image>
                    <div v-else class="no-image">
                      <el-icon><Picture /></el-icon>
                      <p>暂无图片</p>
                    </div>
                  </div>
                </el-col>
                
                <el-col :span="16">
                  <div class="info-section">
                    <h3 class="section-title">基本信息</h3>
                    <div class="info-grid">
                      <div class="info-item">
                        <span class="info-label">器材编号:</span>
                        <span class="info-value">{{ equipment.equipmentno || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">器材分类:</span>
                        <span class="info-value">{{ equipment.classify || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">品牌:</span>
                        <span class="info-value">{{ equipment.brand || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">型号:</span>
                        <span class="info-value">{{ equipment.model || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">购买日期:</span>
                        <span class="info-value">{{ equipment.purchasedate || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">保修截止日期:</span>
                        <span class="info-value">{{ equipment.warrantyenddate || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">存放位置:</span>
                        <span class="info-value">{{ equipment.location || '暂无' }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">单价:</span>
                        <span class="info-value">¥{{ equipment.price || 0 }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">数量:</span>
                        <span class="info-value">{{ equipment.quantity || 0 }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">已借数量:</span>
                        <span class="info-value">{{ equipment.borrowedquantity || 0 }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">剩余数量:</span>
                        <span class="info-value">{{ equipment.remainingquantity || 0 }}</span>
                      </div>
                      <div class="info-item">
                        <span class="info-label">创建人:</span>
                        <span class="info-value">{{ equipment.addusername || '暂无' }}</span>
                      </div>
                    </div>
                  </div>
                </el-col>
              </el-row>

              <div class="description-section">
                <h3 class="section-title">器材描述</h3>
                <div class="description-content">
                  {{ equipment.description || '暂无描述' }}
                </div>
              </div>

              <div class="action-section">
                <el-button type="primary" size="large" @click="handleRent">
                  <el-icon><TakeawayBox /></el-icon>申请租借
                </el-button>
                <el-button type="primary" size="large" @click="goBack">
                  <el-icon><ArrowLeft /></el-icon>返回列表
                </el-button>
              </div>
            </div>
          </template>
          
          <el-empty v-else-if="!loading" description="暂无数据" />
        </el-card>
      </el-main>
    </el-container>

    <!-- 租借对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="申请租借"
      width="500px"
    >
      <el-form :model="rentForm" ref="rentFormRef" :rules="rentRules" label-width="100px">
        <el-form-item label="器材名称" prop="equipmentname">
          <el-input v-model="rentForm.equipmentname" disabled />
        </el-form-item>
        <el-form-item label="用户ID" prop="userid">
          <el-input v-model="rentForm.userid" disabled />
        </el-form-item>
        <el-form-item label="租借人" prop="username">
          <el-input v-model="rentForm.username" disabled />
        </el-form-item>
        <el-form-item label="租借数量" prop="quantity">
          <el-input-number
            v-model="rentForm.quantity"
            :min="1"
            :max="equipment?.remainingquantity || 1"
            :step="1"
            placeholder="请输入租借数量"
          />
        </el-form-item>
        <el-form-item label="归还时间" prop="expectedreturntime">
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
          <el-button type="primary" @click="handleSubmitRent">提交申请</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, reactive } from "vue";
import requestApi from "@/utils/axios.js";
import MessageBox from "@/components/MessageBox/index.js";
import { useRoute, useRouter } from "vue-router";
import { Picture as PictureIcon, ArrowLeft, TakeawayBox } from '@element-plus/icons-vue';

const route = useRoute();
const router = useRouter();

// 响应式状态
const equipment = ref(null);
const loading = ref(true);
const dialogVisible = ref(false);
const rentFormRef = ref(null);

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

// 验证规则
const rentRules = {
  username: [{ required: true, message: '请输入您的姓名', trigger: 'blur' }],
  quantity: [
    { required: true, message: '请输入租借数量', trigger: 'blur' },
    { type: 'number', min: 1, message: '租借数量必须大于0', trigger: 'blur' }
  ],
  expectedreturntime: [{ required: true, message: '请选择预计归还时间', trigger: 'blur' }]
};

// 获取器材详情
const fetchEquipmentDetail = async () => {
  loading.value = true;
  try {
    const equipmentId = route.query.id;
    if (!equipmentId) {
      MessageBox.error("缺少器材ID");
      return;
    }
    
    const response = await requestApi.post("/api/equipment/info", { id: equipmentId });
    if (response.code == 0) {
      equipment.value = response.data;
    } else {
      MessageBox.error(response.msg || "获取器材详情失败");
    }
  } catch (error) {
    console.error("获取器材详情失败:", error);
    MessageBox.error("获取器材详情失败");
  } finally {
    loading.value = false;
  }
};

// 根据状态获取样式类
const getStatusClass = (status) => {
  switch (status) {
    case '正常':
      return 'status-normal';
    case '维修中':
      return 'status-maintenance';
    case '已报废':
      return 'status-scrapped';
    case '已借出':
      return 'status-borrowed';
    default:
      return '';
  }
};

// 打开租借对话框
const handleRent = () => {
  if (!equipment.value) return;
  
  rentForm.equipmentid = equipment.value.id;
  rentForm.equipmentname = equipment.value.name;
  rentForm.quantity = 1;
  rentForm.userid = null;
  rentForm.username = '';
  
  // 自动填充当前登录用户信息
  const userData = localStorage.getItem('userData');
  console.log("userData from localStorage:", userData);
  if (userData) {
    try {
      const parsedUserData = JSON.parse(userData);
      console.log("Parsed userData:", parsedUserData);
      if (parsedUserData.userid) {
         rentForm.userid = String(parsedUserData.userid);
         console.log("Set userid:", rentForm.userid);
       }
      // 优先使用姓名，姓名为空则使用用户名
      rentForm.username = parsedUserData.name || parsedUserData.username || '';
      console.log("Set username:", rentForm.username);
    } catch (e) {
      console.error("Failed to parse userData:", e);
    }
  }
  
  dialogVisible.value = true;
};

// 提交租借
async function handleSubmitRent() {
  if (!rentFormRef.value) return;
  await rentFormRef.value.validate(async (valid) => {
    if (valid) {
      try {
        // 从localStorage获取用户信息
        const userData = JSON.parse(localStorage.getItem('userData'));
        if (userData) {
          rentForm.userid = userData.userid;
        }
        
        const response = await requestApi.post("/api/equipmentRental/rent", rentForm);
        if (response.code == 0) {
          MessageBox.success("租借申请已提交");
          dialogVisible.value = false;
        } else {
          MessageBox.error("租借失败");
        }
      } catch (error) {
        console.error("租借失败:", error);
        MessageBox.error("租借失败");
      }
    }
  });
}

// 返回列表页
const goBack = () => {
  router.push({ path: "equipmentListPage" });
};

// 初始化
onMounted(() => {
  fetchEquipmentDetail();
});
</script>

<style scoped>
.detail-page-container {
  background-color: #f4f5f7;
  padding: 20px;
  min-height: 100vh;
}

.detail-card {
  border-radius: 8px;
  overflow: hidden;
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 0;
  border-bottom: 1px solid #e4e7ed;
  margin-bottom: 20px;
}

.equipment-name {
  font-size: 24px;
  font-weight: 600;
  margin: 0;
  color: #303133;
}

.equipment-status {
  padding: 6px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
}

.status-normal {
  background-color: #f0f9eb;
  color: #67c23a;
}

.status-maintenance {
  background-color: #ecf5ff;
  color: #409eff;
}

.status-scrapped {
  background-color: #fef0f0;
  color: #f56c6c;
}

.status-borrowed {
  background-color: #fdf6ec;
  color: #e6a23c;
}

.detail-content {
  padding: 20px 0;
}

.image-container {
  text-align: center;
}

.main-image {
  width: 100%;
  height: 300px;
  border-radius: 8px;
  background-color: #f0f2f5;
}

.no-image {
  width: 100%;
  height: 300px;
  border-radius: 8px;
  background-color: #f0f2f5;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #c0c4cc;
}

.no-image el-icon {
  font-size: 48px;
  margin-bottom: 10px;
}

.info-section {
  margin-bottom: 30px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  margin: 0 0 16px;
  color: #303133;
  border-left: 4px solid #409eff;
  padding-left: 12px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.info-item {
  display: flex;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid #f0f0f0;
}

.info-label {
  font-weight: 500;
  color: #606266;
  width: 100px;
  flex-shrink: 0;
}

.info-value {
  color: #303133;
  flex: 1;
}

.description-section {
  margin-bottom: 30px;
}

.description-content {
  line-height: 1.6;
  color: #606266;
  padding: 10px 0;
  white-space: pre-wrap;
}

.action-section {
  margin-top: 30px;
  text-align: center;
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  font-size: 48px;
  color: #c0c4cc;
}

@media (max-width: 768px) {
  .info-grid {
    grid-template-columns: 1fr;
  }
  
  .detail-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
}
</style>