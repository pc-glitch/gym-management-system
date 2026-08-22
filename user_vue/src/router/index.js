import { createRouter, createWebHistory } from "vue-router";
import MessageBox from "@/components/MessageBox/index.js";


const HomePage = () => import("../components/home/index.vue");
const Index = () => import("../view/index/index.vue");
const Login = () => import("../view/login/index.vue");
const register = () => import("../view/register/index.vue");
const about = () => import("../view/abouts/index.vue");
const personal = () => import("../view/personal/index.vue");
const ChangePassword = () => import("../view/ChangePassword/index.vue");
const announcement = () => import("../view/announcement/index.vue");





const chatFilesPictures = () => import("../view/chatFilesPictures/index.vue"); // 联系我们

const community = () => import("../view/community/index.vue"); // 社区论坛

const issuePost = () => import("../view/issuePost/index.vue"); // 发布帖子

const myPost = () => import("../view/myPost/index.vue"); // 我的帖子

const myCollection = () => import("../view/myCollection/index.vue"); // 我的收藏

const myOrder = () => import("../view/myOrder/index.vue"); // 我的订单

const orderDetails = () => import("../view/orderDetails/index.vue"); // 订单详情

const myBalance = () => import("../view/myBalance/index.vue"); // 在线充值

const Settlement = () => import("../view/Settlement/index.vue"); // 支付结算

const addressList = () => import("../view/addressList/index.vue"); // 地址管理

const eventregistrationCreatePage = () => import("../view/Page/eventregistrationCreatePage/index.vue"); // 赛事报名

const activityregistrationCreatePage = () => import("../view/Page/activityregistrationCreatePage/index.vue"); // 活动报名

const eventinformationListPage = () => import("../view/Page/eventinformationListPage/index.vue"); // 赛事信息列表

const eventinformationDetailPage = () => import("../view/Page/eventinformationDetailPage/index.vue"); // 赛事信息详情

const activityinformationListPage = () => import("../view/Page/activityinformationListPage/index.vue"); // 活动信息列表

const activityinformationDetailPage = () => import("../view/Page/activityinformationDetailPage/index.vue"); // 活动信息详情

const commodityinformationListPage = () => import("../view/Page/commodityinformationListPage/index.vue"); // 商品信息列表

const commodityinformationDetailPage = () => import("../view/Page/commodityinformationDetailPage/index.vue"); // 商品信息详情

const venuereservationCreatePage = () => import("../view/Page/venuereservationCreatePage/index.vue"); // 场地预约

const venueinformationListPage = () => import("../view/Page/venueinformationListPage/index.vue"); // 场地信息列表

const venueinformationDetailPage = () => import("../view/Page/venueinformationDetailPage/index.vue"); // 场地信息详情

const equipmentListPage = () => import("../view/Page/equipmentListPage/index.vue"); // 器材列表
const equipmentDetailPage = () => import("../view/Page/equipmentDetailPage/index.vue"); // 器材详情
const equipmentRentalPage = () => import("../view/Page/equipmentRentalPage/index.vue"); // 器材租借
const rentalListPage = () => import("../view/Page/rentalListPage/index.vue"); // 租借列表


