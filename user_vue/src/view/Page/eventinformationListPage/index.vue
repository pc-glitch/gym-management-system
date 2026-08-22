
<template>
  <div class="list-page-container">
    <el-container>
      

      <el-main>
        
        <el-card class="search-card" shadow="never">
          <el-form :model="queryParams" ref="queryFormRef" :inline="true" @submit.prevent="handleQuery">
            
            
            
            
            <el-form-item label="赛事名称" prop="name">
              
              
              <el-input
                v-model="queryParams.name"
                placeholder="请输入赛事名称"
                clearable
              />
              
            </el-form-item>
            
            
            
            <el-form-item label="赛事类型" prop="classify">
              
              
              <el-input
                v-model="queryParams.classify"
                placeholder="请输入赛事类型"
                clearable
              />
              
            </el-form-item>
            
            
            
            
            
            <el-form-item label="举办地点" prop="venue">
              
              
              <el-input
                v-model="queryParams.venue"
                placeholder="请输入举办地点"
                clearable
              />
              
            </el-form-item>
            
            
            
            <el-form-item label="举办日期" prop="holdingdate">
              
              
              <el-date-picker
                v-model="queryParams.holdingdate"
                type="date"
                placeholder="选择举办日期"
                value-format="YYYY-MM-DD"
              />
              
            </el-form-item>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            <el-form-item>
              <el-button type="primary"  @click="handleQuery"><el-icon><Search /></el-icon>搜索</el-button>
              <el-button  @click="resetQuery"><el-icon><Refresh /></el-icon>重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
        

        <div class="content-area" v-loading="loading">
          <el-row :gutter="20" v-if="products.length > 0">
            <el-col
              v-for="product in products"
              :key="product.id"
              :xs="24" :sm="12" :md="8" :lg="6"
            >
              <el-card class="product-card" shadow="hover" @click="viewProductDetails(product.id)">
                <el-image
                 v-if="product.photo"
                  :src="product.photo"
                  fit="cover"
                  class="product-image"
                >
                  <template #error>
                    <div class="image-slot">
                      <el-icon><Picture /></el-icon>
                    </div>
                  </template>
                </el-image>
                <div class="product-info">
                  <h4 class="product-name">{{ product.name || product.title }}</h4>
                  <div class="product-attributes">
                    
                      
                    
                      
                        <div v-if="product.name" class="attribute-item">
                          <span class="attribute-label">赛事名称:</span>
                          <span class="attribute-value">{{ product.name }}</span>
                        </div>
                      
                    
                      
                        <div v-if="product.classify" class="attribute-item">
                          <span class="attribute-label">赛事类型:</span>
                          <span class="attribute-value">{{ product.classify }}</span>
                        </div>
                      
                    
                      
                        <div v-if="product.theleveloftheevent" class="attribute-item">
                          <span class="attribute-label">赛事级别:</span>
                          <span class="attribute-value">{{ product.theleveloftheevent }}</span>
                        </div>
                      
                    
                      
                        <div v-if="product.venue" class="attribute-item">
                          <span class="attribute-label">举办地点:</span>
                          <span class="attribute-value">{{ product.venue }}</span>
                        </div>
                      
                    
                      
                        <div v-if="product.holdingdate" class="attribute-item">
                          <span class="attribute-label">举办日期:</span>
                          <span class="attribute-value">{{ product.holdingdate }}</span>
                        </div>
                      
                    
                      
                        <div v-if="product.competitiontime" class="attribute-item">
                          <span class="attribute-label">比赛时间:</span>
                          <span class="attribute-value">{{ product.competitiontime }}</span>
                        </div>
                      
                    
                      
                        <div v-if="product.totheschedule" class="attribute-item">
                          <span class="attribute-label">赛程安排:</span>
                          <span class="attribute-value">{{ product.totheschedule }}</span>
                        </div>
                      
                    
                      
                    
                      
                    
                      
                    
                      
                    
                      
                    
                      
                    
                  </div>
                  <p v-if="product.price" class="product-price">¥{{ product.price }}</p>
                </div>
              </el-card>
            </el-col>
          </el-row>

          <el-empty v-if="!loading && products.length == 0" description="暂无数据" />
        </div>

        <el-pagination
          v-if="total > 0"
          class="pagination-container"
          :current-page="queryParams.page"
          :page-size="queryParams.limit"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </el-main>
    </el-container>
  </div>
