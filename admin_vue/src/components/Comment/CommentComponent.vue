<template>
  <div class="comment-component-container">
    <el-card class="comment-card">
      <template #header>
        <div class="card-header">
          <span class="page-title"
            >评论列表 ({{ commentData.data.length }})</span
          >
        </div>
      </template>

      <!-- 主评论列表 -->
      <div v-if="commentData.data.length > 0">
        <CommentTree
          v-for="comment in commentData.data"
          :key="comment.id"
          :comment="comment"
          :refid="comment.id"
          :current-user="currentUser"
          @post-reply="handlePostReply"
        />
      </div>
      <div v-else class="no-comments">暂无评论，快来发表第一条评论吧！</div>

      <!-- 顶层评论输入框 -->
      <div class="main-reply-box">
        <el-input
          v-model="mainCommentContent"
          type="textarea"
          :rows="3"
          placeholder="发表你的看法..."
        ></el-input>
        <div class="reply-actions">
          <el-button type="primary" size="small" @click="handlePostMainComment">
            发表评论
          </el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from "vue"; // 引入 watch
import Message from "@/components/MessageBox/index.js";
import CommentTree from "./CommentTree.vue"; // 导入子组件

import requestApi from "@/utils/axios";
import { getUserData } from "@/utils/auth.js";

// 接收外部传入参数
const props = defineProps({
  refid: [String, Number],
});

// 调试日志

// 评论数据
const commentData = ref({
  code: "0",
  msg: "success",
  refid: "", // 初始值为空
  data: [],
});

// 获取当前评论数据
const getCommentData = async () => {
  const refidValue = String(props.refid || "").trim();
  if (!refidValue || !/^\d+$/.test(refidValue)) {
    commentData.value.data = []; // 清空评论列表
    return;
  }
  try {
    let res = await requestApi.post("/api/discuss/list", {
      refid: refidValue,
    });

    // 调试日志
    if (res && res.code == 0 && res.data) {
      commentData.value = res;
    } else {
      commentData.value.data = []; // 请求失败或无数据时清空列表
      Message.error("获取评论数据失败或无数据。");
    }
  } catch (error) {
    commentData.value.data = []; // 发生错误时清空列表
    Message.error("获取评论数据异常。");
  }
};

// 监听 refid 的变化，并在变化时重新加载评论数据
watch(
  () => props.refid,
  (newRefid, oldRefid) => {
    // 调试日志
    getCommentData();
  },
  { immediate: true } // 立即执行一次，确保组件初次挂载时加载数据
);

// 模拟当前登录用户信息
// const currentUser = reactive({
//   userid: "1922938589040541698",
//   name: "张三",
//   avatarurl: "https://placehold.co/40x40/FF33A1/ffffff?text=ME",
// });

// 获取本地缓存
const currentUser = ref(null);

onMounted(async () => {
  currentUser.value = await getUserData();
});

// 顶层评论内容
const mainCommentContent = ref("");

/**
 * @description: 发表顶层评论
 */
const handlePostMainComment = () => {
  if (!mainCommentContent.value.trim()) {
    Message.warning("评论内容不能为空");
    return;
  }
  const refidValue = String(props.refid || "").trim();
  if (!refidValue || !/^\d+$/.test(refidValue)) {
    Message.warning("当前内容暂不支持评论");
    return;
  }
  if (!currentUser.value) {
    Message.error("请先登录才能发表评论！");
    return;
  }
  let userid = currentUser.value.userid || currentUser.value.id;
  if (!userid) {
    Message.error("请先登录才能发表评论！");
    return;
  }

  const newComment = {
    refid: refidValue,
    userid: userid,
    username: currentUser.value.name || "匿名用户", // 如果name不存在，使用匿名
    avatarurl:
      currentUser.value.avatarurl ||
      "https://placehold.co/40x40/cccccc/333333?text=User", // 默认头像
    content: mainCommentContent.value,
    parentId: null,
    likesCount: 0,
  };

  postComments(newComment);
  mainCommentContent.value = "";
};

// const 发布评论
const postComments = async (data) => {
  try {
    let res = await requestApi.post("/api/discuss/save", data);
    if (res && res.code == 0) {
      Message.success("评论发表成功！");
      // 成功后重新获取评论数据以更新列表
      getCommentData();
    } else {
      Message.error(res?.msg || "评论发表失败！");
    }
  } catch (error) {
    Message.error(error.message || "评论发表异常！");
  }
};

/**
 * @description: 处理回复评论，将对象打印到控制台
 * @param {object} replyData
 */
const handlePostReply = (replyData) => {
  postComments(replyData);
};
</script>

<style scoped>
.comment-component-container {
  display: flex;
  justify-content: center;
  padding: 20px;
  /* background-color: #f7f9fc; */
  /* width: 100%; */
}

.comment-card {
  width: 100%;
  max-width: 900px;
  border-radius: 12px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.card-header {
  font-size: 1.2em;
  font-weight: bold;
}

.no-comments {
  text-align: center;
  color: #909399;
  padding: 20px;
}

.main-reply-box {
  margin-top: 20px;
  border-top: 1px solid #ebeef5;
  padding-top: 20px;
}

.reply-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 5px;
}
</style>
