

<template>
  <div class="commodityinformation-container">
    <!-- 商品信息 搜索表单 -->
    
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      
      
      
      
      <el-form-item label="商品名称" prop="name">
        
        
        <el-input
          v-model="queryParams.name"
          placeholder="请输入商品名称"
          clearable
          @keyup.enter="handleQuery"
        />
        
      </el-form-item>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      <el-form-item>
        <el-button type="primary" :icon="Search" native-type="button" @click="handleQuery">搜索</el-button>
        <el-button :icon="Refresh" native-type="button" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    

    <!-- 商品信息 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain :icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
    </el-row>

    <!-- 商品信息 数据表格 -->
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      
      
      
      
        
      <el-table-column label="商品名称" align="center" prop="name">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.name) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="所属分类" align="center" prop="classify">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.classify) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="品牌" align="center" prop="brand">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.brand) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="单位" align="center" prop="units">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.units) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="规格详情" align="center" prop="specificationsdetails">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.specificationsdetails) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="描述" align="center" prop="description">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.description) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="价格" align="center" prop="price">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.price) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
      
      
      
        
      <el-table-column label="详细信息" align="center">
        <template #default="scope">
          <div
            v-if="hasValue(scope.row.details)"
            class="ellipsis"
            v-html="scope.row.details"
          ></div>
          <span v-else class="ellipsis">暂无</span>
        </template>
      </el-table-column>
        
      
      
      
      
      
        
      <el-table-column label="发布人" align="center" prop="addusername">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.addusername) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="创建时间" align="center" prop="addtime">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.addtime) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="150">
        <template #default="scope">
          <el-button type="info" link @click="handleView(scope.row)">查看</el-button>
          <el-button type="primary" link @click="handleUpdate(scope.row)">编辑</el-button>
          
          <el-button type="danger" link @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 商品信息 分页 -->
    <div class="commodityinformation-pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getCommodityinformationList"
      />
    </div>

    <!-- 添加或修改 商品信息 对话框 -->
    <el-dialog :title="title" v-model="open" width="80%" append-to-body @close="cancel">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        
        <el-row :gutter="20">
          
          
          <el-col :span="12" >
            <el-form-item label="商品名称" prop="name">
              
              <el-input v-model="form.name" placeholder="请输入商品名称" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="所属分类" prop="classify">
              
                
              <el-select v-model="form.classify" placeholder="请选择所属分类" @change="handleClassifyChange">
                
                <el-option
                  v-for="option in commodityclassificationOptions"
                  :key="(option.id ?? option.userid ?? option._id ?? option.value ?? option.name ?? option.username ?? option.title)"
                  :label="(option.name || option.username || option.title || '未知')"
                  :value="(option.name || option.username || option.title)"
                />
                
              </el-select>
                
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="品牌" prop="brand">
              
              <el-input v-model="form.brand" placeholder="请输入品牌" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="单位" prop="units">
              
              <el-input v-model="form.units" placeholder="请输入单位" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="规格详情" prop="specificationsdetails">
              
              <el-input
                v-model="form.specificationsdetails"
                :rows="5"
                type="textarea"
                placeholder="请输入规格详情"
              />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="描述" prop="description">
              
              <el-input
                v-model="form.description"
                :rows="5"
                type="textarea"
                placeholder="请输入描述"
              />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="价格" prop="price">
              
              <el-input-number v-model="form.price" :min="0" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="详细信息" prop="details">
              
              <RichTextEditor v-model="form.details" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="封面" prop="photo">
              
              <ImageUpload v-model="form.photo" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="详情图" prop="photos">
              
              <ImageUpload v-model="form.photos" :limit="100" />
              
            </el-form-item>
          </el-col>
          
          
          
          
          
          
          
          
          
          
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 查看详情对话框 -->
    <el-dialog title="查看详情" v-model="viewOpen" width="700px" append-to-body>
      <div class="details-container">
        
        <el-row :gutter="20">
        
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">商品名称:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.name) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">所属分类:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.classify) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">品牌:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.brand) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">单位:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.units) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">规格详情:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.specificationsdetails) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">描述:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.description) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">价格:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.price) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">封面:</div>
            <div class="detail-value">
              
                <el-image
                  v-if="hasValue(viewForm.photo)"
                  style="width: 100px; height: 100px; border-radius: 6px;"
                  :src="String(viewForm.photo || '').split(',')[0]"
                  :preview-src-list="String(viewForm.photo || '').split(',').filter(Boolean)"
                  fit="cover"
                  preview-teleported
                />
                <span v-else>暂无</span>
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">详情图:</div>
            <div class="detail-value">
              
                <el-image
                  v-if="hasValue(viewForm.photos)"
                  style="width: 100px; height: 100px; border-radius: 6px;"
                  :src="String(viewForm.photos || '').split(',')[0]"
                  :preview-src-list="String(viewForm.photos || '').split(',').filter(Boolean)"
                  fit="cover"
                  preview-teleported
                />
                <span v-else>暂无</span>
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">详细信息:</div>
            <div class="detail-value">
              
                <div
                  v-if="hasValue(viewForm.details)"
                  v-html="viewForm.details"
                  class="detail-html-content"
                ></div>
                <span v-else>暂无</span>
              
            </div>
          </div>
          </el-col>
        
        
        
        
        
        
        
        
        </el-row>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="viewOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs } from "vue";
