# [openwrt编译笔记，有些技巧是自己试验出来的，很多人死也不肯说](https://www.right.com.cn/forum/thread-469400-1-1.html)

本帖最后由 wulishui 于 2019-11-1 09:01 编辑


首先说一下几个坑：
1.依赖libelf-dev，他们所有人的教程都没有libelf-dev这个（或者我记错了），当编译过程中盯着屏幕到中间时段会提示缺少依赖libelf-dev，跳过了某些模块的编译。编译出来的固件依然可用，但不知有什么问题。
2.root分区，千万别设成128，256，512，1024这类死亡数值，反正不要设，会害死人。
3.他们说的在编译前文件“设权限”，你们肯定不懂。起初我也不懂，后来摸索出来了：（其实在makefile里面也可以通过命令行设，只是动一下鼠标就好，何必写命令）
普通权限（无执行权限，在WINSCP显示为，rw-r-r，即0644）：在ubuntu里，选择文件，右键菜单，在权限设置里依次选择：读写、只读、只读，并把“可作为程序运行”的选择框里所有可见的东西去掉。这样编译出来就是0644.
执行权限（在WINSCP显示为，rwxr-xr-x，即0755）：在权限设置里依次选择：读写、只读、只读，并把“可作为程序运行”的选择框变成√。这样编译出来就是0755.二进制、sh、init.d里的启动文件都要设0755，不然无权限运行。在windows上复制进ubuntu里的文件，基本上权限都是离奇古怪的。可是先在windows上用winrar压缩成zip再复制进去然后解压，权限就会好好的变成0644。
4.更改了某些package配置文件编译出来就是没改变？去make_dir搜索，把这文件夹移到回收站再编译（最好不要直接删除，不然删除了二进制文件你会被害死）。如果你直接删除了掉进坑了，编译过程中提示无某二进制文件，死也进行不了怎么办？妹的，删了特么就死也不重新编译了！怎么办？最傻的办法是make clean（我试过N次才知道这个办法乃下下策，要耗费大量时间重新编译），事实上只需要menuconfig里去掉这个package编译一次（只需要几分钟），然后又选上再编译就行了。make clean了可是得几个钟啊（你选了qbittorent的话你会生不如死）。。。（应该还有更好的办法，很明显是某缓存文件的问题，但我不知道）
5.编译过程中最好不要ctrl+c终止，不然有时候你得到的结果就是make clean吧（因为某个还没完成的半拉子模块，下一次会被认为已完成，造成死也进行不下去了）！一旦开始编译，死也要进行到底。或者还有一个办法，同上面第4，去make dir删除，但问题是，往往它只是报错，并不告诉你是哪个模块错误。。。


------------------这里附上我自己编译的X86固件https://www.right.com.cn/forum/thread-458183-1-1.html-----------------
系统更新      sudo apt-get update
安装依赖关系  sudo apt-get install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils libelf-dev
下载源码      git clone https://www.github.com/openwrt/openwrt
进入目录：    cd openwrt
更新源：      ./scripts/feeds update -a
安装源：      ./scripts/feeds install -a
打开配置：    make menuconfig
打开内核配置：make kernel_menuconfig（一定要在file systems的Native language support设置好，不然网络共享文件名乱码）
开工          make -j1 V=s  （-jn的n为电脑cpu的进程数）

非第一次编译
cd openwrt
git pull
./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf ./tmp && rm -rf .config
make menuconfig
make kernel_menuconfig
make -j2 V=s

没关闭终端的情况下简化为
rm -rf ./tmp
make menuconfig
make -j2 V=s

------------------------------------------------------------------------------
git clone https://github.com/coolsnowwolf/lede          ----------lean的
git clone https://github.com/981213/openwrt             ----------981213的
git clone https://github.com/ericpaulbishop/gargoyle    ----------石像鬼的
git clone https://github.com/rosywrt/rosywrt            ----------Rosy的
git clone https://git.openwrt.org/openwrt/openwrt.git   ----------官方的
git clone https://www.github.com/openwrt/openwrt        ----------官方的

想要18.06或其他老版本的，直接网页打开上面官方地址选18.06.2，下载压缩包来解压就可以了（以后不能用git pull命令，因为不是主支，需要git pull就要进行下面繁琐操作）：
以V18.06.2为例：
git clone https://www.github.com/openwrt/openwrt
git branch -a              ----查看分支（如果直达18.06.2，这条和下面tag命令不需要）
git tag                    ----查看版本
git checkout v18.06.2      ----签出V18.06.2
git pull origin v18.06.2   ----更新V18.06.2
./scripts/feeds update -a && ./scripts/feeds install -a
想要生成支持UEFI的映像文件，则还需要加上下面命令（来源于https://openwrt.org/docs/guide-developer/uefi-bootable-image）：
git remote add jow-staging https://git.openwrt.org/openwrt/staging/jow.git
git fetch jow-staging
git checkout -b uefi-capable --track origin/master # so that you can rebase easily
git merge jow-staging
-----------
make kernel_menuconfig
加入x86的多核心以及大内存支持
Processor type and features  --->
    Symmetric multi-processing support
    Processor family (Core 2/newer Xeon)  --->#自行选择处理器平*
    Supported processor vendors  --->#自行选择处理器平*
    (2) Maximum number of CPUs #自行编辑
    SMT (Hyperthreading) scheduler support#超线程支持
    Multi-core scheduler support 
    High Memory Support (64GB)  --->

