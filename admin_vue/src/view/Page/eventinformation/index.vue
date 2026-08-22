

<template>
  <div class="eventinformation-container">
    <!-- 赛事信息 搜索表单 -->
    
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      
      
      
      
      <el-form-item label="赛事名称" prop="name">
        
        
        <el-input
          v-model="queryParams.name"
          placeholder="请输入赛事名称"
          clearable
          @keyup.enter="handleQuery"
        />
        
      </el-form-item>
      
      
      
      <el-form-item label="赛事类型" prop="classify">
        
        
        <el-input
          v-model="queryParams.classify"
          placeholder="请输入赛事类型"
          clearable
          @keyup.enter="handleQuery"
        />
        
      </el-form-item>
      
      
      
      
      
      <el-form-item label="举办地点" prop="venue">
        
        
        <el-input
          v-model="queryParams.venue"
          placeholder="请输入举办地点"
          clearable
          @keyup.enter="handleQuery"
        />
        
      </el-form-item>
      
      
      
      <el-form-item label="举办日期" prop="holdingdate">
        
        
        <el-date-picker
          v-model="queryParams.holdingdate"
          type="date"
          placeholder="选择日期"
          value-format="YYYY-MM-DD"
        />
        
      </el-form-item>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      <el-form-item>
        <el-button type="primary" :icon="Search" native-type="button" @click="handleQuery">搜索</el-button>
        <el-button :icon="Refresh" native-type="button" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    

    <!-- 赛事信息 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain :icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
    </el-row>

    <!-- 赛事信息 数据表格 -->
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      
      
      
      
        
      <el-table-column label="赛事名称" align="center" prop="name">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.name) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="赛事类型" align="center" prop="classify">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.classify) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="赛事级别" align="center" prop="theleveloftheevent">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.theleveloftheevent) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="举办地点" align="center" prop="venue">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.venue) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="举办日期" align="center" prop="holdingdate">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.holdingdate) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="比赛时间" align="center" prop="competitiontime">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.competitiontime) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="赛程安排" align="center" prop="totheschedule">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.totheschedule) }}</span>
        </template>
      </el-table-column>
        
      
      
      
        
      <el-table-column label="规则与背景" align="center">
        <template #default="scope">
          <div
            v-if="hasValue(scope.row.rulesandbackground)"
            class="ellipsis"
            v-html="scope.row.rulesandbackground"
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

    <!-- 赛事信息 分页 -->
    <div class="eventinformation-pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getEventinformationList"
      />
    </div>

    <!-- 添加或修改 赛事信息 对话框 -->
    <el-dialog :title="title" v-model="open" width="80%" append-to-body @close="cancel">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        
        <el-row :gutter="20">
          
          
          <el-col :span="12" >
            <el-form-item label="赛事名称" prop="name">
              
              <el-input v-model="form.name" placeholder="请输入赛事名称" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="赛事类型" prop="classify">
              
              <el-input v-model="form.classify" placeholder="请输入赛事类型" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="赛事级别" prop="theleveloftheevent">
              
              <el-input v-model="form.theleveloftheevent" placeholder="请输入赛事级别" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="举办地点" prop="venue">
              
              <el-input v-model="form.venue" placeholder="请输入举办地点" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="比赛时间" prop="competitiontime">
              
              <el-input v-model="form.competitiontime" placeholder="请输入比赛时间" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="赛程安排" prop="totheschedule">
              
              <el-input v-model="form.totheschedule" placeholder="请输入赛程安排" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="12" >
            <el-form-item label="举办日期" prop="holdingdate">
              
              <el-date-picker v-model="form.holdingdate" type="datetime" placeholder="选择日期时间" value-format="YYYY-MM-DD HH:mm:ss" />
              
            </el-form-item>
          </el-col>
          
          
          
          <el-col :span="24" >
            <el-form-item label="规则与背景" prop="rulesandbackground">
              
              <RichTextEditor v-model="form.rulesandbackground" />
              
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
            <div class="detail-label">赛事名称:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.name) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">赛事类型:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.classify) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">赛事级别:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.theleveloftheevent) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">举办地点:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.venue) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">举办日期:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.holdingdate) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">比赛时间:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.competitiontime) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="12">
          <div class="detail-item">
            <div class="detail-label">赛程安排:</div>
            <div class="detail-value">
              
               {{ displayOrEmpty(viewForm.totheschedule) }}
              
            </div>
          </div>
          </el-col>
        
        
        
          <el-col :span="24">
          <div class="detail-item">
            <div class="detail-label">规则与背景:</div>
            <div class="detail-value">
              
                <div
                  v-if="hasValue(viewForm.rulesandbackground)"
                  v-html="viewForm.rulesandbackground"
                  class="detail-html-content"
                ></div>
                <span v-else>暂无</span>
              
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


// 初始表单状态
const getInitialForm = () => ({
  id: null,
  name: "",
  classify: "",
  theleveloftheevent: "",
  venue: "",
  holdingdate: "",
  competitiontime: "",
  totheschedule: "",
  rulesandbackground: "",
  photo: "",
  photos: "",
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
    
    
    
    classify: undefined,
    
    
    
    
    
    venue: undefined,
    
    
    
    holdingdate: undefined,
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

/** 查询赛事信息列表 */
async function getEventinformationList() {
  loading.value = true;
  try {
    
    // 如果不是管理员，则根据 adduserid 进行筛选
    if (userDataObj.value && userDataObj.value.id != 1) {
      queryParams.value.adduserid = userDataObj.value.id;
    } else {
      delete queryParams.value.adduserid;
    }
    
    const response = await requestApi.post("/api/eventinformation/page", queryParams.value);
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取赛事信息列表失败");
    }
  } catch (error) {
    console.error("获取赛事信息列表时出错:", error);
    Message.error("请求赛事信息列表失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getEventinformationList();
}

/** 重置按钮操作 */
function resetQuery() {
  const defaultQueryParams = {
    page: 1,
    limit: 10,
    order: "addtime",
    adduserid: undefined,
    
    
    
    
    name: undefined,
    
    
    
    classify: undefined,
    
    
    
    
    
    venue: undefined,
    
    
    
    holdingdate: undefined,
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
  title.value = "添加赛事信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改赛事信息";
}

/** 查看详情按钮操作 */
function handleView(row) {
  viewForm.value = row;
  viewOpen.value = true;
}

/** 新增提交 */
async function submitAddForm() {
  try {
    const response = await requestApi.post("/api/eventinformation/save", form.value);
    if (response.code == 0) {
      Message.success("新增成功");
      open.value = false;
      getEventinformationList();
    } else {
      Message.error(response.msg || "新增失败");
    }
  } catch (error) {
    console.error("新增赛事信息时出错:", error);
    Message.error("请求失败");
  }
}

/** 修改提交 */
async function submitUpdateForm() {
  try {
    const response = await requestApi.post("/api/eventinformation/update", form.value);
    if (response.code == 0) {
      Message.success("修改成功");
      open.value = false;
      getEventinformationList();
    } else {
      Message.error(response.msg || "修改失败");
    }
  } catch (error) {
    console.error("修改赛事信息时出错:", error);
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
    ? `是否确认删除ID为"${row.id}"的赛事信息数据项？`
    : `是否确认删除选中的${itemIds.length}条赛事信息数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/eventinformation/delete", itemIds);
        if (response.code == 0) {
          Message.success("删除成功");
          getEventinformationList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error("删除赛事信息时出错:", error);
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
  
  getEventinformationList();
  
});
</script>

<style scoped>
.eventinformation-container {
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
.eventinformation-pagination-container {
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
