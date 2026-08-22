<template>
  <div class="app-container">
    <el-card shadow="never">
      <template #header>
        <div class="card-header">
          <span>评论管理</span>
        </div>
      </template>

      <el-form
        :model="queryParams"
        :inline="true"
        class="query-form"
        @submit.prevent="handleQuery"
      >
        <el-form-item label="用户名" prop="nickname">
          <el-input
            v-model="queryParams.nickname"
            placeholder="请输入用户名"
            clearable
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input
            v-model="queryParams.content"
            placeholder="请输入评论内容"
            clearable
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" native-type="button" @click="handleQuery"
            >搜索</el-button
          >
          <el-button native-type="button" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table
        v-loading="loading"
        :data="topLevelComments"
        row-key="id"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="关联ID" prop="refid" width="180" />
        <el-table-column label="发起人" prop="nickname" width="150" />
        <el-table-column label="内容摘要">
          <template #default="{ row }">
            <span class="content-cell" :title="row.content">{{ row.content }}</span>
          </template>
        </el-table-column>
        <el-table-column label="创建时间" prop="createTime" width="180" />
        <el-table-column
          label="操作"
          align="center"
          class-name="small-padding fixed-width"
          fixed="right"
          width="200"
        >
          <template #default="{ row }">
            <el-button type="primary" link @click="handleViewThread(row)"
              >查看会话</el-button
            >
            <el-button type="danger" link @click="handleDelete(row)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <el-dialog
        v-model="dialogOpen"
        :title="dialogTitle"
        width="800px"
        append-to-body
        destroy-on-close
      >
        <CommentComponent v-if="selectedRefid" :refid="selectedRefid" />
      </el-dialog>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRefs, computed } from "vue";
import requestApi from "@/utils/axios";
import Message from "@/components/MessageBox/index.js";
import CommentComponent from "@/components/Comment/CommentComponent.vue";

const data = reactive({
  loading: true,
  allComments: [],
  queryParams: {
    nickname: undefined,
    content: undefined,
  },
  selectedIds: [],
});

const { loading, allComments, queryParams, selectedIds } = toRefs(data);

// 计算属性，只返回顶级评论用于表格显示
const topLevelComments = computed(() => {
  return allComments.value.filter((comment) => {
    if (comment.parent_id) return false; // 确保只筛选顶级评论

    const nicknameMatch =
      !queryParams.value.nickname ||
      (comment.nickname &&
        comment.nickname.includes(queryParams.value.nickname));

    const contentMatch =
      !queryParams.value.content ||
      (comment.content && comment.content.includes(queryParams.value.content));

    return nicknameMatch && contentMatch;
  });
});

const dialogOpen = ref(false);
const selectedRefid = ref(null);
const dialogTitle = ref("");

/** 查询列表 */
async function getList() {
  loading.value = true;
  try {
    // 一次性获取所有数据，移除queryParams
    const response = await requestApi.post("/api/discuss/list", {});
    if (response.code == 0) {
      allComments.value = response.data;
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
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  queryParams.value.nickname = undefined;
  queryParams.value.content = undefined;
  handleQuery();
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  selectedIds.value = selection.map((item) => item.id);
}

/** 查看会话按钮操作 */
function handleViewThread(row) {
  selectedRefid.value = row.refid;
  dialogTitle.value = `查看评论会话 (refid: ${row.refid})`;
  dialogOpen.value = true;
}

/** 删除按钮操作 */
function handleDelete(row) {
  const itemIds = row.id ? [row.id] : selectedIds.value;
  Message.confirm({
    title: "警告",
    message: `是否确认删除ID为"${itemIds.join(
      ","
    )}"的数据项？删除顶级评论会一并删除所有子评论。`,
    confirmButtonText: "确定",
    cancelButtonText: "取消",
  })
    .then(async () => {
      try {
        const response = await requestApi.post("/api/discuss/delete", itemIds);
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
    .catch(() => {
      // Cancelled
    });
}

onMounted(() => {
  getList();
});
</script>

<style scoped>
.app-container {
  padding: 20px;
}

.query-form {
  margin-bottom: 16px;
}

.content-cell {
  display: inline-block;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 360px;
}
</style>
