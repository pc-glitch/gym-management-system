
<template>
  <div class="activityinformation-detail-page">
    <div v-if="!activityinformation" class="loading-container">
      <div class="loading-text">加载中...</div>
    </div>

    <div v-else>


      <div class="container">
        <!-- 面包屑 -->
        <div class="breadcrumb">
          首页 <span>&gt;</span>  <span>&gt;</span>
          {{ activityinformation.name || activityinformation.title || "详情" }}
        </div>

        <!-- 卡片 -->
        <div class="product-card">
          <!-- 左侧图片 -->
          <div v-if="allPhotos.length"  class="gallery">
            <div class="main-img-box">
              <img
                :src="mainImage"
                alt="主图"
                class="main-img"
                @error="handleImageError"
              />
            </div>

            <div v-if="allPhotos.length > 0" class="thumb-list">
              <div
                v-for="(img, index) in allPhotos"
                :key="index"
                class="thumb"
                :class="{ active: mainImage === img }"
                @click="handleImageChange(img)"
              >
                <img :src="img" alt="图片" @error="handleImageError" />
              </div>
            </div>
          </div>

          <!-- 右侧信息 -->
          <div class="info-col">
            <h1>{{ activityinformation.name || activityinformation.title || "标题" }}</h1>

            <div v-if="hasValue(activityinformation.classification)" class="subtitle">
              {{ activityinformation.classification }}
            </div>
            <div v-else-if="hasValue(activityinformation.profile)" class="subtitle">
              {{ activityinformation.profile }}
            </div>


            <!-- 价格区域：有价格才显示 -->
            <div
              class="price-panel"
              :class="{ visible: hasValue(activityinformation.price) }"
            >
              <span class="price-label">价格</span>
              <span class="price-symbol">￥</span>
              <span class="price-val">{{ activityinformation.price }}</span>
              <span v-if="hasValue(activityinformation.price)" class="old-price">
                ￥{{ (activityinformation.price * 1.2).toFixed(2) }}
              </span>
            </div>

            <!-- 按钮组：有价格 && 启用商城相关插件 => 展示购买入口 -->
            <div class="btn-group">
              
              <div v-if="hasValue(activityinformation.price)" class="buy-btns visible">
                
                
                <button class="btn btn-buy" @click="handleBuy">立即购买</button>
                
              </div>
              <div v-if="hasValue(activityinformation.name) && hasValue(activityinformation.activitytheme)" class="buy-btns visible">
                <button class="btn btn-buy" @click="handleSignUp">立即报名</button>
              </div>
              

  
            </div>

            <!-- 额外功能区：保留原有功能，不影响业务逻辑 -->
            <div class="extra-actions">
              <LikeGeneral
                v-if="activityinformation.id"
                :refid="activityinformation.id"
                :parentData="activityinformation"
                tablename="activityinformation"
                :type="4"
              />
              <LikeGeneral
                v-if="activityinformation.id"
                :refid="activityinformation.id"
                :parentData="activityinformation"
                tablename="activityinformation"
                :type="-1"
              />
              <LikeGeneral
                v-if="activityinformation.id"
                :refid="activityinformation.id"
                :parentData="activityinformation"
                tablename="activityinformation"
                :type="3"
              />

              <WeiboSharing
                v-if="activityinformation.id"
                :item="activityinformation"
                :title="activityinformation.name || activityinformation.title"
              />
              <QQSharing
                v-if="activityinformation.id"
                :item="activityinformation"
                :title="activityinformation.name || activityinformation.title"
              />
              <TieBaShare
                v-if="activityinformation.id"
                :item="activityinformation"
                :title="activityinformation.name || activityinformation.title"
              />
            </div>


          </div>
        </div>

        <!-- 底部详情Tab（默认先显示参数；第二个Tab为详情；保留评论与视频） -->
        <div class="detail-tabs">
          <div class="tab-header">
            <div
              v-for="tab in tabs"
              :key="tab.id"
              class="tab-item"
              :class="{ active: activeTab === tab.id }"
              @click="activeTab = tab.id"
            >
              {{ tab.name }}
            </div>
          </div>

          <!-- Tab：参数（默认） -->
          <div class="tab-content" v-show="activeTab === 'specs'">
            <table class="param-table">
              
                
              
                
                  <tr v-if="hasValue(activityinformation.name)">
                    <td>活动名称</td>
                    <td>{{ activityinformation.name }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.classify)">
                    <td>活动类型</td>
                    <td>{{ activityinformation.classify }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.activitytheme)">
                    <td>活动主题</td>
                    <td>{{ activityinformation.activitytheme }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.sponsoringdepartment)">
                    <td>主办部门</td>
                    <td>{{ activityinformation.sponsoringdepartment }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.activitytime)">
                    <td>活动时间</td>
                    <td>{{ activityinformation.activitytime }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.venue)">
                    <td>活动地点</td>
                    <td>{{ activityinformation.venue }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.activestate)">
                    <td>活动状态</td>
                    <td>{{ activityinformation.activestate }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.activityrules)">
                    <td>活动规则</td>
                    <td>{{ activityinformation.activityrules }}</td>
                  </tr>
                
              
                
                  <tr v-if="hasValue(activityinformation.introduction)">
                    <td>简介</td>
                    <td>{{ activityinformation.introduction }}</td>
                  </tr>
                
              
                
              
                
              
                
              
                
              
                
              
                
              
            </table>
          </div>

          <!-- Tab：详情（第二个） -->
          <div class="tab-content" v-show="activeTab === 'details'">
            <div v-if="hasValue(activityinformation.details)">
              <span v-html="activityinformation.details"></span>
            </div>
            <img
              v-for="(img, index) in allPhotos"
              :key="index"
              :src="img"
              class="desc-img"
              @error="handleImageError"
            />
          </div>

          <!-- Tab：评价 -->
          <div class="tab-content" v-show="activeTab === 'reviews'">
            <CommentComponent v-if="activityinformation.id" :refid="activityinformation.id" />
          </div>

          <!-- Tab：动态渲染视频（music/film） -->
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
            
          
        </div>
      </div>
    </div>

    <!-- 报名对话框 -->
    <div v-if="showSignUpModal" class="modal-overlay" @click.self="closeSignUpModal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>活动报名</h3>
          <button class="modal-close" @click="closeSignUpModal">&times;</button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>活动名称</label>
            <input type="text" v-model="signUpForm.name" disabled class="form-control" />
          </div>
          <div class="form-group">
            <label>报名人</label>
            <input type="text" v-model="signUpForm.username" class="form-control" placeholder="请输入姓名" />
          </div>
         
          <div class="form-group">
            <label>报名信息</label>
            <textarea v-model="signUpForm.registrationinformation" class="form-control" rows="3" placeholder="请输入报名信息（如个人简介、参赛经历、联系方式等）"></textarea>
          </div>
          <div class="form-group">
            <label>照片</label>
            <ImageUpload v-model="signUpForm.photo" :limit="1" />
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="closeSignUpModal">取消</button>
          <button class="btn btn-primary" @click="submitSignUp">提交报名</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import PlayerVideo from "@/components/playerVideo/index.vue";