更改软件源：
customfeeds.conf自定义源配置文件（在files大法改即可，文件在etc/opkg下）
科大的
src/gz openwrt_core http://openwrt.proxy.ustclug.org ... ets/x86/64/packages
src/gz openwrt_base http://openwrt.proxy.ustclug.org/snapshots/packages/x86_64/base
src/gz openwrt_luci http://openwrt.proxy.ustclug.org/snapshots/packages/x86_64/luci
src/gz openwrt_packages http://openwrt.proxy.ustclug.org ... ges/x86_64/packages
src/gz openwrt_routing http://openwrt.proxy.ustclug.org ... ages/x86_64/routing

distfeeds.conf 官方源配置文件（在files大法改即可）
官方的
src/gz openwrt_core http://downloads.openwrt.org/snapshots/targets/x86/64/packages
src/gz openwrt_base http://downloads.openwrt.org/snapshots/packages/x86_64/base
src/gz openwrt_luci http://downloads.openwrt.org/snapshots/packages/x86_64/luci
src/gz openwrt_packages http://downloads.openwrt.org/snapshots/packages/x86_64/packages
src/gz openwrt_routing http://downloads.openwrt.org/snapshots/packages/x86_64/routing
src/gz openwrt_telephony http://downloads.openwrt.org/snapshots/packages/x86_64/telephony


源问题下载不了模块中途编译终止没问题，按上箭头键重新输入上一个命令重来。
所有东西都乱了，无药可救了怎么办？移出/openwrt/的dl文件夹，然后把整个openwrt删除，再git clone一次，把dl移入，重新来过，可以节省很多下载模块时间。或者执行下面命令。
make clean     仅仅是清除之前编译的可执行文件及配置文件，比如bin路径下面的文件，config配置文件不会清除。
make distclean 清除所有生成的文件，连feeds也会干掉，只留下git clone完成时候的初始状态。

技巧
1：连移动卡的手机热点下载模块要比电信宽带快得多哦！！！！！！

2：files大法，不用去修改源码就可以自定义配置固化到固件中，比如要经常刷固件、做ramdisk版，不用每次都升级备份文件。
刷第一次安装配置好APP等。用scp进入根目录，把整个etc目录搬下来。
在openwrt目录建立file目录。把etc放进去，然后进etc翻看，有用的留下，没用的删除，ok！编译好之后大部分配置都在。
如果你只是在自己主板上用，什么都可以留下。如果你要发给人家或者换机型，则里面所有有MAC地址、UUID识别码或者其它固定硬件识
别码的文件都得删掉（比如wireless就有MAC地址），不然会产生灵异事件。

3：单独编译某个模块比如v2瑞，要先在make menuconfig里面luci app相应的v2瑞-pro打上M
make package/lean/luci-app-v2瑞-pro/compile

4：碰到一个玩意硬是wget不了怎么办？把出错提示的地址复制下来，用浏览器，迅雷，什么都行，下载好扔进dl目录（如果不是dl目录的有提示，并且此方法无效）
比如这个变态的kcptun-linux-amd64-20181002.tar.gz，问了度娘之后在下面地址找到。
https://github.com/xtaci/kcptun/releases


-------------------------------------------------------------------------------
源更新不了，opkg被神经病锁定不能安装app，删除/var/lock/opkg.lock

自己替换“总览”页面
/feeds/luci/modules/luci-mod-status/luasrc/view/admin_status/index.htm

压缩虚拟盘
cd C:\Program Files (x86)\VMware\VMware Workstation
vmware-vdiskmanager.exe -k "G:\Ubuntu\Ubuntu 64 位.vmdk"

-------------------------------------------------------------------------------
1）修改登录密码（可以用files大法，文件在/etc下的shadow，在“管理权”设置好密码，直接SCP备份shadow文件，以下各项同样方法配制）
修改shadow文件，位于package/base-files/files/etc 
root1$BuM.Ox4e$X/RX2ftRaBzzVzoL6TkI0/:17943:0:99999:7:::    ----------------root后面的两个root：：17943之间一串乱码就是加密后的密码（需要在“管理权”设置好SCP上去打开复制下来，不能直接填入明文），此处示例为admin。
----
2）修改路由连接数（可以用files大法，文件在ect下的sysctl.conf）
修改sysctl.conf文件，位于package/base-files/files/etc
net.netfilter.nf_conntrack_max=262144

----
3）默认中文feeds/luci/libs/web/root/etc/config

1
option（可以用files大法，其实不用管，只要时区改了并且添加了中文luci，会自动使用中文）
lang auto
改为

1
option lang zh_cn

