# 命令篇

## Systemd
[![asciicast](https://asciinema.org/a/D582zBK5QokC3FL0aYi6gJCvC.svg)](https://asciinema.org/a/D582zBK5QokC3FL0aYi6gJCvC)
## Unit
[![asciicast](https://asciinema.org/a/XLbuYHncTGWxyjTQtdYT10Hi0.svg)](https://asciinema.org/a/XLbuYHncTGWxyjTQtdYT10Hi0)
## Target and Log
[![asciicast](https://asciinema.org/a/FwuT6gB0weFqRoi2MCXA49jyj.svg)](https://asciinema.org/a/FwuT6gB0weFqRoi2MCXA49jyj)

# 自查清单
## 如何添加一个用户并使其具备sudo执行程序的权限？
- 进入root用户 'su root'
- 添加新用户jhz 'useradd jhz'
- 打开sudo配置文件 'vim /etc/sudoers'
- 在root ALL=(ALL) ALL后一行加上 'jhz ALL=(ALL) ALL'
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/3rd/images/%E4%B8%BA%E7%94%A8%E6%88%B7%E6%B7%BB%E5%8A%A0sudo%E6%9D%83%E9%99%90.PNG)
## 如何将一个用户添加到一个用户组？
- 'usermod -G 组名 账号'
## 如何查看当前系统的分区表和文件系统详细信息？
- 系统分区表 'sudo fdisk -l'
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/3rd/images/%E6%9F%A5%E7%9C%8B%E7%B3%BB%E7%BB%9F%E5%88%86%E5%8C%BA%E8%A1%A8.PNG)
- 文件系统详细信息 'df -a'
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/3rd/images/%E6%9F%A5%E7%9C%8B%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F.PNG)
## 如何实现开机自动挂载Virtualbox的共享目录分区？(我用的VMware,这里为挂载VMware的共享目录)
- 在VMware虚拟机设置中创建共享文件夹vm share folder
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/3rd/images/%E4%B8%BB%E6%9C%BA%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9.PNG)
- 在虚拟机中查看vmware的共享文件夹名称 'vmware-hgfscclient'
- 挂载所有共享文件夹挂载到/mnt/hgfs 'sudo vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other'
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/3rd/images/%E8%99%9A%E6%8B%9F%E6%9C%BA%E6%8C%82%E8%BD%BD%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9.PNG)
## 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
- 扩容2G 'sudo lvextend --size +2G /dev/jhz/root'
- 缩容2G 'sudo lvreduce --size -2G /dev/jhz/root'
## 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？
- 创建服务文件 'vim /usr/lib/systemd/system/do_something.service'
- 输入 
```
  [Unit]
Description=test networking
#Before=network.target
After=networking.service # 网络启动之后
[Service]

Type=oneshot # 执行一次
ExecStart=脚本1
ExecStop=脚本2
KillSignal=SIGINT
[Install]
WantedBy=multi-user.target #多用户模式 
```
- 激活该服务开机自启动 'systemctl enable do_something'
## 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死.
- 将服务配置文件的Restart属性设置为always
