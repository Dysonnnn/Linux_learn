openwrt编译x86镜像
原创i-derry 最后发布于2018-01-15 14:58:38 阅读数 3342  已收藏
展开
有些同学可能想学习openwrt系统，但手头又没有嵌入式板子，是编译和运行系统，然后再增加自己的功能。下面介绍如何编译openwrt系统后再虚拟机下运行。

下载openwrt最新代码 
在github上搜索openwrt，找到下载地址https://github.com/openwrt/openwrt.git

在ubuntu下执行命令克隆openwrt源码 
git clone https://github.com/openwrt/openwrt.git 
3. 
执行以下命令更新包 
./scripts/feeds update -a 
./scripts/feeds install -a 
更新package，否则luci等package通过make menuconfig 不能显示 
4.配置目标系统 
make menuconfig 
选择平台为X86 


选择vmdk目标文件格式

 
5.开启配置页面选项 
选择luci，选luci后就会有配置页面 
 
6. 开始编译

如果代码是通过root用户下载，编译会报错，通过修改用户权限后再编译，也可强制root编译 
chown derry ./ -R 
su derry

make V=99开始编译，第一次编译会比较慢，因为要下载开源包，生成在dl目录。 
7. 编译完成后会在bin目录生成vmdk文件，该文件可以直接在vmware中加载运行。 
8. 
更多wifi相关文章，微信请关注：wifi开发者，定期发布开发相关总结。 
————————————————
版权声明：本文为CSDN博主「i-derry」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/dxt1107/article/details/79064619


---

在X86平台安装运行OpenWRT https://www.jianshu.com/p/4fb1dcf8eeda

码师傅
2017.08.29 15:17:32
字数 741
阅读 11,363
OpenWRT支持很多平台，由于手边没有支持的路由器，所以通过X86平台可以方便的使用PC来安装运行以及调试OpenWRT，对于学习研究OpenWRT很有帮助，

编译
编译环境
Linux version 3.19.0-15-generic (buildd@tipua) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #15-Ubuntu SMP Thu Apr 16 23:32:01 UTC 2015
下载源码
参考：https://dev.openwrt.org/wiki/GetSource

git clone git://github.com/openwrt/openwrt.git

更新安装相关依赖库
由于openWRT依赖了很多开源的库，所以openWRT编写一个脚本用于更新和安装，在scripts目录下

@ubuntu:~/Work/OpenWRT/openwrt/scripts$ ./feeds update -a
@ubuntu:~/Work/OpenWRT/openwrt/scripts$ ./feeds install -a

编译OpenWRT会首先检查一些系统库，根据提示，如果缺少了就使用apt-get install 命令安装，一般提示缺少awk, openssl这两个库

apt-get install gawk #安装awk库

openssl比较特殊，由于版本迭代较快，代码结构有差异，版本用的不对可能导致编译失败。
根据Makefile看出这个版本是的openssl对应的是1.0.2版本, 我们直接下载编译安装1.0.2版本openssl

wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2l.tar.gz #下载
./config shared --prefix=/usr/local --openssldir=/usr/local/openssl #编译为动态库
make & make install

配置
@ubuntu: make defconfig
@ubuntu: make menuconfig

Target System 选择「X86」
Target Images 增加「Build VMware image files VMDK」选项
增加支持「Build the OpenWrt SDK」
编译
make V=99

查看输出
-rw-r--r-- 1 zhenghao zhenghao 592 Aug 29 10:55 md5sums
-rw-r--r-- 1 zhenghao zhenghao 75513842 Aug 29 10:56 OpenWrt-SDK-x86-generic_gcc-5.3.0_musl-1.1.16.Linux-i686.tar.bz2
-rw-r--r-- 1 zhenghao zhenghao 5876883 Aug 29 10:55 openwrt-x86-generic-combined-ext4.img.gz
-rw-r--r-- 1 zhenghao zhenghao 10158080 Aug 29 10:55 openwrt-x86-generic-combined-ext4.vmdk
-rw-r--r-- 1 zhenghao zhenghao 5556285 Aug 29 10:55 openwrt-x86-generic-combined-squashfs.img.gz
-rw-r--r-- 1 zhenghao zhenghao 5898240 Aug 29 10:55 openwrt-x86-generic-combined-squashfs.vmdk
-rw-r--r-- 1 zhenghao zhenghao 1781770 Aug 29 10:54 openwrt-x86-generic-generic-rootfs.tar.gz
-rw-r--r-- 1 zhenghao zhenghao 1841728 Aug 29 10:54 openwrt-x86-generic-rootfs-ext4.img.gz
-rw-r--r-- 1 zhenghao zhenghao 1474163 Aug 29 10:54 openwrt-x86-generic-rootfs-squashfs.img.gz
-rw-r--r-- 1 zhenghao zhenghao 3789312 Aug 29 10:54 openwrt-x86-generic-vmlinuz
drwxr-xr-x 10 zhenghao zhenghao 4096 Aug 29 10:56 packages
-rw-r--r-- 1 zhenghao zhenghao 997 Aug 29 10:55 sha256sums

安装
选择自定义虚拟机安装


创建虚拟机
选择操作系统 OpenWRT15.05对应的内核是3.1


选择操作系统.png
选择硬盘类型艉IDE


硬盘类型.png
将虚拟机文件夹中的vmdk文件替换为上面编译生成的openwrt-x86-generic-combined-ext4.vmdk


