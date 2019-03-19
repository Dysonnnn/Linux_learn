
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
