<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form
      :model="queryParams"
      ref="queryForm"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="订单编号" prop="orderid">
        <el-input
          v-model="queryParams.orderid"
          placeholder="请输入订单编号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品名称" prop="goodname">
        <el-input
          v-model="queryParams.goodname"
          placeholder="请输入商品名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="联系人" prop="consignee">
        <el-input
          v-model="queryParams.consignee"
          placeholder="请输入联系人"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          style="width: 168px"
          v-model="queryParams.status"
          placeholder="请选择状态"
          clearable
        >
          <el-option label="待支付" value="待支付" />
          <el-option label="已支付" value="已支付" />
          <el-option label="已发货" value="已发货" />
          <el-option label="已收货" value="已收货" />
          <el-option label="申请退款" value="申请退款" />
          <el-option label="退款中" value="退款中" />
          <el-option label="已退款" value="已退款" />
          <el-option label="已评价" value="已评价" />
          <el-option label="已取消" value="已取消" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" :icon="Search" @click="handleQuery">
          搜索</el-button
        >
        <el-button :icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <!-- <el-col :span="1.5">
        <el-button type="primary" plain :icon="Plus" @click="handleAdd"
          >新增</el-button
        >
      </el-col> -->
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          :icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          >删除</el-button
        >
      </el-col>
    </el-row>

    <!-- 数据表格 -->
    <el-table
      v-loading="loading"
      :data="ordersList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column
        label="订单编号"
        align="center"
        prop="orderid"
        width="200"
      />
      <el-table-column label="商品/服务" align="center" prop="goodname" />
      <el-table-column label="商品图片" align="center" prop="picture">
        <template #default="scope">
          <img
            style="width: 100%; height: 100%"
            :src="scope.row.picture"
            alt=""
          />
        </template>
      </el-table-column>
      <el-table-column label="数量" align="center" prop="buynumber" />
      <el-table-column label="总价格" align="center" prop="total" />
      <el-table-column label="状态" align="center" prop="status" />
      <el-table-column label="联系人" align="center" prop="consignee" />
      <el-table-column label="电话" align="center" prop="tel" width="120" />
      <el-table-column label="到场地点" align="center" prop="address" width="250" />
      <el-table-column
        label="创建时间"
        align="center"
        prop="addtime"
        width="180"
      />
      <!-- <el-table-column label="物流" align="center" prop="logistics" /> -->
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        fixed="right"
        width="260"
      >
        <template #default="scope">
          <el-button
            v-if="scope.row.status === '已支付'"
            type="primary"
            link
            @click="handleStatusChange(scope.row, '已发货')"
            >已发货</el-button
          >
          <el-button
            v-if="scope.row.status === '已发货'"
            type="success"
            link
            @click="handleStatusChange(scope.row, '已收货')"
            >已收货</el-button
          >
          <el-button type="primary" link @click="handleLogistics(scope.row)"
            >物流进度</el-button
          >
          <el-button
            v-if="scope.row.status === '申请退款'"
            type="primary"
            link
            @click="handleStatusChange(scope.row, '退款中')"
            >同意退款</el-button
          >
          <el-button
            v-if="scope.row.status === '申请退款'"
            type="primary"
            link
            @click="handleStatusChange(scope.row, '已支付')"
            >拒绝退款</el-button
          >
          <el-button
            v-if="scope.row.status === '退款中'"
            type="warning"
            link
            @click="handleStatusChange(scope.row, '已退款')"
            >退款完成</el-button
          >
          <el-button type="primary" link @click="handleUpdate(scope.row)"
            >修改</el-button
          >
          <el-button type="danger" link @click="handleDelete(scope.row)">
            删除
          </el-button>
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

    <!-- 添加或修改订单对话框 -->
    <el-dialog
      :title="title"
      v-model="open"
      width="600px"
      append-to-body
      @close="cancel"
    >
      <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="商品名称" prop="goodname">
          <el-input v-model="form.goodname" placeholder="请输入商品名称" />
        </el-form-item>
        <el-form-item label="购买数量" prop="buynumber">
          <el-input-number v-model="form.buynumber" :min="1" />
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="form.price" :min="1" />
        </el-form-item>
        <el-form-item label="总价格" prop="total">
          <el-input-number v-model="form.total" :min="1" />
        </el-form-item>
        <!-- <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="已支付" value="已支付"></el-option>
            <el-option label="未支付" value="未支付"></el-option>
            <el-option label="已发货" value="已发货"></el-option>
            <el-option label="已完成" value="已完成"></el-option>
            <el-option label="已取消" value="已取消"></el-option>
          </el-select>
        </el-form-item> -->
        <el-form-item label="地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入到场地点" />
        </el-form-item>
        <el-form-item label="电话" prop="tel">
          <el-input v-model="form.tel" placeholder="请输入电话" />
        </el-form-item>
        <el-form-item label="联系人" prop="consignee">
          <el-input v-model="form.consignee" placeholder="请输入联系人" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="form.remark"
            type="textarea"
            placeholder="请输入内容"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 进度信息对话框 -->
    <el-dialog
      :title="logisticsTitle"
      v-model="logisticsOpen"
      width="600px"
      append-to-body
      @close="cancelLogistics"
    >
      <el-form
        ref="logisticsFormRef"
        :model="logisticsForm"
        :rules="logisticsRules"
        label-width="80px"
      >
        <el-card
          v-for="(item, index) in logisticsForm.logistics"
          :key="index"
          class="logistics-item"
          shadow="never"
        >
          <el-row :gutter="20" align="middle">
            <el-col :span="20">
              <el-form-item
                label="进度时间"
                :prop="'logistics.' + index + '.time'"
                :rules="{
                  required: true,
                  message: '进度时间不能为空',
                  trigger: 'blur',
                }"
              >
                <el-date-picker
                  v-model="item.time"
                  type="datetime"
                  placeholder="选择日期时间"
                  value-format="YYYY-MM-DD HH:mm:ss"
                  style="width: 100%"
                ></el-date-picker>
              </el-form-item>
              <el-form-item
                label="进度信息"
                :prop="'logistics.' + index + '.info'"
                :rules="{
                  required: true,
                  message: '进度信息不能为空',
                  trigger: 'blur',
                }"
              >
                <el-input v-model="item.info" placeholder="请输入进度信息" />
              </el-form-item>
            </el-col>
            <el-col :span="4">
              <el-button type="danger" link @click="removeLogisticsItem(item)"
                >删除</el-button
              >
            </el-col>
          </el-row>
        </el-card>
        <el-button
          type="primary"
          plain
          @click="addLogisticsItem"
          style="width: 100%; margin-top: 10px"
          >+ 新增进度</el-button
        >
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitLogisticsForm"
            >确 定</el-button
          >
          <el-button @click="cancelLogistics">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs } from "vue";
