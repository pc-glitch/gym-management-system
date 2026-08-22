/**
 * WebSocket 服务封装 (单例模式)
 * URL被硬编码在此文件中，并使用单例模式确保全局只有一个实例。
 */
import { GetUserId } from "./auth.js";

// 1. 将WebSocket地址定义为常量
const WEBSOCKET_URL = "/ws";

class WebSocketService {
  // 使用静态属性来保存单例实例
  static instance = null;

  constructor() {
    // 防止通过 new 关键字重复创建实例
    if (WebSocketService.instance) {
      return WebSocketService.instance;
    }

    this.url = WEBSOCKET_URL;
    this.ws = null;
    this.onMessageCallback = null; // 回调函数通过方法来设置
    this.isConnecting = false;
    this.reconnectTimeoutId = null;
    this.onOpenCallback = null; // 新增：连接成功的回调
    this.onCloseCallback = null; // 新增：连接关闭的回调
    this.userId = null; // 动态存储用户ID

    WebSocketService.instance = this;
  }

  /**
   * 为当前使用者设置回调函数
   * @param {Object} callbacks - 包含各种回调的对象
   * @param {Function} callbacks.onMessage - 消息回调
   * @param {Function} callbacks.onOpen - 连接成功回调
   * @param {Function} callbacks.onClose - 连接关闭回调
   */
  setCallbacks({ onMessage, onOpen, onClose }) {
    this.onMessageCallback = onMessage;
    this.onOpenCallback = onOpen;
    this.onCloseCallback = onClose;
  }

  async connect() {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      console.log("WebSocket 已连接。");
      // 如果已经连接，也应该触发一次 onOpen 回调，确保新监听者状态正确
      if (this.onOpenCallback) this.onOpenCallback();
      return;
    }
    if (this.isConnecting) {
      console.log("WebSocket 正在连接中...");
      return;
    }

    this.isConnecting = true;
    
    // 动态获取用户ID，确保与发送消息时使用的ID一致
    try {
      this.userId = await GetUserId();
      console.log("WebSocket 连接时获取的用户ID:", this.userId);
    } catch (error) {
      console.error("获取用户ID失败:", error);
      this.isConnecting = false;
      return;
    }
    
    // 动态构建包含协议、主机、路径和用户ID的完整URL
    const fullURL = `${location.protocol === "https:" ? "wss:" : "ws:"}//${
      location.host
    }${this.url}?userId=${this.userId}`;
    console.log(`正在连接到: ${fullURL}`);
    this.ws = new WebSocket(fullURL);

    this.ws.onopen = (event) => {
      console.log("WebSocket 连接成功！");
      this.isConnecting = false;
      if (this.reconnectTimeoutId) {
        clearTimeout(this.reconnectTimeoutId);
        this.reconnectTimeoutId = null;
      }
      if (this.onOpenCallback) {
        this.onOpenCallback(event);
      }

      // 将用户上线 (使用动态获取的userId)
      const onlineMessage = {
        id: this.userId,
        ws_type: 1, // 1 代表上线消息
      };
      console.log("发送上线消息:", JSON.stringify(onlineMessage));
      this.ws.send(JSON.stringify(onlineMessage));
    };

    this.ws.onmessage = (event) => {
      if (this.onMessageCallback) {
        try {
          const data = JSON.parse(event.data);
          this.onMessageCallback(data);
        } catch (error) {
          this.onMessageCallback(event.data);
        }
      }
    };

    this.ws.onerror = (error) => {
      console.error("WebSocket 发生错误:", error);
      this.isConnecting = false;
    };

    this.ws.onclose = (event) => {
      console.log("WebSocket 连接已关闭。");
      this.isConnecting = false;
      this.ws = null;
      if (this.onCloseCallback) {
        this.onCloseCallback(event);
      }
      // 只有在非主动关闭时才重连
      if (event.code != 1000) {
        this.reconnect();
      }
    };
  }

  send(message) {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(JSON.stringify(message));
    } else {
      console.error("WebSocket 未连接，无法发送消息。");
      // 可以尝试连接后再发送
      // this.connect();
      // console.log('尝试重新连接以发送消息...');
    }
  }

  close() {
    if (this.ws) {
      console.log("主动关闭 WebSocket 连接");
      if (this.reconnectTimeoutId) {
        clearTimeout(this.reconnectTimeoutId);
      }
      this.ws.close(1000, "Manual closure"); // 使用标准代码1000表示正常关闭
    }
  }

  reconnect() {
    if (!this.reconnectTimeoutId) {
      this.reconnectTimeoutId = setTimeout(() => {
        console.log("正在尝试重新连接...");
        this.connect();
      }, 5000);
    }
  }
}

// 2. 导出一个已经创建好的单例
const instance = new WebSocketService();
export default instance;