import ImageUpload from "@/components/ImageUpload/index.vue";
import { ref, onMounted, reactive } from "vue";
import requestApi from "@/utils/axios";
import { useRouter, useRoute } from "vue-router";
import { useDataStore } from "@/utils/dataStore";
import MessageBox from "@/components/MessageBox/index.js";

const store = useDataStore();
const router = useRouter();
const route = useRoute();

const hasValue = (value) => {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value)) return value.length > 0;
  if (typeof value === "string") return value.trim() !== "";
  return true;
};

const photoFieldNames = ["photo"];
const photosFieldNames = ["photos"];

const activityinformation = ref(null);
const mainImage = ref("");
const allPhotos = ref([]);
// 默认先显示参数
const activeTab = ref("specs");

const tabs = ref([
  { id: "specs", name: "参数" },
  { id: "details", name: "详情" },
  { id: "reviews", name: "评价" },
  ...[],
]);

onMounted(() => {
  getActivityinformationDetails();
});

// 获取活动信息详情
const getActivityinformationDetails = async () => {
  const productId = route.query.id;
  if (!productId) {
    MessageBox.error("ID未提供");
    return;
  }
  try {
    let res = await requestApi.post(`/api/activityinformation/info`, { id: productId });
    if (res.code != 0) {
      MessageBox.error(res.msg || "获取活动信息详情失败");
      return;
    }

    activityinformation.value = res.data;
    allPhotos.value = handleImg(res.data);
    mainImage.value = allPhotos.value.length > 0 ? allPhotos.value[0] : "";
  } catch (error) {
    console.error("获取活动信息详情失败:", error);
    MessageBox.error("获取活动信息详情失败");
  }
};

