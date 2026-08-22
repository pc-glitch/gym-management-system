<template>
  <div class="chat-container-wrapper">
    <el-container class="chat-layout">
      <!-- 侧边栏：联系人列表 -->
      <el-aside width="280px" class="chat-sidebar">
        <div class="sidebar-header">
          <h3>联系人</h3>
        </div>
        <el-scrollbar class="contact-list-scroll">
          <div
            v-for="item in userPageList"
            :key="item.id"
            @click="handleSwitchUser(item)"
            class="contact-item"
            :class="{ active: chatObject && chatObject.id === item.id }"
          >
            <el-avatar
              :size="40"
              :src="item.avatarurl"
              :icon="!item.avatarurl ? 'UserFilled' : undefined"
              class="contact-avatar"
            />
            <div class="contact-info">
              <span class="contact-name">{{ item.name }}</span>
            </div>
          </div>
        </el-scrollbar>
      </el-aside>

      <!-- 主聊天区域 -->
      <el-container class="chat-main" v-loading="loadingChat">
        <!-- 聊天头部 -->
        <el-header class="chat-header" height="60px">
          <div class="header-content">
            <h2 class="chat-title">
              {{ chatObject ? chatObject.name : "请选择聊天对象" }}
            </h2>
            <el-tag
              :type="isConnected ? 'success' : 'danger'"
              effect="dark"
              round
              size="small"
              class="status-tag"
            >
              {{ isConnected ? "在线" : "离线" }}
            </el-tag>
          </div>
        </el-header>

        <!-- 聊天消息列表 -->
        <el-main class="chat-messages-area">
          <el-scrollbar ref="scrollbarRef" class="messages-scrollbar">
            <div ref="innerMessagesRef" class="messages-inner">
              <div class="welcome-message" v-if="!chatObject">
                <el-empty description="请从左侧选择一位用户开始聊天" />
              </div>

              <div
                v-for="(msg, index) in receivedMessages"
                :key="index"
                class="message-row"
                :class="{ 'is-sent': msg.isSent }"
              >
                <!-- 头像 -->
                <el-avatar
                  :size="40"
                  :src="msg.isSent ? currentUser.avatarurl : msg.avatarurl"
                  :icon="
                    !msg.avatarurl && !currentUser.avatarurl
                      ? 'UserFilled'
                      : undefined
                  "
                  class="message-avatar"
                />

                <!-- 消息内容 -->
                <div class="message-content-wrapper">
                  <div class="sender-name" v-if="!msg.isSent">
                    {{ msg.name }}
                  </div>
                  <div class="message-bubble" :class="getMessageTypeClass(msg)">
                    <!-- 图片消息 -->
                    <template v-if="parseMessageContent(msg).type == 1">
                      <el-image
                        :src="parseMessageContent(msg).content"
                        :preview-src-list="[parseMessageContent(msg).content]"
                        fit="cover"
                        class="chat-image"
                        :initial-index="0"
                        hide-on-click-modal
                      >
                        <template #error>
                          <div class="image-slot">
                            <el-icon><Picture /></el-icon>
                          </div>
                        </template>
                      </el-image>
                    </template>

                    <!-- 文件消息 -->
                    <template v-else-if="parseMessageContent(msg).type == 2">
                      <a
                        :href="parseMessageContent(msg).content.url"
                        target="_blank"
                        class="file-message-link"
                      >
                        <el-icon class="file-icon" :size="24"
                          ><Document
                        /></el-icon>
                        <div class="file-info">
                          <div class="file-name">
                            {{ parseMessageContent(msg).content.name }}
                          </div>
                          <div
                            class="file-size"
                            v-if="parseMessageContent(msg).content.size"
                          >
                            {{
                              formatFileSize(
                                parseMessageContent(msg).content.size
                              )
                            }}
                          </div>
                        </div>
                      </a>
                    </template>

                    <!-- 文本消息 -->
                    <template v-else>
                      <p class="text-content">
                        {{ parseMessageContent(msg).content }}
                      </p>
                    </template>
                  </div>
                </div>
              </div>
            </div>
          </el-scrollbar>
        </el-main>

        <!-- 底部输入框 -->
        <el-footer class="chat-footer" height="auto" v-if="chatObject">
          <div class="input-toolbar">
            <el-tooltip content="发送图片" placement="top">
              <el-button circle @click="triggerImageUpload">
                <el-icon><Picture /></el-icon>
              </el-button>
            </el-tooltip>
            <el-tooltip content="发送文件" placement="top">
              <el-button circle @click="triggerFileUpload">
                <el-icon><FolderAdd /></el-icon>
              </el-button>
            </el-tooltip>
          </div>

          <el-input
            v-model="messageToSend"
            type="textarea"
            :rows="3"
            placeholder="输入消息... (Enter 发送)"
            resize="none"
            class="message-input"
            @keyup.enter.exact="handleSendMessage"
          />

          <div class="footer-actions">
            <el-button
              type="primary"
              @click="handleSendMessage"
              :disabled="!messageToSend.trim()"
            >
              发送 <el-icon class="el-icon--right"><Promotion /></el-icon>
            </el-button>
          </div>
        </el-footer>
      </el-container>
    </el-container>

    <!-- 隐藏的文件上传 Input -->
    <input
      type="file"
      ref="imageUploadInput"
      @change="handleFileSelection('image', $event)"
      style="display: none"
      accept="image/*"
    />
    <input
      type="file"
      ref="fileUploadInput"
      @change="handleFileSelection('file', $event)"
      style="display: none"
      accept="*/*"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick, reactive } from "vue";
