const { exec, spawn } = require("child_process");
const path = require("path");
const fs = require("fs");

function runCommand(command, cwd) {
  return new Promise((resolve, reject) => {
    const child = exec(command, { cwd });

    child.stdout.on("data", (data) => {
      process.stdout.write(data);
    });

    child.stderr.on("data", (data) => {
      process.stderr.write(data);
    });

    child.on("close", (code) => {
      if (code === 0) resolve();
      else reject(new Error(`Command failed with code ${code}: ${command}`));
    });
  });
}

function startProcess(command, args, cwd, name) {
  const child = spawn(command, args, {
    cwd,
    stdio: "inherit",
    shell: true,
  });

  child.on("close", (code) => {
    console.log(`${name} 已退出，code=${code}`);
  });

  return child;
}

async function main() {
  try {
    const registries = [
      "https://registry.npmmirror.com",
      "https://mirrors.cloud.tencent.com/npm/",
    ];

    let yarnInstalled = false;
    for (const registry of registries) {
      try {
        console.log(`正在尝试从 ${registry} 全局安装 yarn...`);
        await runCommand(`npm i -g yarn --registry=${registry}`);
        console.log("Yarn 安装成功。");
        yarnInstalled = true;
        break;
      } catch (error) {
        console.error(`从 ${registry} 安装 yarn 失败，正在尝试下一个...`);
      }
    }

    if (!yarnInstalled) {
      console.error("所有镜像源都无法安装 yarn，请检查网络连接或镜像源状态。");
      return;
    }

    const behindDir = path.join(__dirname, "behind");
    if (fs.existsSync(behindDir)) {
      console.log("正在为 behind 安装依赖...");
      await runCommand("yarn", behindDir);
      console.log("behind 依赖安装成功。");
    } else {
      console.log("behind 目录不存在，跳过依赖安装。");
    }

    const vueDir = path.join(__dirname, "vue");
    if (fs.existsSync(vueDir)) {
      console.log("正在为 vue 安装依赖...");
      await runCommand("yarn", vueDir);
      console.log("vue 依赖安装成功。");
    } else {
      console.log("vue 目录不存在，跳过依赖安装。");
    }

    console.log("正在启动开发服务器...");
    if (fs.existsSync(behindDir)) {
      startProcess("yarn", ["run", "dev"], behindDir, "后端");
    }
    if (fs.existsSync(vueDir)) {
      startProcess("yarn", ["run", "dev"], vueDir, "前端");
    }
  } catch (error) {
    console.error("发生错误:", error);
  }
}

main();
