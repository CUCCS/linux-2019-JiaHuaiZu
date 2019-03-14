> 实验一

**实验目的**

- [ ] 如何配置无人值守安装iso并在Virtualbox中完成自动化安装
- [ ] Virtualbox安装完Ubuntu之后新添加的网卡如何实现系统开机自动启用和自动获取IP？
- [ ] 如何使用sftp在虚拟机和宿主机之间传输文件？

**实验环境**

- 主机：    win10

- 虚拟机： linux ubuntu18.04.1-server

  网络环境

  - NAT

**实验过程**

- 创建无人值守的iso镜像
  - 下载正常镜像到虚拟机wget http://old-releases.ubuntu.com/releases/18.04.0/ubuntu-18.04.1-server-amd64.iso(连接不到校园网,所以在外网上寻找资源)
  - 按照实验指导上的要求执行
    - 创建一个工作目录mkdir loopdir
    - 挂载iso镜像文件到该目录mount -o loop ubuntu-16.04.1-server-amd64.iso loopdir
    - 创建一个工作目录用于克隆光盘内容mkdir cd
    - 同步光盘内容到目标工作目录rsync -av loopdir/ cd
    - 卸载iso镜像umount loopdir
    - 进入目标工作目录cd cd/
    - 编辑Ubuntu安装引导界面增加一个新菜单项入口vim isolinux/txt.cfg
    - 添加以下内容到该文件后强制保存退出
    ```
    label autoinstall
     menu label ^Auto Install Ubuntu Server
     kernel /install/vmlinuz
     append  file=/cdrom/preseed/ubuntu-server-autoinstall.seed debian-installer/locale=en_US console-setup/layoutcode=us keyboard-configuration/layoutcode=us console-setup/ask_detect=false localechooser/translation/warn-light=true localechooser/translation/warn-severe=true initrd=/install/initrd.gz root=/dev/ram rw quiet
    ```
    - 修改isolinux/isolinux.cfg，将timeout 300改为timeout 10
  - 下载老师修改过的.seed文件wget http://sec.cuc.edu.cn/huangwei/course/LinuxSysAdmin/exp/chap0x01/cd-rom/preseed/ubuntu-server-autoinstall.seed
  - 将该文件保存到~/cd/preseed目录下cp ubuntu-server-autoinstall.seed ~/cd/preseed/ubuntu-server-autoinstall.seed
  - 重新生成md5sum.txt文件 cd ~/cd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt
  - 在当前目录下创建shell脚本,在其中添加以下内容
    ```
    IMAGE=custom.iso
    BUILD=~/cd/

    mkisofs -r -V "Custom Ubuntu Install CD" \
            -cache-inodes \
            -J -l -b isolinux/isolinux.bin \
            -c isolinux/boot.cat -no-emul-boot \
            -boot-load-size 4 -boot-info-table \
            -o $IMAGE $BUILD
    ```
  - 下载上述脚本中需要的内容 apt install genisoimage
  - 执行脚本,生成镜像文件bash shell
- 将无人值守的镜像从虚拟机服务器下载到本机,并在本机上安装