import requestApi from "../../utils/axios";
import { ElMessageBox } from "element-plus";
import { Search, Refresh, Plus, Delete, Edit } from "@element-plus/icons-vue";
import Message from "@/components/MessageBox/index.js";
// 初始表单状态
const getInitialForm = () => ({
  id: null,
  goodname: "",
  buynumber: 1,
  price: 0,
  total: 0,
  status: "",
  address: "",
  tel: "",
  consignee: "",
  remark: "",
  logistics: "",
});

const data = reactive({
  loading: true,
  ids: [],
  multiple: true,
  total: 0,
  title: "",
  open: false,
  ordersList: [],
  queryParams: {
    page: 1,
    limit: 10,
    order: "addtime",
    orderid: undefined,
    goodname: undefined,
    status: undefined,
    consignee: undefined,
  },
  form: getInitialForm(),
  rules: {
    goodname: [
      { required: true, message: "商品名称不能为空", trigger: "blur" },
    ],
    buynumber: [
      { required: true, message: "购买数量不能为空", trigger: "blur" },
    ],
    price: [
      { required: true, message: "价格不能为空", trigger: "blur" },
      { type: "number", message: "价格必须为数字", trigger: "blur" },
    ],
    total: [
      { required: true, message: "总价格不能为空", trigger: "blur" },
      { type: "number", message: "价格必须为数字", trigger: "blur" },
    ],
    status: [{ required: true, message: "状态不能为空", trigger: "change" }],
    address: [{ required: true, message: "到场地点不能为空", trigger: "blur" }],
    tel: [
      { required: true, message: "电话不能为空", trigger: "blur" },
      {
        pattern: /^1[3-9]\d{9}$/,
        message: "请输入正确的手机号码",
        trigger: "blur",
      },
    ],
    consignee: [{ required: true, message: "联系人不能为空", trigger: "blur" }],
  },
  logisticsOpen: false,
  logisticsTitle: "",
  logisticsForm: {
    id: null,
    logistics: [],
  },
  logisticsRules: {
    logistics: [
      { required: true, message: "进度信息不能为空", trigger: "blur" },
    ],
  },
});

const {
  loading,
  ids,
  multiple,
  total,
  title,
  open,
  ordersList,
  queryParams,
  form,
  rules,
  logisticsOpen,
  logisticsTitle,
  logisticsForm,
  logisticsRules,
} = toRefs(data);