import wsService from "@/utils/websocket.js";
import requestApi from "@/utils/axios.js";
import { getNowTime, getUserData } from "@/utils/auth.js";
import axios from "axios";
import {
  UserFilled,
  Picture,
  FolderAdd,
  Document,
  Promotion,
} from "@element-plus/icons-vue";
import { ElMessage } from "element-plus";

// --- 响应式数据 ---
const receivedMessages = ref([]);
const messageToSend = ref("");
const isConnected = ref(
  wsService.ws ? wsService.ws.readyState === WebSocket.OPEN : false
);
const scrollbarRef = ref(null);
const innerMessagesRef = ref(null);
const userPageList = ref([]);
const chatObject = ref(null);
const currentUser = ref({});
const imageUploadInput = ref(null);
const fileUploadInput = ref(null);
const loadingChat = ref(false);

// --- WebSocket 消息处理 ---
const scrollToBottom = () => {
  nextTick(() => {
    if (scrollbarRef.value && innerMessagesRef.value) {
      scrollbarRef.value.setScrollTop(innerMessagesRef.value.clientHeight);
    }
  });
};

const handleNewMessage = (data) => {
  if (Number(data.fromId) != Number(currentUser.value.id)) {
    const hasContact = userPageList.value.some(
      (item) => Number(item.id) == Number(data.fromId)
    );
    if (!hasContact) {
      userPageList.value.push({
        id: Number(data.fromId),
        name: data.name || `用户${data.fromId}`,
        avatarurl: data.avatarurl || "",
      });
    }
  }
  if (!chatObject.value || Number(data.fromId) != Number(chatObject.value.id)) {
    return;
  }
  const isSent = Number(data.fromId) == Number(currentUser.value.id);
  receivedMessages.value.push({ ...data, isSent });
  scrollToBottom();
};

// --- Vue 生命周期钩子 ---
onMounted(async () => {
  await obtainUserInformation();
  await getUserChatList();

  wsService.setCallbacks({
    onMessage: handleNewMessage,
    onOpen: () => (isConnected.value = true),
    onClose: () => (isConnected.value = false),
  });

  if (!wsService.ws || wsService.ws.readyState !== WebSocket.OPEN) {
    wsService.connect();
  }
});

onUnmounted(() => {
  wsService.setCallbacks({ onMessage: null, onOpen: null, onClose: null });
});

