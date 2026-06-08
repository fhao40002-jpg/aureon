@echo off
chcp 65001 >nul
echo ╔══════════════════════════════╗
echo ║  秀威供应链 · 网站部署工具  ║
echo ╚══════════════════════════════╝
echo.
echo 第一步：登录 GitHub
echo 浏览器会打开，输入验证码即可
echo.
cd /d "%~dp0"
call gh auth login --web --hostname github.com
echo.
echo 登录成功！开始部署...
echo.
echo 第二步：创建 GitHub 仓库
call gh repo create xiuwei-trading --public --source=. --remote=origin --push
echo.
echo 第三步：开启 GitHub Pages
call gh api repos/xiuwei-trading/pages -X POST -f "source[branch]=main" -f "source[path]=/"
echo.
echo ╔══════════════════════════════╗
echo ║  🚀 部署完成！               ║
echo ║  网址: xiuwei-trading.github.io ║
echo ║  (等1-2分钟后访问)           ║
echo ╚══════════════════════════════╝
pause
