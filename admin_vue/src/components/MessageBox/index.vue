<template>
  <transition name="message-fade">
    <div
      v-if="visible"
      :class="['message-box', `message-box--${type}`]"
      :style="positionStyle"
      @mouseenter="clearTimer"
      @mouseleave="startTimer"
      role="alert"
    >
      <div class="message-box__icon">
        <!-- Success Icon -->
        <svg
          v-if="type === 'success'"
          xmlns="http://www.w3.org/2000/svg"
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
          <polyline points="22 4 12 14.01 9 11.01"></polyline>
        </svg>
        <!-- Info Icon -->
        <svg
          v-if="type === 'info'"
          xmlns="http://www.w3.org/2000/svg"
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="16" x2="12" y2="12"></line>
          <line x1="12" y1="8" x2="12.01" y2="8"></line>
        </svg>
        <!-- Warning Icon -->
        <svg
          v-if="type === 'warning'"
          xmlns="http://www.w3.org/2000/svg"
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path
            d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"
          ></path>
          <line x1="12" y1="9" x2="12" y2="13"></line>
          <line x1="12" y1="17" x2="12.01" y2="17"></line>
        </svg>
        <!-- Error Icon -->
        <svg
          v-if="type === 'error'"
          xmlns="http://www.w3.org/2000/svg"
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="15" y1="9" x2="9" y2="15"></line>
          <line x1="9" y1="9" x2="15" y2="15"></line>
        </svg>
      </div>
      <div class="message-box__content">
        <p class="message-box__title">{{ title }}</p>
        <p class="message-box__message">{{ message }}</p>
      </div>
      <button
        v-if="showClose"
        type="button"
        class="message-box__close-btn"
        @click.stop="hide"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="16"
          height="16"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2.5"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from "vue";

const props = defineProps({
  id: { type: String, default: "" },
  message: { type: String, default: "" },
  type: { type: String, default: "info" },
  duration: { type: Number, default: 3000 },
  showClose: { type: Boolean, default: true },
  onClose: { type: Function, default: () => {} },
  top: { type: Number, default: 20 },
});

const visible = ref(false);
const topRef = ref(props.top);
let timer = null;

const positionStyle = computed(() => ({
  top: `${topRef.value}px`,
  right: "20px",
  position: "fixed",
  zIndex: 9999,
}));

const title = computed(() => {
  // Handle 'error' as a special case if needed, otherwise just capitalize
  const typeName = props.type === "error" ? "Error" : props.type;
  return typeName.charAt(0).toUpperCase() + typeName.slice(1);
});

const startTimer = () => {
  if (props.duration > 0) {
    timer = setTimeout(hide, props.duration);
  }
};

const clearTimer = () => {
  clearTimeout(timer);
  timer = null;
};

const show = () => {
  visible.value = true;
  startTimer();
};

const hide = () => {
  visible.value = false;
  if (props.onClose) {
    props.onClose();
  }
};

onMounted(show);
onUnmounted(clearTimer);

defineExpose({ top: topRef, hide });
</script>

<style scoped>
.message-box {
  display: flex;
  align-items: flex-start;
  padding: 16px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  background-color: #fff;
  border: 1px solid #e4e7ed;
  min-width: 380px;
  max-width: 420px;
  box-sizing: border-box;
  overflow: hidden;
}

.message-box__icon {
  margin-right: 12px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  height: 20px; /* Match icon height */
  margin-top: 2px; /* Align icon with title better */
}

.message-box__content {
  flex-grow: 1;
  margin-right: 12px;
  word-break: break-word;
}

.message-box__title {
  font-weight: 600;
  font-size: 1rem;
  color: #303133;
  margin: 0 0 4px 0;
}

.message-box__message {
  font-size: 0.9rem;
  color: #606266;
  margin: 0;
  line-height: 1.4;
}

.message-box__close-btn {
  flex-shrink: 0;
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 0;
  color: #909399;
  opacity: 0.7;
  transition: all 0.2s;
}

.message-box__close-btn:hover {
  opacity: 1;
  color: #606266;
}

/* Type Variants */
.message-box--success .message-box__icon {
  color: #67c23a;
}
.message-box--info .message-box__icon {
  color: #909399;
}
.message-box--warning .message-box__icon {
  color: #e6a23c;
}
.message-box--error .message-box__icon {
  color: #f56c6c;
}

/* Animation */
.message-fade-enter-active,
.message-fade-leave-active {
  transition: opacity 0.3s, transform 0.4s cubic-bezier(0.23, 1, 0.32, 1);
}

.message-fade-enter-from,
.message-fade-leave-to {
  opacity: 0;
  transform: translate(100%, 0); /* Slide from right */
}
</style>