const routes = [
  {
    path: "/",
    redirect: "/index",
  },
  {
    path: "/index",
    component: Index,
    meta: { title: "首页", requiresAuth: false },
    children: [
      
      {
        path: "",
        component: HomePage,
        meta: { title: "首页", requiresAuth: false },
      },
      {
        path: "/Login",
        component: Login,
        meta: { title: "登录", requiresAuth: false },
      },
      {
        path: "/ChangePassword",
        component: ChangePassword,
        meta: { title: "修改密码", requiresAuth: true },
      },
      {
        path: "/personal",
        component: personal,
        meta: { title: "个人中心", requiresAuth: true },
      },
      {
        path: "/register",
        component: register,
        meta: { title: "注册", requiresAuth: false },
      },
      {
        path: "/about",
        component: about,
        meta: { title: "关于我们", requiresAuth: false },
      },
      {
        path: "/announcement",
        component: announcement,
        meta: { title: "公告列表", requiresAuth: false },
      },

      
      
      
      {
        path: "/chatFilesPictures",
        component: chatFilesPictures,
        meta: { title: "在线客服", requiresAuth: true },
      },
      
      {
        path: "/community",
        component: community,
        meta: { title: "社区论坛", requiresAuth: true },
      },
      
      {
        path: "/issuePost",
        component: issuePost,
        meta: { title: "发布帖子", requiresAuth: true },
      },
      
      {
        path: "/myPost",
        component: myPost,
        meta: { title: "我的帖子", requiresAuth: true },
      },
      
      {
        path: "/myCollection",
        component: myCollection,
        meta: { title: "我的收藏", requiresAuth: true },
      },
      
      {
        path: "/myOrder",
        component: myOrder,
        meta: { title: "我的订单", requiresAuth: true },
      },
      
      {
        path: "/orderDetails",
        component: orderDetails,
        meta: { title: "订单详情", requiresAuth: true },
      },
      
      {
        path: "/myBalance",
        component: myBalance,
        meta: { title: "在线充值", requiresAuth: true },
      },
      
      {
        path: "/Settlement",
        component: Settlement,
        meta: { title: "支付结算", requiresAuth: true },
      },
      
      {
        path: "/addressList",
        component: addressList,
        meta: { title: "地址管理", requiresAuth: true },
      },
      
      {
        path: "/eventregistrationCreatePage",
        component: eventregistrationCreatePage,
        meta: { title: "赛事报名", requiresAuth: true },
      },
      
      {
        path: "/activityregistrationCreatePage",
        component: activityregistrationCreatePage,
        meta: { title: "活动报名", requiresAuth: true },
      },
      
      {
        path: "/eventinformationListPage",
        component: eventinformationListPage,
        meta: { title: "赛事信息列表", requiresAuth: false },
      },
      
      {
        path: "/eventinformationDetailPage",
        component: eventinformationDetailPage,
        meta: { title: "赛事信息详情", requiresAuth: true },
      },
      
      {
        path: "/activityinformationListPage",
        component: activityinformationListPage,
        meta: { title: "活动信息列表", requiresAuth: false },
      },
      
      {
        path: "/activityinformationDetailPage",
        component: activityinformationDetailPage,
        meta: { title: "活动信息详情", requiresAuth: true },
      },
      
      {
        path: "/commodityinformationListPage",
        component: commodityinformationListPage,
        meta: { title: "商品信息列表", requiresAuth: false },
      },
      
      {
        path: "/commodityinformationDetailPage",
        component: commodityinformationDetailPage,
        meta: { title: "商品信息详情", requiresAuth: true },
      },
      
      {
        path: "/venuereservationCreatePage",
        component: venuereservationCreatePage,
        meta: { title: "场地预约", requiresAuth: true },
      },
      
      {
        path: "/venueinformationListPage",
        component: venueinformationListPage,
        meta: { title: "场地信息列表", requiresAuth: false },
      },
      
      {
        path: "/venueinformationDetailPage",
        component: venueinformationDetailPage,
        meta: { title: "场地信息详情", requiresAuth: true },
      },
      
      {
        path: "/equipmentListPage",
        component: equipmentListPage,
        meta: { title: "器材列表", requiresAuth: false },
      },
      
      {
        path: "/equipmentDetailPage",
        component: equipmentDetailPage,
        meta: { title: "器材详情", requiresAuth: true },
      },
      {
        path: "/equipmentRentalPage",
        component: equipmentRentalPage,
        meta: { title: "器材租借", requiresAuth: true },
      },
      {
        path: "/rentalListPage",
        component: rentalListPage,
        meta: { title: "租借记录", requiresAuth: true },
      },
      
    ],
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});


// 全局前置守卫
router.beforeEach((to, from, next) => {
  // 核心逻辑：检查目标路由是否存在
  // to.matched 是一个包含匹配的路由记录的数组。如果数组为空，说明没有找到任何匹配的路由。
  if (to.matched.length == 0) {
    // 1. 提示用户

    MessageBox.warning("您访问的页面不存在，2秒后将自动跳转到首页");

    // 2. 设置延时跳转
    setTimeout(() => {
      next({ path: "/index" }); // 2秒后跳转到首页
    }, 2000);
  } else {
    // 如果路由存在，则执行原来的登录验证逻辑
    const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);
    const token = localStorage.getItem("areSignedIn");
    const isAuthenticated = !!token;

    if (requiresAuth && !isAuthenticated) {
      next({ path: "/Login" });
    } else {
      next();
    }
  }
});

// 全局后置守卫
router.afterEach((to) => {
  if (to.meta && to.meta.title) {
    document.title = to.meta.title;
  }
});

export default router;
