import axios from "axios";
import Message from "@/components/MessageBox/index.js"; // 引入自定义消息提示组件
// 引入token管理函数
import { getToken, removeToken, emptyTheCache } from "./auth";
import router from "../router/index"; // 引入路由实例

/**
 * @description 递归移除对象中值为 null 或 "" (空字符串) 的属性
 * @param {Object|Array} obj - 需要处理的对象或数组
 * @returns {Object|Array} 处理后的对象或数组
 */
const removeEmptyValues = (obj) => {
  // 1. 处理非对象类型 (基础数据类型) 或 null
  if (typeof obj !== "object" || obj === null) {
    return obj;
  }

  // 2. 特殊对象处理：FormData、Date、File、Blob 不处理，直接返回
  if (
    obj instanceof FormData ||
    obj instanceof Date ||
    obj instanceof File ||
    obj instanceof Blob
  ) {
    return obj;
  }

  // 3. 处理数组：递归处理数组中的每一项
  if (Array.isArray(obj)) {
    return obj.map((item) => removeEmptyValues(item));
  }

  // 4. 处理普通对象
  const newObj = {};
  for (const key in obj) {
    // 确保只遍历对象自身的属性
    if (Object.prototype.hasOwnProperty.call(obj, key)) {
      const value = obj[key];

      // 核心判断：如果值为 null 或 ""，则跳过（不添加到新对象中）
      // 注意：这里没有过滤 undefined，如果你也想过滤 undefined，可以加上 value === undefined
      if (value === null || value === "") {
        continue;
      }

      // 递归处理子属性（深度清洗）
      newObj[key] = removeEmptyValues(value);
    }
  }
  return newObj;
};

const service = axios.create({
  baseURL: "/", // 基础路径设置为 /api，通过 Vite 代理
  timeout: 5000, // 请求超时时间
});

// 请求拦截器
service.interceptors.request.use(
  (config) => {
    // --- 新增逻辑开始: 自动过滤空参数 ---
    if (config.data) {
      config.data = removeEmptyValues(config.data);
    }
    if (config.params) {
      config.params = removeEmptyValues(config.params);
    }
    // --- 新增逻辑结束 ---

    const token = getToken();
    // 如果存在 token 且 config.headers.isToken 不为 false (即默认需要携带token)
    if (token && config.headers.isToken != false) {
      config.headers.Authorization = `${token}`; // 在请求头中添加 Authorization
    }
    return config; // 返回配置
  },
  (error) => {
    // 对请求错误做些什么
    return Promise.reject(error);
  }
);

// 响应拦截器
service.interceptors.response.use(
  (response) => {
    // 打印返回的响应数据
    let { success, msg, code } = response.data; // 解构响应数据

    if (code == 0) {
      // 业务成功码
      return response.data; // 正常返回数据
    } else if (code == 401) {
      // 登录过期或未授权
      Message.error("登录过期，请重新登录");
      removeToken("Token"); // 移除本地存储的token
      // 删除所有路由 跳转至登录页 (这里通常需要清除动态路由，确保下次登录是干净的状态)
      setTimeout(() => {
        router.push("/login"); // 跳转到登录页
      }, 1000);
      // 返回拒绝的 Promise，阻止后续的 then/catch 链条继续执行业务逻辑
      return Promise.reject(new Error("登录过期，请重新登录"));
    } else if (code == 500) {
      // 判断msg内是否包含错误，如果有则token出现问题
      if (
        msg.includes("失效") ||
        msg.includes("冻结") ||
        msg.includes("无效") ||
        msg.includes("顶下线") ||
        msg.includes("已被冻结") ||
        msg.includes("fail") ||
        msg.includes("未能读取到有效")
      ) {
        // 清空全部缓存
        emptyTheCache();
        Message.error("登录过期，请重新登录");
        router.push("/login"); // 跳转到登录页
        return Promise.reject(new Error("登录过期，请重新登录"));
      }
      // 服务器内部错误
      Message.error(msg || "服务器内部错误"); // 显示后端返回的错误信息
      // 对于 500 错误，我们仍然返回 response.data，但业务逻辑中需要判断 code
      return response.data;
    } else if (code != 0) {
      // 同样返回 response.data，让业务逻辑自行处理
      return response.data;
    }
    // 对于其他未明确处理的 code，也直接返回数据
    return response.data;
  },
  (error) => {
    // 对响应错误做些什么
    if (error.response) {
      // 请求已发出，但服务器响应的状态码不在 2xx 范围内
      let { success, msg, code } = error.response.data; // 解构响应数据
      if (error.status == 401) {
        // 清空全部缓存
        emptyTheCache();
        Message.error("登录过期，请重新登录");
        router.push("/login"); // 跳转到登录页
        return Promise.reject(new Error("登录过期，请重新登录"));
      }

      console.error("错误响应数据:", error);
      // 判断msg内是否包含错误，如果有则token出现问题
      if (
        msg &&
        (msg.includes("失效") ||
          msg.includes("冻结") ||
          msg.includes("无效") ||
          msg.includes("顶下线") ||
          msg.includes("未能读取到有效"))
      ) {
        // 清空全部缓存
        emptyTheCache();
        Message.error("登录过期，请重新登录");
        router.push("/login"); // 跳转到登录页
        return Promise.reject(new Error("登录过期，请重新登录"));
      }

      Message({
        message:
          error.response.data.msg || `请求错误: ${error.response.status}`,
        type: "error",
      });
    } else if (error.request) {
      // 请求已经发出，但没有收到响应
      Message({
        message: "网络请求失败，请检查网络连接",
        type: "error",
      });
    } else {
      // 在设置请求时发生了某些事情，触发了一个错误
      Message({
        message: error.message || "请求出错，请稍后再试",
        type: "error",
      });
    }
    return Promise.reject(error); // 继续抛出错误，让业务代码捕获
  }
);

/**
 * @description 自定义 GET 请求方法，支持直接传入参数对象
 * @param {string} url - 请求 URL
 * @param {object} [data] - GET 请求的参数对象
 * @param {object} [config] - Axios 配置对象
 * @returns {Promise<any>}
 */
const customGet = (url, data, config = {}) => {
  // 如果 data 存在且是对象，将其合并到 config.params 中
  if (data && typeof data === "object") {
    config.params = { ...config.params, ...data };
  }
  return service.get(url, config);
};

/**
 * @description 自定义 POST 请求方法 (保持与 service.post 一致)
 * @param {string} url - 请求 URL
 * @param {object} [data] - POST 请求体数据  如果没传默认空对象放置报错
 * @param {object} [config] - Axios 配置对象
 * @returns {Promise<any>}
 *
 *
 */
const customPost = (url, data = {}, config = {}) => {
  return service.post(url, data, config);
};

// 导出封装后的请求方法
export default {
  get: customGet,
  post: customPost,
  put: service.put,
  delete: service.delete,
};
