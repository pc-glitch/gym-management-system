<template>
  <div class="light-comment-container">
    <div class="comment-box">
      <h3 class="box-title">
        <span class="title-icon">
          <svg
            t="1761897133505"
            class="icon"
            viewBox="0 0 1024 1024"
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            p-id="13437"
            width="30"
            height="30"
          >
            <path
              d="M803.040562 793.929044 687.137833 793.929044c0.892323 0.577145 1.352811 0.881067 1.352811 0.881067-282.5901 0-489.846444 107.511619-489.846444 107.511619l0-80.633459 0-26.879184c0.066515-1.00898 0.25685-1.847068 0.331551-2.844791-76.78992-9.688663-136.4016-74.506924-136.4016-153.923672L62.574151 278.770098c0-86.09689 69.794599-155.88842 155.88842-155.88842l584.580039 0c86.09689 0 155.88842 69.791529 155.88842 155.88842l0 359.27155C958.927959 724.133422 889.137453 793.929044 803.040562 793.929044zM323.19796 411.516448c-32.284287 0-58.458413 25.62768-58.458413 57.241702s26.173103 57.238632 58.458413 57.238632 58.458413-25.623587 58.458413-57.238632S355.482247 411.516448 323.19796 411.516448zM525.364379 411.516448c-31.614022 0-57.238632 25.62768-57.238632 57.241702s25.623587 57.238632 57.238632 57.238632 57.241702-25.623587 57.241702-57.238632S556.978401 411.516448 525.364379 411.516448zM727.531821 411.516448c-32.284287 0-58.458413 25.62768-58.458413 57.241702s26.174126 57.238632 58.458413 57.238632c32.284287 0 58.458413-25.623587 58.458413-57.238632S759.816109 411.516448 727.531821 411.516448z"
              fill="#1296db"
              p-id="13438"
            ></path>
          </svg>
        </span>
        评论 ({{ commentData.data.length }})
      </h3>

      <!-- 主评论列表 -->
      <div v-if="commentData.data.length > 0" class="comment-list">
        <CommentTree
          v-for="comment in commentData.data"
          :key="comment.id"
          :comment="comment"
          :refid="comment.id"
          :current-user="currentUser"
          @post-reply="handlePostReply"
        />
      </div>
      <div v-else class="no-comments">
        <p>还没有人评论，期待你的声音。</p>
      </div>

      <!-- 顶层评论输入框 -->
      <div class="main-reply-box">
        <img
          v-if="currentUser && currentUser.avatarurl"
          :src="currentUser.avatarurl"
          class="current-user-avatar"
          alt="User Avatar"
        />
        <div class="reply-input-wrapper">
          <div class="rating-row">
            <span class="rating-label">评分</span>
            <el-rate v-model="mainRating" :max="5" allow-half />
            <span class="rating-value">{{ mainRating || 0 }}</span>
          </div>
          <textarea
            v-model="mainCommentContent"
            :rows="3"
            placeholder="分享你的想法..."
            class="reply-textarea"
          ></textarea>
          <div class="reply-actions">
            <button class="post-button" @click="handlePostMainComment">
              发表评论
            </button>
          </div>
        </div>
      </div>
    </div>
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
    commentData.value.data = [];
    return;
  }
  try {
    let res = await requestApi.post("/api/discuss/list", {
      refid: refidValue,
    });
    if (res && res.code == 0 && res.data) {
      commentData.value = res;
    } else {
      commentData.value.data = [];
      Message.error("获取评论数据失败或无数据。");
    }
  } catch (error) {
    commentData.value.data = [];
    Message.error("获取评论数据异常。");
  }
};

// 监听 refid 的变化
watch(
  () => props.refid,
  () => {
    getCommentData();
  },
  { immediate: true }
);

// 当前登录用户信息
const currentUser = ref(null);

onMounted(async () => {
  currentUser.value = await getUserData();
});

// 顶层评论内容
const mainCommentContent = ref("");
const mainRating = ref(0);

const buildCommentContent = () => {
  const score = Number(mainRating.value || 0);
  const prefix = score > 0 ? `评分：${score}/5\n` : "";
  return `${prefix}${mainCommentContent.value}`;
};

// 发表顶层评论
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
    username: currentUser.value.name || "匿名用户",
    avatarurl:
      currentUser.value.avatarurl ||
      "https://placehold.co/40x40/cccccc/333333?text=User",
    content: buildCommentContent(),
    parentId: null,
    likesCount: 0,
  };

  postComments(newComment);
  mainCommentContent.value = "";
  mainRating.value = 0;
};

// 发布评论
const postComments = async (data) => {
  try {
    let res = await requestApi.post("/api/discuss/save", data);
    if (res && res.code == 0) {
      Message.success("评论发表成功！");
      getCommentData();
    } else {
      Message.error(res?.msg || "评论发表失败！");
    }
  } catch (error) {
    Message.error(error.message || "评论发表异常！");
  }
};

// 处理回复
const handlePostReply = (replyData) => {
  postComments(replyData);
};
</script>

<style scoped>
.light-comment-container {
  width: 100%;
  padding: 20px;
  background-color: #f4f6f8; /* 柔和的背景灰 */
  color: #333;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  display: flex;
  justify-content: flex-start; /* 靠左显示 */
}

.comment-box {
  width: 100%;
  max-width: 900px;
  background: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
}

.box-title {
  font-size: 22px;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 20px 0;
  padding-bottom: 10px;
  border-bottom: 1px solid #eaecef;
  display: flex;
  align-items: center;
}

.title-icon {
  margin-right: 10px;
  font-size: 24px;
}

.comment-list {
  margin-bottom: 30px;
}

.no-comments {
  text-align: center;
  color: #909399;
  padding: 40px 20px;
  border: 1px dashed #dcdfe6;
  border-radius: 8px;
  background: #fafcff;
}

.no-comments p {
  margin: 0;
  font-size: 16px;
}

.main-reply-box {
  margin-top: 20px;
  border-top: 1px solid #eaecef;
  padding-top: 20px;
  display: flex;
  gap: 15px;
}

.current-user-avatar {
  flex-shrink: 0;
  width: 40px;
  height: 40px;
  border: 2px solid #f0f0f0;
  border-radius: 50%;
}

.reply-input-wrapper {
  flex-grow: 1;
}

.rating-row {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}

.rating-label {
  color: #606266;
  font-size: 13px;
  font-weight: 600;
}

.rating-value {
  color: #909399;
  font-size: 12px;
}

.reply-textarea {
  width: 100%;
  background-color: #fdfdfd;
  border: 1px solid #dcdfe6;
  color: #333;
  border-radius: 6px;
  transition: border-color 0.3s, box-shadow 0.3s;
  font-size: 14px;
  padding: 5px 11px; /* Mimic el-input padding */
  font-family: inherit;
  resize: vertical; /* Allow vertical resize */
  box-sizing: border-box; /* Ensure padding doesn't affect width */
}

.reply-textarea:focus {
  outline: none;
  border-color: #409eff;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.1);
  background-color: #fff;
}

.reply-textarea::placeholder {
  color: #aab2bd;
}

.reply-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
}

.post-button {
  background: linear-gradient(45deg, #409eff, #66b1ff);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.2);
}

.post-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.4);
}

.post-button:active {
  transform: translateY(0);
  box-shadow: 0 2px 5px rgba(64, 158, 255, 0.2);
}
</style>
