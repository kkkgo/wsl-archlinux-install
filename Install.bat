@echo off
wsl --unregister ArchLinux
wsl_update_x64.msi /q
wsl --update
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
wsl pacman -Syu base base-devel vim git wget nano curl dnsutils openssh make gcc net-tools git inetutils traceroute  linux linux-firmware zsh --noconfirm

echo # language pack...
wsl sed -i 's/^#zh_/zh_/g'  /etc/locale.gen
wsl sed -i 's/^#en_/en_/g'  /etc/locale.gen
wsl locale-gen

echo # Set zsh...
wsl cp zshrc /etc/zsh/
wsl chsh -s /bin/zsh

echo # Finsh
echo Install Finshed. Type "wsl" to use.