</template>

<script setup>
import { ref, onMounted, reactive } from "vue";
import requestApi from "@/utils/axios.js";
import MessageBox from "@/components/MessageBox/index.js";
import { useRouter } from "vue-router";
import { Menu as MenuIcon, Picture as PictureIcon, Search, Refresh } from '@element-plus/icons-vue';

const router = useRouter();

// 响应式状态
const products = ref([]);
const categories = ref([]);
const selectedCategory = ref(null);
const loading = ref(true);
const total = ref(0);

const queryParams = reactive({
  page: 1,
  limit: 10,
  
  
  
  
  name: undefined,
  
  
  
  classify: undefined,
  
  
  
  
  
  venue: undefined,
  
  
  
  holdingdate: undefined,
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
});



// 获取主分类列表


// 获取搜索表单下拉选项


// 获取产品列表
const fetchProducts = async () => {
  loading.value = true;
  try {
    const params = { ...queryParams };
    

    const filteredParams = Object.fromEntries(
      Object.entries(params).filter(([_, v]) => v !== undefined && v !== null && v !== '')
    );

    const response = await requestApi.post("/api/eventinformation/page", filteredParams);
    if (response.code == 0) {
      products.value = response.data.list;
      total.value = parseInt(response.data.total) || 0;
    } else {
      products.value = [];
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
  fetchProducts();
}

// 重置操作
const queryFormRef = ref(null);
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

// 分类选择
const handleCategorySelect = (index) => {
  selectedCategory.value = index === 'all' ? null : index;
  handleQuery();
};

// 分页大小改变
function handleSizeChange(val) {
  queryParams.limit = val;
  fetchProducts();
}

// 当前页改变
function handleCurrentChange(val) {
  queryParams.page = val;
  fetchProducts();
}

// 跳转到详情页
const viewProductDetails = (productId) => {
  router.push({
    path: "eventinformationDetailPage",
    query: { id: productId },
  });
};

// 初始化
onMounted(() => {
  
  
  fetchProducts();
});
</script>

<style scoped>
.list-page-container {
  background-color: #f4f5f7;
  padding: 20px;
  min-height: 100vh;
}

.category-aside {
  background-color: #fff;
  border-radius: 4px;
  margin-right: 20px;
  padding: 10px 0;
}

.aside-title {
  font-size: 16px;
  font-weight: 600;
  padding: 0 20px 10px;
  margin: 0;
  border-bottom: 1px solid #e4e7ed;
}

.el-menu {
  border-right: none;
}

.search-card {
  margin-bottom: 20px;
  border: none;
}

.content-area {
  min-height: 400px;
}

.product-card {
  margin-bottom: 20px;
  cursor: pointer;
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: var(--el-box-shadow-light);
}

.product-image {
  width: 100%;
  height: 180px;
  border-radius: 4px;
  background-color: #f0f2f5;
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  font-size: 30px;
  color: #c0c4cc;
}

.product-info {
  padding: 14px 0 0;
}

.product-name {
  font-size: 16px;
  font-weight: 500;
  margin: 0 0 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.product-attributes {
  font-size: 13px;
  color: #909399;
  margin-bottom: 10px;
}

.attribute-item {
  margin-bottom: 4px;
}

.attribute-label {
  font-weight: 500;
  margin-right: 6px;
}

.product-price {
  font-size: 18px;
  font-weight: bold;
  color: #f56c6c;
  margin: 0;
}

.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>
