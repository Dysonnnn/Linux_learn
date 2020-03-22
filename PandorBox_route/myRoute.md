
旧版本  PandoraBox 16.02 r2075 / LuCI
---
主机名	PandoraBox
主机型号	Phicomm K1
固件版本	PandoraBox 16.02 r2075 / LuCI (git-16.034.33370-8e126a8)
内核版本	3.10.96
---
无可用软件列表 空闲空间: 86% (1.68 MB)

安装iptables 、 luci-aria2 之后：
```
[root@PandoraBox:/etc]#df -h
Filesystem                Size      Used Available Use% Mounted on
rootfs                    1.9M      1.9M     68.0K  97% /
/dev/root                 4.8M      4.8M         0 100% /rom
tmpfs                    30.1M      1.0M     29.1M   3% /tmp
/dev/mtdblock7            1.9M      1.9M     68.0K  97% /overlay
overlayfs:/overlay        1.9M      1.9M     68.0K  97% /
tmpfs                   512.0K         0    512.0K   0% /dev
```

### 软件更新源
``` sh
src/gz 16.02_base http://downloads.pandorabox.com.cn/pandorabox/packages/mt7620/packages/base
src/gz 16.02_packages http://downloads.pandorabox.com.cn/pandorabox/packages/mt7620/packages/packages

```


opkg update失败

在管理界面--系统--软件包--自定义的软件源
新增这个：
http://downloads.openwrt.org.cn/PandoraBox/ralink/mt7620_old/packages/

http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/base/
http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/packages/

[pandoraBox 网站](http://downloads.openwrt.org.cn/PandoraBox/)


更改后出错：
```
Form token mismatch
The submitted security token is invalid or already expired!
```

直接在原有配置去修改链接。
改为

``` sh
src/gz 16.02_base http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/base
src/gz 16.02_packages http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/packages

```
然后就更新了软件列表了。。


更新了 19.01版本
H:\Downloads\PandoraBox-ralink-mt7620-phicomm-k1-squashfs-sysupgrade-r2075-20160203.bin 

新版本 PandoraBox 19.01 
---
主机名	PandoraBox
设备型号	Phicomm K1
固件版本	PandoraBox 19.01 2018-12-31-git-4b6a3d5ca / LuCI Master (git-18.364.80006-87f648f)
内核版本	3.14.79
本地时间	Sun Mar 22 13:55:12 2020
运行时间	2h 37m 18s
平均负载	0.04, 0.06, 0.05
---

系统信息
```sh
[root@PandoraBox:/root]#df -h
Filesystem                Size      Used Available Use% Mounted on
rootfs                    1.2M    284.0K    932.0K  23% /
/dev/root                 5.0M      5.0M         0 100% /rom
tmpfs                    29.4M         0     29.4M   0% /sys/fs/cgroup
tmpfs                    29.4M    736.0K     28.7M   2% /tmp
/dev/mtdblock7            1.2M    284.0K    932.0K  23% /overlay
overlayfs:/overlay        1.2M    284.0K    932.0K  23% /
tmpfs                   512.0K         0    512.0K   0% /dev
[root@PandoraBox:/root]#free -h
             total       used       free     shared    buffers     cached
Mem:         60204      48224      11980          0       4936      12852
-/+ buffers/cache:      30436      29768
Swap:            0          0          0
[root@PandoraBox:/root]#

[root@PandoraBox:/root]#cat /proc/cpuinfo 
system type		: MediaTek MT7620
machine			: Phicomm K1
processor		: 0
cpu model		: MIPS 24KEc V5.0
BogoMIPS		: 385.02
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa			: mips1 mips2 mips32r2
ASEs implemented	: mips16 dsp
shadow register sets	: 1
kscratch registers	: 0
core			: 0
VCED exceptions		: not available
VCEI exceptions		: not available

```


openwrt会自动分配一半的内存做为tmpfs


802.11h涉及两种技术，一种是动态频率选择 （DFS），它用于检测在一个信道上有其他信号出现，当这样的信号被检测到时，就会自动将网络转移到另一个信道。另一种技术是传输功率控制（TPC），它主要是减少网络传输的无线频率输出功率，使系统间干扰最小，而且还可以达到更好的网络性能。


手机wif设置
网络前缀长度：24 对应 子网掩码：255.255.255.0（二进制：11111111.11111111.11111111.0)
网络前缀长度：18 对应 子网掩码：255.255.240.0（二进制：11111111.11111111.11110000.0)
网络前缀长度：16 对应 子网掩码：255.255.0.0（二进制：11111111.11111111.0.0)




