<template>
  <div class="like-general">
    <button
      class="icon-btn"
      :class="{ active: isActive }"
      @click="toggleAction"
      :title="currentItem.title"
    >
      <div class="icon" v-html="currentItem.svg"></div>
      <span class="text">{{ currentItem.title }}</span>
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, computed } from "vue";
// 接口请求
import requestApi from "@/utils/axios";
import Message from "@/components/MessageBox/index.js";
// 引入获取用户信息与获取id
import { GetUserId, getUserData } from "@/utils/auth";

const props = defineProps({
  // 组件类型
  type: {
    type: String,
    required: true,
    default: "5",
  },
  // 上级id
  refid: {
    type: String,
    required: true,
    default: "10086",
  },
  // 表名
  tablename: {
    type: String,
    required: true,
    default: null,
  },
  // 上级数据对象
  parentData: {
    type: Object,
    required: true,
    default: {},
  },
  // 图标大小
  size: {
    type: [Number, String],
    default: 20,
  },
});

const userid = GetUserId();

// 定义操作项映射
const actionItemsMap = {
  "-1": {
    title: "点踩",
    svg: `<svg t="1754894841947" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6880" width="200" height="200"><path d="M862.573714 566.491429h-55.881143c-109.348571 0-167.497143 86.162286-167.497142 176.932571V841.142857c0 4.681143 0 11.702857-2.413715 16.310857a94.72 94.72 0 0 1-109.348571 76.8l-13.897143-2.340571a136.850286 136.850286 0 0 1-104.813714-79.140572 214.454857 214.454857 0 0 1-18.578286-125.659428l9.289143-72.118857v-2.340572c0-7.021714-4.681143-11.702857-11.702857-11.702857h-244.297143c-44.251429-6.948571-74.459429-46.518857-69.851429-93.037714L155.062857 142.994286C159.744 103.424 194.633143 73.142857 236.544 73.142857h607.378286c37.302857 0 67.510857 30.281143 69.851428 67.510857l18.578286 353.718857a67.291429 67.291429 0 0 1-67.437714 72.118858h-2.340572z m-160.621714-423.497143H236.544c-4.681143 0-11.702857 4.608-11.702857 9.289143L143.506286 554.861714c0 7.021714 4.681143 11.702857 9.289143 13.970286h235.081142c44.178286 0 81.481143 37.302857 81.481143 81.481143v11.629714l-9.362285 72.118857c-4.608 30.281143 0 60.562286 13.970285 86.162286 9.289143 23.259429 30.281143 37.229714 53.540572 41.837714l13.897143 2.340572a24.137143 24.137143 0 0 0 28.013714-18.578286v-100.132571c0-100.059429 53.540571-200.118857 158.208-235.008l-25.6-367.689143z m114.102857 356.059428h23.259429c13.897143 0 23.259429-11.702857 23.259428-23.259428l-9.289143-309.540572c0-11.702857-11.702857-23.259429-23.332571-23.259428h-34.889143c-13.897143 0-23.259429 9.289143-23.259428 23.259428v2.340572l20.918857 307.2c2.340571 11.629714 11.702857 23.259429 23.259428 23.259428z" p-id="6881"></path></svg>`,
  },
  2: {
    title: "关注",
    svg: `<svg t="1754895680875" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="7888" width="200" height="200"><path d="M697.21791 135.568628c-90.775446 0-155.800415 81.796958-183.823656 125.059274-28.053939-43.262316-93.049233-125.059274-183.822632-125.059274-130.257669 0-236.19442 117.381407-236.19442 261.648139 0 67.460438 45.757137 164.17106 101.302197 214.784808 76.835969 98.719372 292.845675 276.43082 319.512011 276.43082 27.13808 0 238.512209-174.257789 316.736804-275.247878 56.519248-51.500954 102.498442-148.344606 102.498442-215.96775C933.426657 252.949013 827.47251 135.568628 697.21791 135.568628" p-id="7889"></path></svg>`,
  },
  3: {
    title: "收藏",
    svg: `<svg t="1754895727936" class="icon" viewBox="0 0 1426 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="8889" width="200" height="200"><path d="M985.6 1022.976c-14.848 0-31.744-4.096-47.104-12.288L716.288 899.584l-223.744 111.104c-14.336 7.68-30.208 11.776-47.104 11.776-21.504 0-42.496-6.656-59.392-19.456-31.232-23.552-47.104-64-39.936-101.376l45.568-237.056-175.616-163.328c-27.136-27.648-37.376-67.072-27.136-104.448l0.512-1.024c12.8-38.4 44.544-65.024 82.944-70.144l243.712-44.544L625.152 58.88C642.56 23.552 678.4 1.024 716.288 1.024c39.424 0 76.288 23.552 91.648 58.368l109.056 221.696 243.712 42.496c38.4 5.632 70.656 33.28 81.408 71.168 12.288 36.864 2.048 77.312-25.6 104.96l-0.512 0.512-174.592 164.864 44.032 237.568c7.168 37.888-8.192 76.288-39.424 100.352-17.92 12.8-38.912 19.968-60.416 19.968z"  p-id="8890"></path></svg>`,
  },
  4: {
    title: "点赞",
    svg: `<svg t="1754895781246" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="9919" width="200" height="200"><path d="M806.868 406h-154.16c-0.479 2-0.757 2-0.757 2h166.673c-3.702-1-7.647-2-11.756-2z"  p-id="9920"></path><path d="M622.48 405.937c8.383-21.278 104.826-220.109-30.992-302.775 0 0-86.128-29.741-94.63 57.167C490.01 230.336 492 339.554 372 383.342v541.792l430.925-1.529c20.869 0 37.868-16.917 37.868-37.786l34.049-442.096c0-4.212-0.698-8.249-1.969-12.032-3.789-11.272-12.719-20.161-24.029-23.864" p-id="9921"></path><path d="M342 850.428C342 892.165 308.165 926 266.428 926h-41.856C182.835 926 149 892.165 149 850.428V438.572C149 396.835 182.835 363 224.572 363h41.856C308.165 363 342 396.835 342 438.572v411.856z"  p-id="9922"></path></svg>`,
  },
  5: {
    title: "喜欢",
    svg: `<svg t="1754895884866" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="10940" width="200" height="200"><path d="M736.048379 127.978498c-65.881404 0-128.494541 24.942046-176.314463 70.525785-4.644381 4.300353-28.726356 28.726356-47.30388 47.647909l-47.30388-47.131866c-47.819923-45.755753-110.605073-71.041828-177.00252-71.041828-141.223585 0-255.956996 114.905426-255.956996 255.956996 0 82.394759 41.111372 144.319839 76.546279 182.506971l316.849992 320.11826c25.11406 25.11406 52.980346 41.455401 86.695112 41.455401 33.714766 0 61.581052-16.341341 86.695112-41.455401l316.677977-319.946246 2.236183-2.408198c38.187133-47.647909 74.310096-92.715606 74.310096-180.098774C992.005375 242.883924 877.09995 127.978498 736.048379 127.978498z" p-id="10941"></path></svg>`,
  },
};

