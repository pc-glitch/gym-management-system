<template>
  <div class="equipment-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">

      <el-form-item label="器材名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入器材名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>

      <el-form-item label="器材分类" prop="classify">
        <el-input
          v-model="queryParams.classify"
          placeholder="请输入器材分类"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>

      <el-form-item label="器材状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择器材状态" clearable>
          <el-option label="正常" value="正常" />
          <el-option label="维修中" value="维修中" />
          <el-option label="已报废" value="已报废" />
          <el-option label="已借出" value="已借出" />
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" :icon="Search" native-type="button" @click="handleQuery">搜索</el-button>
        <el-button :icon="Refresh" native-type="button" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain :icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />

      <el-table-column label="器材名称" align="center" prop="name">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.name) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="器材分类" align="center" prop="classify">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.classify) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="器材编号" align="center" prop="equipmentno">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.equipmentno) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="品牌" align="center" prop="brand">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.brand) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="型号" align="center" prop="model">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.model) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="器材状态" align="center" prop="status">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.status) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="存放位置" align="center" prop="location">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.location) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="单价" align="center" prop="price">
        <template #default="scope">
          <span class="ellipsis">{{ hasValue(scope.row.price) ? '¥' + scope.row.price : '暂无' }}</span>
        </template>
      </el-table-column>

      <el-table-column label="数量" align="center" prop="quantity">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.quantity) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="已借数量" align="center" prop="borrowedquantity">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.borrowedquantity) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="剩余数量" align="center" prop="remainingquantity">
        <template #default="scope">
          <span class="ellipsis">{{ displayOrEmpty(scope.row.remainingquantity) }}</span>
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

    <div class="equipment-pagination-container">
      <el-pagination
        v-show="total > 0"
        :total="total"
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.limit"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleQuery"
        @current-change="getEquipmentList"
      />
    </div>

    <el-dialog :title="title" v-model="open" width="80%" append-to-body @close="cancel">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="器材名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入器材名称" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="器材分类" prop="classify">
              <el-input v-model="form.classify" placeholder="请输入器材分类" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="器材编号" prop="equipmentno">
              <el-input v-model="form.equipmentno" placeholder="请输入器材编号" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="品牌" prop="brand">
              <el-input v-model="form.brand" placeholder="请输入品牌" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="型号" prop="model">
              <el-input v-model="form.model" placeholder="请输入型号" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="购买日期" prop="purchasedate">
              <el-date-picker
                v-model="form.purchasedate"
                type="date"
                placeholder="请选择购买日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
              />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="保修截止日期" prop="warrantyenddate">
              <el-date-picker
                v-model="form.warrantyenddate"
                type="date"
                placeholder="请选择保修截止日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
              />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="器材状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择器材状态">
                <el-option label="正常" value="正常" />
                <el-option label="维修中" value="维修中" />
                <el-option label="已报废" value="已报废" />
                <el-option label="已借出" value="已借出" />
              </el-select>
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="存放位置" prop="location">
              <el-input v-model="form.location" placeholder="请输入存放位置" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="单价" prop="price">
              <el-input-number v-model="form.price" :min="0" :precision="2" placeholder="请输入单价" style="width: 100%" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="数量" prop="quantity">
              <el-input-number v-model="form.quantity" :min="0" placeholder="请输入数量" style="width: 100%" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="已借数量" prop="borrowedquantity">
              <el-input-number v-model="form.borrowedquantity" :min="0" placeholder="请输入已借数量" style="width: 100%" />
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="剩余数量" prop="remainingquantity">
              <el-input-number v-model="form.remainingquantity" :min="0" placeholder="请输入剩余数量" style="width: 100%" />
            </el-form-item>
          </el-col>

          <el-col :span="24">
            <el-form-item label="器材描述" prop="description">
              <el-input
                v-model="form.description"
                :rows="5"
                type="textarea"
                placeholder="请输入器材描述"
              />
            </el-form-item>
          </el-col>

          <el-col :span="24">
            <el-form-item label="封面图片" prop="photo">
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

    <el-dialog title="查看详情" v-model="viewOpen" width="700px" append-to-body>
      <div class="details-container">
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">器材名称:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.name) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">器材分类:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.classify) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">器材编号:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.equipmentno) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">品牌:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.brand) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">型号:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.model) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">购买日期:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.purchasedate) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">保修截止日期:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.warrantyenddate) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">器材状态:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.status) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">存放位置:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.location) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">单价:</div>
              <div class="detail-value">{{ hasValue(viewForm.price) ? '¥' + viewForm.price : '暂无' }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">数量:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.quantity) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">已借数量:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.borrowedquantity) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">剩余数量:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.remainingquantity) }}</div>
            </div>
          </el-col>

          <el-col :span="24">
            <div class="detail-item">
              <div class="detail-label">器材描述:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.description) }}</div>
            </div>
          </el-col>

          <el-col :span="24">
            <div class="detail-item">
              <div class="detail-label">封面图片:</div>
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

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">创建人:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.addusername) }}</div>
            </div>
          </el-col>

          <el-col :span="12">
            <div class="detail-item">
              <div class="detail-label">创建时间:</div>
              <div class="detail-value">{{ displayOrEmpty(viewForm.addtime) }}</div>
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
import { Search, Refresh, Plus, Delete } from "@element-plus/icons-vue";

