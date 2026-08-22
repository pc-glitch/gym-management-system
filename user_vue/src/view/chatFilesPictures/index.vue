<template>
  <div class="chat-container-wrapper">
    <div class="chat-container">
      <div class="chat-header">
        <div class="header-left">
          <h1>在线客服中心</h1>
          <div class="contact-selector">
            <span class="selector-label">会话列表</span>
            <el-select
              v-model="activeContactId"
              size="small"
              class="selector-input"
              @change="handleSwitchContact"
            >
              <el-option
                v-for="item in contactList"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              />
            </el-select>
          </div>
        </div>
        <div class="status-indicator">
          <el-tag
            :type="isConnected ? 'success' : 'info'"
            effect="dark"
            round
            size="small"
          >
            {{ isConnected ? "在线" : "离线" }}
          </el-tag>
        </div>
      </div>

      <div class="chat-messages" ref="messagesContainer">
        <div class="welcome-message">
          <h2>欢迎！</h2>
          <p>当前会话：{{ activeContactName }}，请直接发送消息开始沟通。</p>
        </div>

        <!-- Messages loop -->
        <div
          v-for="(msg, index) in receivedMessages"
          :key="index"
          class="message-wrapper"
          :class="{ sent: msg.isSent, received: !msg.isSent }"
        >
          <div class="avatar">
            <!-- Received Message Avatar -->
            <template v-if="!msg.isSent">
              <img v-if="msg.avatarurl" :src="msg.avatarurl" alt="avatar" />
              <svg
                v-else
                t="1761728009593"
                class="icon"
                viewBox="0 0 1024 1024"
                version="1.1"
                xmlns="http://www.w3.org/2000/svg"
                p-id="14315"
                width="40"
                height="40"
              >
                <path
                  d="M515.2 226.752m-226.752 0a226.752 226.752 0 1 0 453.504 0 226.752 226.752 0 1 0-453.504 0Z"
                  fill="#666666"
                  p-id="14316"
                ></path>
                <path
                  d="M906.496 1024H123.904c-42.24 0-76.8-34.56-76.8-76.8v-147.904C47.104 641.28 176.384 512 334.4 512h361.536c158.016 0 287.296 129.28 287.296 287.296V947.2c0.064 42.24-34.496 76.8-76.736 76.8z"
                  fill="#666666"
                  p-id="14317"
                ></path>
              </svg>
            </template>
            <!-- Sent Message Avatar -->
            <template v-if="msg.isSent">
              <img
                v-if="currentUser.avatarurl"
                :src="currentUser.avatarurl"
                alt="user-avatar"
              />
              <svg
                v-else
                t="1761728072530"
                class="icon"
                viewBox="0 0 1024 1024"
                version="1.1"
                xmlns="http://www.w3.org/2000/svg"
                p-id="15386"
                width="40"
                height="40"
              >
                <path
                  d="M317.123217 241.901809c0-107.626482 87.252964-194.879445 194.879445-194.879445s194.870572 87.252964 194.870572 194.879445-87.24409 194.870572-194.870572 194.870572c-107.626482 0-194.879445-87.24409-194.879445-194.870572zM117.962315 705.073692c0-138.390849 176.413726-250.587175 394.03591-250.587176s394.03591 112.196326 394.03591 250.587176c0 138.399723-176.413726 250.593386-394.03591 250.593386s-394.03591-112.193664-394.03591-250.593386z"
                  fill="#89B7FF"
                  p-id="15387"
                ></path>
              </svg>
            </template>
          </div>
          <div class="message-content">
            <div class="username" v-if="!msg.isSent">
              {{ msg.name || "客服" }}
            </div>
            <div class="message-bubble">
              <!-- Image -->
              <template v-if="parseMessageContent(msg).type == 1">
                <img
                  :src="parseMessageContent(msg).content"
                  alt="image"
                  class="chat-image"
                  @click="openImageViewer(parseMessageContent(msg).content)"
                />
              </template>
              <!-- File -->
              <template v-else-if="parseMessageContent(msg).type == 2">
                <a
                  :href="parseMessageContent(msg).content.url"
                  target="_blank"
                  class="file-message"
                >
                  <svg
                    t="1761728269329"
                    class="icon"
                    viewBox="0 0 1024 1024"
                    version="1.1"
                    xmlns="http://www.w3.org/2000/svg"
                    p-id="24230"
                    width="30"
                    height="30"
                  >
                    <path
                      d="M848.8576 199.1936H415.7568c0-26.5728-21.5424-48.128-48.128-48.128H175.1424c-26.5728 0-48.128 21.5424-48.128 48.128V343.5648c0 26.5984 21.5424 48.1408 48.128 48.1408h673.728c26.5728 0 48.128-21.5424 48.128-48.1408v-96.2432c-0.0128-26.5856-21.5552-48.128-48.1408-48.128z"
                      fill="#CCA352"
                      p-id="24231"
                    ></path>
                    <path
                      d="M800.7424 247.3088H223.2576c-26.5728 0-48.128 21.5424-48.128 48.128v48.128c0 26.5984 21.5424 48.1408 48.128 48.1408h577.472c26.5728 0 48.128-21.5424 48.128-48.1408v-48.128c0-26.5728-21.5424-48.128-48.1152-48.128z"
                      fill="#FFFFFF"
                      p-id="24232"
                    ></path>
                    <path
                      d="M848.8576 295.4368H175.1424c-26.5728 0-48.128 21.5424-48.128 48.128v481.2544c0 26.5472 21.5424 48.128 48.128 48.128h673.728c26.5728 0 48.128-21.568 48.128-48.128V343.552c-0.0128-26.5728-21.5552-48.1152-48.1408-48.1152z"
                      fill="#FFCC66"
                      p-id="24233"
                    ></path>
                  </svg>
                  <div class="file-info">
                    <div class="file-name">
                      {{ parseMessageContent(msg).content.name }}
                    </div>
                    <div
                      class="file-size"
                      v-if="parseMessageContent(msg).content.size"
                    >
                      {{
                        formatFileSize(parseMessageContent(msg).content.size)
                      }}
                    </div>
                  </div>
                </a>
              </template>
              <!-- Text -->
              <template v-else>
                <p class="text-content">
                  {{ parseMessageContent(msg).content }}
                </p>
              </template>
            </div>
          </div>
        </div>
      </div>

      <div class="chat-input-area">
        <div class="input-toolbar">
          <el-button
            class="tool-btn"
            circle
            @click="triggerImageUpload"
            title="发送图片"
          >
            <svg
              t="1761728234762"
              class="icon"
              viewBox="0 0 1024 1024"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              p-id="20437"
              width="30"
              height="30"
            >
              <path
                d="M521.152 511.936m-416 0a416 416 0 1 0 832 0 416 416 0 1 0-832 0Z"
                fill="#AEECFF"
                p-id="20438"
              ></path>
              <path
                d="M733.376 205.056l-44.608-44.224L111.936 434.56s-21.44 80.192 2.752 177.408c166.976-107.968 503.552-330.688 618.688-406.912zM653.568 308.416L373.312 557.312l93.376 57.408 232-273.408zM731.904 351.872l-116.352 282.88h104l56-266.816zM818.688 331.136v324.864l100.672-23.616-60.992-301.696z"
                fill="#E3FAFF"
                p-id="20439"
              ></path>
              <path
                d="M774.208 241.216m-145.216 0a145.216 145.216 0 1 0 290.432 0 145.216 145.216 0 1 0-290.432 0Z"
                fill="#FFFF5F"
                p-id="20440"
              ></path>
              <path
                d="M521.088 928c108.16 0 206.4-41.6 280.32-109.312a110.08 110.08 0 0 0-27.648-47.552L447.808 445.12a112.512 112.512 0 0 0-158.656 0L118.656 615.552c46.144 179.584 208.576 312.448 402.432 312.448z"
                fill="#66BF47"
                p-id="20441"
              ></path>
              <path
                d="M316.736 874.048a413.504 413.504 0 0 0 204.352 53.952 415.808 415.808 0 0 0 400.256-303.744l-101.632-101.568a112.512 112.512 0 0 0-158.656 0l-325.952 326.016c-7.616 7.616-13.44 16.32-18.368 25.344z"
                fill="#3FB018"
                p-id="20442"
              ></path>
              <path
                d="M521.088 928a413.76 413.76 0 0 0 186.432-44.48l-221.248-221.184a128.32 128.32 0 0 0-180.992 0l-109.056 109.056A414.848 414.848 0 0 0 521.088 928z"
                fill="#5AA93E"
                p-id="20443"
              ></path>
            </svg>
          </el-button>
          <el-button
            class="tool-btn"
            circle
            @click="triggerFileUpload"
            title="发送文件"
          >
            <svg
              t="1761728211023"
              class="icon"
              viewBox="0 0 1024 1024"
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              p-id="18265"
              width="30"
              height="30"
            >
              <path
                d="M848.8576 199.1936H415.7568c0-26.5728-21.5424-48.128-48.128-48.128H175.1424c-26.5728 0-48.128 21.5424-48.128 48.128V343.5648c0 26.5984 21.5424 48.1408 48.128 48.1408h673.728c26.5728 0 48.128-21.5424 48.128-48.1408v-96.2432c-0.0128-26.5856-21.5552-48.128-48.1408-48.128z"
                fill="#CCA352"
                p-id="18266"
              ></path>
              <path
                d="M800.7424 247.3088H223.2576c-26.5728 0-48.128 21.5424-48.128 48.128v48.128c0 26.5984 21.5424 48.1408 48.128 48.1408h577.472c26.5728 0 48.128-21.5424 48.128-48.1408v-48.128c0-26.5728-21.5424-48.128-48.1152-48.128z"
                fill="#FFFFFF"
                p-id="18267"
              ></path>
              <path
                d="M848.8576 295.4368H175.1424c-26.5728 0-48.128 21.5424-48.128 48.128v481.2544c0 26.5472 21.5424 48.128 48.128 48.128h673.728c26.5728 0 48.128-21.568 48.128-48.128V343.552c-0.0128-26.5728-21.5552-48.1152-48.1408-48.1152z"
                fill="#FFCC66"
                p-id="18268"
              ></path>
            </svg>
          </el-button>
        </div>
        <el-input
          v-model="messageToSend"
          type="textarea"
          :rows="3"
          resize="none"
          placeholder="输入消息..."
          class="message-input"
          @keyup.enter.exact="handleSendMessage"
        />
        <el-button
          type="primary"
          @click="handleSendMessage"
          class="send-btn"
          :disabled="!messageToSend.trim()"
        >
          <span>发送</span>
        </el-button>
      </div>

      <!-- Hidden file inputs -->
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

      <!-- Image Viewer -->
      <el-dialog
        v-model="showImageViewer"
        width="80%"
        :close-on-click-modal="true"
        :destroy-on-close="true"
        @close="closeImageViewer"
      >
        <el-image :src="imageViewerUrl" fit="contain" style="width: 100%" />
      </el-dialog>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, nextTick } from "vue";
