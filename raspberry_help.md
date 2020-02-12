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

