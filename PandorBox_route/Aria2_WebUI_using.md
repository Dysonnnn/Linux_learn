[Aaia2 WebUI使用方法:](http://ys-g.ys168.com/607340765/inkihgr2K763K4U6L47/Aaia2%20WebUI%E4%BD%BF%E7%94%A8%E6%96%B9%E6%B3%95.txt)

1, 下载群里的aria-ng-0.3.0.zip或者官网下载:  https://github.com/mayswind/AriaNg/releases;

2，群晖web文件夹中新建一个aria2子文件夹，将下载的aria-ng-0.3.0.zip解压到aria2文件夹根目录;

3，访问你的  http://你的域名/aria2  或  https://你的域名/aria2  试试看能否打开;



如果你的环境是http，那么直接应该就可以打开了。如果是https，可能需要安装证书。
顺便也把如何添加token跟证书的教程也写一下吧。










我aria2是用docker镜像的，配置文件路径  docker/aria2/config/aria2.conf 



1. 添加token



在aria2.conf 配置文件中添加下面这条命令,xxxxxx就是token。

rpc-secret=xxxxxx








2. 为aria2增加 ssl 证书，使得https方式也可以访问；


同样的在aria2.conf 配置文件中添加下面命令：

比如我的就是这样设置的：
证书文件改名：certificate.pem, certificate.key, 放在 docker/aria2/config 里面，然后aria2.conf添加下面的内容。

rpc-secure=true
rpc-certificate=/conf/certificate.pem
rpc-private-key=/conf/certificate.key
×
拖拽到此处
图片将完成下载