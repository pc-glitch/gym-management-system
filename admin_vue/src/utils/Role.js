// 角色数组，分别对应 角色名 角色role 角色表名

export const options = [
  {
    "label": "管理员",
    "role": "0",
    "table": "admin",
    "routes": [
      {
    "path": "/personalCenter",
    "name": "personalCenter",
    "meta": {
      "title": "个人中心",
      "checkFlag": true,
      "parentTitle": "个人中心"
    }
  },
  {
    "path": "/changePassword",
    "name": "ChangePassword",
    "meta": {
      "title": "密码修改",
      "checkFlag": true,
      "parentTitle": "个人中心"
    }
  },
  {
    "path": "/abouts",
    "name": "abouts",
    "meta": {
      "title": "关于我们",
      "checkFlag": true,
      "parentTitle": "系统管理"
    }
  },
  {
    "path": "/swiperManage",
    "name": "swiperManage",
    "meta": {
      "title": "轮播图管理",
      "checkFlag": true,
      "parentTitle": "系统管理"
    }
  },
  {
    "path": "/userList",
    "name": "userList",
    "meta": {
      "title": "用户管理",
      "checkFlag": true,
      "parentTitle": "用户管理"
    }
  },
  {
    "path": "/announcementList",
    "name": "announcementList",
    "meta": {
      "title": "公告管理",
      "checkFlag": true,
      "parentTitle": "系统管理"
    }
  },
  {
    "path": "/chatFilesPictures",
    "name": "chatFilesPictures",
    "meta": {
      "title": "多人对话",
      "checkFlag": true,
      "parentTitle": "系统管理"
    }
  },
  {
    "path": "/comment",
    "name": "comment",
    "meta": {
      "title": "评论管理",
      "checkFlag": true,
      "parentTitle": "系统管理"
    }
  },
  {
    "path": "/issuePost",
    "name": "issuePost",
    "meta": {
      "title": "发布帖子",
      "checkFlag": true,
      "parentTitle": "论坛管理"
    }
  },
  {
    "path": "/postsList",
    "name": "postsList",
    "meta": {
      "title": "帖子管理",
      "checkFlag": true,
      "parentTitle": "论坛管理"
    }
  },
  {
    "path": "/categoriesList",
    "name": "categoriesList",
    "meta": {
      "title": "帖子话题",
      "checkFlag": true,
      "parentTitle": "论坛管理"
    }
  },
  {
    "path": "/ordersList",
    "name": "ordersList",
    "meta": {
      "title": "订单列表",
      "checkFlag": true,
      "parentTitle": "订单管理"
    }
  },
  {
    "path": "/visualization",
    "name": "visualization",
    "meta": {
      "title": "数据可视化",
      "checkFlag": true,
      "parentTitle": "数据中心"
    }
  },
  {
    "path": "/eventregistration",
    "name": "eventregistration",
    "meta": {
      "title": "赛事报名",
      "checkFlag": true,
      "parentTitle": "赛事活动"
    }
  },
  {
    "path": "/activityregistration",
    "name": "activityregistration",
    "meta": {
      "title": "活动报名",
      "checkFlag": true,
      "parentTitle": "赛事活动"
    }
  },
  {
    "path": "/eventinformation",
    "name": "eventinformation",
    "meta": {
      "title": "赛事信息",
      "checkFlag": true,
      "parentTitle": "赛事活动"
    }
  },
  {
    "path": "/activityinformation",
    "name": "activityinformation",
    "meta": {
      "title": "活动信息",
      "checkFlag": true,
      "parentTitle": "赛事活动"
    }
  },
  {
    "path": "/activitytype",
    "name": "activitytype",
    "meta": {
      "title": "活动类型",
      "checkFlag": true,
      "parentTitle": "赛事活动"
    }
  },
  {
    "path": "/commodityinformation",
    "name": "commodityinformation",
    "meta": {
      "title": "商品信息",
      "checkFlag": true,
      "parentTitle": "商品管理"
    }
  },
  {
    "path": "/commodityclassification",
    "name": "commodityclassification",
    "meta": {
      "title": "商品分类",
      "checkFlag": true,
      "parentTitle": "商品管理"
    }
  },
  {
    "path": "/venuereservation",
    "name": "venuereservation",
    "meta": {
      "title": "场地预约",
      "checkFlag": true,
      "parentTitle": "场地管理"
    }
  },
  {
    "path": "/venueinformation",
    "name": "venueinformation",
    "meta": {
      "title": "场地信息",
      "checkFlag": true,
      "parentTitle": "场地管理"
    }
  },
  {
    "path": "/siteclassification",
    "name": "siteclassification",
    "meta": {
      "title": "场地分类",
      "checkFlag": true,
      "parentTitle": "场地管理"
    }
  },
  {
    "path": "/equipment",
    "name": "equipment",
    "meta": {
      "title": "器材管理",
      "checkFlag": true,
      "parentTitle": "器材管理"
    }
  },
  {
    "path": "/equipmentRental",
    "name": "equipmentRental",
    "meta": {
      "title": "器材租借",
      "checkFlag": true,
      "parentTitle": "器材管理"
    }
  }
    ]
  }
];
