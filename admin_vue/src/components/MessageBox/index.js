import { createVNode, render, nextTick } from "vue";
import MessageBox from "./index.vue";
import ConfirmDialog from "./ConfirmDialog.vue";

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
    const el = instance.vm.el;
    if (el) {
      verticalOffset += el.offsetHeight + 16;
    }
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

  // Manually add el to vm for height calculation
  vm.el = container.firstElementChild;

  instances.push({ vm, container });

  // 兜底：若首次渲染时 el 为空（因过渡 v-if），在下一帧补充绑定，避免读取 offsetHeight 报错
  nextTick(() => {
    if (!vm.el) {
      vm.el = container.firstElementChild;
    }
  });

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

  const removedHeight = vm.el?.offsetHeight || 0;

  userOnClose?.();

  render(null, container);
  if (container.parentNode) {
    container.parentNode.removeChild(container);
  }

  instances.splice(index, 1);

  for (let i = index; i < instances.length; i++) {
    const instance = instances[i];
    const el = instance.vm.el;
    if (!el) continue;
    const pos = parseInt(el.style.top, 10) - removedHeight - 16;
    instance.vm.component.exposed.top.value = pos;
  }
}

// --- Confirm Dialog Logic ---
Message.confirm = (message, title, options = {}) => {
  return new Promise((resolve, reject) => {
    const container = document.createElement("div");
    document.body.appendChild(container);

    const onAction = (action) => {
      if (action === "confirm") {
        resolve(true);
      } else {
        reject(new Error("action:cancel"));
      }
      // Clean up
      render(null, container);
      document.body.removeChild(container);
    };

    const props = {
      message,
      title,
      ...options,
      onAction,
    };

    const vm = createVNode(ConfirmDialog, props);
    render(vm, container);
  });
};

["success", "warning", "info", "error"].forEach((type) => {
  Message[type] = (message) => {
    return Message({
      type,
      message,
    });
  };
});

export default Message;
