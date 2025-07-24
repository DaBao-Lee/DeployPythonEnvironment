# 🐍 Python 环境部署脚本说明

该项目包含一个 Windows 批处理文件 `setup.bat`，用于在本地快速部署轻量级 Python 3.9 环境，并下载与解压 VS Code，以便进行 Python 开发。本脚本特别适用于没有管理员权限或希望在无需安装情况下运行 Python 的场景。

## 📂 功能概述

- 下载并解压 Visual Studio Code 到指定目录
- 下载并部署嵌入式 Python 3.9 环境
- 安装 pip 并配置 Python 路径
- 自动设置系统环境变量，支持 Python 命令行调用

## 🔧 步骤解析

以下为脚本中关键命令的作用说明：

- `cd /d C:\Users\Public`  
  切换工作目录到公共用户文件夹，便于所有用户访问已部署的环境

- `md vscode` / `md python3.9`  
  如果目标文件夹不存在，则创建用于存放 VS Code 和 Python 的目录

- `curl -o ...`  
  下载 VS Code 的压缩包和 Python 3.9 的嵌入式版本（通过阿里云镜像加速）

- `tar -xvzf ...`  
  解压下载好的 zip 文件（此命令需要系统支持 `tar` 命令）

- `.\python get-pip.py -i https://mirrors.aliyun.com/pypi/simple`  
  启动 pip 安装程序，并使用阿里云 PyPI 镜像加快安装速度

- `echo lib\site-packages>> python39._pth`  
  添加 site-packages 路径支持，使 pip 安装的第三方库能被识别

- `copy python.exe python3.9.exe`  
  为 python.exe 创建一个 python3.9.exe 的副本，方便调用

- `setx PATH ...`  
  设置环境变量，使 Python 及其脚本可以在命令行中直接运行

## 🚀 使用方法

1. 克隆本项目或下载 `setup.bat` 文件
2. 双击运行 `setup.bat` 文件
3. 等待部署完成后，可以：
   - 在命令行中运行 `python3.9` 来进入 Python 交互模式
   - 使用 VS Code 进行 Python 开发（无需额外安装）

> ⚠️ 注意：确保你的系统支持 `tar` 命令，否则可以使用其他解压工具手动解压 zip 文件。

## ✅ 部署完成提示

脚本执行完成后，会显示：

Everything is ok...

表示 Python 和 VS Code 已部署成功，可以开始使用了！

---
