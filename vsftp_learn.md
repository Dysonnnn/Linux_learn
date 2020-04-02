[vsftpd本地用户登录密码错误的解决方法](https://www.jb51.net/LINUXjishu/138726.html)

  发布时间：2014-02-21 16:43:22   作者：佚名     我要评论
本文主要介绍了vsftpd本地用户登录密码错误的解决方法，大家参考使用吧
 
今天发现自己虚拟机的vsftp使用本地用户名无法登陆，于是重新配置，但配置了很多次都没成功，一直显示


530 Login incorrect.

Login failed

解决方式是将vsftp.conf中的：

pam_service_name=vsftp

修改成

pam_service_name=ftp

重启vsftpd后本地用户正常登录。


不过觉得很奇怪的是：/etc/pam.d/目录下存在名为vsftp的文件，却不存在名为ftp的文件，而配置文件反而要设置成ftp才有效。



---

[写给大忙人的centos下ftp服务器搭建（以及启动失败/XFTP客户端一直提示“用户身份验证失败”解决方法）](https://www.cnblogs.com/zhjh256/p/9155281.html)

1、安装vsftpd，yum install vsftpd

     安装完成后，可以执行which vsftpd检查是否安装成功，同时会在/etc/vsftpd下创建三个配置文件，如下：

[root@elk1 vsftpd]# ll
总用量 20
-rw-------. 1 root root 125 8月 3 2017 ftpusers             # 指定哪些用户不能访问FTP服务器,这里的用户包括root在内的一些重要用户。
-rw-------. 1 root root 361 8月 3 2017 user_list             # 指定的用户是否可以访问ftp服务器，通过vsftpd.conf文件中的userlist_deny的配置来决定配置中的用户是否可以访问，userlist_enable=YES ，userlist_deny=YES ，userlist_file=/etc/vsftpd/user_list 这三个配置允许文件中的用户访问FTP。
-rw-------. 1 root root 5135 6月 8 11:32 vsftpd.conf     # 主配置文件

     注：vsftpd虽然共享linux的用户，但是做了更加精细化二次安全防护，避免常见的脆弱性安全问题，所以如果希望让root用户访问，需要在ftpusers中注释掉root。


2、安装完成后，默认情况下，直接service vsftpd start就可以启动ftp服务，这就是最傻瓜的方式，全部是使用默认设置，但是在实际中，我们一般需要对配置进行修改满足我们的特定管理要求。比如：

指定根目录，而非默认的/pub。
指定是否启用匿名访问，允许哪些用户访问哪些目录。
设置用户是否可以创建目录，如果不存在的话。
一般来说，对于公有的ftp服务器，需要隔离不同用户的访问权限，一个公司/BU内部的话，一般一个用户，根据目录进行划分就足够，在管理和便利之间权衡。



     ----


---
https://blog.csdn.net/axdc_qa_team/article/details/6185821
ftp的log存放在/var/log/vsftpd.log， 



----

Centos下安装vsftpd，用windows连接时出错如下信息：

500 OOPS: cannot change directory:/home/test

500 OOPS: priv_sock_get_cmd

远程主机关闭连接。

如图：

错误原因：对方服务器开启了selinux，导致连接被阻断的情况。

解决方法：1） 关闭selinux: #setenforce 0

             2)设定setsebool值  
查看ftp的setsebool值：#sestatus -b| grep ftp或者#getsebool –a | grep ftp

修改值：

#setsebool -P ftpd_disable_trans 1

             #setsebool  -p ftp_home_dir  1
重启vsftpd :

#service vsftpd restart

转载于:https://blog.51cto.com/linuxjun/2154919



---?????????这几个命令都没有。


----  

https://boke.wsfnk.com/archives/75.html

ubuntu vsftpd 本地账户登陆时出错500 oops:priv_sock_get_cmd
辣条①号 2016年10月25日 Linux System 运维 2,584 0

安装完ftp后，sudo aptitude install vsftpd

安装完后登陆不上，需要更改/etc/vsftpd.conf

local_root 设置根目录，前提的都是些权限方面的东西，设置即可。

设置完后，用filezilla登陆ftp时出现错误

200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
500 OOPS: priv_sock_get_cmd
Bash
解决办法如下：

在配置文件/etc/vsftpd.conf中添加

seccomp_sandbox=NO
Bash
添加之后重启就好了

service vsftpd restart





----
https://blog.csdn.net/qq_40808344/article/details/81151951

进入selinu文件夹：
cd /etc/selinux
 
编辑其配置文件：
vim config
 
然后使SELINUX=disabled


----

[vsftp FTP服务器外网访问设置](https://www.cnblogs.com/spaceship9/archive/2013/06/27/3159243.html)

原文：

FTP协议有两种工作方式：PORT方式和PASV方式，中文意思为主动式和被动式。

Port模式：

ftp server:tcp 21 <------client:dynamic

ftp server:tcp 20 ------>client:dynamic

 

Pasv模式：

ftp server:tcp 21 <----client:dynamic

ftp server:tcp dynamic <----client:dynamic

 

PORT（主动）方式的连接过程是：客户端向服务器的FTP端口（默认是21）发送连接请求，服务器接受连接，建立一条命令链路。当需要传送数据 时，客户端在命令链路上用PORT命令告诉服务器：“我打开了XXXX端口，你过来连接我”。于是服务器从20端口向客户端的XXXX端口发送连接请求， 建立一条数据链路来传送数据。

 

PASV（被动）方式的连接过程是：客户端向服务器的FTP端口（默认是21）发送连接请求，服务器接受连接，建立一条命令链路。当需要传送数据 时，服务器在命令链路上用PASV命令告诉客户端：“我打开了XXXX端口，你过来连接我”。于是客户端向服务器的XXXX端口发送连接请求，建立一条数 据链路来传送数据。

 

linux中VSFTP无法从外网访问问题解决如下！

需要防火墙配置文件里配置端口映射

　　 202.100.0.22 -p tcp --dport 21 -j SNAT --to 172.16.0.22 

这样就可以通过外网访问到内网的21端口了

############################################

用的是filezilla的软件，看到信息栏里面出来的数据问题PASV，time out, 估计是被动方式，而笔记本是不知道服务器的已经开始的端口了。所以，应该用iptables 命令来做一下修改。

 怎么用iptables 来配置 vsftp 呢？？？？？

这里有详细的链接：http://blog.csdn.net/moreorless/article/details/5289147

 ××××××××××××××××××××××××××××××××××××××××××××××××××××××××××

关于vsftp的工作方式的开启与否。

这里有详细介绍，怎么在PORT与PASV之间转换

http://www.longsays.com/20120309/blog-4.html/comment-page-1

VSFTP如何开启PASV模式，虽然我不用FTP，但总有人喜欢用，下面我们就来详细阐述一下VSFTP如何开启PASV模式吧！

问题：装好VSFTP后，FTP不能使用，提示PASV模式失败，尝试PORT模式。

原因：iptables防火墙挡住了PASV的端口

解决：修改VSFTP配置文件，开放防火墙端口

1.打开VSFTP配置文件
1
vi /etc/vsftpd/vsftpd.conf
未尾添加：

1
2
3
4
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40080
pasv_promiscuous=YES
2.打开iptables文件
1
vi /etc/sysconfig/iptables
加入：

1
2
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 21 -j ACCEPT
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 40000:40080 -j ACCEPT
重启iptables与vsftpd，就可以使用pasv模式了。