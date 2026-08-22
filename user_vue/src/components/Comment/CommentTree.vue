<template>
  <div class="comment-item">
    <!-- 头像存在时才显示 -->
    <img
      v-if="comment.avatarurl"
      :src="comment.avatarurl"
      class="comment-avatar"
      alt="Commenter Avatar"
    />
    <div v-else class="comment-avatar comment-defaultProfilePhoto">
      <svg
        t="1761896579660"
        class="icon"
        viewBox="0 0 1024 1024"
        version="1.1"
        xmlns="http://www.w3.org/2000/svg"
        p-id="9062"
        width="40"
        height="40"
      >
        <path
          d="M512.252018 266.581333a161.166222 161.166222 0 1 0 0 322.332445 161.166222 161.166222 0 0 0 0-322.332445z m0 386.844445c-173.681778 0-273.066667 60.643556-288.199111 175.217778a419.157333 419.157333 0 0 0 576.284444 0c-15.018667-114.574222-114.403556-175.217778-288.085333-175.217778z m0 354.588444A483.555556 483.555556 0 0 1 166.936462 185.856 480.654222 480.654222 0 0 1 502.182684 40.903111H512.252018a483.555556 483.555556 0 0 1 345.201778 822.158222 480.711111 480.711111 0 0 1-335.075556 144.952889H512.252018z"
          fill="#999999"
          p-id="9063"
        ></path>
      </svg>
    </div>
    <div class="comment-content-box">
      <div class="comment-header">
        <span class="comment-nickname">{{
          comment.nickname || comment.username
        }}</span>
      </div>
      <div class="comment-text">
        {{ comment.content }}
      </div>
      <div class="comment-actions">
        <button
          class="action-button like-button"
          :class="{ active: isLiked }"
          @click="toggleLike"
        >
          <span class="icon">
            <svg
              v-if="likeCount"
              t="1761896998130"
              class="icon"
              viewBox="0 0 1024 1024"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              p-id="11049"
              width="20"
              height="20"
            >
              <path
                d="M298.666667 385.073333a53.546667 53.546667 0 0 0-10.666667-1.073333H96a53.393333 53.393333 0 0 0-53.333333 53.333333v490.666667a53.393333 53.393333 0 0 0 53.333333 53.333333h192a53.06 53.06 0 0 0 10.666667-1.086666zM192 853.333333a21.333333 21.333333 0 1 1 21.333333-21.333333 21.333333 21.333333 0 0 1-21.333333 21.333333z m820.313333-370.42l-65.546666 426.06A85.333333 85.333333 0 0 1 862.426667 981.333333H448a148.353333 148.353333 0 0 1-105.593333-43.74c-0.366667-0.36-0.72-0.733333-1.073334-1.1V413.066667c25.106667-39.806667 57.126667-74.106667 84.12-103.006667l6-6.446667C500 230.053333 505.433333 169.706667 505.433333 98.46c0-25.746667 12.04-39.333333 22.14-46.186667C539.26 44.333333 552.326667 42.666667 561.233333 42.666667c20.993333 0 52.946667 9.473333 79.66 36.066666 20.553333 20.453333 45.053333 58.42 45.053334 123.113334 0 29.566667-7.18 62.666667-13.206667 85.2-7.8 29.213333-18.56 59.253333-30.28 84.573333a10.666667 10.666667 0 0 0 0.666667 10.373333 10.28 10.28 0 0 0 8.873333 4.833334h0.1l275.153333-2.22h0.666667a85.333333 85.333333 0 0 1 84.333333 98.306666z"
                fill="#1296db"
                p-id="11050"
              ></path>
            </svg>
            <svg
              v-else
              t="1761896998130"
              class="icon"
              viewBox="0 0 1024 1024"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              p-id="11049"
              width="20"
              height="20"
            >
              <path
                d="M298.666667 385.073333a53.546667 53.546667 0 0 0-10.666667-1.073333H96a53.393333 53.393333 0 0 0-53.333333 53.333333v490.666667a53.393333 53.393333 0 0 0 53.333333 53.333333h192a53.06 53.06 0 0 0 10.666667-1.086666zM192 853.333333a21.333333 21.333333 0 1 1 21.333333-21.333333 21.333333 21.333333 0 0 1-21.333333 21.333333z m820.313333-370.42l-65.546666 426.06A85.333333 85.333333 0 0 1 862.426667 981.333333H448a148.353333 148.353333 0 0 1-105.593333-43.74c-0.366667-0.36-0.72-0.733333-1.073334-1.1V413.066667c25.106667-39.806667 57.126667-74.106667 84.12-103.006667l6-6.446667C500 230.053333 505.433333 169.706667 505.433333 98.46c0-25.746667 12.04-39.333333 22.14-46.186667C539.26 44.333333 552.326667 42.666667 561.233333 42.666667c20.993333 0 52.946667 9.473333 79.66 36.066666 20.553333 20.453333 45.053333 58.42 45.053334 123.113334 0 29.566667-7.18 62.666667-13.206667 85.2-7.8 29.213333-18.56 59.253333-30.28 84.573333a10.666667 10.666667 0 0 0 0.666667 10.373333 10.28 10.28 0 0 0 8.873333 4.833334h0.1l275.153333-2.22h0.666667a85.333333 85.333333 0 0 1 84.333333 98.306666z"
                fill="#5C5C66"
                p-id="11050"
              ></path>
            </svg>
          </span>
          <span v-if="likeCount">{{ likeCount }}</span>
        </button>
        <button class="action-button" @click="toggleReplyForm">
          <span class="icon"></span> 回复
        </button>
      </div>

      <!-- 回复表单 -->
      <div v-if="showReplyForm" class="reply-box">
        <textarea
          v-model="replyContent"
          :rows="2"
          placeholder="写下你的回复..."
          class="reply-textarea"
        ></textarea>
        <div class="reply-actions">
          <button class="post-reply-button" @click="postReply">发送回复</button>
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
import { ref, onMounted } from "vue";
import Message from "@/components/MessageBox/index.js";
import CommentTree from "./CommentTree.vue"; // 递归调用自身
import requestApi from "@/utils/axios";
import { GetUserId } from "@/utils/auth";