const currentItem = computed(() => {
  const item = actionItemsMap[props.type] || {
    title: "未知",
    svg: "",
  };
  // 动态替换svg中的width和height属性
  if (item.svg) {
    // 替换width和height属性，支持数字或字符串
    const sizeStr =
      typeof props.size === "number" ? `${props.size}` : props.size;
    const svgStr = item.svg
      .replace(/width="[^"]*"/g, `width="${sizeStr}"`)
      .replace(/height="[^"]*"/g, `height="${sizeStr}"`);
    return {
      title: item.title,
      svg: svgStr,
    };
  }
  return item;
});

const isActive = ref(false);

// let 已有数据
let existingData = ref({});
const loadStatus = async () => {
  if (!userid) return;
  try {
    const res = await requestApi.post("/api/storeup/list", {
      userid,
      refid: processingData().refid,
      type: props.type,
    });
    if (res.code == 0 && Array.isArray(res.data)) {
      // 如果返回数据中有对应type，表示已激活
      isActive.value = res.data.some((item) => item.type === props.type);
      // 如果有数据则存储
      if (isActive.value) existingData.value = res.data[0];
    } else {
      isActive.value = false;
    }
  } catch (error) {
    console.error("加载状态失败", error);
    isActive.value = false;
  }
};

const toggleAction = async () => {
  if (!userid) {
    Message.warning("请先登录");
    return;
  }

  if (isActive.value) {
    // 取消操作
    try {
      let obj = [existingData.value.id];
      const res = await requestApi.post("/api/storeup/delete", obj);
      if (res.code == 0) {
        isActive.value = !isActive.value;
      } else {
        Message.error(res.msg || "操作失败");
      }
    } catch (error) {
      console.error("操作失败", error);
      Message.error("操作失败");
    }
  } else {
    try {
      // 新增操作
      const params = await processingData();
      const res = await requestApi.post("/api/storeup/save", params);
      if (res.code == 0) {
        isActive.value = !isActive.value;
      } else {
        Message.error(res.msg || "操作失败");
      }
    } catch (error) {}
  }
};
// let 上级数据
let parentData = ref({});
// const 处理数据
const processingData = async () => {
  // 深拷贝数据
  parentData.value = JSON.parse(JSON.stringify(props));

  let obj = {
    // 用户id
    userid,
    // 上级id  依靠传入数据 没有就写死一个防止报错
    refid:
      parentData.value.id ||
      parentData.value.adduserid ||
      parentData.value.userid ||
      "10086",
    // 父级传入
    tablename: props.tablename,
    // 类型标题，依靠传入数据
    name: parentData.value.name || parentData.value.title,
    // 图片，依靠传入数据
    picture:
      parentData.value.img ||
      parentData.value.picture ||
      parentData.value.photo,
    // 类型 依靠父级传入
    type: Number(props.type),
    // 备注
    remark: "",
  };

  return obj;
};

onMounted(() => {
  loadStatus();
});

watch(
  () => [props.type, props.refid],
  () => {
    loadStatus();
  }
);
</script>

<style scoped>
.like-general {
  display: flex;
  gap: 16px;
}
.icon-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--secondary-color, #6c757d);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 14px;
  transition: color 0.25s ease;
}
.icon-btn .icon {
  fill: var(--secondary-color, #6c757d);
  transition: fill 0.25s ease;
  width: 20px;
  height: 20px;
}
.icon-btn:hover {
  color: var(--primary-color, #1e90ff);
}
.icon-btn:hover .icon {
  fill: var(--primary-color, #1e90ff);
}
.icon-btn.active {
  color: var(--primary-color, #1e90ff);
}
.icon-btn.active .icon {
  fill: var(--primary-color, #1e90ff);
}
</style>
