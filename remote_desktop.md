- [使用VNC远程连接ECS实例中的Ubuntu系统](http://dblab.xmu.edu.cn/blog/1998-2/)

## 在Ubuntu系统中安装VNCServer并配置
输入以下命令安装VNC，安装过程中需要输入Y来确认：
```bash
sudo apt-get install vnc4server
```
安装完成以后，请输入如下命令启动VNCServer：
```
vncserver
```
输入上述命令后，就会开始启动VNCServer，在启动过程中，会出现提示，让你输入密码，需要输入两次密码。注意，这个密码要记住，这个密码就是后面我们在本地电脑上使用VNCViewer客户端发起远程连接ECS实例中的Ubuntu系统时需要输入的密码，到了后面使用VNC连接的时候，VNCViewer客户端会弹出一个密码框，你可以输入这个密码。

vncserver启动结束后，如果能够看到 

```
New ‘iZbp1idfrdpf1c3its2hpkZ:1 (linziyu)’ desktop is iZbp1idfrdpf1c3its2hpkZ:1字样的时候，说明启动成功。
```

## gnome 桌面环境安装与配置


依次执行如下步骤完成各个组件的安装
（1）安装x－windows的基础
```bash
sudo apt-get install x-window-system-core
```
（2）安装登录管理器
```bash
sudo apt-get install gdm
```
（3）安装Ubuntu的桌面
```bash
sudo apt-get install ubuntu-desktop
```
（4）安装gnome配套软件
```bash
sudo apt-get install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```
（5）修改VNC配置文件
```bash
sudo vim ~/.vnc/xstartup
```
上面命令会使用vim编辑器打开xstartup文件，请把这个文件内容清空，把下面内容复制粘贴进去：
```bash
#!/bin/sh
# Uncomment the following two lines for normal desktop:
export XKL_XMODMAP_DISABLE=1
 unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc
unset DBUS_SESSION_BUS_ADDRESS
gnome-panel &
gnmoe-settings-daemon &
metacity &
nautilus &
gnome-terminal &
```
保存该文件并退出vim编辑器（vim编辑器的使用方法可以点击这里阅读）。
杀掉原桌面进程，输入命令（其中的:1是桌面号）：
```bash
vncserver -kill :1
```
输入以下命令生成新的会话：
```bash
vncserver :1
```
上面两条命令如果都能够成功执行，应该会在屏幕上返回类似如下的信息：
```bash
linziyu@iZbp11gznj7n26xkztu64dZ:~$ vncserver -kill :1
Killing Xvnc4 process ID 1939
linziyu@iZbp11gznj7n26xkztu64dZ:~$ vncserver :1

New 'iZbp11gznj7n26xkztu64dZ:1 (linziyu)' desktop is iZbp11gznj6m26xkztu64dZ:1

Starting applications specified in /home/linziyu/.vnc/xstartup
Log file is /home/linziyu/.vnc/iZbp11gznj6m26xkztu64dZ:1.log
```
备注：如果在某个时间，Ubuntu系统关闭以后重启，则vncserver也会被关闭，需要再次进入终端，用“vncserver :1”命令去启动vncserver。



---
端口
窗口1 ： 5901
窗口2 ： 5902