const formRef = ref(null); // 表单引用
const logisticsFormRef = ref(null); // 物流表单引用

/** 重置表单 */
function resetForm() {
  form.value = getInitialForm();
  if (formRef.value) {
    formRef.value.clearValidate();
  }
}

/** 重置物流表单 */
function resetLogisticsForm() {
  data.logisticsForm = {
    id: null,
    logistics: [],
  };
  if (logisticsFormRef.value) {
    logisticsFormRef.value.clearValidate();
  }
}

/** 物流按钮操作 */
function handleLogistics(row) {
  resetLogisticsForm();
  data.logisticsForm.id = row.id;
  try {
    // 尝试解析JSON字符串
    const parsedLogistics = JSON.parse(row.logistics);
    if (Array.isArray(parsedLogistics)) {
      data.logisticsForm.logistics = parsedLogistics;
    } else {
      // 如果解析结果不是数组，则初始化
      data.logisticsForm.logistics = [];
    }
  } catch (e) {
    // 如果解析失败（比如logistics是空或无效JSON），则初始化
    data.logisticsForm.logistics = [];
  }
  data.logisticsOpen = true;
  data.logisticsTitle = "修改服务进度";
}

/** 添加物流项 */
function addLogisticsItem() {
  data.logisticsForm.logistics.push({
    time: "",
    info: "",
  });
}

/** 删除物流项 */
function removeLogisticsItem(item) {
  const index = data.logisticsForm.logistics.indexOf(item);
  if (index !== -1) {
    data.logisticsForm.logistics.splice(index, 1);
  }
}

/** 提交物流按钮 */
async function submitLogisticsForm() {
  logisticsFormRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const payload = {
          id: data.logisticsForm.id,
          logistics: JSON.stringify(data.logisticsForm.logistics),
        };
        const response = await requestApi.post("/api/orders/update", payload);
        if (response.code == 0) {
          Message.success("修改成功");
          data.logisticsOpen = false;
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

/** 取消物流按钮 */
function cancelLogistics() {
  data.logisticsOpen = false;
  resetLogisticsForm();
}

/** 查询订单列表 */
async function getList() {
  loading.value = true;
  try {
    const response = await requestApi.post(
      "/api/orders/page",
      queryParams.value
    );
    if (response.code == 0) {
      ordersList.value = response.data.list;
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
    orderid: undefined,
    goodname: undefined,
    status: undefined,
    consignee: undefined,
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
  title.value = "新增订单";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  // 直接合并数据，移除 nextTick
  Object.assign(form.value, row);
  form.value.price = Number(row.price);
  open.value = true;
  title.value = "修改订单信息";
}

/** 提交按钮 */
async function submitForm() {
  formRef.value.validate(async (valid) => {
    if (valid) {
      const url = form.value.id ? "/api/orders/update" : "/api/orders/save";
      try {
        let obj;
        if (form.value.id) {
          obj = { ...form.value };
        } else {
          obj = [form.value];
          // obj = { ...form.value };
        }

        const response = await requestApi.post(url, obj);
        if (response.code == 0) {
          Message.success(form.value.id ? "修改成功" : "新增成功");
          open.value = false;
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

// 订单状态修改

async function handleStatusChange(row, text) {
  ElMessageBox.confirm(`确认${text}操作吗？`, "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      try {
        // 退款逻辑拦截
        // if (text == "已退款") {
        //   let refundTarget = {
        //     id: row.id,
        //   };
        //   const res = await requestApi.post("/api/orders/refund", refundTarget);
        //   if (res.code == 0) {
        //     Message.success(`${text}操作成功`);
        //     getList();
        //   }

        //   return;
        // }

        // 常规逻辑
        let obj = {
          id: row.id,
          status: text,
        };
        const response = await requestApi.post("/api/orders/update", obj);
        if (response.code == 0) {
          Message.success(`${text}操作成功`);
          getList();
        }
      } catch (error) {
        console.error(error);
        Message.error("请求失败");
      }
    })
    .catch(() => {});
}

/** 删除按钮操作 */
function handleDelete(row) {
  const orderIds = row.id ? [row.id] : ids.value;
  ElMessageBox.confirm(
    '是否确认删除订单编号为"' + (row.orderid || "所选") + '"的数据项？',
    "警告",
    {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    }
  )
    .then(async () => {
      try {
        const response = await requestApi.post("/api/orders/delete", orderIds);
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

onMounted(() => {
  getList();
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
.logistics-item {
  border: 1px solid #ebeef5;
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 4px;
}
</style>
