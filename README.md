# 🐍 Python 环境部署脚本说明

该项目包含两个 Windows 批处理文件：`setup.bat` 用于在本地快速部署轻量级 Python 3.14.10 环境，并下载与解压 VS Code，以便进行 Python 开发；`update.bat` 用于把本仓库的改动一键提交并推送。部署脚本特别适用于希望在无需安装情况下运行 Python 的场景，脚本按部署阶段分段注释，可以逐段对照阅读。

## 📂 功能概述

- 下载并解压最新稳定版 Visual Studio Code 到指定目录
- 下载并部署嵌入式 Python 3.14.10 环境
- 安装 pip 并配置 Python 路径
- 自动设置系统环境变量，支持 Python 命令行调用
- VS Code 与 get-pip 均从官方地址取当前版本，无需再手动更新下载链接

## 🔧 步骤解析

以下为脚本中关键命令的作用说明：

- `cd /d C:\Users\Public`  
  切换工作目录到公共用户文件夹，便于所有用户访问已部署的环境

- `md vscode` / `md python3.14`  
  如果目标文件夹不存在，则创建用于存放 VS Code 和 Python 的目录

- `curl -L -o ...`  
  下载 VS Code 最新稳定版压缩包（`-L` 跟随重定向）和 Python 3.14.10 的嵌入式版本（通过阿里云镜像加速）

- `tar -xvzf ...`  
  解压下载好的 zip 文件（此命令需要系统支持 `tar` 命令）

- `curl -o "get-pip.py" "https://bootstrap.pypa.io/get-pip.py"`  
  从 pip 官方获取与新版 Python 兼容的 get-pip 脚本；仓库内的 `get-pip.py` 是同源的离线备份

- `.\python get-pip.py -i https://mirrors.aliyun.com/pypi/simple`  
  启动 pip 安装程序，并使用阿里云 PyPI 镜像加快安装速度

- `echo lib\site-packages>> python314._pth`  
  添加 site-packages 路径支持，使 pip 安装的第三方库能被识别

- `copy python.exe python3.14.exe`  
  为 python.exe 创建一个 python3.14.exe 的副本，方便调用

- `setx PATH ...`  
  分别写入当前用户和全机器 PATH，包含 Python 根目录与 `Scripts`（pip 生成的命令行工具所在处）

## 📁 部署结果

- `C:\Users\Public\vscode`：VS Code 本体
- `C:\Users\Public\vscode\python3.14`：Python 解释器，其下 `Lib\site-packages` 存放第三方库，`Scripts` 存放 `pip` 等命令行工具

## 🚀 使用方法

1. 克隆本项目或下载 `setup.bat` 文件  
2. **右键点击 `setup.bat`，选择“以管理员身份运行”**
3. 等待部署完成后，可以：
   - 在命令行中运行 `python3.14` 来进入 Python 交互模式
   - 运行 `python3.14 -m pip install 包名` 安装第三方库
   - 使用 VS Code 进行 Python 开发（无需额外安装）

## 📤 一键提交

改完脚本或文档后，双击运行 `update.bat` 即可：它会 `git add -A`、用带时间戳的信息提交（工作区无改动时自动跳过提交），再推送到 `origin` 当前分支。推送失败会把原因留在窗口里，修好再重跑一次就行。

## ⚠️ 注意事项

- ⚙️ 请务必以 **管理员身份运行** `setup.bat` 文件，否则环境变量可能无法正确写入。
- 🛠 确保你的系统支持 `tar` 命令；如无可用，请手动解压 zip 文件。
- 📡 下载依赖于网络连接，建议使用稳定 Wi-Fi 环境运行脚本（VS Code 压缩包有数百 MB）。
- 🔁 脚本可重复执行，但会向 `python314._pth` 再次追加 site-packages、并向 PATH 追加重复条目；重新部署前建议先删除这两个目录。
- 📏 `setx` 写入的值有长度上限，PATH 本身过长时可能被截断，部署后建议确认环境变量是否完整。
- 🧩 嵌入式 Python 不执行 `site.main()`，第三方库的查找完全依赖 `python314._pth` 中的条目，请勿删除脚本追加的这一行。

## ✅ 部署完成提示

脚本执行完成后，会显示：

Everything is ok...

表示 Python 和 VS Code 已部署成功，可以开始使用了！

---
