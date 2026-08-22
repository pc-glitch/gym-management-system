<template>
  <div class="editor-wrapper">
    <div ref="toolbarContainerRef" class="toolbar-container"></div>
    <div ref="editorContainerRef" class="editor-container"></div>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, watch } from "vue";
import { createEditor, createToolbar, DomEditor } from "@wangeditor/editor";
// 引入 wangEditor 的 CSS 样式
import "@wangeditor/editor/dist/css/style.css";

// 定义组件的 props 和 emits
const props = defineProps({
  modelValue: {
    type: String,
    default: "",
  },
  placeholder: {
    type: String,
    default: "请输入内容...",
  },
  mode: {
    type: String,
    default: "default", // 'default' 或 'simple'
  },
});

const emit = defineEmits(["update:modelValue"]);

// 用于获取 DOM 元素的引用
const toolbarContainerRef = ref(null);
const editorContainerRef = ref(null);

// 编辑器实例和工具栏实例
let editor = null;
let toolbar = null;

// 组件挂载后初始化编辑器
onMounted(() => {
  const editorConfig = {
    placeholder: props.placeholder,
    // 编辑器内容变化时的回调函数
    onChange(editor) {
      // 获取 HTML 内容并触发 update:modelValue 事件，实现 v-model 双向绑定
      const html = editor.getHtml();
      emit("update:modelValue", html);
    },
    MENU_CONF: {
      // 图片上传配置，这里仅为示例
      uploadImage: {
        server: "/api/file/upload",
        fieldName: "file",
        maxFileSize: 2 * 1024 * 1024, // 2MB
        maxNumberOfFiles: 10,
        customInsert(res, insertFn) {
          if (res.code == "0") {
            // 从返回结果中获取图片地址
            const url = res.data.url;
            // 调用 insertFn 插入图片
            insertFn(url, res.data.name, url);
          } else {
            // 如果上传失败，给出提示
            alert(res.msg || "图片上传失败");
          }
        },
      },
    },
  };

  // 工具栏配置
  const toolbarConfig = {
    toolbarKeys: [
      "headerSelect",
      "bold",
      "italic",
      "underline",
      "color",
      "bgColor",
      "|",
      "bulletedList",
      "numberedList",
      "todo",
      "justifyLeft",
      "justifyRight",
      "justifyCenter",
      "justifyJustify",
      "indent",
      "blockquote",
      "insertLink",
      "insertTable",
      "insertImage",
      "undo",
      "redo",
      "fullScreen",
    ],
  };

  // 创建编辑器实例
  editor = createEditor({
    selector: editorContainerRef.value,
    html: props.modelValue, // 使用 props.modelValue 初始化内容
    config: editorConfig,
    mode: props.mode,
  });

  // 创建工具栏实例
  toolbar = createToolbar({
    editor,
    selector: toolbarContainerRef.value,
    config: toolbarConfig,
    mode: props.mode,
  });

  // 调试信息：打印所有可用菜单键
  console.log("wangEditor 所有可用菜单键:", editor.getAllMenuKeys());
});

// 监听 modelValue 的变化，当父组件更新 modelValue 时，同步更新编辑器内容
watch(
  () => props.modelValue,
  (newVal) => {
    if (editor && editor.getHtml() != newVal) {
      editor.setHtml(newVal);
    }
  }
);

// 组件卸载前销毁编辑器和工具栏实例，防止内存泄漏
onBeforeUnmount(() => {
  if (editor) {
    editor.destroy();
    editor = null;
  }
  if (toolbar) {
    toolbar.destroy();
    toolbar = null;
  }
});
</script>

<style scoped>
/* wangEditor 容器样式 */
.editor-wrapper {
  border: 1px solid #ccc;
  z-index: 100; /* 确保编辑器在页面上层 */
  border-radius: 8px;
  overflow: hidden; /* 确保圆角显示正常 */
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}
.toolbar-container {
  border-bottom: 1px solid #ccc;
  background-color: #f1f5f9; /* 工具栏背景色 */
}
.editor-container {
  height: 500px; /* 编辑器高度 */
  background-color: #fff;
  padding: 0.5rem 1rem;
}
</style>
