<template>
  <el-cascader
    v-model="selectedLocation"
    :options="cascaderOptions"
    :props="cascaderProps"
    :placeholder="placeholder"
    filterable
    clearable
    @change="handleChange"
    style="width: 100%"
  />
</template>

<script setup>
import { ref, computed, onMounted, watch } from "vue";
import { ElCascader } from "element-plus";

// 导入原始的省市区数据字符串
import cityData from "./pca.js";

const props = defineProps({
  modelValue: {
    type: String, // 更改为 String 类型
    default: "",
  },
  placeholder: {
    type: String,
    default: "请选择省/市/区",
  },
});

const emit = defineEmits(["update:modelValue", "change"]);

// 内部状态，用于 ElCascader 的 v-model
// 如果 modelValue 是字符串，则尝试分割为数组，否则初始化为空数组
const selectedLocation = ref(
  props.modelValue ? props.modelValue.split("-") : []
);

// 监听 props.modelValue 变化，同步内部状态
watch(
  () => props.modelValue,
  (newValue) => {
    selectedLocation.value = newValue ? newValue.split("-") : [];
  }
);

// Element Plus Cascader 的配置
const cascaderProps = {
  expandTrigger: "hover", // 鼠标悬停时展开子菜单
  value: "value", // 选项值的字段名
  label: "label", // 选项标签的字段名
  children: "children", // 子选项的字段名
};

// 存储解析后的原始位置数据对象
const rawLocationData = ref({});

// 转换数据格式以适应 ElCascader
const cascaderOptions = computed(() => {
  const options = [];
  const data = rawLocationData.value; // 使用解析后的数据
  for (const provinceName in data) {
    const province = {
      value: provinceName,
      label: provinceName,
      children: [],
    };
    const cities = data[provinceName]; // 使用解析后的数据
    for (const cityName in cities) {
      const city = {
        value: cityName,
        label: cityName,
        children: [],
      };
      const districts = cities[cityName];
      districts.forEach((districtName) => {
        city.children.push({
          value: districtName,
          label: districtName,
        });
      });
      province.children.push(city);
    }
    options.push(province);
  }
  return options;
});

// 处理选择器值改变事件
const handleChange = (value) => {
  // 将选中的数组值通过 '-' 连接成字符串
  const joinedValue = value.join("-");
  console.log("选中的位置（字符串）：", joinedValue);
  emit("update:modelValue", joinedValue); // 更新 v-model 绑定的值
  emit("change", joinedValue); // 触发 change 事件
};

// 组件挂载时解析导入的字符串数据
onMounted(() => {
  try {
    rawLocationData.value = cityData;
    console.log("LocationCascader 组件已挂载，数据已加载。");
  } catch (e) {
    console.error("解析 pca.js 数据失败:", e);
    // 可以在这里设置一个默认空数据或显示错误消息
    rawLocationData.value = {};
  }
});
</script>

<style scoped>
/* 可以根据需要添加自定义样式 */
</style>