const props = defineProps({
  comment: Object,
  refid: String,
  currentUser: Object,
});

const emit = defineEmits(["post-reply"]);

// 回复功能 state
const showReplyForm = ref(false);
const replyContent = ref("");

// 点赞功能 state
const isLiked = ref(false);
const likeCount = ref(0); // 初始化为0，通过接口获取
const storeupId = ref(null); // 存储点赞记录的ID，用于取消点赞
const userId = ref(null);

onMounted(async () => {
  userId.value = await GetUserId();
  loadLikeData();
});

// 加载点赞数据（数量和当前用户状态）
const loadLikeData = async () => {
  try {
    const res = await requestApi.post("/api/storeup/list", {
      refid: props.comment.id,
      type: 4, // 4 代表 "点赞"
    });
    if (res.code == 0 && Array.isArray(res.data)) {
      // 使用返回的数组长度作为真实点赞数
      likeCount.value = res.data.length;

      // 检查当前用户是否在点赞列表中
      if (userId.value) {
        const userLike = res.data.find((like) => like.userid === userId.value);
        if (userLike) {
          isLiked.value = true;
          storeupId.value = userLike.id; // 保存点赞记录ID
        } else {
          isLiked.value = false;
          storeupId.value = null;
        }
      }
    } else {
      // 接口异常或无数据
      likeCount.value = 0;
      isLiked.value = false;
    }
  } catch (error) {
    console.error("加载点赞数据失败", error);
    // 发生错误时，回退到props中的数据
    likeCount.value = props.comment.likesCount || 0;
  }
};

// 点赞/取消点赞
const toggleLike = async () => {
  if (!userId.value) {
    Message.warning("请先登录");
    return;
  }

  if (isLiked.value) {
    // --- 取消点赞 ---
    try {
      const res = await requestApi.post("/api/storeup/delete", [
        storeupId.value,
      ]);
      if (res.code == 0) {
        isLiked.value = false;
        likeCount.value--;
        storeupId.value = null;
      } else {
        Message.error(res.msg || "取消点赞失败");
      }
    } catch (error) {
      Message.error("取消点赞失败");
    }
  } else {
    // --- 点赞 ---
    try {
      const params = {
        userid: userId.value,
        refid: props.comment.id,
        tablename: "discuss",
        name: `评论: ${props.comment.content.substring(0, 20)}...`,
        picture: props.comment.avatarurl,
        type: 4, // 4 代表 "点赞"
      };
      const res = await requestApi.post("/api/storeup/save", params);
      if (res.code == 0) {
        isLiked.value = true;
        likeCount.value++;
        // 点赞成功后，重新加载数据以获取新的storeupId
        loadLikeData();
      } else {
        Message.error(res.msg || "点赞失败");
      }
    } catch (error) {
      Message.error("点赞失败");
    }
  }
};

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
    avatarurl:
      props.currentUser.avatarurl ||
      `data:image/png;base64,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`,
    content: replyContent.value,
    parentId: props.comment.id,
    likesCount: 0,
  };

  emit("post-reply", newReply);

  // 成功后清空并隐藏
  replyContent.value = "";
  showReplyForm.value = false;
};
</script>

