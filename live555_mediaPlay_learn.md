本文提供两种在树莓派上搭建Live555流媒体服务器端的方法：

1）直接在树莓派上对live555进行编译

2）交叉编译之后在传到树莓派上

注：前者相当简简单，而后者只需要传最后生成的可执行文件以及想要测试的.264文件（或者其他格式视频文件）消耗树莓派的空间较少。

 

准备：

1）在 [live555官网](http://www.live555.com/liveMedia/public/)上下载最新版的live555.tar.gz（官方参考页面：http://www.live555.com/liveMedia/#config-unix ）

2）在PC端安装VLC软件。

 

 

第一种，直接在树莓派上进行编译。

1）在虚拟机上登录树莓派（方法很多，这里使用ssh登录 **ssh pi@IP_Address**）

2）把下载到的live555.tar.gz传到树莓派上（同样方法很多，FTP也好，ssh也好，这里使用后者 **scp pi@IP_Address:togglePath //”togglePath”为你指定的树莓派上的路径**）

3）在树莓派上 tar -xzvf解压之

4）cd live/

./genMakefile linux //”linux”是用户指定的编译平台，这里写”linux“就好

make

5）make过程很长，结束之后cd mediaService/ ，顺便把测试视频一起放到该目录下（这里使用的是live555官网上的.264测试视频）

6）./live555MediaServer  执行之后可以看到他给出的rtsp的IP地址和端口号

7）在PC端打开VLC，ctrl+N打开网络串流，输入是上一步得到的IP地址:端口号

 

 

第二种，交叉编译

1）在虚拟机上解压live555，打开解压后得到的文件夹里的config.armlinux

修改第一行 “CROSS_COMPILE?=”为arm-linux-

保存退出。

2）./genMakefile armlinux //这里平台指定为”armlinux”

make

3）之后就是把mediaService中的live555MediaServer  传到树莓派上，并在同一目录下放置测试视频

4）接下来就是和第一种方法的6、7步相同了。

 

注：其实live/testProgs里还有好多测试程序，比如运行./testOnDemandRTSPServer 测试视频若命名正确也可到达上面方法中的测试结果。

且可利用摄像头经RTSP播放直播。方法如下：

1）打开live/testProgs/testOnDemandRTSPServer.cpp，找到“ // A H.264 video elementary stream:”
    char const* streamName = "liv0";
    char const* inputFileName = "/tmp/pi.264";

载文件最开头，修改reuseFirstSource的值为True
 

2) 添加管道文件 mkfifo /tmp/pi.264


3) 启动RTSP服务端 ./testOnDemandRTSPServer


4) 启动摄像头raspivid -o /tmp/pi.264 -t 0 -d

 
5) 使用vlc打开串流rtsp://xx.xx.xx.xx:xxxx/liv0
————————————————
版权声明：本文为CSDN博主「Endless_N」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/u010515579/article/details/42671879