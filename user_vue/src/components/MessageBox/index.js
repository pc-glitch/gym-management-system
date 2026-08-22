import { createVNode, render } from "vue";
import MessageBox from "./index.vue";

const instances = [];
let seed = 1;

const Message = (options) => {
  if (typeof options === "string") {
    options = {
      message: options,
    };
  }

  const id = `message_${seed++}`;
  const container = document.createElement("div");
  document.body.appendChild(container);

  let verticalOffset = 20;
  instances.forEach((instance) => {
    verticalOffset += instance.vm.component.vnode.el.offsetHeight + 16;
  });

  const userOnClose = options.onClose;
  const props = {
    ...options,
    id,
    top: verticalOffset,
    onClose: () => {
      close(id, userOnClose);
    },
  };

  const vm = createVNode(MessageBox, props);
  render(vm, container);

  // 将实例和容器存储起来
  instances.push({ vm, container });

  // 暴露 hide 方法
  return {
    hide: () => {
      vm.component.exposed.hide();
    },
  };
};

function close(id, userOnClose) {
  const index = instances.findIndex(({ vm }) => vm.props.id === id);
  if (index === -1) return;

  const { vm, container } = instances[index];
  if (!vm || !container) return;

  const removedHeight = vm.component.vnode.el.offsetHeight;

  userOnClose?.();

  // 从DOM中移除
  render(null, container);
  document.body.removeChild(container);

  // 从实例数组中移除
  instances.splice(index, 1);

  // 重新计算剩余实例的位置
  for (let i = index; i < instances.length; i++) {
    const instance = instances[i];
    const pos =
      parseInt(instance.vm.component.vnode.el.style.top, 10) -
      removedHeight -
      16;
    instance.vm.component.exposed.top.value = pos;
  }
}

// 添加快捷调用方法
["success", "warning", "info", "error"].forEach((type) => {
  Message[type] = (message) => {
    return Message({
      type,
      message,
    });
  };
});
export default Message;