// --- 事件处理方法 ---
const handleSendMessage = () => {
  if (!messageToSend.value.trim() || !chatObject.value) {
    return;
  }

  const payload = {
    fromId: currentUser.value.id,
    toId: chatObject.value.id,
    type: 0,
    contentType: 0,
    ws_type: 3,
    content: JSON.stringify({ type: 0, content: messageToSend.value }),
    name: currentUser.value.username,
    avatarurl: currentUser.value.avatarurl,
  };

  wsService.send(payload);
  receivedMessages.value.push({ ...payload, isSent: true });
  scrollToBottom();
  messageToSend.value = "";
};

const getChatHistory = async (toId) => {
  loadingChat.value = true;
  try {
    const time = await getNowTime();
    const res = await requestApi.post("/api/message/load", {
      type: 0,
      count: 50,
      toId: toId,
      updateTime: time,
    });
    receivedMessages.value = res.data.map((item) => ({
      ...item,
      isSent: item.fromId === currentUser.value.id,
    }));
    scrollToBottom();
  } catch (error) {
    console.error("获取聊天记录失败:", error);
    ElMessage.error("获取聊天记录失败");
  } finally {
    loadingChat.value = false;
  }
};

const obtainUserInformation = async () => {
  const userData = await getUserData();
  currentUser.value = userData;
};

const getUserChatList = async () => {
  try {
    const response = await requestApi.post("/api/user/list", {});
    userPageList.value = (response.data || [])
      .filter((item) => Number(item.id) != Number(currentUser.value.id))
      .map((item) => ({
      ...item,
      name: item?.name || item?.username || `用户${item?.id || ""}`,
    }));
    if (userPageList.value.length == 0) {
      chatObject.value = null;
      receivedMessages.value = [];
      return;
    }
    const keepCurrent = userPageList.value.find(
      (item) => Number(item.id) == Number(chatObject.value?.id)
    );
    await handleSwitchUser(keepCurrent || userPageList.value[0]);
  } catch (error) {
    console.error("获取用户聊天列表失败:", error);
    ElMessage.error("获取用户列表失败");
  }
};

const handleSwitchUser = async (user) => {
  if (!user || !user.id) return;
  chatObject.value = user;
  await getChatHistory(user.id);
};

const triggerImageUpload = () => {
  imageUploadInput.value?.click();
};

const triggerFileUpload = () => {
  fileUploadInput.value?.click();
};

const handleFileSelection = (type, event) => {
  const file = event.target.files[0];
  if (!file) return;
  uploadFile(file, type);
  event.target.value = ""; // Reset input
};

const uploadFile = async (file, type) => {
  const formData = new FormData();
  formData.append("file", file);

  try {
    const response = await axios.post("/api/file/upload", formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });

    if (response.data.code == 0) {
      if (type === "image") {
        handleImageUploadSuccess(response.data.data);
      } else if (type === "file") {
        handleFileUploadSuccess(response.data.data);
      }
    } else {
      ElMessage.error(response.data.msg || "上传失败");
    }
  } catch (error) {
    console.error(error);
    ElMessage.error("上传发生错误");
  }
};

const handleImageUploadSuccess = (data) => {
  const imageUrl = data.url;
  const payload = {
    fromId: currentUser.value.id,
    toId: chatObject.value.id,
    type: 0,
    ws_type: 3,
    content: JSON.stringify({ type: 1, content: imageUrl }),
    name: currentUser.value.username,
    avatarurl: currentUser.value.avatarurl,
  };

  wsService.send(payload);

  receivedMessages.value.push({ ...payload, isSent: true });
  scrollToBottom();
};

const handleFileUploadSuccess = (data) => {
  const payload = {
    fromId: currentUser.value.id,
    toId: chatObject.value.id,
    type: 0,
    ws_type: 3,
    content: JSON.stringify({ type: 2, content: data }),
    name: currentUser.value.username,
    avatarurl: currentUser.value.avatarurl,
  };

  wsService.send(payload);

  receivedMessages.value.push({ ...payload, isSent: true });
  scrollToBottom();
};

const parseMessageContent = (msg) => {
  if (typeof msg.content === "string") {
    try {
      const parsed = JSON.parse(msg.content);
      if (
        typeof parsed.type !== "undefined" &&
        typeof parsed.content !== "undefined"
      ) {
        return parsed;
      }
    } catch (e) {
      return { type: 0, content: msg.content };
    }
  }
  return { type: 0, content: msg.content };
};

