# 体育馆管理系统 (Gym Management System)

基于 **Spring Boot + Vue** 的体育馆管理系统毕业设计。包含管理端、用户端两个前端，以及统一的 Spring Boot 后端服务。

---

## 技术栈

### 后端 (`myproject`)
- **Java 8** / **Spring Boot 2.7.5**
- **MyBatis-Plus**（ORM）
- **Sa-Token**（鉴权，Token 名称 `Authorization`，存于 Redis）
- **Undertow**（Web 容器，非 Tomcat）
- **Redis**（缓存 / Session）
- **MySQL**（持久化）
- 统一响应：`Result<T> { code, msg, data }`；分页：`PageResult { total, list }`

### 前端 (`admin_vue` / `user_vue`)
- **Vue 3** + **Vite 7**
- **Element Plus**（UI 组件库）
- **Pinia**（状态管理 + 持久化）
- **Vue Router**
- **ECharts**（数据可视化）
- **wangEditor / Quill**（富文本编辑）
- `user_vue` 额外集成 **Vitest** 单元测试

---

## 目录结构

```
gym-management-system/
├── myproject/          # Spring Boot 后端（端口 6001，WebSocket 端口 5001）
├── admin_vue/          # 管理端前端（Vite，npm run dev）
├── user_vue/           # 用户端前端（Vite，含单元测试）
├── upload/             # 运行时上传目录（由程序自动创建，默认不纳入版本库）
├── start.js / start.bat# 旧版一键启动脚本（引用目录已变更，请勿直接使用）
├── logo2.png
└── README.md
```

> ⚠️ `start.js` / `start.bat` 为早期脚本，内部引用的 `behind`、`vue` 目录与当前结构不符，**请不要使用**，按下方「启动步骤」手动启动。

---

## 环境要求

| 依赖 | 版本要求 |
| --- | --- |
| JDK | 17 |
| Maven | 3.x |
| Node.js | 20.19+ / 22.12+（Vite 7 需要较新版本） |
| MySQL | 5.7+ / 8.x |
| Redis | 5+ |

---

## 数据库与配置

1. 在 MySQL 中创建数据库，默认库名 **`gym-test`**（字符集建议 `utf8mb4`）。
2. 后端配置位于 `myproject/src/main/resources/`：
   - `application.yml`：公共配置，激活 `dev` 环境。
   - `application-dev.yml`：开发环境配置（端口、数据源、Redis、邮件等）。
3. 默认开发连接（仅本地使用，生产请修改）：
   - MySQL：`127.0.0.1:3306` / 账号 `root` / 密码 `1234`
   - Redis：`127.0.0.1:6379` / 密码 `1234` / 库 `7`

---

## 启动步骤

### 1. 启动后端

```bash
cd myproject
mvn clean install -DskipTests
mvn spring-boot:run
# 也可以直接在 IDE 中运行 Spring Boot 主类
```

后端默认监听 **6001** 端口。

### 2. 启动管理端前端 (`admin_vue`)

```bash
cd admin_vue
npm install        # 或 yarn
npm run dev
```

根据终端输出的地址访问（Vite 绑定 `0.0.0.0`，端口以终端为准）。

### 3. 启动用户端前端 (`user_vue`)

```bash
cd user_vue
npm install
npm run dev
```

### 可选：运行用户端单元测试

```bash
cd user_vue
npm run test:run
```

---

## 接口与鉴权说明

- 所有业务接口统一返回 `Result<T>`（`code=0` 表示成功）。
- 登录后，前端在请求头 `Authorization` 中携带 Sa-Token 下发的 token；后端据此校验身份。


---

## 许可证

仅供学习交流使用。