const hasValue = (value) => {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value)) return value.length > 0;
  if (typeof value === "string") return value.trim() !== "";
  return true;
};
const displayOrEmpty = (value) => (hasValue(value) ? value : "暂无");

import { getUserData } from "@/utils/auth";

const userDataObj = ref(null);

const getInitialForm = () => ({
  id: null,
  name: "",
  classify: "",
  equipmentno: "",
  brand: "",
  model: "",
  purchasedate: "",
  warrantyenddate: "",
  status: "",
  location: "",
  price: null,
  quantity: null,
  borrowedquantity: null,
  remainingquantity: null,
  description: "",
  photo: "",
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
  viewOpen: false,
  showSearch: true,
  dataList: [],
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    adduserid: undefined,
    name: undefined,
    classify: undefined,
    equipmentno: undefined,
    brand: undefined,
    model: undefined,
    status: undefined,
    location: undefined,
    price: undefined,
    quantity: undefined,
    borrowedquantity: undefined,
    remainingquantity: undefined,
    description: undefined,
    photo: undefined
  },
  form: getInitialForm(),
  viewForm: {},
  rules: {}
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
  rules
} = toRefs(data);

const formRef = ref(null);

/** 查询器材信息列表 */
async function getEquipmentList() {
  loading.value = true;
  try {
    if (userDataObj.value && userDataObj.value.id != 1) {
      queryParams.value.adduserid = userDataObj.value.id;
    } else {
      delete queryParams.value.adduserid;
    }
    const response = await requestApi.post("/api/equipment/page", queryParams.value);
    if (response.code == 0) {
      dataList.value = response.data.list;
      total.value = parseInt(response.data.total);
    } else {
      Message.error(response.msg || "获取器材信息列表失败");
    }
  } catch (error) {
    console.error("获取器材信息列表时出错:", error);
    Message.error("请求器材信息列表失败");
  } finally {
    loading.value = false;
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getEquipmentList();
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
    equipmentno: undefined,
    brand: undefined,
    model: undefined,
    status: undefined,
    location: undefined,
    price: undefined,
    quantity: undefined,
    borrowedquantity: undefined,
    remainingquantity: undefined,
    description: undefined,
    photo: undefined
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
  title.value = "添加器材信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  Object.assign(form.value, row);
  open.value = true;
  title.value = "修改器材信息";
}

/** 查看详情按钮操作 */
function handleView(row) {
  viewForm.value = row;
  viewOpen.value = true;
}

/** 新增提交 */
async function submitAddForm() {
  try {
    const response = await requestApi.post("/api/equipment/save", form.value);
    if (response.code == 0) {
      Message.success("新增成功");
      open.value = false;
      getEquipmentList();
    } else {
      Message.error(response.msg || "新增失败");
    }
  } catch (error) {
    console.error("新增器材信息时出错:", error);
    Message.error("请求失败");
  }
}

/** 修改提交 */
async function submitUpdateForm() {
  try {
    const response = await requestApi.post("/api/equipment/update", form.value);
    if (response.code == 0) {
      Message.success("修改成功");
      open.value = false;
      getEquipmentList();
    } else {
      Message.error(response.msg || "修改失败");
    }
  } catch (error) {
    console.error("修改器材信息时出错:", error);
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
    ? `是否确认删除ID为"${row.id}"的器材信息数据项？`
    : `是否确认删除选中的${itemIds.length}条器材信息数据项？`;

  ElMessageBox.confirm(confirmMessage, "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/equipment/delete", itemIds);
        if (response.code == 0) {
          Message.success("删除成功");
          getEquipmentList();
        } else {
          Message.error(response.msg || "删除失败");
        }
      } catch (error) {
        console.error("删除器材信息时出错:", error);
        Message.error("请求失败");
      }
    })
    .catch(() => {});
}

/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
  }
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  resetForm();
}

onMounted(async () => {
  userDataObj.value = await getUserData();
  getEquipmentList();
});
</script>

<style scoped>
.equipment-container {
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
.equipment-pagination-container {
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