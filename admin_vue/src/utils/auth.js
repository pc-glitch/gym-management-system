const TokenKey = "Token";
import requestApi from "@/utils/axios.js";
import { options } from "@/utils/Role";
export function getToken() {
  return localStorage.getItem(TokenKey); // 获取浏览器缓存中的token
}

export function setToken(token) {
  return localStorage.setItem(TokenKey, token); // 设置浏览器缓存中的token
}

export function removeToken() {
  return localStorage.removeItem(TokenKey); // 删除浏览器缓存中的token
}

// 清空全部浏览器缓存
export function emptyTheCache() {
  console.log("--- 正在尝试清空客户端缓存 ---");
  // 1. 清空 localStorage
  try {
    // 读取rememberedUsername;与;rememberedPassword;
    const rememberedUsername = localStorage.getItem("rememberedUsername");
    const rememberedPassword = localStorage.getItem("rememberedPassword");

    localStorage.clear();
    console.log("localStorage 已清空。");

    if (rememberedUsername && rememberedPassword) {
      // 存储用户名密码
      localStorage.setItem("rememberedUsername", rememberedUsername);
      localStorage.setItem("rememberedPassword", rememberedPassword);
      localStorage.setItem("rememberMeChecked", "true");
    }
  } catch (e) {
    console.error("清空 localStorage 失败:", e);
  }

  // 2. 清空 sessionStorage
  try {
    sessionStorage.clear();
    console.log("sessionStorage 已清空。");
  } catch (e) {
    console.error("清空 sessionStorage 失败:", e);
  }

  // 3. 清空 IndexedDB (所有数据库)
  // 这需要遍历所有数据库名称并删除
  indexedDB
    .databases()
    .then((dbs) => {
      dbs.forEach((db) => {
        try {
          indexedDB.deleteDatabase(db.name);
          console.log(`IndexedDB 数据库 "${db.name}" 已删除。`);
        } catch (e) {
          console.error(`删除 IndexedDB 数据库 "${db.name}" 失败:`, e);
        }
      });
    })
    .catch((e) => {
      console.error("获取 IndexedDB 数据库列表失败:", e);
    });

  // 4. 清空 Service Worker 缓存 (如果存在)
  if ("caches" in window) {
    caches
      .keys()
      .then((cacheNames) => {
        cacheNames.forEach((cacheName) => {
          try {
            caches.delete(cacheName);
            console.log(`Service Worker 缓存 "${cacheName}" 已删除。`);
          } catch (e) {
            console.error(`删除 Service Worker 缓存 "${cacheName}" 失败:`, e);
          }
        });
      })
      .catch((e) => {
        console.error("获取 Service Worker 缓存列表失败:", e);
      });
  } else {
    console.log("当前浏览器不支持 Service Worker 缓存 API。");
  }
}

// 获取用户信息
export async function getUserData() {
  // 1. 健壮性检查：确保 localStorage 在当前环境下可用
  if (typeof localStorage === "undefined") {
    console.error("错误: localStorage 在此环境中不可用。");
    return null;
  }

  // 2. 使用 try-catch 块来处理潜在的 JSON.parse 错误
  try {
    // 3. 使用 localStorage.getItem(key) 获取存储的数据。
    //    如果键不存在，则返回 null。
    const storedData = localStorage.getItem("userData");
    // 4. 检查数据是否存在。如果为 null 或 undefined，则返回 null
    if (!storedData) {
      console.log(`提示: 在 localStorage 中没有找到键为 "userData" 的数据。`);
      return null;
    }

    // 5. 将获取的字符串数据解析为 JSON 对象
    const parsedObject = JSON.parse(storedData);

    // 6. 获取最新用户数据
    const userRole = parsedObject.role;
    const roleInfo = options.find(option => option.role === userRole);

    if (!roleInfo) {
      console.error("错误: 未知的用户角色。", userRole);
      return null;
    }

    const apiUrl = `/api/${roleInfo.table}/info`;
    let res = await requestApi.post(apiUrl, {
      id: parsedObject.userid || parsedObject.id,
    });

    return res.data;
  } catch (error) {
    // 7. 如果在解析 JSON 时发生错误，捕获并处理它。
    //    例如，当存储的数据不是有效的 JSON 字符串时。
    console.error(
      `错误: 无法解析键为  userData 的 localStorage 数据。可能不是有效的 JSON 格式。`,
      error
    );
    return null;
  }
}

// 获取用户id
export async function GetUserId() {
  let userData = await getUserData();
  let userid = userData.userid || userData.id;
  if (!userid) {
    console.warn("未找到用户ID。请检查用户数据是否正确或已登录。");
    return null;
  }
  return userid;
}

// 从本地缓存解析 userData（不发请求）
export function getStoredUserData() {
  try {
    const raw = localStorage.getItem("userData");
    if (!raw) return null;
    return JSON.parse(raw);
  } catch (e) {
    console.error("解析本地 userData 失败:", e);
    return null;
  }
}

// 获取当前登录角色（0 管理员 / 1 毕业校友）
export function getUserRole() {
  const stored = getStoredUserData();
  return stored ? stored.role : null;
}

// 是否管理员
export function isAdminRole() {
  return getUserRole() == "0";
}

// 获取当前时间 年月日时分秒格式
export const getNowTime = async () => {
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth() + 1;
  const day = now.getDate();
  const hours = now.getHours();
  const minutes = now.getMinutes();
  const seconds = now.getSeconds();

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};
