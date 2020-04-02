[如何编译自己路由器的OPENWRT固件（最新的教程）](https://www.right.com.cn/forum/thread-361119-1-1.html)
 发表于 2018-11-21 13:48 | 只看该作者 |只看大图 回帖奖励
本帖最后由 kygsmsc 于 2018-11-22 21:11 编辑


OPENWRT/LEDE编译教程

1.首先安装编译需要Linux环境，其他Linux也可以，版本较多，实机安装和虚拟机安都可以，按装步奏自行解决。


2.这里以UBUNTU最新18.04为例。按装完成后一般是英文界面要更换中文请在左下角的更多中选择Language Support 项，即为“语言支持”项，我们需要访问此项来改变界面语言。
  2.1. 选择下方的 Install/remove Languages。
  2.2. 在“支持的语言”列表中找到“Chinese（simplified）”，在右端打上勾，点击apply
  2.3. 弹出对话框，输入管理员密码。后系统自动安装中文语言库。
  2.4. 安装完成后在Language for menus and widows：中将下载好的中文(简体)按住鼠标拖拽到最上面，后点Close关闭对话窗。
  2.5. 重启系统。
  
3.更换UBUNTU的更新服务器到国内。
  3.1.更多中选择软件和更新
  3.2.选择下载自：其他站点。找到中国的服务器地址选择即可。


4.更新UBUNTU系统软件，在更多中选择“终端”输入：
  sudo apt-get update
  sudo apt-get upgrade


5.安装编译基础环境（官网资料）（对应自己的Linux版本，多选一）


Arch Linux
pacman -S --needed subversion asciidoc bash bc binutils bzip2 fastjar flex git gcc util-linux gawk intltool zlib make cdrkit ncurses openssl patch perl-extutils-makemaker rsync unzip wget gettext libxslt boost libusb bin86 sharutils b43-fwcutter findutils time


Alpine Linux 3.7
apk add asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils findutils flex g++ gawk gcc gettext git grep intltool libxslt linux-headers make ncurses-dev patch perl python2-dev tar unzip  util-linux wget zlib-dev


Debian 7 Wheezy
apt-get install libncurses5-dev zlib1g-dev gawk


Debian 8 Jessie
sudo apt-get install build-essential libncurses5-dev gawk git subversion libssl-dev gettext unzip zlib1g-dev file python


Debian 9.4 Stretch
sudo apt install build-essential libncurses5-dev gawk git subversion libssl-dev gettext zlib1g-dev swig unzip time


Fedora 24
dnf install subversion binutils bzip2 gcc gcc-c++ gawk gettext git-core flex ncurses-devel ncurses-compat-libs zlib-devel zlib-static make patch unzip perl-ExtUtils-MakeMaker perl-Thread-Queue \
glibc glibc-devel glibc-static quilt sed sdcc intltool sharutils bison wget openssl-devel


Fedora 26
dnf install @c-development @development-tools @development-libs zlib-static which bzip2 file wget


openSUSE 13.2
zypper install asciidoc bash bc binutils bzip2 fastjar flex git-core gcc-c++ gcc util-linux gawk gtk2-devel intltool jikes zlib-devel mercurial make genisoimage ncurses-devel libopenssl-devel patch perl-ExtUtils-MakeMaker python-devel rsync ruby sdcc unzip wget gettext-tools libxslt-tools zlib-devel subversion


openSUSE 42.3
zypper install patterns-openSUSE-devel_basis zlib-devel-static git-core


Ubuntu 12.04 LTS
sudo apt-get install build-essential subversion git-core libncurses5-dev zlib1g-dev gawk flex quilt libssl-dev xsltproc libxml-parser-perl mercurial bzr ecj cvs unzip


Ubuntu, Kubuntu 17.10
sudo apt-get install build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev


Centos x86-64 (some packages require EPEL)
yum install subversion binutils bzip2 gcc gcc-c++ gawk gettext flex ncurses-devel zlib-devel zlib-static make patch unzip perl-ExtUtils-MakeMaker glibc glibc-devel glibc-static quilt ncurses-libs sed sdcc intltool sharutils bison wget git-core openssl-devel xz


Gentoo
$ echo \
    app-arch/{bzip2,fastjar,sharutils,unzip,zip} \
    app-text/asciidoc dev-java/{icedtea:7,jikes,oracle-jdk-bin} \
    dev-libs/{libusb-compat,libxslt,openssl} dev-util/intltool \
    dev-vcs/{git,mercurial} net-misc/{rsync,wget} \
    net-wireless/b43-fwcutter sys-apps/{gawk,util-linux} \
    sys-devel/{bc,bin86,binutils,dev86,flex,gcc[gcj],gettext} \
    sys-libs/{ncurses,zlib} virtual/{cdrtools,perl-ExtUtils-MakeMaker} \
    x11-libs/gtk+:2 \
        | sed 's/\s/\n/g' \
            | sort \
                | sudo tee /etc/portage/sets/openwrt-prerequisites \
                    && sudo emerge -DuvNa '@openwrt-prerequisites'


自己对应安装的Linux版本，从上面找到对应的命更新编译环境。


6.下载OPENWRT/LEDE源码
  mkdir lede             #新建一个目录
  sudo chmod 777 lede        #修改权限（重要）
  cd lede                #进入目录
  git clone  https://git.openwrt.org/openwrt/openwrt.git #openwet最新源码包地址
  git clone  https://git.lede-project.org/source.git      #LEDE最新源码包地址（2018年openwrt和LEDE合并后会自动跳转到OPENWRT的源码地址上）（和上一命令二选一）


7.源码下载完成后，选择用OPENWRT编译还是用LEDE编译。


  用 LEDE 17.01编译时输入以下命令后回车:
  git checkout lede-17.01


  用 OpenWrt 18.06编译时输入以下命令后回车:
  git checkout openwrt-18.06


  用以上命令时请注意对应的目录，一般是在SOURCE目录下。


8.更新源码中的软件。
  在源码目录下执行如：cd source    #进入源码的主目录
    ./scripts/feeds update -a      #下载最新软件
    ./scripts/feeds install -a     #把下载完的新软件进行安装


以上完成后，就可以编译你自已的OPENWRT/LEDE固件了。说明一下，我是在home根目录下自己建了个LEDE的目录，用的也是LEDE的源码地址，系统在下载LEDE源码是自动跳转到openwrt源码的下载地址了，并自动在我建的LEDE目录下生成了source目录，所有源码也下载到了source目录下了，特此说明一下，避免小白们看不懂。
注：以上步奏基本都可以国内完成（如有完成不了同样是下面的原因），下面的步奏就要求能访问国外的网络下进行。所以在国内一定要用梯子，也就是要--翻----墙--，这个在国内一般是不被允许的，所以自行想办法（要是无法完成，你是编译不了自已的固件的）。


9.测试一下编译环境是不是正常： make  defconfig （也可不作这步，只要是按上面一步步来的一般不会有问题）


10.开始自己固件的编译
   源码主目录下输入：
    make menuconfig     #运行编译软件的功能配置）


    编译界面打开了（哈哈全是英文）
    简单说一下，没有说的可以不管。（以后有时间详细给大家说下怎么选择，所有的工能基本都能实现如：USB设备挂载、打印机网络共享、广告屏蔽、网络下载、多次拨号叠加、---翻---墙--等）


操作方法：上下键：移动选标  左右键：移动编辑界面下边的功能选标（如：Exit退出、Help帮助、Save保存、load加载） 回车键：进入  ESC键双击：返回上一级  空格键：选择（*是编译时加入此功能和对应文件，M是编译时只是显示没有对文件）




Target System (Broadcom BCM63xx)  --->                                #选择你要需要生成那种CPU的固件


Target Profile (Alcatel RG100A)  --->                                        #固件界面显示的型号（如：阿尔卡特rg100a）——>


LuCI  --->                                                                           #界面工能添加——>
         1.Collections                                                             #web界面样式
                      你随便选一个就行，多选也可但是会加大固件的体积。
         2.Modules   --->Translations   --->Chinses (zh-cn)          #web界面加入中文，只选这一个，多选也可但是会加大固件体积
         3.Applications                                                           #web界面里有的功能
                      luci-app-qos                                                #qos限速
保存退出。


11.最后生成刷机用的BIN固件（三选一）

   make V=99          #生成固件并显示成生的每一个步奏及正确性。速度最慢，建议首次生成时使用（3小时左右）。


   make V=s           #生成固件忽略不影响固件主功能的错误


   make -j4 V=s       #调用CPU全部性能来生成固件，相对速度最快，但首次生成时不建议使用。


等完成后，会在openwrt源码主目录下有一个BIN目录，在BIN目录下边多级目录下找你的BIN刷机文件吧。详细的就不叙述了。
所有要输入的命令都用红色标注了，蓝色是要注意的提示信息，水平有限，如有错误和不足欢迎指正。有些网友说OPENWRT老是生成不成功，原因有两个，一个是你的编译环境有问题，系统支持的软件不是最新的，二一个是---翻--墙--或梯子有问题有些地址不通，导致下载下来的软件不全。也有可能你用的教程太老，有些软件下载地址失效了。用我的试试，一定成功，这是最新的。




----


[新手折腾进阶篇---------openwrt编译入门（绝对详细版）](https://www.right.com.cn/forum/thread-324501-1-1.html)