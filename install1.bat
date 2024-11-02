@echo off

color 2
cd /d C:\Users\Public

if NOT EXIST vscode (
    md vscode
)
cd vscode
curl -o "VScode.zip" "https://vscode.download.prss.microsoft.com/dbazure/download/stable/38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40/VSCode-win32-x64-1.93.1.zip"
tar -xvzf VScode.zip

if NOT EXIST python3.9 (
    md python3.9
) 
cd python3.9
curl -o "python.zip" "https://mirrors.aliyun.com/python-release/windows/python-3.9.0-embed-amd64.zip?spm=a2c6h.25603864.0.0.4ac531fcDZkuHg"
tar -xvzf python.zip 

curl -o get-pip.py "http://mirrors.aliyun.com/pypi/get-pip.py"
.\python get-pip.py -i https://pypi.tuna.tsinghua.edu.cn/simple 

echo lib\site-packages>> python39._pth

rename python.exe python3.9.exe
setx PATH "%PATH%;C:\Users\Public\vscode\python3.9;C:\Users\Public\vscode\python3.9\Scripts;C:\Users\Public\vscode\python3.9\python3.9.exe"
setx -M PATH "%PATH%;C:\Users\Public\vscode\python3.9;C:\Users\Public\vscode\python3.9\Script;C:\Users\Public\vscode\python3.9\python3.9.exe"

echo Everything is ok...

pause

