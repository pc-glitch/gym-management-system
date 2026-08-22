import { defineConfig, loadEnv } from "vite";
import vue from "@vitejs/plugin-vue";
import path from "path";

export default ({ mode }) => {
  // 根据当前工作目录中的 `mode` 加载 .env 文件
  // `process.cwd()` 返回项目的根目录
  const env = loadEnv(mode, process.cwd());

  return defineConfig({
    plugins: [vue()],
    resolve: {
      alias: {
        // 配置路径映射，将 '@' 映射到项目的 'src' 目录
        // 允许使用 @/path/to/module 来导入模块
        "@": path.resolve(__dirname, "./src"),
      },
    },
    server: {
      host: "0.0.0.0", // 允许外部访问
      port: 8080, // 设置启动端口
      strictPort: false, // 设为 false (默认)，若端口被占用则会自动尝试下一个可用端口
      open: true, // 服务启动时自动在浏览器中打开应用
      // 开发服务器选项
      proxy: {
        // 代理所有以 /api 开头的请求到后端
        "/api": {
          target: env.VITE_APP_BASE_URL,
          changeOrigin: true, // 解决跨域
          rewrite: (path) => path.replace(/^\/api/, ""),
          ws: true,
        },
        // 代理websocket
        "/ws": {
          target: `${env.VITE_STOCKET_BASE_URL}`,
          ws: true,
          changeOrigin: true,
        },
      },
    },
  });
};