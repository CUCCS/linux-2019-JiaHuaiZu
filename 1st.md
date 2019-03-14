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
    ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/1.PNG)
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
    ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/2.PNG)
    - 修改isolinux/isolinux.cfg，将timeout 300改为timeout 10
  - 下载老师修改过的.seed文件wget http://sec.cuc.edu.cn/huangwei/course/LinuxSysAdmin/exp/chap0x01/cd-rom/preseed/ubuntu-server-autoinstall.seed
  - 将该文件保存到~/cd/preseed目录下cp ubuntu-server-autoinstall.seed ~/cd/preseed/ubuntu-server-autoinstall.seed
  ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/3.PNG)
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
  ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/4.PNG)
- 将无人值守的镜像从虚拟机服务器使用sftp方式下载到本机,并在本机上安装
  - 在virtualbox中为虚拟机添加另一个网卡,并设为host-only模式
  - 在虚拟机中修改01-netcfg.yaml文件 sudo vi /etc/netplan/01-netcfg.yaml
     并在尾部添加如下内容
     ```
     enp0s8:
       dhcp4: yes
     ```
     ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/7.png)
  - 应用改变 sudo netplan apply
  - 连接服务器,在本机上cmd命令行中输入sftp jhz@192.168.56.102 
  ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/5.png)
  - 获取镜像文件wget /home/jhz/cd/custom.iso
  ![image](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/1st/image/6.png)
  - 之后使用该镜像文件安装虚拟机
- 新添加网卡实现开机自启动和自动获取ip
  - 在虚拟机中修改01-netcfg.yaml文件 sudo vi /etc/netplan/01-netcfg.yaml
     并在尾部添加如下内容
     ```
    auto enp0s8
    iface enp0s8 inet dhcp

     ```
   - 应用改变 sudo netplan apply
- 实验遇到的问题
  - 在各种配置文件的编辑中经常出错,后来才发现在ubuntn中是空格敏感的,许多行末出现的空格都会报错
  - 在连接好了sftp服务器后找不到iso文件,后来查询才得知在home文件夹下的用户文件内