并添加          
config internal languages

        option en 'English'

        option zh_cn 'chinese'

----
4）修改默认主题（用files大法无效）
修改feeds/luci/libs/web/root/etc/config
option mediaurlbase /luci-static/openwrt.org
可根据需要将openwrt.org修改为Bootstap、openwrtcn、freifunk-bno、freifunk-generic

----
5）修改主机名、设定时区（可以用files大法，文件在/etc/config下的system）
修改package/base-files/files/etc/config/system
option hostname Openwrt      ----------主机名
option timezone Asia/Shanghai----------时区设置为亚洲/上海
option timezone CST-8        ----------正8区

----
6）默认lan ip地址配置（本机使用可以用files大法，在ect下面找同名文件）
package/base-files/files/bin/config_generate搜索192.168定位到下面字段配置。
set network.$1.ipaddr='192.168.1.1'
set network.$1.netmask='255.255.255.0'

----
7）更改openwrt后台web登陆用户名方法
1.修改/etc/passwd
将root:x:0:0:root:/root:/bin/ash修改为username:x:0:0:root:/root:/bin/ash。

2.修改/etc/shadow
将root:xxxxxx:0:0:99999:7:::修改为username:xxxxxx:0:0:99999:7:::。

3.修改/usr/lib/lua/luci/controller/admin/index.lua
将page.sysauth = {“root”}修改为page.sysauth = {“username”}。

4.修改/usr/lib/lua/luci/controller/admin/servicectl.lua
将entry({“servicectl”}, alias(“servicectl”, “status”)).sysauth = {“root”}修改为entry({“servicectl”}, alias(“servicectl”, “status”)).sysauth = {“username”}。

----
默认wifi系列（本机使用可以用files大法，文件是etc/config下wireless）
修改的文件为 /trunk/package/kernel/mac80211/files/lib/wifi
set wireless.radio${devidx}=wifi-device
set wireless.radio${devidx}.type=mac80211
set wireless.radio${devidx}.channel=1   -------指定频道
set wireless.radio${devidx}.hwmode=11g  -------指定11g模式
set wireless.radio${devidx}.country=CN  -------指定国家
set wireless.radio${devidx}.htmode=HT40 -------40MHz带宽（单改无效，还需要改上面iw phy "$dev" info | grep -q 'Capabilities:' && htmode=HT40）
set wireless.radio${devidx}.legacy_rates=1
set wireless.radio${devidx}.noscan=1    -------强制40MHz带宽（默认无，需要添加）
${dev_id}
${ht_capab}
set wireless.radio${devidx}.disabled=0  --------改为0默认开无线

set wireless.default_radio${devidx}=wifi-iface
set wireless.default_radio${devidx}.device=radio${devidx}
set wireless.default_radio${devidx}.network=lan
set wireless.default_radio${devidx}.mode=ap
set wireless.default_radio${devidx}.ssid=IOU              ---------指定SSID
set wireless.default_radio${devidx}.encryption=psk2+ccmp  ---------指定加密模式
set wireless.default_radio${devidx}.key=13143344          ---------指定密码（默认无，需要添加）

----
8）整理web管理上面APP出现的菜单位置
比如把一个出现在“服务”菜单里的app改到“网络”里，以NFT-QOS为例：
进入package下面的luci-app-nft-qos/controller,看到nft-qos.lua文件，打开看到：
entry({"admin", "services", "nft-qos"}, cbi("nft-qos/nft-qos"),
上面的"services"就是“服务”，修改为"network",这个app就会改变到“网络”菜单里了。

----
我要出去工作了，没时间玩了，最后给你们一个东西，这个东西来源于lean(抱歉，我拿来用了），可以编译时加载默认设置和加一些额外的翻译词组。我精简了一些官方源码用不到的项，只留下上面说到那些基本设置，然后加上了一些我自己需要的设置项。解压后放到package下面，然后在make menuconfig/luci里打开default settings这个选项就可以了，上面提到的大部分设置都可以在这package的files/zzz-default-settings里面修改的，不用再一个个model去修改，自己研究吧。
  default-settings.rar (26.76 KB, 下载次数: 171)   增加了一些项的default-settings.tar.xz.zip (21.91 KB, 下载次数: 161) 
  

20191009补充：
8）整理web管理上面APP出现的菜单位置
比如把一个出现在“服务”菜单里的app改到“网络”里，以NFT-QOS为例：
进入package下面的luci-app-nft-qos/controller,看到nft-qos.lua文件，打开看到：
entry({"admin", "services", "nft-qos"}, cbi("nft-qos/nft-qos"),
上面的"services"就是“服务”，修改为"network",这个app就会改变到“网络”菜单里了。
--------------某些比较复杂关系的app只修改这一处会无法运行，是因为多个函数使用了这个路径，需要一一修改。luasrc下面所有文件都要打开查找一遍，凡是存在“services”这个一路径的（或者是admin/services/xxx这样的路径的），通通需要替换成“network”才算完成。
lean的defaultsetting有这些lua重分配命令，但是同样存在上面的问题，所以必须从源码本身去修改。