const handleImg = (data) => {
  if (!data || typeof data !== "object") {
    return [];
  }
  const coverImages = [];
  const galleryImages = [];

  for (const field of photoFieldNames) {
    const value = data?.[field];
    if (typeof value === "string" && value.trim()) coverImages.push(value);
  }

  for (const field of photosFieldNames) {
    const value = data?.[field];
    if (!value) continue;
    if (typeof value === "string") {
      galleryImages.push(...value.split(",").map((s) => s.trim()).filter(Boolean));
    } else if (Array.isArray(value)) {
      galleryImages.push(...value.map((s) => String(s).trim()).filter(Boolean));
    }
  }

  // 兼容旧字段命名（当表里没有配置 photo/photos webType 时）
  if (coverImages.length === 0 && galleryImages.length === 0) {
    const fallbackPhoto = data?.photo;
    const fallbackPhotos = data?.photos;
    if (typeof fallbackPhoto === "string" && fallbackPhoto.trim()) coverImages.push(fallbackPhoto);
    if (typeof fallbackPhotos === "string" && fallbackPhotos.trim()) {
      galleryImages.push(...fallbackPhotos.split(",").map((s) => s.trim()).filter(Boolean));
    }
  }

  return [...new Set([...coverImages, ...galleryImages])];
};

const handleImageChange = (newImage) => {
  mainImage.value = newImage;
};


const handleBuy = () => {
  if (!activityinformation.value) return;
  const arr = [activityinformation.value];
  store.setSharedData(arr);
  router.push({ path: "/Settlement" });
};

// 报名对话框状态
const showSignUpModal = ref(false);

// 报名表单
const signUpForm = reactive({
  activityId: "",
  name: "",
  username: "",
  phone: "",
  registrationinformation: "",
  photo: ""
});

// 打开报名对话框
const handleSignUp = () => {
  if (!activityinformation.value) return;
  
  // 从localStorage获取用户信息
  const userData = localStorage.getItem('userData');
  if (!userData) {
    MessageBox.error("请先登录");
    return;
  }
  
  const parsedUserData = JSON.parse(userData);
  
  // 初始化表单
  signUpForm.activityId = activityinformation.value.id || "";
  signUpForm.name = activityinformation.value.name || activityinformation.value.title || "";
  signUpForm.username = parsedUserData.name || parsedUserData.username || "";
  signUpForm.phone = "";
  signUpForm.registrationinformation = "";
  signUpForm.photo = "";
  
  showSignUpModal.value = true;
};

// 关闭报名对话框
const closeSignUpModal = () => {
  showSignUpModal.value = false;
};

// 提交报名
const submitSignUp = async () => {
  // 验证表单
  if (!signUpForm.username.trim()) {
    MessageBox.error("请输入姓名");
    return;
  }
 
  
  try {
    // 从localStorage获取用户信息
    const userData = localStorage.getItem('userData');
    if (!userData) {
      MessageBox.error("请先登录");
      return;
    }
    
    const parsedUserData = JSON.parse(userData);
    
    const registrationData = {
      shenheid: signUpForm.activityId,
      name: signUpForm.name,
      userid: parsedUserData.userid,
      username: signUpForm.username,
      phone: signUpForm.phone,
      registrationinformation: signUpForm.registrationinformation || `报名参加活动: ${signUpForm.name}`,
      photo: signUpForm.photo
    };
    
    const response = await requestApi.post("/api/activityregistration/save", registrationData);
    if (response.code == 0) {
      MessageBox.success("报名成功！");
      closeSignUpModal();
    } else {
      MessageBox.error(response.msg || "报名失败");
    }
  } catch (error) {
    console.error("报名失败:", error);
    MessageBox.error("报名失败");
  }
};


const handleImageError = (event) => {
  event.target.src = "https://placehold.co/800x600/cccccc/ffffff?text=加载失败";
};

