以下总结了一下nginx在使用过程中的一些常用命令(yum安装nginx)
```sh
nginx的访问页面(welcome to nginx)具体所在位置
vi /usr/share/nginx/html/index.html
# 访问IP
curl 192.168.100.111
# 关闭nginx进程
nginx -s stop
# 启动nginx进程
/usr/sbin/nginx          yum安装的nginx也可以使用         
servic nginx start
# 检查配置文件是否有误
nginx –t
# 重新加载配置文件
nginx –s reload
# 查看日志
tail -f filename 显示文件默认10行，刷新显示
# 例：tail -f /var/log/lvs-agent.log          tail -f /etc/nginx/nginx.conf
# 查看文件后几行
tail -n 行数 文件名 例： tail -n 100 /var/log/aa.log
# 删除网卡ip
ip addr del 192.168.11.5/32 dev lo (lo eth1 eth2)
lvs清空所有集群服务
ipvsadm –C
# 获取eth0网卡上的所挂的ip值
ip a|grep eth0|grep inet|awk ‘{print $2}’|cut -d “/” -f1
# 验证该ip或者网址是否通 可用返回200
curl -I -m 10 -o /dev/null -s -w %{http_code} 10.110.26.10:8080
# 后台启动jar包
nohup java -jar /usr/sbin/项目名.jar >>/var/log/项目名.log 2>&1 &
# 查看上一个命令是否执行成功 返回0执行成功 其他不成
echo $?
# 查看nginx进程是否启动。此命令用在代码判断nginx进程是否启动，如果只用ps aux | grep nginx 即使没有启动也会用内容返回，影响判断
ps aux | grep nginx | greo –v grep
# 如果是安装包安装的nginx,查看nginx进程，找到路径，使用命令。
ps aux | grep nginx

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx -s reload

/usr/local/nginx/sbin/nginx -s stop
```
————————————————

版权声明：本文为CSDN博主「liucy007」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/liucy007/article/details/86716870



# 自定义 域名解析：

```sh
 #搜索网站
  server {
        listen       80;
        server_name  search.pinyougou.com;

  #设置请求行
  proxy_set_header X-Forwarded-Host $host;
  proxy_set_header X-Forwarded-Server $host;
  proxy_set_header Host $host; 
  

        location / {
            proxy_pass http://127.0.0.1:9104;
   proxy_connect_timeout 600;
   proxy_read_timeout 600;
        }
    }
```