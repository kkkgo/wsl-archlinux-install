# wsl-archlinux-install
自用的wsl安装Archlinux脚本

## 使用方法，3步
 0、前置条件:确保你已经开启了WSL功能和虚拟机平台功能，如有其他版本的WSL系统建议卸载。Windows版本为1903 或更高版本，采用内部版本 18362 或更高版本。[参考链接](https://docs.microsoft.com/zh-cn/windows/wsl/install-manual)     
 
建议使用管理员手动执行以下命令名并重启：    

**启用适用于 Linux 的 Windows 子系统 [管理员]**
>dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart  

**启用“虚拟机平台”可选功能  [管理员]**
>dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart  

**如果你在Hyper-v虚拟机中使用WSL则需要为虚拟机开启虚拟化嵌套：  [管理员]**
>Set-VMProcessor -VMName win10vm -ExposeVirtualizationExtensions $true   

***
1、在你要安装Archlinux的目录新建文件夹，比如C:\Arch，到镜像站下载x86_64.tar.gz格式的Archlinux镜像放到C:\Arch：  
https://mirrors.ustc.edu.cn/archlinux/iso/latest/  

2、[下载脚本压缩包](https://github.com/kkkgo/wsl-archlinux-install/archive/refs/heads/main.zip)，把压缩包内容解压进去。确认install.bat等文件和下载好的x86_64.tar.gz镜像在同一个目录。  
**如果你一切准备好的话，文件看起来应该是这样：**  
![路径演示](./path.png)    

3、直接双击运行Install.bat即可安装（无需右键管理员！），过程需要联网。  

## 如何进入wsl
在命令行敲`WSL`回车就进去了

## 如何卸载
`wsl --unregister ArchLinux`