import wsService from "@/utils/websocket.js";
import axios from "axios";
import requestApi from "@/utils/axios.js";
import { getNowTime, getUserData } from "@/utils/auth.js";

// --- 响应式数据 ---
const receivedMessages = ref([]);
const messageToSend = ref("");
const isConnected = ref(
  wsService.ws ? wsService.ws.readyState === WebSocket.OPEN : false
);
const messagesContainer = ref(null);
const imageUploadInput = ref(null);
const fileUploadInput = ref(null);
const showImageViewer = ref(false);
const imageViewerUrl = ref("");
const contactList = ref([]);
const activeContactId = ref(null);
let currentUser = ref({});
const activeContactName = computed(() => {
  const current = contactList.value.find((item) => item.id == activeContactId.value);
  return current?.name || "平台客服";
});
const currentUserId = computed(
  () => Number(currentUser.value.id || currentUser.value.userid || 0)
);

// --- WebSocket 消息处理 ---
const scrollToBottom = () => {
  nextTick(() => {
    if (messagesContainer.value) {
      messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight;
    }
  });
};

const handleNewMessage = (data) => {
  if (!currentUserId.value) {
    return;
  }
  if (Number(data.fromId) == currentUserId.value) {
    return;
  }
  if (Number(data.toId) != currentUserId.value) {
    return;
  }
  const fromId = Number(data.fromId);
  const hasContact = contactList.value.some((item) => Number(item.id) == fromId);
  if (!hasContact) {
    contactList.value.push({
      id: fromId,
      name: data.name || `客服${fromId}`,
      avatarurl: data.avatarurl || "",
    });
  }
  if (!activeContactId.value) {
    activeContactId.value = fromId;
  }
  const targetId = Number(activeContactId.value);
  const isCurrentConversation =
    (Number(data.fromId) == targetId && Number(data.toId) == currentUserId.value);
  if (!isCurrentConversation) return;

  const isSent = Number(data.fromId) == currentUserId.value;

  if (data.code && data.code != 0 && data.msg) {
    receivedMessages.value.push({
      content: `[错误 ${data.code}]: ${data.msg}`,
      isSent: true,
      avatarurl: currentUser.value.avatarurl,
    });
  } else {
    receivedMessages.value.push({ ...data, isSent });
  }

  scrollToBottom();
};

