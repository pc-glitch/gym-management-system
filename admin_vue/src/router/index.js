import { createRouter, createWebHistory } from "vue-router";
import { options as roleOptions } from "@/utils/Role";
import { getToken } from "@/utils/auth";

// =============================================================================
// 静态路由组件定义
// 这些是系统的核心、无需权限即可访问的基础页面组件。
// =============================================================================
const Index = () => import("../view/index/index.vue"); // 主页框架
const Login = () => import("../view/login/index.vue"); // 登录页
const register = () => import("../view/register/index.vue"); // 注册页
const NotFound = () => import("../view/NotFound/index.vue"); // 404 页面

// =============================================================================
// 动态路由组件映射
// 这个对象用于将路由配置中的 `name` 属性映射到实际的 Vue 组件。
// 当动态添加路由时，会根据这里的映射关系来加载对应的组件。
// 键（key）必须与 `Role.js` 中定义的路由 `name` 完全一致。
// =============================================================================
const componentMap = {
  swiperManage: () => import("../view/swiperManage/index.vue"), // 轮播图管理
  personalCenter: () => import("../view/personalCenter/index.vue"), // 个人中心
  ChangePassword: () => import("../view/ChangePassword/index.vue"), // 修改密码
  userList: () => import("../view/userList/index.vue"), // 用户管理
  announcementList: () => import("../view/announcementList/index.vue"), // 公告管理
  abouts: () => import("../view/abouts/index.vue"), // 关于我们
    chatFilesPictures: () => import("../view/chatFilesPictures/index.vue"), // 多人对话,
  comment: () => import("../view/comment/index.vue"), // 评论管理,
  issuePost: () => import("../view/issuePost/view/issuePost/index.vue"), // 发布帖子,
  postsList: () => import("../view/postsList/view/postsList/index.vue"), // 帖子管理,
  categoriesList: () => import("../view/categoriesList/view/categoriesList/index.vue"), // 话题管理,
  ordersList: () => import("../view/ordersList/index.vue"), // 订单列表,
  visualization: () => import("../view/visualization/index.vue"), // 数据可视化,
  eventregistration: () => import("../view/Page/eventregistration/index.vue"), // 赛事报名,
  eventinformation: () => import("../view/Page/eventinformation/index.vue"), // 赛事信息,
  activityregistration: () => import("../view/Page/activityregistration/index.vue"), // 活动报名,
  activityinformation: () => import("../view/Page/activityinformation/index.vue"), // 活动信息,
  activitytype: () => import("../view/Page/activitytype/index.vue"), // 活动类型,
  commodityinformation: () => import("../view/Page/commodityinformation/index.vue"), // 商品信息,
  commodityclassification: () => import("../view/Page/commodityclassification/index.vue"), // 商品分类,
  venuereservation: () => import("../view/Page/venuereservation/index.vue"), // 场地预约,
  venueinformation: () => import("../view/Page/venueinformation/index.vue"), // 场地信息,
  siteclassification: () => import("../view/Page/siteclassification/index.vue"), // 场地分类,
  equipment: () => import("../view/Page/equipment/index.vue"), // 器材管理
  equipmentRental: () => import("../view/Page/equipmentRental/index.vue") // 器材租借
};

