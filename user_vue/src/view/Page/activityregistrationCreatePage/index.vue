<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      
      
      
      
      <el-form-item label="活动名称" prop="name">
        
        <el-input
          v-model="queryParams.name"
          placeholder="请输入活动名称"
          clearable
          @keyup.enter="handleQuery"
        />
        
      </el-form-item>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      <el-form-item>
        <el-button type="primary" :icon="Search" native-type="button" @click="handleQuery">搜索</el-button>
        <el-button :icon="Refresh" native-type="button" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain :icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
    </el-row>

    <!-- 数据表格 -->
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      
      
      
      
      
        
      <el-table-column label="活动名称" align="center" prop="name">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.name) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
      
      
      
      
        
      <el-table-column label="报名人" align="center" prop="username">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.username) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
        
      <el-table-column label="审核" align="center" prop="shenhe">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.shenhe) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
      
      
      
        
      <el-table-column label="报名信息" align="center" prop="registrationinformation">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.registrationinformation) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
      
      
      
        
      <el-table-column label="审核人" align="center" prop="addusername">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.addusername) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
        
      <el-table-column label="审核回复" align="center" prop="shenhehuifu">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.shenhehuifu) }}</span>
        </template>
      </el-table-column>
        
      
      
      
      
        
      <el-table-column label="创建时间" align="center" prop="addtime">
        <template #default="scope">
          <span>{{ displayOrEmpty(scope.row.addtime) }}</span>
        </template>
      </el-table-column>
        
      
      
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="150">
        <template #default="scope">
          
          <!-- 审核页不提供编辑 -->
          
          <el-button type="danger" link @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div class="pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getList"
      />
    </div>

    <!-- 添加或修改对话框 -->
    <el-dialog :title="title" v-model="open" width="80%" append-to-body @close="cancel">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        
        
        <el-row :gutter="20">
          
          
          <el-col :span="12" >
            <el-form-item label="活动名称" prop="name">
              
                
              <el-select v-model="form.name" placeholder="请选择活动名称" @change="handleNameChange">
                
                <el-option
                  v-for="option in activityinformationOptions"
                  :key="option.id"
                  :label="option.name || option.username || option.title || '未知'"
                  :value="option.name || option.username || option.title"
                />
                
              </el-select>
                
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="报名信息" prop="registrationinformation">
              
              <el-input
                v-model="form.registrationinformation"
                :rows="2"
                type="textarea"
                placeholder="请输入报名信息"
              />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="照片" prop="photo">
              
              <ImageUpload v-model="form.photo" />
              
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
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs } from "vue";
import requestApi from "@/utils/axios";
import { ElMessageBox } from "element-plus";
import Message from "@/components/MessageBox/index.js";
import ImageUpload from "@/components/ImageUpload/index.vue";
import RichTextEditor from "@/components/RichTextEditor/index.vue";
import fileUpload from "@/components/fileUpload/index.vue";
import { Search, Refresh, Plus, Delete } from "@element-plus/icons-vue";
import { getUserData } from "@/utils/auth.js"; 

// 空值统一显示“暂无”（管理端/表格场景）
const hasValue = (value) => {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value)) return value.length > 0;
  if (typeof value === "string") return value.trim() !== "";
  return true;
};
const displayOrEmpty = (value) => (hasValue(value) ? value : "暂无");

// 下拉列表数据

const activityinformationOptions = ref([]);


// 初始表单状态
const getInitialForm = () => ({
  id: null,
  name: "",
  shenheid: null,
  userid: null,
  username: "",
  shenhe: "",
  photo: "",
  registrationinformation: "",
  adduserid: null,
  addusername: "",
  shenhehuifu: "",
  addtime: ""
});

const data = reactive({
  loading: true,
  ids: [],
  multiple: true,
  total: 0,
  title: "",
  open: false,
  showSearch: true,
  dataList: [],
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    
    
    
    
    name: undefined,
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  },
  form: getInitialForm(),
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
  showSearch,
  dataList,
  queryParams,
  form,
  rules,
} = toRefs(data);

const formRef = ref(null);


/** 活动名称 change handler */
function handleNameChange(selectedValue) {
  let selectedOption = null;

  const optionsRef = activityinformationOptions;
  if (optionsRef && optionsRef.value) {
    selectedOption = optionsRef.value.find(opt => (opt.name || opt.username || opt.title) === selectedValue);
  }

  if (selectedOption) {
    console.log(`找到数据 'name' :`, selectedOption);
    // 后续处理逻辑
    // form.value.username = selectedOption.username;
  }
}


/** 获取下拉列表数据 */

async function getActivityinformationOptions() {
  try {
    const response = await requestApi.post("/api/activityinformation/list");
    if (response.code == 0) {
      activityinformationOptions.value = response.data;
    } else {
      Message.error(response.msg || "获取activityinformation列表失败");
    }
  } catch (error) {
    console.error(error);
    Message.error("请求activityinformation列表失败");
  }
}


/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
  }
}

/** 查询列表 */
async function getList() {
  loading.value = true;
  try {
    const response = await requestApi.post("/api/activityregistration/page", queryParams.value);
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取列表失败");
    }
  } catch (error) {
    console.error(error);
    Message.error("请求失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getList();
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
  title.value = "添加活动报名";
  
  // 若表包含 shenhe 字段，则默认设置为“待审核”
  form.value.shenhe = "待审核";
  
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改活动报名";
}
/** 提交按钮 */
async function submitForm() {
  formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        form.value.userid = userid.value;
        form.value.username = username.value;
        if (form.value.id) {
          const response = await requestApi.post("/api/activityregistration/update", form.value);
          if (response.code == 0) {
            Message.success("修改成功");
            open.value = false;
            getList();
          } else {
            Message.error(response.msg || "操作失败");
          }
        } else {
          
          // 若表包含 shenhe 字段，则默认设置为“待审核”
          form.value.shenhe = "待审核";
          form.value.shenhehuifu = "";
          
          const response = await requestApi.post("/api/activityregistration/save", form.value);
          if (response.code == 0) {
            Message.success("新增成功");
            open.value = false;
            getList();
          } else {
            Message.error(response.msg || "操作失败");
          }
        }
      } catch (error) {
        console.error(error);
        Message.error("请求失败");
      }
    }
  });
}


/** 删除按钮操作 */
function handleDelete(row) {
  const itemIds = row.id ? [row.id] : ids.value;
  const confirmMessage = row.id
    ? `是否确认删除ID为"${row.id}"的数据项？`
    : `是否确认删除选中的${itemIds.length}条数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/activityregistration/delete", itemIds);
        if (response.code == 0) {
          Message.success("删除成功");
          getList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error(error);
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

let userid = ref("")
let username = ref("")
onMounted(async () => {
  const userData = await getUserData();
  userid.value = userData?.userid || userData?.id;
  username.value = userData?.username;
  queryParams.value.userid = userid.value;

  getList();
  
  getActivityinformationOptions();
  
});
</script>

<style scoped>
.app-container {
  padding: 20px;
}
.mb8 {
  margin-bottom: 10px;
}
.dialog-footer {
  text-align: right;
}
.pagination-container {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>