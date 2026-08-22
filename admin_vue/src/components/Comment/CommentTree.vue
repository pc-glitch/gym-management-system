<template>
  <div class="comment-item">
    <!-- 头像存在时才显示 -->
    <el-avatar
      v-if="comment.avatarurl"
      :src="comment.avatarurl"
      class="comment-avatar"
    />
    <div class="comment-content-box">
      <div class="comment-header">
        <span class="comment-nickname">{{ comment.nickname }}</span>
        <span class="comment-create-time">{{ comment.createTime }}</span>
      </div>
      <div class="comment-text">
        {{ comment.content }}
      </div>
      <div class="comment-actions">
        <!-- <span class="likes-count">👍 {{ comment.likesCount }}</span> -->
        <el-button link size="small" @click="toggleReplyForm">回复</el-button>
      </div>

      <!-- 回复表单 -->
      <div v-if="showReplyForm" class="reply-box">
        <el-input
          v-model="replyContent"
          type="textarea"
          :rows="2"
          placeholder="回复..."
        ></el-input>
        <div class="reply-actions">
          <el-button type="primary" size="small" @click="postReply">
            发表回复
          </el-button>
        </div>
      </div>

      <!-- 递归渲染子评论 -->
      <div
        v-if="comment.children && comment.children.length"
        class="children-comments"
      >
        <CommentTree
          v-for="child in comment.children"
          :key="child.id"
          :comment="child"
          :refid="refid"
          :current-user="currentUser"
          @post-reply="$emit('post-reply', $event)"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { ElAvatar, ElInput, ElButton } from "element-plus";
import Message from "@/components/MessageBox/index.js";
import CommentTree from "./CommentTree.vue"; // 递归调用自身

import requestApi from "@/utils/axios";

const props = defineProps({
  comment: Object,
  refid: String,
  currentUser: Object,
});

const emit = defineEmits(["post-reply"]);

const showReplyForm = ref(false);
const replyContent = ref("");

// 处理回复按钮点击
const toggleReplyForm = () => {
  showReplyForm.value = !showReplyForm.value;
};

// 发表回复
const postReply = () => {
  if (!replyContent.value.trim()) {
    Message.warning("评论内容不能为空");
    return;
  }
  const newReply = {
    refid: props.refid,
    userid: props.currentUser.userid,
    username: props.currentUser.username,
    avatarurl: props.currentUser.avatarurl,
    content: replyContent.value,
    parentId: props.comment.id,
    likesCount: 0,
  };

  emit("post-reply", newReply);

  // 模拟将新评论添加到列表中
  if (!props.comment.children) {
    props.comment.children = [];
  }
  props.comment.children.unshift(newReply);
  replyContent.value = "";
  showReplyForm.value = false;
};
</script>

<style scoped>
.comment-item {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #ebeef5;
}

.comment-item:last-child {
  border-bottom: none;
}

.comment-avatar {
  flex-shrink: 0;
}

.comment-content-box {
  flex-grow: 1;
}

.comment-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 5px;
}

.comment-nickname {
  font-weight: bold;
  color: #303133;
}

.comment-create-time {
  font-size: 0.8em;
  color: #909399;
}

.comment-text {
  font-size: 0.9em;
  line-height: 1.5;
  color: #606266;
  text-align: left;
}

.comment-actions {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 5px;
  font-size: 0.8em;
  color: #909399;
}

.likes-count {
  margin-right: 10px;
}

.reply-box {
  margin-top: 10px;
  background-color: #f0f2f5;
  padding: 10px;
  border-radius: 8px;
}

.reply-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 5px;
}

.children-comments {
  margin-top: 10px;
  padding-left: 20px;
  border-left: 2px solid #e4e7ed;
  /* 优化子评论层次感 */
  padding-left: 15px;
  border-left: 2px solid #dcdfe6;
}
</style>
