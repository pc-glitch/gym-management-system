<template>
  <div class="personal-page">
    <!-- 背景装饰 -->
    <div class="bg-shapes">
      <div class="shape shape-1"></div>
      <div class="shape shape-2"></div>
    </div>

    <div class="page-container">
      <el-row :gutter="24">
        <!-- 左侧：个人信息卡片 -->
        <el-col :span="8" :xs="24">
          <div class="glass-card profile-card">
            <div class="profile-header">
              <div class="avatar-wrapper">
                <el-avatar
                  :size="100"
                  :src="userInfo.avatarurl"
                  class="user-avatar"
                >
                  <img
                    src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                  />
                </el-avatar>
              </div>
              <h2 class="user-name">
                {{ userInfo.name || userInfo.username || "未登录" }}
              </h2>
              <p class="user-handle">@{{ userInfo.username || "-" }}</p>
              <div class="user-meta">
                <span class="meta-item">
                  <i class="el-icon-time"></i> 注册时间：{{
                    formatJoinDate(userInfo.addtime)
                  }}
                </span>
              </div>
            </div>

            <div class="profile-details">
              <div class="detail-item">
                <span class="label">手机号</span>
                <span class="value">{{ userInfo.phone || "-" }}</span>
              </div>
              <div class="detail-item">
                <span class="label">邮箱</span>
                <span class="value">{{ userInfo.email || "-" }}</span>
              </div>
              <div v-if="userInfo.money" class="detail-item">
                <span class="label">余额</span>
                <span class="value highlight"
                  >¥ {{ userInfo.money || "0.00" }}</span
                >
              </div>
            </div>
          </div>
        </el-col>

        <!-- 右侧：功能标签页 -->
        <el-col :span="16" :xs="24">
          <div class="glass-card content-card">
            <el-tabs v-model="activeTab" class="custom-tabs">
              <el-tab-pane label="档案概览" name="profile">
                <div class="tab-content">
                  <h3 class="section-title">基本信息</h3>
                  <el-descriptions
                    :column="1"
                    border
                    class="custom-descriptions"
                  >
                    <el-descriptions-item label="姓名">{{
                      userInfo.name || "-"
                    }}</el-descriptions-item>
                    <el-descriptions-item label="性别">{{
                      userInfo.gender || "-"
                    }}</el-descriptions-item>
                    <el-descriptions-item label="联系电话">{{
                      userInfo.phone || "-"
                    }}</el-descriptions-item>
                    <el-descriptions-item label="电子邮箱">{{
                      userInfo.email || "-"
                    }}</el-descriptions-item>
                  </el-descriptions>
                </div>
              </el-tab-pane>

              <el-tab-pane label="编辑资料" name="edit">
                <div class="tab-content">
                  <h3 class="section-title">更新信息</h3>
                  <el-form :model="form" label-position="top" class="edit-form">
                    <el-form-item label="头像">
                      <ImageUpload
                        v-model="form.avatarurl"
                        :limit="1"
                        uploadUrl="/api/file/upload"
                      />
                    </el-form-item>
                    <el-row :gutter="20">
                      <el-col :span="12">
                        <el-form-item label="姓名">
                          <el-input
                            v-model="form.name"
                            placeholder="请输入姓名"
                          />
                        </el-form-item>
                      </el-col>
                      <el-col :span="12">
                        <el-form-item label="性别">
                          <el-select
                            v-model="form.gender"
                            placeholder="请选择"
                            style="width: 100%"
                          >
                            <el-option label="男" value="男" />
                            <el-option label="女" value="女" />
                            <el-option label="保密" value="未知" />
                          </el-select>
                        </el-form-item>
                      </el-col>
                    </el-row>
                    <el-form-item label="手机号">
                      <el-input
                        v-model="form.phone"
                        placeholder="请输入手机号"
                      />
                    </el-form-item>
                    <el-form-item label="邮箱">
                      <el-input v-model="form.email" placeholder="请输入邮箱" />
                    </el-form-item>
                    <el-form-item class="form-actions">
                      <el-button
                        type="primary"
                        @click="submitForm"
                        class="btn-save"
                        >保存更改</el-button
                      >
                      <el-button @click="cancelEdit" class="btn-cancel"
                        >取消</el-button
                      >
                    </el-form-item>
                  </el-form>
                </div>
              </el-tab-pane>
            </el-tabs>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from "vue";
import Message from "@/components/MessageBox/index.js";
import requestApi from "@/utils/axios";
import ImageUpload from "@/components/ImageUpload/index.vue";
import { getUserData } from "@/utils/auth.js";
import { ElMessageBox } from "element-plus";
import { useRoute } from "vue-router";

const userInfo = reactive({});
const form = reactive({});
const loading = ref(false);
const activeTab = ref("profile");
const route = useRoute();

const formatJoinDate = (dateString) => {
  if (!dateString) return "-";
  try {
    return new Date(dateString).toLocaleDateString();
  } catch (e) {
    return dateString;
  }
};

const resetFormFromUser = () => {
  Object.keys(form).forEach((key) => delete form[key]);
  Object.assign(form, userInfo);
};

