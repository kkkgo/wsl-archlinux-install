@echo off
echo !NEED: Microsoft Windows [10.0.18362+]
echo Your version:
ver

@echo off
:: Get Administrator Rights
set _Args=%*
if "%~1" NEQ "" (
  set _Args=%_Args:"=%
)
fltmc 1>nul 2>nul || (
  cd /d "%~dp0"
  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~dp0"" && ""%~dpnx0"" ""%_Args%""", "", "runas", 1 > "%temp%\GetAdmin.vbs"
  "%temp%\GetAdmin.vbs"
  del /f /q "%temp%\GetAdmin.vbs" 1>nul 2>nul
  exit
)

cd /d %~sdp0
wsl_update_x64.msi /q
wsl --update
wsl --unregister ArchLinux
wsl --set-default-version 2
echo Install rootfs...
ren archlinux-bootstrap*x86_64.tar.gz archlinux-bootstrap-x86_64.tar.gz
LxRunOffline i -n ArchLinux -f archlinux-bootstrap-x86_64.tar.gz -d . -r root.x86_64
wsl --set-version ArchLinux 2
wsl sed -i  's/^#Server/Server/g' /etc/pacman.d/mirrorlist

echo # Set your mirror here...
wsl sed -i  '1c Server  = http://mirrors.ustc.edu.cn\/archlinux\/$repo\/os\/$arch\/' /etc/pacman.d/mirrorlist
wsl pacman-key --init
wsl pacman-key --populate

echo # Install your Package here...
wsl pacman -Syu base base-devel vim git wget nano curl dnsutils openssh make gcc net-tools inetutils traceroute linux linux-firmware zsh --noconfirm

echo # language pack...
wsl sed -i 's/^#zh_CN/zh_CN/g'  /etc/locale.gen
wsl sed -i 's/^#en_US/en_US/g'  /etc/locale.gen
wsl locale-gen

echo # Set zsh...
wsl cp zshrc /etc/zsh/
wsl chsh -s /bin/zsh

echo # Finsh
echo Install Finshed. Type "wsl" to use.

pause