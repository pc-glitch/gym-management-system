<template>
  <div v-loading="loading">
    <div class="page-title-row">
      <div class="page-title">个人资料设置</div>
      <div>
        <button
          v-if="activeTab === 'profile'"
          type="button"
          class="btn primary"
          @click="activeTab = 'edit'"
        >
          编辑资料
        </button>
        <button
          v-else
          type="button"
          class="btn"
          @click="activeTab = 'profile'"
        >
          返回概览
        </button>
      </div>
    </div>

    <div class="profile-layout">
      <!-- 左侧：档案卡片 -->
      <div class="profile-card">
        <div class="profile-cover"></div>
        <div class="profile-avatar-wrap">
          <div class="profile-avatar">
            <img
              v-if="userInfo.avatarurl"
              :src="userInfo.avatarurl"
              alt="avatar"
              @error="(e) => (e.target.src = fallbackAvatar)"
            />
            <span v-else>{{ (userInfo.username || "U").slice(0, 1) }}</span>
          </div>
          <div class="profile-edit-badge" title="编辑资料" @click="activeTab = 'edit'">
            ✎
          </div>
        </div>

        <div class="profile-name">
          {{ userInfo.name || userInfo.username || "-" }}
        </div>
        <div class="profile-role">
          {{ userRoleInfo?.label || "普通用户" }}
        </div>

        <div class="profile-stats">
          <div class="p-stat-item">
            <span class="p-stat-val">{{ userInfo.id || "-" }}</span>
            <span class="p-stat-label">ID</span>
          </div>
          <div class="p-stat-item">
            <span class="p-stat-val">{{ userInfo.gender || "-" }}</span>
            <span class="p-stat-label">Gender</span>
          </div>
          <div class="p-stat-item">
            <span class="p-stat-val">{{ formatJoinDate(userInfo.addtime) }}</span>
            <span class="p-stat-label">Join</span>
          </div>
        </div>

        <div class="info-list">
          <div class="info-item">
            <span class="info-icon">📧</span>
            <span class="info-text">{{ userInfo.email || "-" }}</span>
          </div>
          <div class="info-item">
            <span class="info-icon">📱</span>
            <span class="info-text">{{ userInfo.phone || "-" }}</span>
          </div>
          <div class="info-item">
            <span class="info-icon">👤</span>
            <span class="info-text">{{ userInfo.username || "-" }}</span>
          </div>
        </div>
      </div>

      <!-- 右侧：设置面板 -->
      <div class="settings-panel">
        <div class="tabs-header">
          <div
            class="tab-btn"
            :class="{ active: activeTab === 'profile' }"
            @click="activeTab = 'profile'"
          >
            资料概览
          </div>
          <div
            class="tab-btn"
            :class="{ active: activeTab === 'edit' }"
            @click="activeTab = 'edit'"
          >
            编辑资料
          </div>
        </div>

        <div class="settings-content">
          <!-- 概览 -->
          <div v-if="activeTab === 'profile'">
            <div class="form-group">
              <label class="form-label">真实姓名</label>
              <input class="form-input" type="text" :value="userInfo.name || '-'" disabled />
            </div>
            <div class="form-group">
              <label class="form-label">性别</label>
              <input
                class="form-input"
                type="text"
                :value="userInfo.gender || '-'"
                disabled
              />
            </div>
            <div class="form-group">
              <label class="form-label">手机号</label>
              <input
                class="form-input"
                type="text"
                :value="userInfo.phone || '-'"
                disabled
              />
            </div>
            <div class="form-group">
              <label class="form-label">邮箱</label>
              <input
                class="form-input"
                type="text"
                :value="userInfo.email || '-'"
                disabled
              />
            </div>
          </div>

          <!-- 编辑 -->
          <div v-else>
            <div class="form-group">
              <label class="form-label">头像</label>
              <ImageUpload
                v-model="form.avatarurl"
                :limit="1"
                uploadUrl="/api/file/upload"
              />
            </div>

            <div class="form-group">
              <label class="form-label">真实姓名</label>
              <input v-model="form.name" class="form-input" type="text" placeholder="请输入姓名" />
            </div>

            <div class="form-group">
              <label class="form-label">性别</label>
              <select v-model="form.gender" class="form-input">
                <option value="">请选择</option>
                <option value="男">男</option>
                <option value="女">女</option>
                <option value="未知">保密</option>
              </select>
            </div>

            <div class="form-group">
              <label class="form-label">手机号</label>
              <input
                v-model="form.phone"
                class="form-input"
                type="text"
                placeholder="请输入手机号"
              />
            </div>

            <div class="form-group">
              <label class="form-label">邮箱</label>
              <input
                v-model="form.email"
                class="form-input"
                type="text"
                placeholder="请输入邮箱"
              />
            </div>
          </div>
        </div>

        <div v-if="activeTab === 'edit'" class="save-bar">
          <button type="button" class="btn" @click="resetFormFromUser">重置</button>
          <button type="button" class="btn primary" @click="saveChanges">保存</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import { getUserData } from "@/utils/auth";
import request from "@/utils/axios";
import { options as roleOptions } from "@/utils/Role.js";
import ImageUpload from "@/components/ImageUpload/index.vue";
import { ElMessage } from "element-plus";
import fallbackAvatar from "./0fc7d20532fdaf769a25683617711png.png";

const loading = ref(true);
const activeTab = ref("profile");
const userRoleInfo = ref(null);
const userInfo = reactive({});
const form = reactive({});

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

onMounted(async () => {
  loading.value = true;
  try {
    const data = await getUserData();
    if (data) {
      Object.assign(userInfo, data);
      resetFormFromUser();
      userRoleInfo.value = roleOptions.find((r) => r.role === data.role);
    } else {
      ElMessage.error("获取用户信息失败，请检查登录状态或网络。");
    }
  } catch (error) {
    console.error("在 personalCenter 中获取用户信息失败:", error);
    ElMessage.error("加载用户信息时发生错误。");
  } finally {
    loading.value = false;
  }
});

const saveChanges = async () => {
  if (!userRoleInfo.value || !userRoleInfo.value.table) {
    ElMessage.error("无法确定用户角色，无法保存。");
    return;
  }

  if (!form.phone) {
    ElMessage.error("请输入手机号");
    return;
  }

  if (!/^1[3-9]\d{9}$/.test(form.phone)) {
    ElMessage.error("请输入正确的11位手机号");
    return;
  }

  loading.value = true;
  try {
    const payload = { ...form };
    delete payload.password;
    const res = await request.post(`/api/${userRoleInfo.value.table}/update`, payload);
    if (res && res.code == 0) {
      Object.assign(userInfo, form);
      activeTab.value = "profile";
      ElMessage.success("用户信息更新成功！");
    } else {
      ElMessage.error(res.msg || "更新失败");
    }
  } catch (error) {
    console.error("更新用户信息失败:", error);
    ElMessage.error("更新用户信息时发生网络错误。");
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped></style>

