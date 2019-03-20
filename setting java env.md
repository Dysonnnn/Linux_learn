setting java env
[安装Java环境(Linux)](https://www.yiibai.com/java/how-to-install-java-on-ubuntu.html)
				
1. 在开始设置使用 Java 之前，则需要从系统中删除 OpenJDK/JRE。
请使用以下命令 :

```
yiibai@ubuntu:~$ sudo apt-get purge openjdk-\*
```

2. 查看 Ubuntu 操作系统的架构是32位还是64位。
可以使用下面的命令:
```
yiibai@ubuntu:~$ file /sbin/init
```


3. 从 Oracle 站点下载最新版本的 Java 安装包这是一个 zip 文件，名称为:jdk-8-linux-x64.tar.gz下载链接如下: http://www.oracle.com/technetwork/java/javase/downloads/index.html 


4. 在终端，打开下载的 Java zip 文件的目录位置
yiibai@ubuntu:~$ cd /home/yiibai/Downloads
yiibai@ubuntu:~/Downloads$
Shell
选择一个目录提取 java zip 文件的内容。
在本教程中，我们将提取的下载文件到/opt/java/ 目录中 ，如下命令:
使用如下命令 - 
yiibai@ubuntu:~$ sudo tar -xvf jdk-8u201-linux-64.tar.gz -C /opt/java/ 




5.  添加下面内空到系统变量，即打开 /etc/profile 文件，并在文件的结束位置添加以下内容:
```
JAVA_HOME=/opt/java/jdk1.8.0_201
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export JAVA_HOME
export PATH
```

6.  现在让 Ubuntu 知道 JDK/JRE 的位置

```bash
$ sudo update-alternatives --install "/usr/bin/java" "java" "/opt/java/jdk1.8.0_201/bin/java" 1
$ sudo update-alternatives --install "/usr/bin/javac" "javac" "/opt/java/jdk1.8.0_201/bin/javac" 1
$ sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/java/jdk1.8.0_201/bin/javaws" 1
Shell
```

7.  告诉 Ubuntu 我们安装的 jdk1.8.0_201 是默认的Java
请使用以下命令来完成:
```bash
$ sudo update-alternatives --set java /opt/java/jdk1.8.0_201/bin/java
$ sudo update-alternatives --set javac /opt/java/jdk1.8.0_201/bin/javac
$ sudo update-alternatives --set javaws /opt/java/jdk1.8.0_201/bin/javaws
```

8. 使用下面的命令来测试安装 Java 的结果，
```bash
yiibai@ubuntu:~$ java -version
```


具体原文出自【易百教程】，商业转载请联系作者获得授权，非商业请保留原文链接：https://www.yiibai.com/java/how-to-install-java-on-ubuntu.html