// =============================================================================
// 静态路由配置
// 这个数组定义了应用的基础路由，这些路由在应用初始化时就会被加载。
// 注意：404 (NotFound) 路由已被移除，将在路由守卫中动态添加。
// =============================================================================
const routes = [
  {
    path: "/",
    redirect: "/personalCenter",
  },
  {
    path: "/index",
    name: "Index",
    component: Index,
    meta: { title: "首页", requiresAuth: true },
    children: [], // 注意：此处的 children 为空，因为权限路由将在此路由下动态添加
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
    meta: { title: "登录" },
  },
  {
    path: "/register",
    name: "Register",
    component: register,
    meta: { title: "注册" },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

// =============================================================================
// 路由守卫与动态路由添加
// =============================================================================

// 标志位，用于跟踪动态路由是否已经添加，防止重复添加
let hasAddRoutes = false;

/**
 * 全局前置守卫 (router.beforeEach)
 *
 * 这个函数会在每次路由跳转之前被调用。
 * 它的核心职责是进行权限控制，并根据用户角色动态地添加路由。
 */
router.beforeEach(async (to, from, next) => {
  // 1. 检查用户是否已登录（通过 localStorage 中是否存在 token）
  const isAuthenticated = getToken();

  // 2. 如果用户已登录
  if (isAuthenticated) {
    // 如果已登录用户试图访问登录页，则重定向到首页
    if (to.path === "/login") {
      next({ path: "/index" });
    } else {
      // 如果动态路由尚未添加
      if (!hasAddRoutes) {
        try {
          // a. 从 localStorage 获取用户数据并解析出角色
          const userData = JSON.parse(localStorage.getItem("userData"));
          const userRole = userData ? userData.role : null;

          // b. 根据角色在 `Role.js` 的 `roleOptions` 中查找对应的路由配置
          const roleInfo = roleOptions.find(
            (option) => option.role === userRole
          );

          // c. 如果找到了角色信息并且该角色有对应的路由
          if (roleInfo && roleInfo.routes) {
            // 遍历该角色的所有路由
            roleInfo.routes.forEach((route) => {
              const component = componentMap[route.name];
              if (component) {
                const routeConfig = {
                  ...route,
                  component: component,
                };
                // 如果 checkFlag 为 false，则将其添加为一级路由
                if (route.meta?.checkFlag === false) {
                  router.addRoute(routeConfig);
                } else {
                  // 否则，将其作为 'Index' 的子路由添加
                  router.addRoute("Index", routeConfig);
                }
              } else {
                console.warn(
                  `[路由守卫] 警告: 未在 componentMap 中找到路由 '\${route.name}' 对应的组件`
                );
              }
            });

            // d. 在所有动态路由添加完毕后，最后添加 404 路由
            //    这可以防止刷新页面时，因动态路由尚未加载而错误地显示 404 页面
            router.addRoute({
              path: "/:pathMatch(.*)*",
              name: "NotFound",
              component: NotFound,
              meta: { title: "404" },
            });

            // e. 设置标志位为 true，表示路由已添加
            hasAddRoutes = true;

            // f. 使用 `next({ ...to, replace: true })` 重新进入导航流程
            //    这可以确保新添加的路由能够被正确匹配到，避免刷新时出现 404
            next({ ...to, replace: true });
          } else {
            // 如果没有找到角色信息或路由，则重定向到登录页以避免无限循环或权限问题
            console.warn(
              `[路由守卫] 未找到用户角色信息或路由配置 (角色: ${userRole})，将重定向到登录页`
            );
            localStorage.clear(); // 清除可能无效的本地存储
            hasAddRoutes = false; // 重置状态
            next({ path: "/login", replace: true });
          }
        } catch (error) {
          console.error("[路由守卫] 动态添加路由失败", error);
          localStorage.clear(); // 清除可能无效的本地存储
          hasAddRoutes = false; // 重置状态，以便下次可以重试
          next({ path: "/login", replace: true }); // 出现错误时重定向到登录页
        }
      } else {
        // 如果路由已经添加，处理后续导航
        // 场景：刚登录后从 /login 跳转到 /index，或刷新页面时
        if (to.path === "/index" || to.path === "/") {
          // 检查 sessionStorage 中是否有上次访问的记录（用于处理刷新）
          const lastRoutePath = sessionStorage.getItem("lastRoutePath");
          if (lastRoutePath && from.path === "/") {
            // from.path === '/' 是一个刷新页面的典型特征
            const resolvedRoute = router.resolve(lastRoutePath);
            if (
              resolvedRoute.name !== "NotFound" &&
              resolvedRoute.path !== "/index"
            ) {
              return next({ path: lastRoutePath, replace: true });
            }
          }

          // 如果没有有效的 lastRoutePath（例如刚登录时），则重定向到角色有权限的第一个路由
          const userData = JSON.parse(localStorage.getItem("userData"));
          const userRole = userData ? userData.role : null;
          const roleInfo = roleOptions.find(
            (option) => option.role === userRole
          );
          if (roleInfo && roleInfo.routes && roleInfo.routes.length > 0) {
            // 修正了之前的错误：使用 roleInfo.routes.path 而不是 roleInfo.routes.path
            return next({ path: roleInfo.routes[0].path, replace: true });
          }
        }

        // 对于所有其他情况，正常导航
        next();
      }
    }
  } else {
    // 3. 如果用户未登录
    console.log("[路由守卫] 用户未登录");
    // 如果目标路径不是登录页或注册页，则重定向到登录页
    if (to.path !== "/login" && to.path !== "/register") {
      console.log(`[路由守卫] 访问受限页面 ${to.path}，重定向到 /login`);
      next({ path: "/login" });
    } else {
      // 如果是登录页或注册页，则正常放行
      console.log(`[路由守卫] 访问公共页面 ${to.path}，正常放行`);
      next();
    }
  }
});

// 全局后置守卫
router.afterEach((to) => {
  if (to.meta && to.meta.title) {
    document.title = to.meta.title;
  }
  // 如果路由需要认证，则在每次导航成功后存储其路径
  // 这样可以确保用户刷新后能返回到最后一个访问的受保护页面
  if (to.meta.requiresAuth) {
    sessionStorage.setItem("lastRoutePath", to.fullPath);
  }
});

export default router;
