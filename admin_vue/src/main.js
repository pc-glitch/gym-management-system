import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";
import router from "./router";

import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import "./style/override.scss";
import zhCn from "element-plus/dist/locale/zh-cn.mjs"; // 引入中文语言包
import * as ElementPlusIconsVue from "@element-plus/icons-vue";

import RichTextEditor from "./components/RichTextEditor/index.vue";
import fileUpload from "./components/fileUpload/index.vue";

// 组件引入
// 图片上传
import ImageUpload from "./components/ImageUpload/index.vue";
import ImageView from "./components/ImageView/index.vue";

const app = createApp(App);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}

app.component("ImageUpload", ImageUpload);
app.component("ImageView", ImageView);
app.component("FileUpload", fileUpload);

app.use(router);
// app.use(TDesign)
app.component("RichTextEditor", RichTextEditor);
app.use(ElementPlus, {
  locale: zhCn, // 配置 Element Plus 使用中文语言包
});

app.mount("#app");
