<template>
  <main class="main-content">
      <!-- 关于我们 -->
    <AboutUsSection />
    <!-- 轮播图 -->
    <ImageCarousel />

    <!-- 推荐模块 -->
    
      
    <VenueinformationCFRecommend />
      
    

    <!-- 列表展示模块 -->
    

    <!-- 公告列表 -->
    <AnnouncementModule />


  </main>
</template>

<script setup>
import ImageCarousel from "@/components/ImageCarousel/index.vue";

  
import VenueinformationCFRecommend from "@/view/VenueinformationCFRecommend/index.vue";
  


import AnnouncementModule from "@/components/announcementModule/index.vue";
import AboutUsSection from "@/components/AboutUsSection/index.vue";
</script>

<style scoped>
.main-content {
  flex-grow: 1;
  width: 100%;

}

.main-content :deep(.content-wrapper) {
  padding: 0 2rem;
}

@media (max-width: 767px) {
  .main-content {
    padding: 0;
  }
}
</style>