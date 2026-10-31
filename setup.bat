@echo off

color 2

rem 一键部署：最新稳定版 VS Code + 嵌入式 Python 3.14
rem 请以管理员身份运行，部署目录固定为 C:\Users\Public\vscode
cd /d C:\Users\Public

rem ---------- 1. VS Code ----------
rem update.code.visualstudio.com 会 302 跳转到当前最新稳定版，所以 curl 必须带 -L
if NOT EXIST vscode (
    md vscode
)
cd vscode
curl -L -o "VScode.zip" "https://update.code.visualstudio.com/latest/win32-x64-archive/stable"
rem Windows 自带的 tar 是 bsdtar，可直接解压 zip
tar -xvzf VScode.zip

rem ---------- 2. 嵌入式 Python ----------
rem 阿里云 python-release 镜像，解压后当前目录即为 Python 根目录，无需安装
if NOT EXIST python3.14 (
    md python3.14
) 
cd python3.14
curl -o "python.zip" "https://mirrors.aliyun.com/python-release/windows/python-3.14.10-embed-amd64.zip"
tar -xvzf python.zip 

rem ---------- 3. pip ----------
rem 嵌入式版本不带 pip；用官方 bootstrap 脚本取当前可用的 get-pip，避免旧版不认新 Python
curl -o "get-pip.py" "https://bootstrap.pypa.io/get-pip.py"
.\python get-pip.py -i https://mirrors.aliyun.com/pypi/simple 

rem 嵌入式版本不执行 site.main()，只按 ._pth 里的条目搜索包，
rem 因此要把 site-packages 追加到 python314._pth，pip 装的第三方库才能被 import
echo lib\site-packages>> python314._pth

rem ---------- 4. 命令别名与环境变量 ----------
rem 复制一份带版本号的解释器，方便与机器上其他 Python 版本共存
copy python.exe python3.14.exe
rem 写入当前用户的 PATH
setx PATH "%PATH%;C:\Users\Public\vscode\python3.14;C:\Users\Public\vscode\python3.14\Scripts;C:\Users\Public\vscode\python3.14\python3.14.exe"
rem 写入全机器 PATH，需要管理员权限
setx /M PATH "%PATH%;C:\Users\Public\vscode\python3.14;C:\Users\Public\vscode\python3.14\Scripts;C:\Users\Public\vscode\python3.14\python3.14.exe"

echo Everything is ok...

pause
