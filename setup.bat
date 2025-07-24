@echo off

color 2
cd /d C:\Users\Public

if NOT EXIST vscode (
    md vscode
)
cd vscode
curl -o "VScode.zip" "https://vscode.download.prss.microsoft.com/dbazure/download/stable/38c31bc77e0dd6ae88a4e9cc93428cc27a56ba40/VSCode-win32-x64-1.93.1.zip"
tar -xvzf VScode.zip

if NOT EXIST python3.11 (
    md python3.11
) 
cd python3.11
curl -o "python.zip" "https://mirrors.aliyun.com/python-release/windows/python-3.11.2-embed-amd64.zip?spm=a2c6h.25603864.0.0.392831fcBfM9bV"
tar -xvzf python.zip 

.\python get-pip.py -i https://mirrors.aliyun.com/pypi/simple 

echo lib\site-packages>> python311._pth

copy python.exe python3.11.exe
setx PATH "%PATH%;C:\Users\Public\vscode\python3.11;C:\Users\Public\vscode\python3.11\Scripts;C:\Users\Public\vscode\python3.11\python3.11.exe"
setx /M PATH "%PATH%;C:\Users\Public\vscode\python3.11;C:\Users\Public\vscode\python3.11\Script;C:\Users\Public\vscode\python3.11\python3.11.exe"

echo Everything is ok...

pause

