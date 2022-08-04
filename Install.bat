@echo off
echo !NEED: Microsoft Windows [10.0.18362+]
echo ======================
echo Your version:
ver
echo ======================

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
echo %~sdp0
wsl_update_x64.msi /q
wsl --update
wsl --unregister ArchLinux
wsl --unregister alpine-makerootfs
wsl --set-default-version 2
echo Makeing rootfs...
del /F /S /Q Archlinux_WSL_root.tar
curl https://mirrors.ustc.edu.cn/alpine/latest-stable/releases/x86_64/alpine-minirootfs-3.16.0-x86_64.tar.gz --output alpine.tar.gz
rmdir /s/q alpine-makerootfs
mkdir alpine-makerootfs
wsl --import alpine-makerootfs alpine-makerootfs alpine.tar.gz
wsl -d alpine-makerootfs -e sh tar_conv.txt
wsl --unregister alpine-makerootfs
rmdir /s/q alpine-makerootfs
del /F /S /Q alpine.tar.gz
wsl --import Archlinux . .\Archlinux_WSL_root.tar
del /F /S /Q Archlinux_WSL_root.tar
wsl --set-version ArchLinux 2
wsl -d Archlinux -e sh pacman_init.txt
echo # Finsh
echo Install Finshed. Type "wsl" to use.
wsl
