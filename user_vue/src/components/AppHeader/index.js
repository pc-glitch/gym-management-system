const navigation = [
  { name: "首页", path: "/" },
  { name: "公告列表", path: "/announcement" },
  { 
    name: "信息浏览", 
    path: null, 
    children: [
      { name: "赛事信息列表", path: "/eventinformationListPage" },
      { name: "活动信息列表", path: "/activityinformationListPage" },
      { name: "商品信息列表", path: "/commodityinformationListPage" },
      { name: "场地信息列表", path: "/venueinformationListPage" },
      { name: "器材列表", path: "/equipmentListPage" }
    ]
  },
  { 
    name: "报名预约", 
    path: null, 
    children: [
      { name: "赛事报名", path: "/eventregistrationCreatePage" },
      { name: "活动报名", path: "/activityregistrationCreatePage" },
      { name: "场地预约", path: "/venuereservationCreatePage" }
    ]
  }
];


const personalCenter = [
  { 
    name: "个人服务", 
    path: null, 
    children: [
      { name: "个人资料", path: "/personal" },
      { name: "修改密码", path: "/ChangePassword" },
      { name: "在线客服", path: "/chatFilesPictures" },
      { name: "我的收藏", path: "/myCollection" },
      { name: "我的订单", path: "/myOrder" },
      { name: "在线充值", path: "/myBalance" },
      { name: "地址管理", path: "/addressList" },
      { name: "我的租借", path: "/rentalListPage" }
    ]
  },
  { 
    name: "社区互动", 
    path: null, 
    children: [
      { name: "社区论坛", path: "/community" },
      { name: "发布帖子", path: "/issuePost" },
      { name: "我的帖子", path: "/myPost" }
    ]
  }
];

export { personalCenter, navigation };