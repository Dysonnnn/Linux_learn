[【我的树莓派玩机之旅】-升级、安装Python3安装](https://www.bilibili.com/read/cv1484170/)

一、更新树莓派系统

sudo  apt-get  update

sudo  apt-get  upgrade

二、安装python3依赖环境 

sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev bzip2 sqlite3 libreadline-dev openssl

三、下载python3.6.4并解压

wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz

tar zxvf Python-3.6.4.tgz

四、编译安装

cd Python-3.6.4

sudo ./configure

sudo make

sudo make install

五、检查安装

ls -al /usr/local/bin/python*

六、安装完成后，软件应该会被安装在/usr/local/bin/下面，我们需要创建一个软连接，便于以后的使用

ln -s /usr/local/bin/python3.6.4 /usr/bin/python3.6.4

注意，这里我只是为了区分原来系统自带的python3，而选择将软链接创建为/usr/bin/python3.6.4的

七、安装pip3

sudo apt-get install python3-pip python3-dev

sudo pip install --upgrade pip