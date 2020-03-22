[翻译](http://ys-g.ys168.com/607340765/inkihgr2K763K4U6L49/LuCI%20%E9%85%8D%E7%BD%AE%E8%AF%B4%E6%98%8E%20v2.0.txt)

花了大半天的时候翻译过来，如果有错误请大佬们改正一下。谢谢

make menuconfig  进入定制界面
进入编译选项配置界面,.按照需要配置.( ‘\*’ 代表编入固件，‘M’ 表示编译成模块或者IPK包， ‘空’不编译 )


选择LuCI 配置（web网页管理程序）：  常用
-----------------------------------------------------------------------------------------
LuCI ---> Applications ---> luci-app-adbyby-plus   去广告
LuCI ---> Applications ---> luci-app-arpbind  IP/MAC绑定
LuCI ---> Applications ---> luci-app-autoreboot  支持计划重启
LuCI ---> Applications ---> luci-app-ddns   动态域名
LuCI ---> Applications ---> luci-app-filetransfer  文件传输
LuCI ---> Applications ---> luci-app-firewall   添加防火墙
LuCI ---> Applications ---> luci-app-frpc   FRP内网穿透
LuCI ---> Applications ---> luci-app-hd-idle  硬盘休眠
LuCI ---> Applications ---> luci-app-ipsec-server  IPSec VPN服务
LuCI ---> Applications ---> luci-app-mwan3   网络叠加
LuCI ---> Applications ---> luci-app-nlbwmon   网络带宽监视器
LuCI ---> Applications ---> luci-app-pptp-server  PPTP VPN服务
LuCI ---> Applications ---> luci-app-qos   服务质量 可选石像鬼QOS
LuCI ---> Applications ---> luci-app-ramfree  释放内存
LuCI ---> Applications ---> luci-app-samba   网络共享
LuCI ---> Applications ---> luci-app-sfe  Turbo ACC网络加速
LuCI ---> Applications ---> luci-app-ssr-plus   SSR科学上网
LuCI ---> Applications ---> luci-app-syncdial  多拨虚拟网卡(原macvlan)
LuCI ---> Applications ---> luci-app-upnp   通用即插即用
LuCI ---> Applications ---> luci-app-v2ray-pro   V2Ray透明代理
LuCI ---> Applications ---> luci-app-vlmcsd  KMS服务器设置
LuCI ---> Applications ---> luci-app-vsftpd  FTP服务
LuCI ---> Applications ---> luci-app-wifischedule  WiFi 计划
LuCI ---> Applications ---> luci-app-wol   网络唤醒
LuCI ---> Applications ---> luci-app-wrtbwmon  客户端实时流量监测
LuCI ---> Applications ---> luci-app-xlnetacc  迅雷快鸟
LuCI ---> Applications ---> luci-app-zerotier  ZeroTier内网穿透

不常用
-----------------------------------------------------------------------------------------
LuCI ---> Applications ---> luci-app-adblock   ADB广告过滤
LuCI ---> Applications ---> luci-app-adbyby   广告过滤大师
LuCI ---> Applications ---> luci-app-adkill   广告过滤
LuCI ---> Applications ---> luci-app-advanced-reboot  Linksys高级重启
LuCI ---> Applications ---> luci-app-ahcp  支持AHCPd
LuCI ---> Applications ---> luci-app-aliddns   阿里DDNS客户端
LuCI ---> Applications ---> luci-app-aria2  Aria2下载
LuCI ---> Applications ---> luci-app-asterisk  支持Asterisk
LuCI ---> Applications ---> luci-app-attendedsysupgrade  固件相关
LuCI ---> Applications ---> luci-app-bcp38  BCP38网络入口过滤(不确定)
LuCI ---> Applications ---> luci-app-bird4   Bird 4(未知)
LuCI ---> Applications ---> luci-app-bird6   Bird 6(未知)
LuCI ---> Applications ---> luci-app-bmx6  协议相关(未知)
LuCI ---> Applications ---> luci-app-bmx7  协议相关(未知)
LuCI ---> Applications ---> luci-app-cjdns  CJDNS(未知)
LuCI ---> Applications ---> luci-app-clamav  ClamAV杀毒软件
LuCI ---> Applications ---> luci-app-commands   Shell命令模块
LuCI ---> Applications ---> luci-app-cshark   CloudShark捕获工具
LuCI ---> Applications ---> luci-app-diag-core   core诊断工具
LuCI ---> Applications ---> luci-app-dnscrypt    DNSCrypt解决DNS污染
LuCI ---> Applications ---> luci-app-dump1090  民般飞行跟踪相关(不确定)
LuCI ---> Applications ---> luci-app-dynapoint  DynaPoint(未知)
LuCI ---> Applications ---> luci-app-e2guardian   Web内容过滤器
LuCI ---> Applications ---> luci-app-freifunk-diagnostics   诊断(未知)
LuCI ---> Applications ---> luci-app-freifunk-policyrouting  策略(未知)
LuCI ---> Applications ---> luci-app-freifunk-widgets  索引(未知)
LuCI ---> Applications ---> luci-app-fwknopd  Fwknop服务器
LuCI ---> Applications ---> luci-app-gfwlist   GFW域名列表
LuCI ---> Applications ---> luci-app-hnet  HNCP家庭网络控制协议(不确定)
LuCI ---> Applications ---> luci-app-lxc   LXC容器管理
LuCI ---> Applications ---> luci-app-meshwizard 网络设置向导
LuCI ---> Applications ---> luci-app-minidlna   miniDLNA共享
LuCI ---> Applications ---> luci-app-mjpg-streamer   添加视频监控
LuCI ---> Applications ---> luci-app-mmc-over-gpio   添加SD卡操作界面
LuCI ---> Applications ---> luci-app-multiwan   网络叠加 wan、pppoe多拨
LuCI ---> Applications ---> luci-app-noddos  阻止DDoS攻击
LuCI ---> Applications ---> luci-app-ntpc   NTP时间同步服务器
LuCI ---> Applications ---> luci-app-ocserv  OpenConnect VPN
LuCI ---> Applications ---> luci-app-olsr  OLSR配置和状态模块
LuCI ---> Applications ---> luci-app-olsr-services  OLSR服务器
LuCI ---> Applications ---> luci-app-olsr-viz   OLSR可视化
LuCI ---> Applications ---> luci-app-ocserv   OpenConnect VPN服务
LuCI ---> Applications ---> luci-app-openvpn  OpenVPN客户端
LuCI ---> Applications ---> luci-app-openvpn-server  OpenVPN服务器
LuCI ---> Applications ---> luci-app-oscam   OSCAM服务器
LuCI ---> Applications ---> luci-app-p910nd   打印服务器模块
LuCI ---> Applications ---> luci-app-pagekitec   Pagekite内网穿透客户端
LuCI ---> Applications ---> luci-app-polipo  Polipo代理
LuCI ---> Applications ---> luci-app-privoxy  Privoxy带过滤功能代理
LuCI ---> Applications ---> luci-app-radicale   CalDAV/CardDAV同步工具
LuCI ---> Applications ---> luci-app-redsock2   科学上网
LuCI ---> Applications ---> luci-app-rp-pppoe-server  PPPoE 服务器
LuCI ---> Applications ---> luci-app-shadowsocks-libes  SS-libev服务端
LuCI ---> Applications ---> luci-app-shairplay  支持AirPlay功能
LuCI ---> Applications ---> luci-app-siitwizard  SIIT配置向导
LuCI ---> Applications ---> luci-app-simple-adblock  简单的广告拦截
LuCI ---> Applications ---> luci-app-splash  DHCP客户端应用
LuCI ---> Applications ---> luci-app-squid   Squid代理服务器
LuCI ---> Applications ---> luci-app-shadowsocks   科学上网
LuCI ---> Applications ---> luci-app-ssrserver-python  SSR服务器-Python
LuCI ---> Applications ---> luci-app-statistics  流量监控工具
LuCI ---> Applications ---> luci-app-tinyproxy  TinyProxy 代理服务器
LuCI ---> Applications ---> luci-app-travelmate  wlan连接管理器
LuCI ---> Applications ---> luci-app-transmission   BT下载
LuCI ---> Applications ---> luci-app-udpxy  udpxy做组播服务器
LuCI ---> Applications ---> luci-app-uhttpd  uHTTPd Web服务器
LuCI ---> Applications ---> luci-app-unbound  Unbound DNS解析器
LuCI ---> Applications ---> luci-app-usb-printer   打印机TCP/IP共享服务
LuCI ---> Applications ---> luci-app-vnstat   vnStat流量查看/监测工具
LuCI ---> Applications ---> luci-app-vpnbypass  VPN Bypass Web UI
LuCI ---> Applications ---> luci-app-watchcat  断网检测功能
LuCI ---> Applications ---> luci-app-webshell  网页命令行终端
LuCI ---> Applications ---> luci-app-wireguard  WireGuard VPN服务器
LuCI ---> Applications ---> luci-app-xware3   迅雷下载（丢弃）
LuCI ---> Applications ---> luci-app-xunlei   迅雷下载（丢弃）
LuCI ---> Collections ---> luci   添加luci (web界面管理)
LuCI ---> Modules ---> Translations ---> Simplified Chinese (zh-cn) 新版本中文语言包位置
LuCI ---> Themes ---> luci-theme-bootstrap   默认主题，大家可以自行增减插件
LuCI ---> Translations ---> luci-i18n-chinese   添加luci的中文语言包
---------------------------------------------------------------------------------------------------
×
拖拽到此处
图片将完成下载