- 扫描局域网内所有ip
```bash
arp -a
```
返回值： 
ip地址 mac地址 

---


Linux：将80端口的请求转发到8080
文章来源：https://blog.csdn.net/sbsujjbcy/article/details/45387347

在Linux的下面部署了apache 或者 tomcat，为了安全我们使用非root用户进行启动，但是在域名绑定时无法直接访问80端口号。众所周知，在unix下，非root用户不能监听1024以下的端口号，这个apache服务器就没办法绑定在80端口下。所以这里需要使用linux的端口转发机制，把到80端口的服务请求都转到8080端口上。
在root账户下面运行一下命令：
```sh
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
```
另外如果防火墙重新启动，该命令就会失效，可以使用下面的命令把该规则保存到iptables里面。
```sh
service iptables save
```

在路由器那里设置：
```
iptables -t nat -A PREROUTING -d 192.168.1.117 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.117:8000

```
不行。


ssh的端口转发：

```sh 
# https://www.cnblogs.com/keerya/p/7612715.html
# 我们使用的端口是9527端口，从上图中我么已经看出，9527端口没有被占用，所以我们可以使用~

#b 接着我们建立本地转发的隧道（5上输入以下命令）：

ssh -L 8888:192.168.1.117:80 -fN 192.168.1.117:8080
```