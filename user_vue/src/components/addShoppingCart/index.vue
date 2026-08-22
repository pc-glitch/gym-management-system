<template>
  <div class="add-to-cart-container">
    <button @click="handleAddToCart" class="add-cart-btn">加入购物车</button>
  </div>
</template>

<script setup>
import { watch, ref, onMounted } from "vue";
import requestApi from "../../utils/axios";
import Message from "@/components/MessageBox/index.js";
import { GetUserId } from "@/utils/auth.js";

// 使用onMounted
onMounted(() => {
  processingProductData();
});

// 处理商品数据

// 购物车数据
let shoppingCartData = ref({});
const processingProductData = async () => {
  console.log(props.productInfo);

  let { id, title, name, photo, picture, price, adduserid, userid, classify } =
    props.productInfo;

  let loginUserId = await GetUserId();

  let obj = {
    // 用户id
    userid: loginUserId,
    // 商品id
    goodid: id,
    // 商品名称
    goodname: title || name,
    // 图片
    picture: photo || picture,
    // 购买数量
    buynumber: "",
    // 单价
    price: price,
    // 会员价
    discountprice: "",
    // 商户名称
    shangjiazhanghao: adduserid || userid,
    // 商品分类
    fenlei: classify || "",
  };
  shoppingCartData.value = obj;
};

// 通过props定义从父组件接收的商品数据
const props = defineProps({
  // 父组件传递商品信息
  productInfo: {
    type: Object,
    required: true,
    default: () => ({
      id: null, // 商品id
      name: "", // 商品名称
      picture: "", // 商品图片
      price: 0.0, // 商品价格
      shangjiazhanghao: "", //商家账号
      fenlei: "", // 商品分类
    }),
  },
});

// 监听productInfo数据变化
watch(
  () => props.productInfo,
  (newValue) => {
    console.log("productInfo changed:", newValue);
  }
);

/**
 * 处理添加购物车点击事件
 */
const handleAddToCart = async () => {
  // 1. 提示用户输入购买数量
  const buynumberStr = prompt("请输入购买数量:", "1");

  // 如果用户点击了“取消”，则buynumberStr为null，直接返回
  if (buynumberStr === null) {
    return;
  }

  //  输入校验
  const buynumber = parseInt(buynumberStr, 10);
  if (isNaN(buynumber) || buynumber <= 0) {
    Message.warning("请输入一个有效的正整数作为购买数量！");
    return;
  }

  shoppingCartData.value.buynumber = buynumber;

  try {
    const response = await requestApi.post(
      "/api/cart/save",
      shoppingCartData.value
    );
    if (response && response.code == 0) {
      Message.success("成功添加到购物车！");
    } else {
      Message.error("添加失败：" + (response.msg || "未知错误"));
    }
  } catch (error) {
    console.error("添加到购物车时发生错误:", error);
    Message.error("请求失败，请检查网络或联系管理员。");
  }
};
</script>

<style scoped>
.add-cart-btn {
  padding: 8px 16px;
  font-size: 14px;
  color: #fff;
  background-color: #ff4d4f;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.add-cart-btn:hover {
  background-color: #d9363e;
}
</style>