import requestApi from "@/utils/axios";
import { ElMessageBox } from "element-plus";
import Message from "@/components/MessageBox/index.js";
import ImageUpload from "@/components/ImageUpload/index.vue";
import RichTextEditor from "@/components/RichTextEditor/index.vue";
import FileUpload from "@/components/fileUpload/index.vue";
import { Search, Refresh, Plus, Delete } from "@element-plus/icons-vue";

// 后台空值统一显示“暂无”
const hasValue = (value) => {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value)) return value.length > 0;
  if (typeof value === "string") return value.trim() !== "";
  return true;
};
const displayOrEmpty = (value) => (hasValue(value) ? value : "暂无");


import { getUserData } from "@/utils/auth";

// 用户信息
const userDataObj = ref(null);


// 下拉列表数据

const commodityclassificationOptions = ref([]);


// 初始表单状态
const getInitialForm = () => ({
  id: null,
  name: "",
  classify: "",
  brand: "",
  units: "",
  specificationsdetails: "",
  description: "",
  price: null,
  photo: "",
  photos: "",
  details: "",
  adduserid: null,
  addusername: "",
  addtime: ""
});

const data = reactive({
  loading: true,
  ids: [],
  multiple: true,
  total: 0,
  title: "",
  open: false,
  viewOpen: false, // 控制查看详情对话框
  showSearch: true,
  dataList: [],
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    adduserid: undefined,
    
    
    
    
    name: undefined,
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  },
  form: getInitialForm(),
  viewForm: {}, // 存储详情数据
  rules: {
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  },
});

const {
  loading,
  ids,
  multiple,
  total,
  title,
  open,
  viewOpen,
  showSearch,
  dataList,
  queryParams,
  form,
  viewForm,
  rules,
} = toRefs(data);

const formRef = ref(null);

/** 获取下拉列表数据 */

async function getCommodityclassificationOptions() {
  try {
    const response = await requestApi.post("/api/commodityclassification/list");
    if (response.code == 0) {
      commodityclassificationOptions.value = response.data;
    } else {
      Message.error(response.msg || "获取所属分类列表失败");
    }
  } catch (error) {
    console.error("获取所属分类列表时出错:", error);
    Message.error("请求所属分类列表失败");
  }
}



/** 所属分类 change handler */
function handleClassifyChange(selectedValue) {
  let selectedOption = null;

  const optionsRef = commodityclassificationOptions;
  if (optionsRef && optionsRef.value) {
    const normalize = (v) => (v === undefined || v === null ? "" : String(v));
    selectedOption = optionsRef.value.find((opt) => {
      const optValue = (opt.name || opt.username || opt.title);
      return normalize(optValue) === normalize(selectedValue);
    });
  }

  if (selectedOption) {
    console.log(`找到数据:`, selectedOption);
    const selectedId = selectedOption.id ?? selectedOption.userid ?? selectedOption._id;

    
      
      

      
    

  }
}


