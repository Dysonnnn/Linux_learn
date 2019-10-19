ubuntu首次登录mysql未设置密码或忘记密码解决方法

1.首先输入以下指令：
```bash
sudo cat /etc/mysql/debian.cnf
```
可以看到
```bash
# Automatically generated for Debian scripts. DO NOT TOUCH!
[client]
host     = localhost
user     = debian-sys-maint
password = vpRh58NgxZwjO9yb
socket   = /var/run/mysqld/mysqld.sock
[mysql_upgrade]
host     = localhost
user     = debian-sys-maint
password = vpRh58NgxZwj****
socket   = /var/run/mysqld/mysqld.sock
```
有用户名和密码

2. 再输入以下指令：

```bash
mysql -u debian-sys-maint -p
```
输入刚才看到的密码

修改密码，本篇文章将密码修改成 root , 用户可自行定义。
```bash
use mysql;
// 下面这句命令有点长，请注意。
update mysql.user set authentication_string=password('mysql') where user='root' and Host ='localhost';
update user set plugin="mysql_native_password"; 
flush privileges;
quit;
```


4. 重新启动mysql:
```bash
sudo service mysql restart
mysql -u root -p // 启动后输入已经修改好的密码：root
```


————————————————
版权声明：本文为CSDN博主「syrdbt」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_38737992/article/details/81090373