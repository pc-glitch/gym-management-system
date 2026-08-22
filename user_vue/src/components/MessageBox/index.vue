<template>
  <transition name="message-fade">
    <div
      v-if="visible"
      :class="['message-box', `message-box--${type}`]"
      :style="{ top: `${top}px` }"
      @mouseenter="clearTimer"
      @mouseleave="startTimer"
    >
      <svg
        class="message-box__icon"
        viewBox="0 0 1024 1024"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          v-if="type === 'success'"
          fill="currentColor"
          d="M512 0C229.2 0 0 229.2 0 512s229.2 512 512 512 512-229.2 512-512S794.8 0 512 0zm0 960C264.6 960 64 759.4 64 512S264.6 64 512 64s448 200.6 448 448-200.6 448-448 448zm-89.6-358.4L699 323.2c12.8-12.8 33.4-12.8 46.2 0 12.8 12.8 12.8 33.4 0 46.2L468.4 648.8c-6.4 6.4-14.8 9.6-23.2 9.6s-16.8-3.2-23.2-9.6L273.4 500.6c-12.8-12.8-12.8-33.4 0-46.2 12.8-12.8 33.4-12.8 46.2 0l102.8 102.8z"
        ></path>
        <path
          v-if="type === 'info'"
          fill="currentColor"
          d="M512 0C229.2 0 0 229.2 0 512s229.2 512 512 512 512-229.2 512-512S794.8 0 512 0zm0 960C264.6 960 64 759.4 64 512S264.6 64 512 64s448 200.6 448 448-200.6 448-448 448zM480 288h64v128h-64V288zm0 224h64v256h-64V512z"
        ></path>
        <path
          v-if="type === 'warning'"
          fill="currentColor"
          d="M946.2 833.2L564.4 169.8c-38.4-66-112-66-150.4 0L33.8 833.2c-38.4 66 3.8 149.4 75.2 149.4h762.4c71.4 0 113.6-83.4 75.2-149.4zM512 864c-26.4 0-48-21.6-48-48s21.6-48 48-48 48 21.6 48 48-21.6 48-48 48zm-32-128V320h64v416h-64z"
        ></path>
        <path
          v-if="type === 'error'"
          fill="currentColor"
          d="M512 0C229.2 0 0 229.2 0 512s229.2 512 512 512 512-229.2 512-512S794.8 0 512 0zm0 960C264.6 960 64 759.4 64 512S264.6 64 512 64s448 200.6 448 448-200.6 448-448 448zm-48-544l-112-112c-12.8-12.8-33.4-12.8-46.2 0s-12.8 33.4 0 46.2l112 112 112-112c12.8-12.8 33.4-12.8 46.2 0s12.8 33.4 0 46.2L558.2 512l112 112c12.8 12.8 12.8 33.4 0 46.2-6.4 6.4-14.8 9.6-23.2 9.6s-16.8-3.2-23.2-9.6L512 558.2l-112 112c-6.4 6.4-14.8 9.6-23.2 9.6s-16.8-3.2-23.2-9.6c-12.8-12.8-12.8-33.4 0-46.2l112-112-112-112c-12.8-12.8-12.8-33.4 0-46.2s33.4-12.8 46.2 0l112 112z"
        ></path>
      </svg>
      <p class="message-box__content">{{ message }}</p>
      <svg
        v-if="showClose"
        class="message-box__close"
        @click="hide"
        viewBox="0 0 1024 1024"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          fill="currentColor"
          d="M512 448l224-224 64 64-224 224 224 224-64 64-224-224-224 224-64-64 224-224-224-224 64-64 224 224z"
        ></path>
      </svg>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";

const props = defineProps({
  id: {
    type: String,
    default: "",
  },
  message: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "info", // info, success, warning, error
  },
  duration: {
    type: Number,
    default: 3000,
  },
  showClose: {
    type: Boolean,
    default: false,
  },
  onClose: {
    type: Function,
    default: () => {},
  },
});

const visible = ref(false);
const top = ref(20);
let timer = null;

const startTimer = () => {
  if (props.duration > 0) {
    timer = setTimeout(() => {
      hide();
    }, props.duration);
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

onMounted(() => {
  show();
});

onUnmounted(() => {
  clearTimer();
});

defineExpose({
  top,
  hide,
});
</script>

<style scoped>
.message-box {
  position: fixed;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  padding: 15px 19px;
  border-radius: 4px;
  border: 1px solid #ebeef5;
  background-color: #fff;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  z-index: 9999999;
  overflow: hidden;
  transition:
    top 0.4s ease-out,
    opacity 0.4s ease-out;
}

.message-box__icon {
  width: 16px;
  height: 16px;
  margin-right: 8px;
}

.message-box__content {
  padding: 0;
  margin: 0;
  font-size: 14px;
  line-height: 1;
  color: #606266;
}

.message-box__close {
  position: absolute;
  top: 50%;
  right: 15px;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  cursor: pointer;
  color: #c0c4cc;
}
.message-box__close:hover {
  color: #909399;
}

.message-box--success {
  background-color: #f0f9eb;
  border-color: #e1f3d8;
}
.message-box--success .message-box__content {
  color: #67c23a;
}
.message-box--success .message-box__icon {
  color: #67c23a;
}

.message-box--warning {
  background-color: #fdf6ec;
  border-color: #faecd8;
}
.message-box--warning .message-box__content {
  color: #e6a23c;
}
.message-box--warning .message-box__icon {
  color: #e6a23c;
}

.message-box--info {
  background-color: #f4f4f5;
  border-color: #e9e9eb;
}
.message-box--info .message-box__content {
  color: #909399;
}
.message-box--info .message-box__icon {
  color: #909399;
}

.message-box--error {
  background-color: #fef0f0;
  border-color: #fde2e2;
}
.message-box--error .message-box__content {
  color: #f56c6c;
}
.message-box--error .message-box__icon {
  color: #f56c6c;
}

.message-fade-enter-active,
.message-fade-leave-active {
  transition:
    opacity 0.3s,
    transform 0.4s;
}

.message-fade-enter-from,
.message-fade-leave-to {
  opacity: 0;
  transform: translate(-50%, -20px);
}
</style>
