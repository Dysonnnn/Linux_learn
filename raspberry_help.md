
**树莓派3的板载蓝牙和串口，现在成了鱼和熊掌，两者无法兼得**



[Linux+树莓派3开发总结——给树莓派挂载移动硬盘或U盘(https://blog.csdn.net/xqf1528399071/article/details/52191530)
首先使用
```
fdisk -l
```

命令查看一下U盘是否有被识别到，及识别的U盘是在哪个位置



外接U盘或移动硬盘时，默认不会自动挂载，所以需要用mount 命令挂载。通常我们在/mnt 或/media 目录下新建一个目录作为挂载点。比如：
```
sudo mkdir /mnt/1GB_USB_flash
sudo mount -o uid=pi,gid=pi /dev/sda1 /mnt/1GB_USB_flash
//用完之后卸载
sudo umount /mnt/1GB_USB_flash
```
sda1 是取决于你的实际情况，a表示第一个硬盘，1表示第一个分区。

挂载exFAT格式的硬盘
FAT 格式U盘mount 本身就能支持，但如果你的U盘或移动硬盘使用的是exFAT 格式，mount会说不支持。没关系，安装 exfat-fuse软件之后 mount就支持了。
```
sudo apt-get install exfat-fuse
```
如果想开机自动挂载，而不是每次手工执行，可以编辑 /etc/fstab 文件。比如在末尾添加一行：
```
/dev/sda1 /mnt/usbdisk vfat rw,defaults 0 0
```
挂载NTFS格式的硬盘(读写方式挂载)
默认挂载NTFS格式的硬盘只有只读权限，需要借助其它工具实现。

#安装所需软件包
```
sudo apt-get install fuse-utils ntfs-3g
```
#加载内核模块
```
modprobe fuse
```
#编辑fstab让移动硬盘开机自动挂载
```
sudo nano /etc/fstab
```
#在最后一行添加如下内容
```
/dev/sda1 /mnt/myusbdrive ntfs-3g defaults,noexec,umask=0000 0 0
```
#保存重启，即可生效


挂载FAT32格式的硬盘

#创建挂载点
```
sudo mkdir /mnt/myusbdrive
```
#编辑fstab让移动硬盘开机自动挂载
```
sudo nano /etc/fstab
```
#在最后一行添加如下内容
```
/dev/sda1 /mnt/myusbdrive auto defaults,noexec,umask=0000 0 0
```
#保存重启，即可生效


说明：
sda1是取决于你的实际情况，a表示第一个硬盘，1表示第一个分区。
umask=0000 0 0
前面四个0就是对所有人,可读可写可执行,
后面两个0,第一个代表dump,0是不备份
第二个代表fsck检查的顺序,0表示不检查
卸载：sudo umount /mnt/myusbdrive

查看挂载情况可使用以下命令。
```bash
cd /mnt/myusbdrive
 
ls
```




- 20200111
树莓派+CSI摄像头

参考文章 [树莓派连接官方CSI摄像头的使用](https://blog.csdn.net/fhqlongteng/article/details/80433633)
目前提供了三个应用程序，分别为：raspistill、raspivid、raspistillyuv。
其中 raspistill 和 raspistillyuv 非常相似，并且都是用于捕捉图像，
而 raspivid 用于捕捉视频。 
在树莓派3B+的树莓派的 raspberry 2018.04.18 stretch版本的系统中已经自带raspistill,raspivid这两个应用程序，另外一个不支持。

所有应用程序均基于命令行方式运行，通过 OpenMAX 的 mmal API 进行编写。OpenMAX 的 mmal API 提供了更易使用的系统组件。注意，mmal 是一个由 Broadcom 为 Videocore 4 系统定制的 API。 

应用程序使用了四个 OpenMAX（mmal）组件：camera（摄像）、preview（预览）、encoder（编码）、null_sink。
所有应用程序均使用了摄像组件，raspistill 使用了图像编码组件，raspivid使用了视频编码组件，raspistillyuv没有使用编码组件，而是直接将 YUV 或 RGB 从摄像组件输出到文件。 


### 安装摄像头软件
执行下文介绍的命令行进行下载并安装最新的内核，GPU 固件及应用程序。您需要连接到互联网才可以实现以下操作。
```
$sudo apt-get update
$sudo apt-get upgrade
```
接下来，您首先需要在 Raspberry Pi 的 raspi-config 程序中启用摄像头的支持。 
1）连接摄像头与树莓派 
2）修改树莓派配置，开启摄像头模块。
```
sudo raspi-config
```
将光标移动到摄像头选项（Camera option）处，并选择启用（Enable）。在退出 raspi-config 时会要求您重新启动。启用选项是为了确保重启后 GPU 固件能够正确运行（包括摄像头驱动和调节电路），并且 GPU 从主内存划分到了足够的内存使摄像头能够正确运行。 

测试系统已经完成安装并正常工作，可尝试以下命令：
```bash
$raspistill -v -o test.jpg 

$raspistill -o rasp.jpg -t 1000 # 1000ms 后拍照
```


[树莓派3B+ 树莓派官方CSI接口摄像头生成/dev/video0设备节点](https://blog.csdn.net/zz531987464/article/details/83422794)
修改配置文件，使树莓派能够生成/dev/video0设备节点
```bash
sudo vi /etc/modules-load.d/modules.conf
```
在最后面添加一行：bcm2835-v4l2

保存重启树莓派，ls /dev/video0即可看到生成的设备节点





---

蓝牙 BlueTooth使用：
报错：
连接至BlueZ失败
BlueZ守护进程没有运行。blueman-manage无法继续。


[树莓派3如何使用蓝牙](https://shumeipai.nxez.com/2016/07/10/raspberry-pi-3-how-to-use-bluetooth.html)
2016年7月10日 Spoony 未分类 12

一、升级安装蓝牙相关软件包
```sh
sudo apt-get update 
sudo apt-get upgrade -y 
sudo apt-get dist-upgrade -y 
sudo apt-get install pi-bluetooth bluez bluez-firmware blueman
```
二、最关键一点：添加pi用户到蓝牙组

```sh
sudo usermod -G bluetooth -a pi
```
三、重启

```sh
sudo reboot
```
之后就可以按照各种教程正确使用蓝牙了

---

通过蓝牙操作树莓派
原创qzero233 最后发布于2019-03-16 19:45:38 阅读数 1559  收藏
展开
在前面的一些文章中，笔者曾使用usb网络共享的方式来操作树莓派，但是这个操作还是很麻烦，所以笔者上网查了一下，摸索出了一个用蓝牙无线操作树莓派的方法

首先，先开启蓝牙服务并设置为开机自启

service bluetooth start
update-rc.d bluetooth enable
1
2
接着，按照 https://raspberrypi.stackexchange.com/questions/29504/how-can-i-set-up-a-bluetooth-pan-connection-with-a-raspberry-pi-and-an-ipod/71587
————————————————
版权声明：本文为CSDN博主「qzero233」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Powerful_Green/article/details/88604205



---
查看蓝牙信息
```
sudo bluetoothctl
```
显示如下信息，其中B8:27:EB:19:55:E7就是树莓派的蓝牙地址
```
[NEW] Controller B8:27:EB:19:55:E7 raspberrypi [default]
```
输入scan on命令进行扫描
找到和手机相关的设备信息，如下：

[NEW] Device C0:9F:05:49:99:2C OPPO R9m
C0:9F:05:49:99:2C就是手机的蓝牙地址 接下来即可进行配对

蓝牙配对
power on
agent on
pair C0:9F:05:49:99:2C
但是返回信息里边显示失败：

Attempting to pair with C0:9F:05:49:99:2C
[CHG] Device C0:9F:05:49:99:2C Connected: yes
Request confirmation
[agent] Confirm passkey 439499 (yes/no): yes
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device C0:9F:05:49:99:2C Connected: no
返回手机的蓝牙设置界面，再次执行配对，出现是否允许配对时选择确定即可

Attempting to pair with C0:9F:05:49:99:2C
[CHG] Device C0:9F:05:49:99:2C Connected: yes
Request confirmation
[agent] Confirm passkey 654340 (yes/no): yes
[CHG] Device C0:9F:05:49:99:2C Modalias: bluetooth:v0046p0802d0903
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001105-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001116-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 0000112f-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001132-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device C0:9F:05:49:99:2C ServicesResolved: yes
[CHG] Device C0:9F:05:49:99:2C Paired: yes
Pairing successful
再信任该设备：

trust C0:9F:05:49:99:2C
注意 配对和连接是两个概念！配对成功较容易 但是连接则需要一点操作

蓝牙连接
直接connect会出现Failed to connect或者远程桌面中No usable services的情况，如下：

[bluetooth]# connect C0:9F:05:49:99:2C
Attempting to connect to C0:9F:05:49:99:2C
Failed to connect: org.bluez.Error.Failed
首先安装蓝牙相关的安装包：

sudo apt-get install pi-bluetooth bluez bluez-firmware blueman
添加用户到蓝牙组（假设用户名为pi）

sudo usermod -G bluetooth -a pi 
sudo reboot 
启动/增加SPP(Serial Port Profile)
打开蓝牙配置文件(nano/vi都行)：


sudo nano /etc/systemd/system/dbus-org.bluez.service

作者：小米智能香蕉
链接：https://www.jianshu.com/p/f7999399b4a8
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。+


---

树莓派（Raspberry Pi 3）开启和连接蓝牙
原创ZoharAndroid 最后发布于2017-11-19 15:17:38 阅读数 24648  收藏
展开
参考连接：https://www.raspberrypi.org/forums/viewtopic.php?p=919420

1、查看树莓派蓝牙开启状态
```bash
systemctl status bluetooth
```


————————————————
版权声明：本文为CSDN博主「ZoharAndroid」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/guzhong10/article/details/78574577

---
[了解树莓派上的蓝牙](https://www.cnblogs.com/vamei/p/6753531.html)
在Raspbian中，基本的蓝牙操作可以通过bluez中的bluetoothctl命令进行。该命令运行后，将进入到一个新的Shell。在这个shell中输入：

 

list
 

将显示树莓派上可用的蓝牙模块，例如：

Controller B8:27:EB:72:47:5E raspberrypi [default]
 

运行scan命令，开启扫描：

scan on
扫描启动后，用devices命令，可以打印扫描到蓝牙设备的MAC地址和名称，例如：

Device 00:9E:C8:62:AF:55 MiBOX3
Device 4D:CE:7A:1D:B8:6A vamei
此外，你还可以用help命令获得帮助。使用结束后，你可以用exit命令推出bluetoothctl。

 

 

除了bluetoothctl，在Raspbian是shell中可以通过hciconfig来控制蓝牙模块。比如开关蓝牙模块：

sudo hciconfig hci0 up   #启动hci设备
sudo hciconfig hci0 down #关闭hci设备
命令中的hci0指的是0号HCI设备，即树莓派的蓝牙适配器。 

 

与此同时，你可以用下面命令来查看蓝牙设备的工作日志： 

hcidump
bluez本身还提供了连接和读写工具。但不同版本的bluez相关功能的差异比较大，而且使用起来不太方便，所以我下面使用Node.js的工具来实现相关功能。



----
树莓派3串口(UART)使用问题的解决方法
http://shumeipai.nxez.com/2016/08/08/solution-raspberry-pi3-serial-uart-use-issues.html

根据官方的反馈和回复，我们了解到树莓派3上用户目前无法正常是使用GPIO中的UART串口(GPIO14&GPIO15),也就是说用户无论是想用串口来调试树莓派，还是想用GPIO中的串口来连接GPS，蓝牙，XBEE等等串口外设目前都是有问题的。


原因是树莓派CPU内部有两个串口，一个是硬件串口(官方称为PL011 UART)，一个是迷你串口(官方成为mini-uart)。在树莓派2B/B+这些老版树莓派上，官方设计时都是将“硬件串口”分配给GPIO中的UART(GPIO14&GPIO15)，因此可以独立调整串口的速率和模式。而树莓派3的设计上，官方在设计时将硬件串口分配给了新增的蓝牙模块上，而将一个没有时钟源，必须由内核提供时钟参考源的“迷你串口”分配给了GPIO的串口，这样以来由于内核的频率本身是变化的，就会导致“迷你串口”的速率不稳定，这样就出现了无法正常使用的情况。

目前解决方法就是，关闭蓝牙对硬件串口的使用，将硬件串口重新恢复给GPIO的串口使用，也就意味着树莓派3的板载蓝牙和串口，现在成了鱼和熊掌，两者无法兼得。

下面我就讲讲如何 恢复硬件串口的方法 ：

1.下载 pi3-miniuart-bt-overlay 文件，解压出pi3-miniuart-bt-overlay.dtb文件，并将dtb文件拷贝到/boot/overlays/目录下

2.编辑/boot目录下的config.txt文件

1
sudo nano /boot/config.txt
添加下面两行:

1
2
dtoverlay=pi3-miniuart-bt-overlay
force_turbo=1
20160808215327155

3.编辑/boot目录下的cmdline.txt文件

1
sudo nano /boot/cmdline.txt
参考下面内容修改:

1
dwc_otg.lpm_enable=0 console=serial1,115200  console=tty1 root=/dev/mmcblk0p2  kgdboc=serial1,115200 rootfstype=ext4 elevator=deadline fsck.repair=yes  rootwait
保存退出

关闭板载蓝牙的方法：
1.SSH登录树莓派3后，输入下面命令关闭hciuart使用uart0.

1
sudo systemctl disable hciuart
2.编辑/lib/systemd/system/hciuart.server 将 “ttyAMA0”修改为“ttyS0”

1
sudo nano /lib/systemd/system/hciuart.service
将 “ttyAMA0”修改为“ttyS0”
20160808215327347

保存退出

3.更新并重启

1
2
3
sudo apt-get update
sudo apt-get upgrade
sudo reboot
----