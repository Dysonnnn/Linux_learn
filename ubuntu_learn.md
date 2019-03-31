
**Ubuntu系统桌面任务栏和启动器全部消失**??????


**解决办法：**

Ctrl+Alt+F1 进入命令行，输入:

sudo service lightdm restart 重启lightdm

如果不行的话就重装Unity，依次输入：

sudo apt-get update

sudo apt-get install --reinstall ubuntu-desktop  # 这个没执行

sudo apt-get install unity

systemctl daemon-reload

sudo service lightdm start

-- [001](https://blog.csdn.net/u014797226/article/details/80249956) 

这样就好了   右键没有终端，快捷键吧。


---


第一步：按下Ctrl+Alt+T来唤醒终端，如果你没法唤醒终端，那么只能Ctrl+Alt+F1进入命令行模式了，然后login。
第二步：安装compizconfig-settings-manager。

    命令行输入：sudo apt-get install compizconfig-settings-manager

第三步：运行compizconfig-settings-manager软件

    DISPLAY=:0 ccsm

!!! no module named 'pygtk'
>The libraries are not in the PYTHONPATH. I'd try:
```bash
$ export PYTHONPATH=/usr/local/lib/python2.7/site-packages
# https://stackoverflow.com/questions/12510716/no-module-named-gtk 
```

- 将python2.7 设置为默认的python就可以了


第四步：如果第一步是进入了命令行模式，这里需要返回到图形界面，按下Ctrl+Alt+F7或者F8。

第五步：找到buntu Unity plugin，然后开启它！ 



- 找不到。。。。
（ps ： 我照这个这个教程的时候并没有 Ubuntu unity plugin 于是我直接

dconf reset -f /org/compiz/

-+------ cannot autolauch D-BUS without dirs ？？？


unity –reset-icons &disown

也没反应。




[002](https://blog.csdn.net/m0_38015368/article/details/76641521)

开机启动，log说找不到/usr/bin/python3 ？
试下搞个快捷方式到那里。

又报错了。不能随便改 /usr/bin 下的python啊。？


**修改之后各种报错。。。。不修改了，恢复原状了。**

**python3.6 的命令是python36  pip3.6 pip36**

---

右键没有终端？？？

sudo apt install gnome-terminal

没有gedit？？？

sudo apt install gedit





----

空间不够。，。

vbox新增虚拟磁盘，记住磁盘号，例如 /dev/sdb

格式化分区
如果想将/dev/sdX3格式化成ext4
```
$ sudo mkfs.ext4 /dev/sdb
```

挂载分区
将根分区 挂载 到/vdisk，例如：
```
$ sudo mkdir /vdisk
$ sudo mount /dev/sdb /vdisk
```

参考：[Linux系统使用GPT分区表方案推荐](https://blog.csdn.net/rbpicsdn/article/details/86603345)


自动挂载
1. 修改fstab文件。在终端输入
```bash
sudo vim /etc/fstab。
```
2. 在文件中添加如下行

/dev/sdb /disk2 ext4 defaults 0 1

3. 保存退出。

[【Linux】virtualbox下ubuntu虚拟机重新挂载一个硬盘](https://blog.csdn.net/heiheiya/article/details/80885719)







----



修改DNS

通过/etc/network/interfaces，在它的最后增加一句：

dns-nameservers 8.8.8.8     