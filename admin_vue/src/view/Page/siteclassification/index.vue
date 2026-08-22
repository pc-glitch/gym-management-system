

<template>
  <div class="siteclassification-container">
    <!-- 场地分类 搜索表单 -->
    
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      
      
      
      
      <el-form-item label="分类名称" prop="name">
        
        
        <el-input
          v-model="queryParams.name"
          placeholder="请输入分类名称"
          clearable
          @keyup.enter="handleQuery"
        />
        
      </el-form-item>
      
      
      
      
      <el-form-item>
        <el-button type="primary" :icon="Search" native-type="button" @click="handleQuery">搜索</el-button>
        <el-button :icon="Refresh" native-type="button" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    

    <!-- 场地分类 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain :icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
    </el-row>

    <!-- 场地分类 数据表格 -->
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      
      
      
      
        
      <el-table-column label="分类名称" align="center" prop="name">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.name) }}</span>
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

    <!-- 场地分类 分页 -->
    <div class="siteclassification-pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getSiteclassificationList"
      />
    </div>

    <!-- 添加或修改 场地分类 对话框 -->
    <el-dialog :title="title" v-model="open" width="80%" append-to-body @close="cancel">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        
        <el-row :gutter="20">
          
          
          <el-col :span="12" >
            <el-form-item label="分类名称" prop="name">
              
              <el-input v-model="form.name" placeholder="请输入分类名称" />
              
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
            <div class="detail-label">分类名称:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.name) }}
              
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



// 下拉列表数据


// 初始表单状态
const getInitialForm = () => ({
  id: null,
  name: "",
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




/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
  }
}

/** 查询场地分类列表 */
async function getSiteclassificationList() {
  loading.value = true;
  try {
    
    const response = await requestApi.post("/api/siteclassification/page", queryParams.value);
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取场地分类列表失败");
    }
  } catch (error) {
    console.error("获取场地分类列表时出错:", error);
    Message.error("请求场地分类列表失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getSiteclassificationList();
}

/** 重置按钮操作 */
function resetQuery() {
  const defaultQueryParams = {
    page: 1,
    limit: 10,
    order: "addtime",
    
    
    
    
    
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
  
  open.value = true;
  title.value = "添加场地分类";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改场地分类";
}

/** 查看详情按钮操作 */
function handleView(row) {
  viewForm.value = row;
  viewOpen.value = true;
}

/** 新增提交 */
async function submitAddForm() {
  try {
    const response = await requestApi.post("/api/siteclassification/save", form.value);
    if (response.code == 0) {
      Message.success("新增成功");
      open.value = false;
      getSiteclassificationList();
    } else {
      Message.error(response.msg || "新增失败");
    }
  } catch (error) {
    console.error("新增场地分类时出错:", error);
    Message.error("请求失败");
  }
}

/** 修改提交 */
async function submitUpdateForm() {
  try {
    const response = await requestApi.post("/api/siteclassification/update", form.value);
    if (response.code == 0) {
      Message.success("修改成功");
      open.value = false;
      getSiteclassificationList();
    } else {
      Message.error(response.msg || "修改失败");
    }
  } catch (error) {
    console.error("修改场地分类时出错:", error);
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
    ? `是否确认删除ID为"${row.id}"的场地分类数据项？`
    : `是否确认删除选中的${itemIds.length}条场地分类数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/siteclassification/delete", itemIds);
        if (response.code == 0) {
          Message.success("删除成功");
          getSiteclassificationList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error("删除场地分类时出错:", error);
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
  
  getSiteclassificationList();
  
});
</script>

<style scoped>
.siteclassification-container {
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
.siteclassification-pagination-container {
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