const getFileName = (url) => {
  if (!url || typeof url !== "string") {
    return "无效文件";
  }
  try {
    // 使用URL API来处理可能包含参数的URL
    const urlObject = new URL(url);
    const pathname = urlObject.pathname;
    return pathname.substring(pathname.lastIndexOf("/") + 1);
  } catch (e) {
    // 如果URL格式不正确，则回退到基本字符串操作
    return url.substring(url.lastIndexOf("/") + 1);
  }
};
</script>

<style scoped lang="scss">
.activityinformation-detail-page {
  --primary-color: #0056b3; /* 科技蓝 */
  --primary-hover: #004494;
  --accent-color: #ff4d4f; /* 价格红 */
  --text-main: #333;
  --text-secondary: #666;
  --text-light: #999;
  --bg-body: #f5f5f5;
  --bg-card: #fff;
  --border-color: #e8e8e8;
  --radius: 8px;

  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
  background-color: var(--bg-body);
  color: var(--text-main);
  line-height: 1.5;
  min-height: 100vh;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* 加载中 */
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
}
.loading-text {
  font-size: 18px;
  color: var(--text-secondary);
}

/* 顶部导航 */
.header {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 100;
}
.header-inner {
  max-width: 1200px;
  margin: 0 auto;
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}
.logo {
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--primary-color);
  letter-spacing: -0.5px;
}
.search-bar {
  flex: 1;
  max-width: 500px;
  margin: 0 40px;
  position: relative;
  display: none; /* 移动端隐藏 */
}
@media (min-width: 768px) {
  .search-bar {
    display: block;
  }
}

.search-input {
  width: 100%;
  padding: 8px 16px;
  border: 2px solid var(--primary-color);
  border-radius: 20px;
  outline: none;
}
.header-icons {
  display: flex;
  gap: 20px;
  color: var(--text-secondary);
  font-size: 1.1rem;
}

