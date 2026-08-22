<template>
  <div class="loader">
    <!-- Generate 12 groups of dots -->
    <div class="strand" v-for="i in 12" :key="i">
      <div class="dot dot-top"></div>
      <div class="dot dot-bottom"></div>
    </div>
  </div>
</template>

<style scoped>
/* 2. 容器 */
.loader {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px; /* 点之间的间距 */
  height: 100px;
  transform: scale(1.2);
}

/* 3. 每一列包含两个点 */
.strand {
  position: relative;
  width: 10px;
  height: 100px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
}

/* 4. 点的通用样式 */
.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: #fff;
  box-shadow: 0 0 10px rgba(255, 255, 255, 0.8); /* 发光效果 */
}

/* 上方的点 */
.dot-top {
  background-color: #00f260; /* 荧光绿/青 */
  animation: move-top 2s ease-in-out infinite;
  box-shadow: 0 0 15px #00f260;
}

/* 下方的点 */
.dot-bottom {
  background-color: #0575e6; /* 深科技蓝 */
  animation: move-bottom 2s ease-in-out infinite;
  box-shadow: 0 0 15px #0575e6;
}

/* 
   5. 核心魔法：利用 animation-delay 制造波浪 
*/
.strand:nth-child(1) .dot {
  animation-delay: -0.15s;
}
.strand:nth-child(2) .dot {
  animation-delay: -0.3s;
}
.strand:nth-child(3) .dot {
  animation-delay: -0.45s;
}
.strand:nth-child(4) .dot {
  animation-delay: -0.6s;
}
.strand:nth-child(5) .dot {
  animation-delay: -0.75s;
}
.strand:nth-child(6) .dot {
  animation-delay: -0.9s;
}
.strand:nth-child(7) .dot {
  animation-delay: -1.05s;
}
.strand:nth-child(8) .dot {
  animation-delay: -1.2s;
}
.strand:nth-child(9) .dot {
  animation-delay: -1.35s;
}
.strand:nth-child(10) .dot {
  animation-delay: -1.5s;
}
.strand:nth-child(11) .dot {
  animation-delay: -1.65s;
}
.strand:nth-child(12) .dot {
  animation-delay: -1.8s;
}

/* 6. 动画定义 */
@keyframes move-top {
  0% {
    transform: translateY(0) scale(1);
    opacity: 1;
    z-index: 1;
  }
  25% {
    transform: translateY(45px) scale(0.5);
    opacity: 0.5;
    z-index: 0;
  }
  50% {
    transform: translateY(90px) scale(1);
    opacity: 1;
    z-index: 1;
  }
  75% {
    transform: translateY(45px) scale(1.5);
    opacity: 1;
    z-index: 2;
  }
  100% {
    transform: translateY(0) scale(1);
    opacity: 1;
    z-index: 1;
  }
}

@keyframes move-bottom {
  0% {
    transform: translateY(0) scale(1);
    opacity: 1;
    z-index: 1;
  }
  25% {
    transform: translateY(-45px) scale(1.5);
    opacity: 1;
    z-index: 2;
  }
  50% {
    transform: translateY(-90px) scale(1);
    opacity: 1;
    z-index: 1;
  }
  75% {
    transform: translateY(-45px) scale(0.5);
    opacity: 0.5;
    z-index: 0;
  }
  100% {
    transform: translateY(0) scale(1);
    opacity: 1;
    z-index: 1;
  }
}
</style>