/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
  }
}

/** 查询商品信息列表 */
async function getCommodityinformationList() {
  loading.value = true;
  try {
    
    // 如果不是管理员，则根据 adduserid 进行筛选
    if (userDataObj.value && userDataObj.value.id != 1) {
      queryParams.value.adduserid = userDataObj.value.id;
    } else {
      delete queryParams.value.adduserid;
    }
    
    const response = await requestApi.post("/api/commodityinformation/page", queryParams.value);
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取商品信息列表失败");
    }
  } catch (error) {
    console.error("获取商品信息列表时出错:", error);
    Message.error("请求商品信息列表失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getCommodityinformationList();
}

/** 重置按钮操作 */
function resetQuery() {
  const defaultQueryParams = {
    page: 1,
    limit: 10,
    order: "addtime",
    adduserid: undefined,
    
    
    
    
    name: undefined,
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  };
  Object.assign(queryParams.value, defaultQueryParams);
  handleQuery();
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.id);
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  resetForm();
  
  if (userDataObj.value) {
    form.value.adduserid = userDataObj.value.id;
        form.value.addusername = userDataObj.value.name;
  }
  
  open.value = true;
  title.value = "添加商品信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改商品信息";
}

/** 查看详情按钮操作 */
function handleView(row) {
  viewForm.value = row;
  viewOpen.value = true;
}

/** 新增提交 */
async function submitAddForm() {
  try {
    const response = await requestApi.post("/api/commodityinformation/save", form.value);
    if (response.code == 0) {
      Message.success("新增成功");
      open.value = false;
      getCommodityinformationList();
    } else {
      Message.error(response.msg || "新增失败");
    }
  } catch (error) {
    console.error("新增商品信息时出错:", error);
    Message.error("请求失败");
  }
}

/** 修改提交 */
async function submitUpdateForm() {
  try {
    const response = await requestApi.post("/api/commodityinformation/update", form.value);
    if (response.code == 0) {
      Message.success("修改成功");
      open.value = false;
      getCommodityinformationList();
    } else {
      Message.error(response.msg || "修改失败");
    }
  } catch (error) {
    console.error("修改商品信息时出错:", error);
    Message.error("请求失败");
  }
}

/** 提交按钮 */
function submitForm() {
  formRef.value.validate((valid) => {
    if (valid) {
      if (form.value.id) {
        submitUpdateForm();
      } else {
        submitAddForm();
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const itemIds = row.id ? [row.id] : ids.value;
  const confirmMessage = row.id
    ? `是否确认删除ID为"${row.id}"的商品信息数据项？`
    : `是否确认删除选中的${itemIds.length}条商品信息数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/commodityinformation/delete", itemIds);
        if (response.code == 0) {
          Message.success("删除成功");
          getCommodityinformationList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error("删除商品信息时出错:", error);
        Message.error("请求失败");
      }
    })
    .catch(() => {});
}



/** 取消按钮 */
function cancel() {
  open.value = false;
  resetForm();
}

onMounted(async () => {
  
  userDataObj.value = await getUserData();
  
  getCommodityinformationList();
  
  getCommodityclassificationOptions();
  
});
</script>

<style scoped>
.commodityinformation-container {
  padding: 20px;
    background-color: #fff;
  border-radius: 10px;
}
.mb8 {
  margin-bottom: 10px;
}
.dialog-footer {
  text-align: right;
}
.commodityinformation-pagination-container {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
.ellipsis {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
  text-overflow: ellipsis;
  word-break: break-all;
}
.details-container {
  padding: 10px 20px;
}
.detail-item {
  display: flex;
  border-bottom: 1px solid #f0f0f0;
  padding: 15px 0;
  font-size: 14px;
}
.detail-item:last-child {
  border-bottom: none;
}
.detail-label {
  width: 120px;
  color: #606266;
  font-weight: 600;
  flex-shrink: 0;
}
.detail-value {
  flex-grow: 1;
  color: #303133;
}
.detail-html-content {
  overflow: auto;
  max-height: 300px;
}
.detail-link {
  color: #409eff;
  text-decoration: none;
}
.detail-link:hover {
  text-decoration: underline;
}
</style>
