import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";
import router from "./router";

import ElementPlus from "element-plus";
import "./style/override.scss";
import "element-plus/dist/index.css";

import zhCn from "element-plus/dist/locale/zh-cn.mjs"; // 引入中文语言包
// 引入菠萝
import { createPinia } from "pinia";
// 引入菠萝持久化
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";

// 页面组件=======================================
// 引入轮播图组件
import ImageCarousel from "./components/ImageCarousel/index.vue";
// 引入公告组件
import announcementModule from "./components/announcementModule/index.vue";
// 引入关于我们
import AboutUsSection from "./components/AboutUsSection/index.vue";
// 引入导航栏
import AppHeader from "./components/AppHeader/index.vue";
// 引入视频音乐播放器
import playerVideo from "./components/playerVideo/index.vue";
// 引入推荐模块
import userCFRecommend from "./components/userCFRecommend/index.vue";
// 首页集合组件;
import home from "./components/home/index.vue";

// 单独使用组件==================================
// 引入评论组件
import CommentComponent from "./components/Comment/CommentComponent.vue";
// 富文本组件
import RichTextEditor from "./components/RichTextEditor/index.vue";
// 地址选择器
import AddressSelector from "./components/AddressSelector/index.vue";
// 图片上传
import ImageUpload from "./components/ImageUpload/index.vue";
// 图片预览
import ImageView from "./components/ImageView/index.vue";
// 地址选择器模块 使用v-model
import ReceiptInformation from "./components/receiptInformation/index.vue";
// 点赞收藏模块
// 使用教程         上级id              上级对象               表名(非必传字符串)          类型： -1踩 2关注 3收藏 4点赞 5喜欢
//    <LikeGeneral :refid="product.id" :parentData="product" :tablename="'productPage'" :type="2" />
import likeGeneral from "./components/likeGeneral/index.vue";
// 微博分享
import weiboSharing from "./components/weiboSharing/index.vue";
import qqSharing from "./components/qqSharing/index.vue";
import TieBaShare from "./components/TieBaShare/index.vue";
// 添加购物车
import addShoppingCart from "./components/addShoppingCart/index.vue";
// 引入接口请求
import requestApi from "./utils/axios";
// 文件上传
import fileUpload from "./components/fileUpload/index.vue";
const app = createApp(App);

// 全局注册组件
app.component("CommentComponent", CommentComponent);
app.component("ImageCarousel", ImageCarousel);
app.component("AnnouncementModule", announcementModule);
app.component("AboutUsSection", AboutUsSection);
app.component("AppHeader", AppHeader);
app.component("UserCFRecommend", userCFRecommend);
app.component("HomePage", home);
app.component("RichTextEditor", RichTextEditor);
app.component("AddressSelector", AddressSelector);
app.component("ImageUpload", ImageUpload);
app.component("ImageView", ImageView);
app.component("ReceiptInformation", ReceiptInformation);
app.component("LikeGeneral", likeGeneral);
app.component("AddShoppingCart", addShoppingCart);
app.component("WeiboSharing", weiboSharing);
app.component("QQSharing", qqSharing);
app.component("TieBaShare", TieBaShare);
app.component("PlayerVideo", playerVideo);
app.component("FileUpload", fileUpload);
// 全局注册接口请求

app.config.globalProperties.$http = requestApi;

// 注册菠萝
const pinia = createPinia();
// // 注册菠萝持久化
pinia.use(piniaPluginPersistedstate);
app.use(pinia);

app.use(router);

app.use(ElementPlus, {
  locale: zhCn, // 配置 Element Plus 使用中文语言包
});

app.mount("#app");
