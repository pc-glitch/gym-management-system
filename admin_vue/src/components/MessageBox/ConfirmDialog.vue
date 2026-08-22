<template>
  <transition name="message-box-fade">
    <div
      v-if="visible"
      class="modal-overlay"
      @click.self="handleAction('cancel')"
    >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{{ title }}</h5>
          <button
            v-if="showClose"
            class="btn-close"
            @click="handleAction('cancel')"
          >
            &times;
          </button>
        </div>
        <div class="modal-body">
          <p>{{ message }}</p>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="handleAction('cancel')">
            {{ cancelButtonText }}
          </button>
          <button class="btn btn-primary" @click="handleAction('confirm')">
            {{ confirmButtonText }}
          </button>
        </div>
      </div>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted } from "vue";

const props = defineProps({
  title: { type: String, default: "提示" },
  message: { type: String, default: "" },
  showClose: { type: Boolean, default: true },
  confirmButtonText: { type: String, default: "确定" },
  cancelButtonText: { type: String, default: "取消" },
  onAction: { type: Function, required: true },
});

const visible = ref(false);

const handleAction = (action) => {
  visible.value = false;
  props.onAction(action);
};

onMounted(() => {
  visible.value = true;
});
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
}

.modal-content {
  width: 90%;
  max-width: 420px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.18);
  overflow: hidden;
}

.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 16px;
  border-bottom: 1px solid #f0f0f0;
  font-weight: 600;
  color: #303133;
}

.modal-title {
  margin: 0;
  font-size: 16px;
}

.btn-close {
  border: none;
  background: transparent;
  font-size: 18px;
  color: #999;
  cursor: pointer;
  line-height: 1;
}

.btn-close:hover {
  color: #666;
}

.modal-body {
  padding: 18px 16px 10px;
  color: #606266;
  line-height: 1.6;
}

.modal-body p {
  margin: 0;
  font-size: 14px;
  color: #303133;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  padding: 12px 16px 14px;
  border-top: 1px solid #f0f0f0;
  background: #fafafa;
}

.btn {
  min-width: 72px;
  padding: 8px 14px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  border: 1px solid #dcdfe6;
  background: #fff;
  color: #606266;
  transition: all 0.2s;
}

.btn:hover {
  color: #303133;
  border-color: #c0c4cc;
}

.btn-primary {
  background-color: var(--el-color-primary, #409eff);
  border-color: var(--el-color-primary, #409eff);
  color: #fff;
}

.btn-primary:hover {
  background-color: var(--el-color-primary-light-3, #66b1ff);
  border-color: var(--el-color-primary-light-3, #66b1ff);
}

.btn-secondary {
  background-color: #f5f7fa;
}

.message-box-fade-enter-active,
.message-box-fade-leave-active {
  transition: opacity 0.2s ease;
}
.message-box-fade-enter-active .modal-content,
.message-box-fade-leave-active .modal-content {
  transition: transform 0.3s cubic-bezier(0.23, 1, 0.32, 1);
}

.message-box-fade-enter-from,
.message-box-fade-leave-to {
  opacity: 0;
}

.message-box-fade-enter-from .modal-content,
.message-box-fade-leave-to .modal-content {
  transform: translateY(-20px);
}
</style>