const getMessageTypeClass = (msg) => {
  const type = parseMessageContent(msg).type;
  if (type == 1) return "is-image";
  if (type == 2) return "is-file";
  return "is-text";
};

const formatFileSize = (bytes) => {
  if (!bytes || bytes == 0) return "";
  const k = 1024;
  const sizes = ["Bytes", "KB", "MB", "GB", "TB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
};
</script>

<style scoped>
.chat-container-wrapper {
  height: calc(100vh - 40px); /* Adjust based on your layout padding */
  background-color: #f0f2f5;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.chat-layout {
  height: 100%;
}

/* Sidebar */
.chat-sidebar {
  background-color: #fff;
  border-right: 1px solid #e6e6e6;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  padding: 16px 20px;
  border-bottom: 1px solid #f0f0f0;
}

.sidebar-header h3 {
  margin: 0;
  font-size: 18px;
  color: #303133;
}

.contact-list-scroll {
  flex: 1;
}

.contact-item {
  display: flex;
  align-items: center;
  padding: 12px 20px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.contact-item:hover {
  background-color: #f5f7fa;
}

.contact-item.active {
  background-color: #ecf5ff;
}

.contact-avatar {
  flex-shrink: 0;
  margin-right: 12px;
}

.contact-info {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.contact-name {
  font-size: 14px;
  color: #303133;
  font-weight: 500;
}

/* Main Chat Area */
.chat-main {
  background-color: #f0f2f5;
  display: flex;
  flex-direction: column;
}

.chat-header {
  background-color: #fff;
  border-bottom: 1px solid #e6e6e6;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.header-content {
  display: flex;
  align-items: center;
  gap: 12px;
  width: 100%;
}

.chat-title {
  margin: 0;
  font-size: 18px;
  color: #303133;
}

.chat-messages-area {
  padding: 0; /* Let scrollbar handle padding */
  flex: 1;
  overflow: hidden;
}

.messages-scrollbar {
  height: 100%;
}

.messages-inner {
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.welcome-message {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  color: #909399;
}

.message-row {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  max-width: 80%;
}

.message-row.is-sent {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.message-avatar {
  flex-shrink: 0;
}

.message-content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 4px;
  max-width: 100%;
}

.sender-name {
  font-size: 12px;
  color: #909399;
  margin-left: 4px;
}

.message-bubble {
  padding: 10px 16px;
  border-radius: 8px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  font-size: 14px;
  line-height: 1.5;
  word-break: break-all;
  color: #303133;
  position: relative;
}

.message-row.is-sent .message-bubble {
  background-color: #409eff; /* Element Plus Primary Color */
  color: #fff;
}

.message-bubble.is-image {
  padding: 4px;
  background-color: transparent;
  box-shadow: none;
}

.chat-image {
  max-width: 300px;
  border-radius: 8px;
  display: block;
}

.message-row.is-sent .chat-image {
  /* float: right; */
}

.text-content {
  margin: 0;
}

.file-message-link {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
  color: inherit;
}

.message-row.is-sent .file-message-link {
  color: #fff;
}

.file-info {
  display: flex;
  flex-direction: column;
}

.file-name {
  font-weight: 500;
}

.file-size {
  font-size: 12px;
  opacity: 0.8;
}

/* Footer */
.chat-footer {
  background-color: #fff;
  border-top: 1px solid #e6e6e6;
  padding: 16px 20px;
}

.input-toolbar {
  margin-bottom: 12px;
  display: flex;
  gap: 8px;
}

.message-input {
  margin-bottom: 12px;
}

.message-input :deep(.el-textarea__inner) {
  border: none;
  background-color: #f5f7fa;
  box-shadow: none;
  padding: 10px;
}

.message-input :deep(.el-textarea__inner:focus) {
  background-color: #fff;
  box-shadow: 0 0 0 1px #409eff inset;
}

.footer-actions {
  display: flex;
  justify-content: flex-end;
}
</style>