// --- Vue 生命周期钩子 ---
onMounted(async () => {
  await obtainUserInformation();
  await getContactList();
  await getChatHistory(activeContactId.value);

  wsService.setCallbacks({
    onMessage: handleNewMessage,
    onOpen: () => {
      isConnected.value = true;
    },
    onClose: () => {
      isConnected.value = false;
    },
  });

  wsService.connect();
});

onUnmounted(() => {
  wsService.setCallbacks({ onMessage: null, onOpen: null, onClose: null });
});

// --- 事件处理方法 ---
const handleSendMessage = () => {
  if (!messageToSend.value.trim() || !activeContactId.value) {
    return;
  }

  const payload = {
    fromId: currentUserId.value,
    toId: activeContactId.value,
    type: 0,
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
  event.target.value = ""; // Reset input to allow selecting the same file again
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
      console.error(response.data.msg || "Upload failed");
    }
  } catch (error) {
    console.error(error.message || "An error occurred during upload");
  }
};

const handleImageUploadSuccess = (data) => {
  if (!activeContactId.value) return;
  const imageUrl = data.url;
  const payload = {
    fromId: currentUserId.value,
    toId: activeContactId.value,
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
  if (!activeContactId.value) return;
  const payload = {
    fromId: currentUserId.value,
    toId: activeContactId.value,
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

const openImageViewer = (url) => {
  imageViewerUrl.value = url;
  showImageViewer.value = true;
};

const closeImageViewer = () => {
  showImageViewer.value = false;
  imageViewerUrl.value = "";
};

const getChatHistory = async (toId) => {
  if (!toId || !currentUserId.value) return;
  try {
    const time = await getNowTime();
    const res = await requestApi.post("/api/message/load", {
      type: 0,
      count: 50,
      toId: toId,
      updateTime: time,
    });

    const messages = res.data.map((item) => ({
      ...item,
      isSent: Number(item.fromId) == currentUserId.value,
    }));

    receivedMessages.value = messages;
    scrollToBottom();
  } catch (error) {
    console.error("获取聊天记录失败:", error);
  }
};

// 配置当前用户信息
const obtainUserInformation = async () => {
  const userData = await getUserData();
  currentUser.value = userData;
};

const getContactList = async () => {
  try {
    const response = await requestApi.post("/api/admin/list", {});
    const allUsers = response?.data || [];
    const targetList = allUsers.map(
      (item) => ({
        id: Number(item.id || item.userid),
        name: item.name || item.username || `管理员${item.id || item.userid || ""}`,
        avatarurl: item.avatarurl || "",
      })
    );
    contactList.value = targetList.filter((item) => item.id);
  } catch (error) {
    contactList.value = [];
  }
  if (contactList.value.length == 0) {
    contactList.value = [{ id: 1, name: "平台客服", avatarurl: "" }];
  }
  if (
    !activeContactId.value ||
    !contactList.value.some((item) => Number(item.id) == Number(activeContactId.value))
  ) {
    activeContactId.value = contactList.value[0].id;
  }
};

const handleSwitchContact = async () => {
  await getChatHistory(activeContactId.value);
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
      // Not a JSON string, treat as a plain text message for backward compatibility
      return { type: 0, content: msg.content };
    }
  }
  // Fallback for malformed or non-string content
  return { type: 0, content: msg.content };
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
:root {
  --chat-bg-color: #f0f4f8;
  --chat-panel-color: rgba(255, 255, 255, 0.85);
  --primary-text-color: #1a202c;
  --secondary-text-color: #718096;
  --accent-color-sent: #d6eaff;
  --accent-color-received: #e9eaf0;
  --online-color: #48bb78;
  --offline-color: #a0aec0;
  --font-family: "Microsoft YaHei", "PingFang SC", sans-serif;
}

.chat-container-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: var(--chat-bg-color);
  padding: 20px;
  box-sizing: border-box;
}

.chat-container {
  width: 100%;
  max-width: 80%;
  height: 90vh;
  max-height: 800px;
  display: flex;
  flex-direction: column;
  background: var(--chat-panel-color);
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  overflow: hidden;
  font-family: var(--font-family);
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
  padding: 20px 25px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
  flex-shrink: 0;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 18px;
}

.chat-header h1 {
  font-size: 22px;
  font-weight: 600;
  color: var(--primary-text-color);
  margin: 0;
}

.contact-selector {
  display: flex;
  align-items: center;
  gap: 10px;
}

.selector-label {
  font-size: 13px;
  color: var(--secondary-text-color);
}

.selector-input {
  width: 180px;
}

.status-indicator {
  display: flex;
  align-items: center;
}

.status-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: var(--offline-color);
  margin-right: 8px;
  transition: background-color 0.3s ease;
}

