

<template>
  <div class="activityinformation-container">
    <!-- 活动信息 搜索表单 -->
    
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
    

    <!-- 活动信息 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain :icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
    </el-row>

    <!-- 活动信息 数据表格 -->
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      
      
      
      
        
      <el-table-column label="活动名称" align="center" prop="name">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.name) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="活动类型" align="center" prop="classify">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.classify) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="活动主题" align="center" prop="activitytheme">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.activitytheme) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="主办部门" align="center" prop="sponsoringdepartment">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.sponsoringdepartment) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="活动时间" align="center" prop="activitytime">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.activitytime) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="活动地点" align="center" prop="venue">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.venue) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="活动状态" align="center" prop="activestate">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.activestate) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="活动规则" align="center" prop="activityrules">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.activityrules) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="简介" align="center" prop="introduction">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.introduction) }}</span>
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
        
      
      
      
      
      
        
      <el-table-column label="创建人名称" align="center" prop="addusername">
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

    <!-- 活动信息 分页 -->
    <div class="activityinformation-pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getActivityinformationList"
      />
    </div>

    <!-- 添加或修改 活动信息 对话框 -->
    <el-dialog :title="title" v-model="open" width="80%" append-to-body @close="cancel">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        
        <el-row :gutter="20">
          
          
          <el-col :span="12" >
            <el-form-item label="活动名称" prop="name">
              
              <el-input v-model="form.name" placeholder="请输入活动名称" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="活动类型" prop="classify">
              
                
              <el-select v-model="form.classify" placeholder="请选择活动类型" @change="handleClassifyChange">
                
                <el-option
                  v-for="option in activitytypeOptions"
                  :key="(option.id ?? option.userid ?? option._id ?? option.value ?? option.name ?? option.username ?? option.title)"
                  :label="(option.name || option.username || option.title || '未知')"
                  :value="(option.name || option.username || option.title)"
                />
                
              </el-select>
                
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="活动主题" prop="activitytheme">
              
              <el-input v-model="form.activitytheme" placeholder="请输入活动主题" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="主办部门" prop="sponsoringdepartment">
              
              <el-input v-model="form.sponsoringdepartment" placeholder="请输入主办部门" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="活动时间" prop="activitytime">
              
              <el-input v-model="form.activitytime" placeholder="请输入活动时间" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="活动地点" prop="venue">
              
              <el-input v-model="form.venue" placeholder="请输入活动地点" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="活动状态" prop="activestate">
              
                
              <el-select v-model="form.activestate" placeholder="请选择活动状态" @change="handleActivestateChange">
                
                
                <el-option label="未开始" value="未开始" />
                
                <el-option label="已截止" value="已截止" />
                
                
              </el-select>
                
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="活动规则" prop="activityrules">
              
              <el-input
                v-model="form.activityrules"
                :rows="5"
                type="textarea"
                placeholder="请输入活动规则"
              />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="简介" prop="introduction">
              
              <el-input
                v-model="form.introduction"
                :rows="5"
                type="textarea"
                placeholder="请输入简介"
              />
              
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
            <div class="detail-label">活动名称:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.name) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">活动类型:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.classify) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">活动主题:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.activitytheme) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">主办部门:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.sponsoringdepartment) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">活动时间:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.activitytime) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">活动地点:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.venue) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">活动状态:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.activestate) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">活动规则:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.activityrules) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">简介:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.introduction) }}
              
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

const activitytypeOptions = ref([]);


// 初始表单状态
const getInitialForm = () => ({
  id: null,
  name: "",
  classify: "",
  activitytheme: "",
  sponsoringdepartment: "",
  activitytime: "",
  venue: "",
  activestate: "",
  activityrules: "",
  introduction: "",
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

async function getActivitytypeOptions() {
  try {
    const response = await requestApi.post("/api/activitytype/list");
    if (response.code == 0) {
      activitytypeOptions.value = response.data;
    } else {
      Message.error(response.msg || "获取活动类型列表失败");
    }
  } catch (error) {
    console.error("获取活动类型列表时出错:", error);
    Message.error("请求活动类型列表失败");
  }
}



/** 活动类型 change handler */
function handleClassifyChange(selectedValue) {
  let selectedOption = null;

  const optionsRef = activitytypeOptions;
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

/** 活动状态 change handler */
function handleActivestateChange(selectedValue) {
  let selectedOption = null;

  const staticOptions = '未开始,已截止'.split(',');
  const foundOption = staticOptions.find(opt => opt === selectedValue);
  if (foundOption) {
    selectedOption = { value: foundOption, label: foundOption };
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

/** 查询活动信息列表 */
async function getActivityinformationList() {
  loading.value = true;
  try {
    
    // 如果不是管理员，则根据 adduserid 进行筛选
    if (userDataObj.value && userDataObj.value.id != 1) {
      queryParams.value.adduserid = userDataObj.value.id;
    } else {
      delete queryParams.value.adduserid;
    }
    
    const response = await requestApi.post("/api/activityinformation/page", queryParams.value);
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取活动信息列表失败");
    }
  } catch (error) {
    console.error("获取活动信息列表时出错:", error);
    Message.error("请求活动信息列表失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getActivityinformationList();
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
  title.value = "添加活动信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改活动信息";
}

/** 查看详情按钮操作 */
function handleView(row) {
  viewForm.value = row;
  viewOpen.value = true;
}

/** 新增提交 */
async function submitAddForm() {
  try {
    const response = await requestApi.post("/api/activityinformation/save", form.value);
    if (response.code == 0) {
      Message.success("新增成功");
      open.value = false;
      getActivityinformationList();
    } else {
      Message.error(response.msg || "新增失败");
    }
  } catch (error) {
    console.error("新增活动信息时出错:", error);
    Message.error("请求失败");
  }
}

/** 修改提交 */
async function submitUpdateForm() {
  try {
    const response = await requestApi.post("/api/activityinformation/update", form.value);
    if (response.code == 0) {
      Message.success("修改成功");
      open.value = false;
      getActivityinformationList();
    } else {
      Message.error(response.msg || "修改失败");
    }
  } catch (error) {
    console.error("修改活动信息时出错:", error);
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
    ? `是否确认删除ID为"${row.id}"的活动信息数据项？`
    : `是否确认删除选中的${itemIds.length}条活动信息数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/activityinformation/delete", itemIds);
        if (response.code == 0) {
          Message.success("删除成功");
          getActivityinformationList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error("删除活动信息时出错:", error);
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
  
  getActivityinformationList();
  
  getActivitytypeOptions();
  
});
</script>

<style scoped>
.activityinformation-container {
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
.activityinformation-pagination-container {
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