const loadUser = async () => {
  loading.value = true;
  const data = (await getUserData()) || {};
  Object.assign(userInfo, data);
  userInfo.money = Number(userInfo.money) || 0;
  resetFormFromUser();
  loading.value = false;
};

const submitForm = async () => {
  if (!form.name || !form.phone || !form.email) {
    Message.error("姓名、电话、邮箱不能为空");
    return;
  }

  if (!/^1[3-9]\d{9}$/.test(form.phone)) {
    Message.error("请输入正确的11位手机号");
    return;
  }
  try {
    const payload = { ...form, id: userInfo.userid || userInfo.id };
    delete payload.password;
    const res = await requestApi.post("/api/user/update", payload);
    if (res.code == 0) {
      Message.success("信息修改成功");
      await loadUser();
      activeTab.value = "profile";
    } else {
      Message.error(res.message || "修改失败");
    }
  } catch (error) {
    console.error(error);
    Message.error("请求失败");
  }
};

const cancelEdit = () => {
  resetFormFromUser();
  activeTab.value = "profile";
};

onMounted(async () => {
  await loadUser();
  if (route.query && route.query.tab) {
    activeTab.value = route.query.tab;
  }
});

watch(
  () => route.query && route.query.tab,
  (tab) => {
    if (tab) activeTab.value = tab;
  }
);
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap");

.personal-page {
  min-height: calc(100vh - 60px); /* 减去头部高度 */
  background: #f5f7fa;
  font-family: "Inter", sans-serif;
  padding: 40px 20px;
  position: relative;
  overflow: hidden;
}

/* 背景装饰 */
.bg-shapes .shape {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  z-index: 0;
}
.shape-1 {
  top: -100px;
  left: -100px;
  width: 400px;
  height: 400px;
  background: rgba(64, 158, 255, 0.15);
}
.shape-2 {
  bottom: -100px;
  right: -100px;
  width: 500px;
  height: 500px;
  background: rgba(103, 194, 58, 0.1);
}

.page-container {
  max-width: 1200px;
  margin: 0 auto;
  position: relative;
  z-index: 1;
}

/* 玻璃卡片通用样式 */
.glass-card {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: 20px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.glass-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.08);
}

/* 左侧 Profile Card */
.profile-card {
  padding: 40px 30px;
  text-align: center;
  height: 100%;
}

.avatar-wrapper {
  margin-bottom: 20px;
  position: relative;
  display: inline-block;
}

.user-avatar {
  border: 4px solid rgba(255, 255, 255, 0.8);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.user-name {
  font-size: 24px;
  font-weight: 700;
  color: #303133;
  margin-bottom: 4px;
}

.user-handle {
  font-size: 14px;
  color: #909399;
  margin-bottom: 16px;
}

.user-meta {
  font-size: 12px;
  color: #606266;
  background: rgba(0, 0, 0, 0.03);
  display: inline-block;
  padding: 4px 12px;
  border-radius: 20px;
  margin-bottom: 30px;
}

.profile-details {
  text-align: left;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
  padding-top: 20px;
}

.detail-item {
  display: flex;
  justify-content: space-between;
  padding: 12px 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.03);
  font-size: 14px;
}

.detail-item:last-child {
  border-bottom: none;
}

.detail-item .label {
  color: #909399;
}

.detail-item .value {
  color: #303133;
  font-weight: 500;
}

.detail-item .value.highlight {
  color: #409eff;
  font-weight: 700;
  font-size: 16px;
}

/* 右侧 Content Card */
.content-card {
  padding: 30px 40px;
  min-height: 500px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 24px;
  padding-left: 12px;
  border-left: 4px solid #409eff;
}

/* Element Plus 覆盖样式 */
:deep(.el-tabs__nav-wrap::after) {
  background-color: transparent;
}

:deep(.el-tabs__item) {
  font-size: 16px;
  font-weight: 500;
  color: #909399;
}

:deep(.el-tabs__item.is-active) {
  color: #409eff;
  font-weight: 700;
}

:deep(.el-descriptions__body) {
  background: transparent;
}

:deep(.el-descriptions__label) {
  background: rgba(255, 255, 255, 0.5);
  color: #606266;
  font-weight: 600;
}

:deep(.el-descriptions__content) {
  background: rgba(255, 255, 255, 0.2);
}

/* 表单样式 */
.edit-form {
  max-width: 600px;
}

:deep(.el-input__wrapper) {
  background: rgba(255, 255, 255, 0.5);
  box-shadow: none;
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 8px 12px;
}

:deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px #409eff;
  background: white;
}

.form-actions {
  margin-top: 40px;
}

.btn-save {
  padding: 12px 30px;
  border-radius: 8px;
  font-weight: 600;
}

.btn-cancel {
  padding: 12px 30px;
  border-radius: 8px;
  background: transparent;
  border: 1px solid #dcdfe6;
}

/* 响应式 */
@media (max-width: 768px) {
  .personal-page {
    padding: 20px 10px;
  }

  .profile-card {
    margin-bottom: 20px;
  }

  .content-card {
    padding: 20px;
  }
}
</style>
