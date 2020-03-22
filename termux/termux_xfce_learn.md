# 安装xfce桌面
```sh
pkg install x11-repo
pkg install tigervnc
pkg install xfce
```
初始化vnc

```sh
vncsever
```
输入两次密码

关闭vnc服务
```sh
vncserver -kill:1
```

vnc启动xfce配置

```sh
cd .vnc
vim xstartup
```

在文件最后加一句：
```sh
startxfce4
```

输入
```sh
pkg search xfce
```

可以查看xfce的程序列表，按需添加。

例如添加终端：
```sh
pkg install xfce4-terminal
```

使用软件vncviewer进行连接。
