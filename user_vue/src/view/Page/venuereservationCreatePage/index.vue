
<template>
  <div class="evaluation-page-container">


    <main class="content-area">
      <el-tabs v-model="activeTab" class="main-tabs">
        <!-- 数据列表 Tab -->
        <el-tab-pane :label="tableComment + '列表'" name="list">
          <div class="card">
            <!-- 搜索表单 -->
            <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="80px" class="search-form">
              
              
              
              
              <el-form-item label="场地名称" prop="name">
                
                <el-input v-model="queryParams.name" placeholder="请输入场地名称" clearable @keyup.enter="handleQuery" />
                
              </el-form-item>
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              <el-form-item>
                <el-button type="primary" native-type="button" @click="handleQuery">查询</el-button>
                <el-button native-type="button" @click="resetQuery">重置</el-button>
              </el-form-item>
            </el-form>

            <!-- 操作按钮 -->
            <div class="action-buttons">
              <el-button type="primary" plain @click="handleAdd">发布新{{ tableComment }}</el-button>
              <el-button type="danger" plain :disabled="multiple" @click="handleDelete">批量删除</el-button>
            </div>
          </div>

          <!-- 数据表格 -->
          <div class="data-panel card">
	            <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
	              <el-table-column type="selection" width="55" align="center" />
	              
	              
	              
	              
	                
	              <el-table-column label="场地名称" align="center" prop="name">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.name) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	                
	              <el-table-column label="预约开始时间" align="center" prop="thereservationstarttime">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.thereservationstarttime) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	                
	              <el-table-column label="预约结束时间" align="center" prop="appointmentendtime">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.appointmentendtime) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	              
	              
	                
	              <el-table-column label="备注信息" align="center" prop="remarkinformation">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.remarkinformation) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	              
	              
	                
	              <el-table-column label="预约人" align="center" prop="reservationpersonname">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.reservationpersonname) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	              
	              
	                
	              <el-table-column label="审核人" align="center" prop="addusername">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.addusername) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	                
	              <el-table-column label="审核" align="center" prop="shenhe">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.shenhe) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	              
	              
	                
	              <el-table-column label="审核回复" align="center" prop="shenhehuifu">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.shenhehuifu) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	              
	              
	                
	              <el-table-column label="用户名称" align="center" prop="username">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.username) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
	              
	                
	              <el-table-column label="创建时间" align="center" prop="addtime">
	                <template #default="scope">
	                  <span>{{ displayOrEmpty(scope.row.addtime) }}</span>
	                </template>
	              </el-table-column>
	                
	              
	              
              <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="120">
                <template #default="scope">
                  <div class="table-actions">
                    <button class="table-action-btn edit" @click="handleUpdate(scope.row)">编辑</button>
                    <button class="table-action-btn delete" @click="handleDelete(scope.row)">删除</button>
                  </div>
                </template>
              </el-table-column>
            </el-table>

            <!-- 分页 -->
            <div class="pagination-container">
              <el-pagination v-show="total > 0" :total="total" v-model:current-page="queryParams.page" v-model:page-size="queryParams.limit" layout="total, sizes, prev, pager, next, jumper" @size-change="handleQuery" @current-change="getList" />
            </div>
          </div>
        </el-tab-pane>

        <!-- 新增/修改 Tab 公用表单 -->
        <el-tab-pane v-if="activeTab === 'create' || activeTab === 'edit'" :label="form.id ? '修改' + tableComment : '新增' + tableComment" :name="activeTab">
          <div class="card">
            <el-form :ref="form.id ? 'updateFormRef' : 'createFormRef'" :model="form" :rules="rules" label-width="120px" class="dialog-form">
              
              
              <el-form-item label="场地名称" prop="name">
                
                  
                    <div class="card-select-container">
                      <div v-for="option in venueinformationOptions" :key="option.id" class="option-card" :class="{ selected: form.name === (option.name || option.username || option.title) }" @click="handleNameChange(option.name || option.username || option.title)">
                        
                        <div class="card-image-wrapper">
                          <img :src="option.photo || '/default-placeholder.png'" alt="封面" class="card-image" />
                        </div>
                        
                        <div class="card-content">
                          <div v-if="form.name === (option.name || option.username || option.title)" class="selected-checkmark"><div class="checkmark-icon"></div></div>
                          <div class="card-name">{{ option.name || option.username || option.title || '未知' }}</div>
                          <div class="card-details-wrapper">
                            
                              
                              <div class="card-detail-item">
                                <span class="card-detail-label">场地名称:</span>
                                <span class="card-detail-value">{{ option.name || '无' }}</span>
                              </div>
                              
                              <div class="card-detail-item">
                                <span class="card-detail-label">俱乐部名称:</span>
                                <span class="card-detail-value">{{ option.clubname || '无' }}</span>
                              </div>
                              
                            
                          </div>
                        </div>
                      </div>
                    </div>
                  
                
              </el-form-item>
              
              
              
              <el-form-item label="备注信息" prop="remarkinformation">
                
                <el-input v-model="form.remarkinformation" :rows="4" type="textarea" placeholder="请输入备注信息" />
                
              </el-form-item>
              
              
              
              <el-form-item label="预约开始时间" prop="thereservationstarttime">
                
                <el-date-picker v-model="form.thereservationstarttime" type="datetime" placeholder="选择日期时间" value-format="YYYY-MM-DD HH:mm:ss" />
                
              </el-form-item>
              
              
              
              <el-form-item label="预约结束时间" prop="appointmentendtime">
                
                <el-date-picker v-model="form.appointmentendtime" type="datetime" placeholder="选择日期时间" value-format="YYYY-MM-DD HH:mm:ss" />
                
              </el-form-item>
              
              
              
              <el-form-item label="封面" prop="photo">
                
                <ImageUpload v-model="form.photo" />
                
              </el-form-item>
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
            </el-form>
            <div class="form-footer">
              <el-button @click="form.id ? cancelEdit() : cancelCreate()">取 消</el-button>
              <el-button type="primary" @click="form.id ? submitUpdateForm() : submitCreateForm()">{{ form.id ? '确认修改' : '确认提交' }}</el-button>
            </div>
          </div>
        </el-tab-pane>
      </el-tabs>
    </main>
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
import { getUserData } from "@/utils/auth.js";