.status-dot.connected {
  background-color: var(--online-color);
  box-shadow: 0 0 8px var(--online-color);
}

.status-text {
  font-size: 14px;
  font-weight: 500;
  color: var(--secondary-text-color);
}

.chat-messages {
  flex-grow: 1;
  overflow-y: auto;
  padding: 25px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.welcome-message {
  text-align: center;
  margin: 20px 0;
  color: var(--secondary-text-color);
}

.welcome-message h2 {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 5px;
}

.welcome-message p {
  font-size: 14px;
}

.message-wrapper {
  display: flex;
  align-items: flex-end;
  gap: 15px;
  max-width: 80%;
  animation: message-fade-in 0.4s ease-out;
}

@keyframes message-fade-in {
  from {
    opacity: 0;
    transform: translateY(15px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.message-wrapper.sent {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.message-wrapper.received {
  align-self: flex-start;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  overflow: hidden;
  flex-shrink: 0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  background-color: #e2e8f0;
}

.avatar img,
.avatar svg {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.message-content {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.username {
  font-size: 13px;
  color: var(--secondary-text-color);
  padding: 0 5px;
}

.message-wrapper.sent .username {
  display: none;
}

.message-bubble {
  padding: 12px 18px;
  border-radius: 20px;
  line-height: 1.6;
  font-size: 15px;
  max-width: 100%;
  word-wrap: break-word;
}

.message-wrapper.sent .message-bubble {
  background: var(--accent-color-sent);
  color: var(--primary-text-color);
  border-bottom-right-radius: 5px;
}

.message-wrapper.received .message-bubble {
  background: var(--accent-color-received);
  color: var(--primary-text-color);
  border-bottom-left-radius: 5px;
}

.text-content {
  margin: 0;
}

.chat-image {
  max-width: 250px;
  max-height: 250px;
  border-radius: 15px;
  cursor: pointer;
  transition: transform 0.2s ease;
}
.chat-image:hover {
  transform: scale(1.05);
}

.message-bubble:has(.chat-image) {
  padding: 5px;
  background: transparent;
}

.file-message {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
  color: inherit;
}

.message-wrapper.sent .file-message {
  color: var(--primary-text-color);
}

.file-icon {
  width: 30px;
  height: 36px;
  background-color: #a0aec0;
  border-radius: 4px;
  position: relative;
  flex-shrink: 0;
}
.file-icon::before {
  content: "";
  position: absolute;
  top: -3px;
  right: -3px;
  width: 0;
  height: 0;
  border-left: 12px solid transparent;
  border-bottom: 12px solid var(--chat-panel-color);
  filter: brightness(0.9);
}
.message-wrapper.sent .file-icon::before {
  border-bottom-color: var(--accent-color-sent);
}
.message-wrapper.received .file-icon {
  background-color: #a0aec0;
}
.message-wrapper.sent .file-icon {
  background-color: rgba(0, 0, 0, 0.2);
}

.file-info {
  overflow: hidden;
}

.file-name {
  font-weight: 600;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.file-size {
  font-size: 12px;
  opacity: 0.8;
}

.chat-input-area {
  display: flex;
  align-items: flex-start;
  padding: 15px 25px;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
  background-color: rgba(255, 255, 255, 0.5);
  flex-shrink: 0;
}

.input-toolbar {
  display: flex;
  gap: 10px;
  padding-top: 8px;
}

.tool-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 5px;
  opacity: 0.6;
  transition: opacity 0.2s ease;
}
.tool-btn:hover {
  opacity: 1;
}

.icon-image,
.icon-file {
  width: 24px;
  height: 24px;
  background-color: var(--secondary-text-color);
}

.icon-image {
  mask: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>')
    no-repeat center / contain;
}

.icon-file {
  mask: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg>')
    no-repeat center / contain;
}

.message-input {
  flex: 1;
  min-width: 0;
}

:deep(.message-input .el-textarea__inner) {
  padding: 10px 15px;
  font-size: 15px;
  color: var(--primary-text-color);
  font-family: inherit;
  border-radius: 12px;
}

.send-btn {
  background: #4a90e2;
  color: white;
  border: none;
  border-radius: 10px;
  padding: 10px 20px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  margin-left: 15px;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.send-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 10px rgba(74, 144, 226, 0.4);
}
.send-btn:active {
  transform: translateY(0);
  box-shadow: none;
}

.image-viewer-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
  cursor: pointer;
  animation: viewer-fade-in 0.3s ease;
}

@keyframes viewer-fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.fullscreen-image {
  max-width: 90%;
  max-height: 90%;
  object-fit: contain;
  cursor: default;
  border-radius: 10px;
  box-shadow: 0 0 50px rgba(0, 0, 0, 0.5);
}

/* Custom Scrollbar */
.chat-messages::-webkit-scrollbar {
  width: 6px;
}
.chat-messages::-webkit-scrollbar-track {
  background: transparent;
}
.chat-messages::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}
.chat-messages::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 0, 0, 0.3);
}
</style>
