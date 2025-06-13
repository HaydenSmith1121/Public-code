chcp 65001

@echo off
:: 批处理脚本：将本地文件推送到 GitHub 仓库
:: 使用前请确保：
:: 1. 已安装 Git 并配置了用户名和邮箱
:: 2. 已初始化本地仓库并关联到远程 GitHub 仓库
:: 3. 当前目录是 Git 仓库的根目录

:: 设置变量
set REMOTE_NAME=origin
set BRANCH_NAME=wbw
set COMMIT_MESSAGE="自动提交：更新文件"

:: 检查是否在 Git 仓库中
git rev-parse --is-inside-work-tree >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：当前目录不是 Git 仓库。
    pause
    exit /b 1
)

:: 检查远程仓库是否存在
git remote show %REMOTE_NAME% >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：远程仓库 %REMOTE_NAME% 不存在。
    pause
    exit /b 1
)

:: 添加所有文件到暂存区
echo 正在添加文件到暂存区...
git add .
if %errorlevel% neq 0 (
    echo 错误：添加文件失败。
    pause
    exit /b 1
)

:: 提交更改
echo 正在提交更改...
git commit -m %COMMIT_MESSAGE%
if %errorlevel% neq 0 (
    echo 错误：提交失败。
    pause
    exit /b 1
)

:: 推送到远程仓库
echo 正在推送到远程仓库 %REMOTE_NAME% 的 %BRANCH_NAME% 分支...
git push %REMOTE_NAME% %BRANCH_NAME%
if %errorlevel% neq 0 (
    echo 错误：推送失败。
    pause
    exit /b 1
)

echo 成功推送到 GitHub！
pause