const activeTab = ref('list');
const tableComment = "场地预约";

// 空值统一显示“暂无”（管理端/表格场景）
const hasValue = (value) => {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value)) return value.length > 0;
  if (typeof value === "string") return value.trim() !== "";
  return true;
};
const displayOrEmpty = (value) => (hasValue(value) ? value : "暂无");

// 下拉列表数据

const venueinformationOptions = ref([]);


// 初始表单状态
const getInitialForm = () => ({
  id: null,
  name: "",
  thereservationstarttime: "",
  appointmentendtime: "",
  photo: "",
  remarkinformation: "",
  reservationpersonid: null,
  reservationpersonname: "",
  adduserid: null,
  addusername: "",
  shenhe: "",
  shenheid: null,
  shenhehuifu: "",
  userid: null,
  username: "",
  addtime: ""
});

const data = reactive({
  loading: true,
  ids: [],
  multiple: true,
  total: 0,
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

const { loading, ids, multiple, total, showSearch, dataList, queryParams, form, rules } = toRefs(data);
const createFormRef = ref(null);
const updateFormRef = ref(null);


/** 场地名称 change handler */
function handleNameChange(selectedValue) {
  form.value.name = selectedValue;
  let selectedOption = null;

  const optionsRef = venueinformationOptions;
  if (optionsRef && optionsRef.value) {
    selectedOption = optionsRef.value.find(opt => (opt.name || opt.username || opt.title) === selectedValue);
  }

  if (selectedOption) {
    console.log(`找到数据 'name' :`, selectedOption);
  }
}


/** 获取下拉列表数据 */

async function getVenueinformationOptions() {
  try {
    const response = await requestApi.post("/api/venueinformation/list");
    if (response.code == 0) {
      venueinformationOptions.value = response.data;
    } else {
      Message.error(response.msg || "获取venueinformation列表失败");
    }
  } catch (error) {
    console.error(error);
    Message.error("请求venueinformation列表失败");
  }
}


/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (createFormRef.value) createFormRef.value.clearValidate();
  if (updateFormRef.value) updateFormRef.value.clearValidate();
}

/** 查询列表 */
async function getList() {
  loading.value = true;
  try {
    const response = await requestApi.post("/api/venuereservation/page", queryParams.value);
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
  const defaultQueryParams = { page: 1, limit: 10, order: "addtime" };
  Object.keys(queryParams.value).forEach(key => {
    if (!defaultQueryParams.hasOwnProperty(key)) {
      queryParams.value[key] = undefined;
    }
  });
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
  form.value.userid = userid.value;
  form.value.username = username.value;
  form.value.reservationpersonid = userid.value;
  form.value.reservationpersonname = username.value;
  form.value.shenhe = "待审核";
  form.value.shenhehuifu = "";
  activeTab.value = 'create';
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  const newForm = { ...row };
  
    
      if (newForm.id !== null && newForm.id !== undefined) {
        const parsedValue = parseFloat(newForm.id);
        newForm.id = isNaN(parsedValue) ? null : parsedValue;
      }
    
  
    
  
    
  
    
  
    
  
    
  
    
      if (newForm.reservationpersonid !== null && newForm.reservationpersonid !== undefined) {
        const parsedValue = parseFloat(newForm.reservationpersonid);
        newForm.reservationpersonid = isNaN(parsedValue) ? null : parsedValue;
      }
    
  
    
  
    
      if (newForm.adduserid !== null && newForm.adduserid !== undefined) {
        const parsedValue = parseFloat(newForm.adduserid);
        newForm.adduserid = isNaN(parsedValue) ? null : parsedValue;
      }
    
  
    
  
    
  
    
      if (newForm.shenheid !== null && newForm.shenheid !== undefined) {
        const parsedValue = parseFloat(newForm.shenheid);
        newForm.shenheid = isNaN(parsedValue) ? null : parsedValue;
      }
    
  
    
  
    
      if (newForm.userid !== null && newForm.userid !== undefined) {
        const parsedValue = parseFloat(newForm.userid);
        newForm.userid = isNaN(parsedValue) ? null : parsedValue;
      }
    
  
    
  
    
  
  Object.assign(form.value, newForm);
  activeTab.value = 'edit';
}

/** 提交新增表单 */
async function submitCreateForm() {
  createFormRef.value.validate(async (valid) => {
    if (valid) {
      try {
        if (
          form.value.thereservationstarttime &&
          form.value.appointmentendtime &&
          new Date(form.value.thereservationstarttime).getTime() >=
            new Date(form.value.appointmentendtime).getTime()
        ) {
          Message.warning("预约结束时间需晚于预约开始时间");
          return;
        }
        form.value.userid = userid.value;
        form.value.username = username.value;
        form.value.reservationpersonid = userid.value;
        form.value.reservationpersonname = username.value;
        if (!form.value.shenhe) {
          form.value.shenhe = "待审核";
        }
        if (!form.value.shenhehuifu) {
          form.value.shenhehuifu = "";
        }
        const response = await requestApi.post("/api/venuereservation/save", form.value);
        if (response.code == 0) {
          Message.success("新增成功");
          activeTab.value = 'list';
          getList();
        } else {
          Message.error(response.msg || "操作失败");
        }
      } catch (error) {
        console.error(error);
        Message.error("请求失败");
      }
    }
  });
}

/** 提交修改表单 */
async function submitUpdateForm() {
  updateFormRef.value.validate(async (valid) => {
    if (valid) {
      try {
        if (
          form.value.thereservationstarttime &&
          form.value.appointmentendtime &&
          new Date(form.value.thereservationstarttime).getTime() >=
            new Date(form.value.appointmentendtime).getTime()
        ) {
          Message.warning("预约结束时间需晚于预约开始时间");
          return;
        }
        form.value.userid = userid.value;
        form.value.username = username.value;
        form.value.reservationpersonid = userid.value;
        form.value.reservationpersonname = username.value;
        const response = await requestApi.post("/api/venuereservation/update", form.value);
        if (response.code == 0) {
          Message.success("修改成功");
          resetForm();
          activeTab.value = 'list';
          getList();
        } else {
          Message.error(response.msg || "操作失败");
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
  const confirmMessage = row.id ? `是否确认删除ID为"${row.id}"的数据项？` : `是否确认删除选中的${itemIds.length}条数据项？`;
  ElMessageBox.confirm(confirmMessage, "警告", { confirmButtonText: "确定", cancelButtonText: "取消", type: "warning" })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/venuereservation/delete", itemIds);
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

/** 新增页取消按钮 */
function cancelCreate() {
  resetForm();
  activeTab.value = 'list';
}

/** 修改页取消按钮 */
function cancelEdit() {
  resetForm();
  activeTab.value = 'list';
}

let userid = ref("");
let username = ref("");
onMounted(async () => {
  const userData = await getUserData();
  userid.value = userData?.userid || userData?.id;
  username.value = userData?.username;
  queryParams.value.userid = userid.value;
  getList();
  
  getVenueinformationOptions();
  
});
</script>

<style scoped>
.evaluation-page-container { background-color: #f0f2f5; min-height: 100vh; padding: 24px; font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif; }
.page-header { margin-bottom: 24px; }
.page-header h1 { font-size: 28px; color: #1d2129; font-weight: 700; margin: 0 0 8px 0; }
.page-header p { font-size: 14px; color: #86909c; margin: 0; }
.content-area { display: flex; flex-direction: column; gap: 20px; }
.card { background-color: #ffffff; border-radius: 8px; padding: 24px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06); transition: box-shadow 0.3s ease; }
.card:hover { box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08); }
.main-tabs { background-color: #fff; padding: 0 20px; border-radius: 8px; }
:deep(.el-tabs__header) { margin: 0; }
:deep(.el-tabs__nav-wrap::after) { height: 1px; background-color: #e5e6eb; }
:deep(.el-tabs__item) { font-size: 16px; font-weight: 500; }
.search-form { display: flex; flex-wrap: wrap; gap: 16px; align-items: center; }
.action-buttons { display: flex; justify-content: flex-start; gap: 10px; margin-top: 16px; padding-top: 16px; border-top: 1px solid #f0f0f0; }
.data-panel { margin-top: 20px; }
:deep(.el-table) { border-radius: 8px; overflow: hidden; }
:deep(.el-table th.el-table__cell) { background-color: #fafafa; color: #4e5969; font-weight: 600; }
:deep(.el-table tr:hover > td.el-table__cell) { background-color: #f7f8fa; }
.table-actions { display: flex; gap: 8px; justify-content: center; }
.table-action-btn { background: none; border: none; cursor: pointer; font-size: 14px; font-weight: 500; padding: 4px 8px; border-radius: 4px; transition: background-color 0.2s ease; }
.table-action-btn.edit { color: #1890ff; }
.table-action-btn.edit:hover { background-color: #e6f7ff; }
.table-action-btn.delete { color: #ff4d4f; }
.table-action-btn.delete:hover { background-color: #fff1f0; }
.pagination-container { display: flex; justify-content: flex-end; margin-top: 24px; }
.dialog-form .el-form-item, .card .el-form-item { margin-bottom: 22px; }
.form-footer { display: flex; justify-content: flex-end; margin-top: 24px; padding-top: 24px; border-top: 1px solid #f0f0f0; }

/* Modern Card Styles */
.card-select-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 20px; max-height: 500px; overflow-y: auto; padding: 20px; border: 1px solid #e5e6eb; border-radius: 12px; background-color: #f9fafb; width: 100%; }
.option-card { position: relative; border: 1px solid #e5e6eb; border-radius: 12px; cursor: pointer; transition: all 0.3s ease-in-out; background-color: #fff; overflow: hidden; display: flex; flex-direction: column; }
.option-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.07), 0 4px 6px -2px rgba(0, 0, 0, 0.05); }
.option-card.selected { border-color: #4f46e5; box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2); }
.card-image-wrapper { width: 100%; height: 120px; overflow: hidden; border-bottom: 1px solid #f3f4f6; }
.card-image { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease; }
.option-card:hover .card-image { transform: scale(1.05); }
.card-content { padding: 20px; position: relative; flex-grow: 1; display: flex; flex-direction: column; }
.card-name { font-weight: 600; color: #111827; font-size: 18px; padding-bottom: 12px; margin-bottom: 12px; border-bottom: 1px solid #f3f4f6; }
.card-details-wrapper { display: flex; flex-direction: column; gap: 10px; }
.card-detail-item { display: flex; justify-content: space-between; align-items: center; font-size: 14px; }
.card-detail-value {
  color: #374151;
  font-weight: 500;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  word-break: break-all;
}
.card-detail-value { color: #374151; font-weight: 500; }
.selected-checkmark { position: absolute; top: 12px; right: 12px; width: 24px; height: 24px; background-color: #4f46e5; border-radius: 50%; display: flex; align-items: center; justify-content: center; transform: scale(0); transition: transform 0.2s ease-out; z-index: 1; }
.option-card.selected .selected-checkmark { transform: scale(1); }
.checkmark-icon { width: 6px; height: 12px; border: solid white; border-width: 0 2.5px 2.5px 0; transform: rotate(45deg) translate(-1px, -2px); }
</style>