<style scoped>
.comment-item {
  display: flex;
  gap: 15px;
  padding: 16px 0;
  border-bottom: 1px solid #eaecef;
  transition: background-color 0.3s;
  position: relative;
}

.comment-item:last-child {
  border-bottom: none;
}

.comment-item:hover {
  background-color: #f9fafb;
}

.comment-avatar {
  flex-shrink: 0;
  width: 40px;
  height: 40px;
  border: 2px solid #f0f0f0;
  transition: border-color 0.3s, transform 0.3s;
  border-radius: 50%;
}
.comment-defaultProfilePhoto {
  border: 0;
}
.comment-item:hover .comment-avatar {
  border-color: #409eff;
  transform: scale(1.05);
}

.comment-content-box {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

.comment-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 8px;
}

.comment-nickname {
  font-weight: 600;
  color: #555;
  transition: color 0.3s;
}

.comment-item:hover .comment-nickname {
  color: #409eff;
}

.comment-text {
  font-size: 14px;
  line-height: 1.6;
  color: #333;
  padding-bottom: 8px;
  white-space: pre-wrap;
  text-align: left;
}

.comment-actions {
  display: flex;
  align-items: center;
  gap: 20px; /* 增加按钮间距 */
  margin-top: 5px;
  font-size: 12px;
  color: #909399;
}

.action-button {
  background: transparent;
  border: 1px solid transparent;
  color: #909399;
  padding: 4px 8px;
  border-radius: 6px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 5px;
  transition: all 0.2s ease-in-out;
  font-family: inherit;
}

.action-button .icon {
  font-size: 14px;
  transition: transform 0.3s;
}

.action-button:hover {
  color: #409eff;
  background-color: rgba(64, 158, 255, 0.08);
}

.action-button:hover .icon {
  transform: scale(1.1);
}

/* 点赞按钮激活状态 */
.like-button.active {
  color: #ff4d4f;
  font-weight: bold;
}
.like-button.active .icon {
  animation: like-pop 0.5s ease;
}

@keyframes like-pop {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.3);
  }
  100% {
    transform: scale(1);
  }
}

.reply-box {
  margin-top: 12px;
  background-color: #f9fafb;
  padding: 12px;
  border-radius: 8px;
  border: 1px solid #eaecef;
}

.reply-textarea {
  width: 100%;
  background-color: #fff;
  border: 1px solid #dcdfe6;
  color: #333;
  border-radius: 6px;
  transition: border-color 0.3s, box-shadow 0.3s;
  font-size: 14px;
  padding: 5px 11px;
  font-family: inherit;
  resize: vertical;
  box-sizing: border-box;
}

.reply-textarea:focus {
  outline: none;
  border-color: #409eff;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.1);
}

.reply-textarea::placeholder {
  color: #aab2bd;
}

.reply-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
}

.post-reply-button {
  background: #409eff;
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.2);
}

.post-reply-button:hover {
  background: #66b1ff;
  box-shadow: 0 3px 10px rgba(64, 158, 255, 0.3);
}

.children-comments {
  margin-top: 16px;
  padding-left: 30px;
  position: relative;
}

.children-comments::before {
  content: "";
  position: absolute;
  left: 0;
  top: 10px;
  bottom: 0;
  width: 1px;
  background-color: #e0e0e0;
  z-index: 1;
}

.children-comments > .comment-item::before {
  content: "";
  position: absolute;
  left: -24px;
  top: 26px;
  width: 15px;
  height: 1px;
  background-color: #e0e0e0;
  z-index: 2;
}
</style>