我现在是两台路由器，路由器A接了网线，路由器B的WAN口接了路由器A的LAN口


如何关闭潘多拉固件的dhcp？
设置--网络--lan，修改

为什么路由器自身无法ping 百度，但是其他设备能上网的？
子路由的WAN口接到了主路由的LAN口，为啥路由器不能上网，连到路由器wifi的设备却能上网的？
答：
主路由器的ip地址是192.168.1.1，（子路由的ip地址也是192.168.1.1）
其他设备获取到的ip地址都是主路由分配的，子路由只是转发了。

现在修改：
子路由ip地址为192.168.1.2
子路由的LAN口和主路由的LAN口连接。



配置ssh：
系统--管理--
不要指定 LAN或者WAN，要选择 “未指定”
/etc/config/dropbear    SSH服务端选项

查看本地端口
```
[root@PandoraBox:/root]#netstat -antp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:18017           0.0.0.0:*               LISTEN      3693/detect_interne
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      3838/uhttpd
tcp        0      0 192.168.1.1:22          0.0.0.0:*               LISTEN      2308/dropbear
tcp        0      0 :::5000                 :::*                    LISTEN      24237/miniupnpd
tcp        0      0 :::80                   :::*                    LISTEN      3838/uhttpd
tcp        0      0 :::23                   :::*                    LISTEN      2368/telnetd
tcp        0    448 ::ffff:192.168.1.2:23   ::ffff:192.168.1.111:13939 ESTABLISHED 2368/telnetd
```


配置DNS：
网络- 接口--点击lan或者wan， 使用自定义的DNS服务器。



在网络--主机名，可以自定义绑定主机名和ip地址。



配置文件
```
openwrt 配置文件功能简介
配置文件

文件位置 描述
基本配置

复制代码
/etc/config/dhcp    dnsmasq和DHCP的配置
/etc/config/dropbear    SSH服务端选项
/etc/config/firewall    中央防火墙配置
/etc/config/network 交换，接口和路由配置
/etc/config/system  杂项与系统配置
/etc/config/timeserver  rdate的时间服务器列表
/etc/config/wireless    无线设置和无线网络的定义
/etc/config/etherwake   以太网唤醒: etherwake
/etc/config/fstab   挂载点及swap
/etc/config/hd-idle 另一个可选的硬盘空闲休眠进程(需要路由器支持usb硬盘)
/etc/config/httpd   网页服务器配置选项(Busybox 自带httpd, 已被舍弃)
/etc/config/luci    基础 LuCI 配置
/etc/config/luci_statistics 包统计配置
/etc/config/mini_snmpd  mini_snmpd 配置
/etc/config/mountd  OpenWrt 自动挂载进程(类似autofs)
/etc/config/multiwan    简单多WAN出口配置
/etc/config/ntpclient   ntp客户端配置，用以获取正确时间
/etc/config/pure-ftpd   Pure-FTPd 服务端配置
/etc/config/qos QoS配置(流量限制与整形)
/etc/config/samba   samba配置(Microsoft文件共享)
/etc/config/snmpd   SNMPd(snmp服务进程) 配置
/etc/config/sshtunnel   sshtunnel配置
/etc/config/stund   STUN 服务端配置
/etc/config/transmission    BitTorrent配置
/etc/config/uhttpd  Web服务器配置(uHTTPd)
/etc/config/upnpd   miniupnpd UPnP服务器配置
/etc/config/ushare  uShare UPnP 服务器配置
/etc/config/vblade  vblade 用户空间AOE(ATA over Ethernet)配置
/etc/config/vnstat  vnstat 下载器配置
/etc/config/wifitoogle  使用按钮来开关WiFi的脚本
/etc/config/wol Wake-on-Lan: wol
/etc/config/znc ZNC 配置
本文章由http://www.wifidog.pro/2015/08/05/openwrt%E9%85%8D%E7%BD%AE.html整理编辑，转载请注明出处
```



旁路由（192.168.1.2 斐讯k1） 的WAN连接 主路由（192.168.1.1）的LAN；
然后又可以上网了。


当旁路由的LAN连接 主路由的LAN，有线能上网WiFi不能
当旁路由的WAN连接 主路由的LAN，设备都能上网，旁路由不能联网。




---
撤掉水星路由器，改用斐讯k1路由器作为主路由，ip:192.168.1.1


dns过滤广告：
设置
网络--DHCP/DNS-- DNS转发，只能填ip地址

设置Turbo ACC网络加速
-- 开启DNS加速