/* 主容器 */
.container {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

/* 面包屑 */
.breadcrumb {
  font-size: 0.9rem;
  color: var(--text-secondary);
  margin-bottom: 16px;
}
.breadcrumb span {
  margin: 0 8px;
  color: #ccc;
}

/* 主要区域 */
.product-card {
  background: var(--bg-card);
  border-radius: var(--radius);
  padding: 24px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

/* 左侧图片 */
.gallery {
  position: relative;
}
.main-img-box {
  width: 100%;
  height: 400px;
  border: 1px solid var(--border-color);
  border-radius: var(--radius);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
  overflow: hidden;
}
.main-img {
  max-width: 90%;
  max-height: 90%;
  object-fit: contain;
}

.thumb-list {
  display: flex;
  gap: 10px;
  overflow-x: auto;
}
.thumb {
  width: 70px;
  height: 70px;
  border: 1px solid var(--border-color);
  border-radius: 4px;
  cursor: pointer;
  padding: 4px;
}
.thumb.active {
  border-color: var(--primary-color);
  border-width: 2px;
}
.thumb img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

/* 右侧信息 */
.info-col h1 {
  font-size: 1.5rem;
  line-height: 1.4;
  margin-bottom: 10px;
  color: #000;
}
.subtitle {
  font-size: 0.9rem;
  color: var(--accent-color);
  margin-bottom: 12px;
}

.rating-box {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 5px;
}
.stars {
  color: #ffc107;
}

/* 价格区域 */
.price-panel {
  background: #fdf4f4; /* 浅红背景 */
  padding: 16px;
  border-radius: 4px;
  margin-bottom: 24px;
  display: none; /* 默认隐藏 */
}
.price-panel.visible {
  display: block;
}

.price-label {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-right: 10px;
}
.price-val {
  font-size: 1.8rem;
  font-weight: 700;
  color: var(--accent-color);
}
.price-symbol {
  font-size: 1rem;
  color: var(--accent-color);
}
.old-price {
  text-decoration: line-through;
  color: var(--text-light);
  margin-left: 10px;
  font-size: 0.9rem;
}

/* 按钮组 */
.btn-group {
  margin-top: 30px;
  display: flex;
  gap: 16px;
}

/* 购买模式按钮 */
.buy-btns {
  display: none;
  gap: 16px;
  width: 100%;
}
.buy-btns.visible {
  display: flex;
}

.btn {
  flex: 1;
  height: 48px;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: opacity 0.2s;
}
.btn-cart {
  background: #ffebd1;
  color: #ff5000;
  border: 1px solid #ff5000;
}
.btn-buy {
  background: linear-gradient(90deg, #ff9000, #ff5000);
  color: white;
}
.btn-contact {
  background: #fff;
  border: 1px solid var(--primary-color);
  color: var(--primary-color);
}

/* 仅展示模式按钮 */
.inquiry-btn-box {
  display: none;
  width: 100%;
}
.inquiry-btn-box.visible {
  display: block;
}

.inquiry-tip {
  font-size: 0.85rem;
  color: #999;
  margin-top: 10px;
  text-align: center;
}

/* 详情/参数 标签页 */
.detail-tabs {
  margin-top: 20px;
  background: var(--bg-card);
  border-radius: var(--radius);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  overflow: hidden;
}
.tab-header {
  border-bottom: 1px solid var(--border-color);
  display: flex;
}
.tab-item {
  padding: 16px 30px;
  cursor: pointer;
  font-weight: 500;
  color: var(--text-main);
  border-bottom: 3px solid transparent;
}
.tab-item.active {
  color: var(--primary-color);
  border-bottom-color: var(--primary-color);
}

.tab-content {
  padding: 30px;
  min-height: 300px;
}
.desc-img {
  width: 100%;
  max-width: 800px;
  margin: 20px 0;
  display: block;
  border-radius: 8px;
}
.param-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.9rem;
}
.param-table td {
  padding: 12px;
  border-bottom: 1px solid #eee;
}
.param-table td:first-child {
  width: 150px;
  color: var(--text-secondary);
  background: #fbfbfb;
}

.file-link {
  color: var(--primary-color);
  text-decoration: none;
  margin-right: 10px;
  display: inline-block;
}
.file-link:hover {
  text-decoration: underline;
}

/* 额外功能区 */
.extra-actions {
  margin-top: 14px;
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.service-row {
  margin-top: 20px;
  font-size: 0.85rem;
  color: var(--text-secondary);
}
.service-item {
  margin-right: 15px;
}

/* 兼容 AddShoppingCart 组件：一比一贴近原型的“加入购物车”按钮样式 */
.buy-btns :deep(.add-to-cart-container) {
  flex: 1;
  width: 100%;
}

.buy-btns :deep(.add-cart-btn) {
  width: 100% !important;
  height: 48px !important;
  border-radius: 4px !important;
  font-size: 1rem !important;
  font-weight: 600 !important;
  cursor: pointer !important;
  transition: opacity 0.2s !important;

  background: #ffebd1 !important;
  color: #ff5000 !important;
  border: 1px solid #ff5000 !important;
  padding: 0 !important;
}

.buy-btns :deep(.add-cart-btn:hover) {
  opacity: 0.9;
}

/* 移动端 */
@media (max-width: 768px) {
  .product-card {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  .btn-group {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: #fff;
    padding: 10px 20px;
    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
    z-index: 90;
    margin: 0;
  }
  .container {
    margin-bottom: 80px;
  }
}

/* 报名对话框样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: #fff;
  border-radius: 8px;
  width: 90%;
  max-width: 500px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid #eee;
}

.modal-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.modal-close {
  background: none;
  border: none;
  font-size: 24px;
  color: #999;
  cursor: pointer;
  line-height: 1;
}

.modal-close:hover {
  color: #666;
}

.modal-body {
  padding: 20px;
}

.form-group {
  margin-bottom: 16px;
}

.form-group label {
  display: block;
  margin-bottom: 6px;
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

.form-control {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  box-sizing: border-box;
}

.form-control:focus {
  outline: none;
  border-color: #0056b3;
}

.form-control:disabled {
  background: #f5f5f5;
  color: #999;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 16px 20px;
  border-top: 1px solid #eee;
  background: #fafafa;
}

.modal-footer .btn {
  padding: 8px 20px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border: none;
  transition: opacity 0.2s;
}

.modal-footer .btn-secondary {
  background: #f5f5f5;
  color: #666;
}

.modal-footer .btn-secondary:hover {
  background: #eee;
}

.modal-footer .btn-primary {
  background: linear-gradient(90deg, #ff9000, #ff5000);
  color: #fff;
}

.modal-footer .btn-primary:hover {
  opacity: 0.9;
}
</style>