替换vmdk.png
加载运行，看到br-len打印就可以输入Enter进入shell交互界面了


br-lan.png
这里就是一个可以交互的终端了

---
ubuntu11.10下编译openwrt的环境配置
转载mrwangwang 最后发布于2014-09-01 11:08:04 阅读数 12928  收藏
展开
首先安装基本开发环境：
sudo apt-get install ssh vim samba tftp nfs

安装编译openwrt须要的包：

解压openwrt包编译出错：
Build dependency: Please install the GNU C++ Compiler (g++).
Build dependency: Please install ncurses. (Missing libncurses.so or ncurses.h)
Build dependency: Please install zlib. (Missing libz.so or zlib.h)
Build dependency: Please install GNU awk.  www.2cto.com  
Build dependency: Please install flex.
Build dependency: Please install patch.
Build dependency: Please install git (git-core).
Build dependency: Please install the subversion client.
 
安装编译openwrt须要的包：
sudo apt-get install  libncurses5-dev  zlib1g-dev  gawk  flex  patch   git-core g++   subversion 
 
然后直接make

 
 
作者 mutes
转自：http://www.2cto.com/os/201204/126215.html

---



----

lfs群，
考古砖家(1578656303)  0:33:55
make V=s -j1

考古砖家(1578656303)  0:34:06
可以看到每个下载的链接
考古砖家(1578656303)  0:32:47
下载的包在dl目录下

考古砖家(1578656303)  0:33:19
用其他方式下载包，复制到dl中，重新make即可

需要把当前的make停掉，复制进去，再重新开始



 make -j1 V=s      ，  j1  和j4有啥区别？
h1jacker<h1jacker@163.com>  10:45:57
线程

h1jacker<h1jacker@163.com>  10:46:03
编译的线程

h1jacker<h1jacker@163.com>  10:46:38
j1就是一线程编译j4就是4线程编译

V=s就是详细输出编译信息，跟V=99差不多

线程调低，防止他忽略过多错误。


编译：
周五晚上，笔记本i5-3337+8G，分配了1G1核给虚拟机ubuntu18.04编译openwrt x86，
最后,周六晚上11点编译完成。
```

Generating index for package ./cgi-io_19_i386_pentium4.ipk
Signing package index...
make[2]: Leaving directory '/home/dysonnnn/openwrt/openwrt'
export MAKEFLAGS= ;make -w -r checksum
make[2]: Entering directory '/home/dysonnnn/openwrt/openwrt'
make[2]: Leaving directory '/home/dysonnnn/openwrt/openwrt'
make[1]: Leaving directory '/home/dysonnnn/openwrt/openwrt'

# dysonnnn @ dysonnnn-ubuntu in ~/openwrt/openwrt on git:master x [11:06:21]
```

周六中午11点开始，在台式机r3-2200g + 16G 内的 虚拟机vbox LinuxMint 4G+2核配置，编译，晚上十点编译好了openwrt x86,编译完的文件压缩了，文件名《openwrt_x86_20020328》，；
但是lede编译失败了，还导致虚拟机崩溃了，错误ID BLKCACHE_IOERR.



----

openwrt-x86-generic-Generic-rootfs.tar.gz         
openwrt-x86-generic-combined-ext4.img.gz           
openwrt-x86-generic-combined-squashfs.img      
openwrt-x86-generic-rootfs-ext4.img.gz           
openwrt-x86-generic-rootfs-squashfs.img  


通用根文件系统
混合的（多个分区）的硬盘镜像（IMG格式）
混合的（多个分区）的硬盘的压缩只读镜像（IMG格式）
单分区的硬盘镜像（IMG格式）
单分区的硬盘压缩只读镜像（IMG格式）

----
openwrt-x86-generic-generic-squashfs-combined.vmdk
vmdk镜像打开失败，can't find valid F2FS filesystem in 2th superblock


用了openwrt-x86-generic-generic-ext4-combined.vmdk.gz这个镜像，就可以了

https://openwrt.org/docs/guide-user/installation/openwrt_x86

Combined-squashfs.img.gz该磁盘映像使用传统的OpenWrt布局，一个squashfs只读根文件系统和一个读写分区，在其中存储您安装的设置和软件包。由于此映像的组装方式，您只有230 兆MB的空间来存储其他程序包和配置，而Extroot不起作用。
Combined-ext4.img.gz该磁盘映像使用单个读写ext4分区，没有只读squashfs根文件系统，因此可以扩大分区。故障安全模式或出厂重置等功能将不可用，因为它们需要只读的squashfs分区才能起作用。



设置网络？？？？

www 要给权限。



---

3.OpenWRT如何使用SDK进行模块编译?

1.解压SDK

2.使用./script/feed update -a更新模块package

3.使用./script/feed install -a将模块与编译环境关联

4.使用make menuconfig进行模块配置.如我想要为aria2添加种子和磁力支持,勾选相应的选项保存即可

5.使用make pakcage/xxx/compile进行编译,如我要编译aria2,则使用make pakcage/aria2/compile.编译产物位于根目录下的 bin/ramips/packages/packages/即可看到编译的ipk安装包

4.安装ipk程序

将新的ipk程序上传到路由器上,使用opkg install xxxx.ipk即可.如果是替换原有的程序,也无需将原先的程序卸载,直接安装即可.

作者：MrMrLi
链接：https://www.jianshu.com/p/1eb19d82bf64
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

----