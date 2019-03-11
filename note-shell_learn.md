# 【申嵌视频-基础篇】第五讲%20Shell脚本编程.pdf

- “菜鸟玩转嵌入式”视频培训讲座 —mini2440基础篇

## 第五讲 Shell脚本编程

### 本章目标
- 了解shell的发展过程和用途 
- 掌握shell变量的设置和使用 
- 掌握bash的基本操作方式 
- 掌握简单的shell脚本编辑方法

提供了多种Shell程序可供用户选择 文件Shells中保存了Linux系统中可使用的Shell程序列表 
└─[$] <> cat /etc/shells
```bash
# /etc/shells: valid login shells
/bin/sh
/bin/dash
/bin/bash
/bin/rbash
/bin/zsh
/usr/bin/zsh
```

- 用户默认Shell的设定 
> - 用户使用的登录Shell保存在passwd文件的记录中 
> /etc/passwd eg:/root:/bin/bash


### Bash的主要功能
命令行编辑功能 
命令和文件名补全功能(Tab键) 
命令历史功能(history) 
命令别名功能(alias) 
提供作业控制功能 
自定义功能键的功能 
灵活的Shell脚本编程

### Shell变量
Shell变量名可以包含数字，字母和下划线，变量名的 开头只准许是字母和下划线。

变量名中的字母是大小 写敏感的。为了与命令名相区别，一般建议采用大写 字母来表示Shell变量。 

Shell变量的取值都是一个字符串，赋值采用：“变量名=值”。注意“=”左右不能有空格！

Shell变量的引用：$变量名

### Shell变量的分类
用户自定义变量（本地变量） 
环境变量 
位置参数变量 
预定义变量


自定义变量的设置 
$ DAY=Sunday // =两边不能有空格 
$ DAY=“today is Sunday”
//若变量值本身包含空格，则整个字符 串必须用双引号括起来 

自定义变量的清除 
```
$ unset DAY 
```

显示所有本地定义的Shell 变量
```
$ set
```

环境变量定义用户的工作环境，用户可以在当前shell和任 意子shell中获得它们设置的信息。

环境变量必须用export命令导出，使之能够用于全部的 Shell环境。 
```
$ exportDAY 
```
使用env命令查看环境变量 
```
env 
```
常用环境变量 USER PWD SHELL HOME PATHHOSTNAME 
环境变量配置文件 /etc/profile       //所有用户登录都会先执行本文件 
/etc/bashrc//被用户主目录下的.bashrc调用执行 
~/.bash_profile//用户登录时执行，并调用本目录下.bashrc 
~/.bashrc//每次打开新的终端时执行，并调用/etc/bashrc


### 预定义变量
变量名含义
```
$#      传递到脚本的参数的数量
$*      以一个单字符串显示传递到脚本的所有参数的内容
$?      表示命令执行后返回的状态，用于检查上一个命令的执行 是否正确;在Linux中，命令退出状态为0表示命令正确执行 ，任何非0值表示命令执行错误 $$表示当前进程的进程号 
$!      表示后台运行的后一个进程号
$0      表示当前执行的进程名
```
### Bash的命令行补全功能
- 命令补全功能 
> 使用Tab键可在命令查找路径中查找匹配的命令，并进行命令拼写的 补全 
- 文件补全功能 
> 使用Tab键可对文件和目录名进行补全


**Bash中提供的通配符“？”和“*”**


历史命令的查看 
$ history 
用户命令历史保存文件 
~/.bash_history 
命令历史的清除 
$ history -c



## 管道与重定向
- 标准输入输出
- 重定向操作
- 管道操作

输入输出文件文件描述符默认设备 
标准输入 0 键盘
标准输出 1 终端屏幕
标准错误 2 输出终端屏幕



###  重定向操作
|操作|符号|说明|
|---|---|---|
| 输出重定向  |>  |将命令的执行结果重定向输出到指定的文件中，命令进行 输出重定向后执行结果将不显示在屏幕上|
|输出重定向|>> |将命令执行的结果重定向并追加到指定文件的末尾保存|
|错误重定向|2>|清空指定文件的内容，并保存标准错误输出的内容到指定 文件中|
|错误重定向|2>>    | 向指定文件中追加命令的错误输出，而不覆盖文件中的原有内容|

### 输出重定向实例

#### 将命令输出重定向到文件 
将标准输入重定向到文件 
```
$ wc                //统计从键盘输入的信息，包含的行数、单词数和字符数 
$ wc    </etc/passwd 
将标准输出重定向到文件 
$ ls/etc/ >show.ls              将标准输出重定向追加到文件 
$ ls/etc/sysconfig/ >>show.ls       将错误输出重定向到文件 
$ cmd   2  >   errfile 
Eg;lsmyfile        //假设当前路径下myfile目录不存在 输出结果: “ls: myfile：没有那个目录或文件” 使用错误输出重定向到文件errfile: 
lsmyfile2   > errfile          将标准输出和错误输出重定向到文件 
$ lsafilebfile  &>  errfile
```
### 管道的使用
管道操作符
 | 
“|”符用于连接左右两个命令，将“|”左边的命令执行结 果（输出）作为“|”右边命令的输入 
cmd1 | cmd2 
在同一条命令中可以使用多个“|”符连接多条命令 
cmd1 | cmd2 | ... | cmdn

eg:  ps–ef| grep bash


### Shell脚本
- Shell脚本的概念
- 基本的脚本编程
- 运行脚本程序



### 基本脚本编程
- 使用文本编辑器（vi）建立Shell脚本文件 
vi hello.sh 
- 脚本中应包括的内容 
脚本运行环境设置，指明使用哪种Shell来解释本脚本。 
#!/bin/bash或者#!/bin/sh 
- 注释行以#开始 # Clean command history,清除用户命令历史 
- 脚本语句 
Shell命令+系统命令 
- 设置脚本文件为可执行属性（+x） 
chmodu+xhello.sh



**执行shell文件的时候，如果使用的是zsh状态栏，记得在sh文件开头标明  #!/bin/bash**
**使用shell 命令的时候，记得切换回bash终端**



### 条件测试
- 使用test命令 

条件表达式的值为真返回零，为假时返回非零值 
**注意：条件表达式两边都必须留有一个空格**
test $PWD = /home/student 
echo $?  //回显结果，0-真，非零-假


### 流程控制
if then else语句 if语句测试条件，如果测试结果为真(0)，则执行if体中的某段语句： 
如果为假(1)，则执行if体外的语句。

```bash
if [ 条件语句 条件语句1 ] ; then  # 括号两端必须要有空格
    指令序列1 
elif[  条件语句 条件语句2 ] ; then  # 括号两端必须要有空格
    指令序列2 
else
    指令序列3 3
fi 
```

整数比较：

-eq	检测两个数是否相等，相等返回 true。	[ $a -eq $b ] 返回 false。  
-ne	检测两个数是否不相等，不相等返回 true。	[ $a -ne $b ] 返回 true。  
-gt	检测左边的数是否大于右边的，如果是，则返回 true。	[ $a -gt $b ] 返回 false。  
-lt	检测左边的数是否小于右边的，如果是，则返回 true。	[ $a -lt $b ] 返回 true。  
-ge	检测左边的数是否大于等于右边的，如果是，则返回 true。	[ $a -ge $b ] 返回 false。  
-le	检测左边的数是否小于等于右边的，如果是，则返回 true。	[ $a -le $b ] 返回 true。  

字符串运算符
下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

运算符	说明	举例
=	检测两个字符串是否相等，相等返回 true。	[ $a = $b ] 返回 false。  
!=	检测两个字符串是否相等，不相等返回 true。	[ $a != $b ] 返回 true。  
-z	检测字符串长度是否为0，为0返回 true。	[ -z $a ] 返回 false。  
-n	检测字符串长度是否为0，不为0返回 true。	[ -n "$a" ] 返回 true。  
$	检测字符串是否为空，不为空返回 true。	[ $a ] 返回 true。  

---参考自 [Shell 基本运算符](http://www.runoob.com/linux/linux-shell-basic-operators.html)



    双目运算符=~；它和==以及!=具有同样的优先级。如果使用了它，则其右边的字符串就被认为是一个扩展的正则表达式来匹配。如果字符串和模式匹配，则返回值是0，否则返回1。如果这个正则表达式有语法错误，则整个条件表达式的返回值是2。如果打开了shell的nocasematch 选项则匹配时不考虑字母的大小写。模式的任何部分都可以被引用以强制把其当作字符串来匹配。由正则表达式中括号里面的子模式匹配的字符串被保存在数组变量BASH_REMATCH 中。BASH_REMATCH 中下标为0的元素是字符串中与整个正则表达式匹配的部分。BASH_REMATCH 中下标为n的元素是字符串中与第n 个括号里面的子模式匹配的部分。
参考自 [bash自带正则匹配功能-BASH_REMATCH介绍](http://bbs.chinaunix.net/thread-4125147-1-1.html)



---

getReturn.sh: line 16: syntax error near unexpected token `fi'
getReturn.sh: line 16: `fi'

????

上面两个问题都是由于.sh文件的格式为dos格式。而linux只能执行格式为unix格式的脚本。因为在dos/window下按一次回车键实际上输入的是“回车（CR)”和“换行（LF）”，而Linux/unix下按一次回车键只输入“换行（LF）”，所以修改的sh文件在每行都会多了一个CR，所以Linux下运行时就会报错找不到命令。
        我们可以查看该脚本文件的格式，方法是使用命令：vim nginx_check.sh进入编辑文件界面，如下图所示。

直接输入":"，然后在":"之后输入"set ff"如下图所示
回车即可看到脚本格式，如下图所示，可以看到当前脚本格式是dos。
我们需要把格式改为unix，方法是输入":set ff=unix"，也可以输入":set fileformat=unix"如下图所示。


--------------------- 
作者：在京奋斗者 
来源：CSDN 
原文：https://blog.csdn.net/u012453843/article/details/69803244/ 
版权声明：本文为博主原创文章，转载请附上博文链接！


---

### for循环 
当变量可以在列表中取值时，执行下面的指令序列，循环替换变量 的值，直到列表中的值被替换完为止。

```
for 变量名 in 列表;do
    指令序列
done    
```

-- https://blog.csdn.net/babyfish13/article/details/52981110

### until循环 
- until在条件为假时执行指令序列，循环直到条件为真。
```
until 条件;do
    指令序列
done

```

### while循环 
语法
```
while 条件;do
    指令序列
done

```

**死循环**：
```
while :
do
    指令序列
done
```

### case语句 
语法
```
case 值 in
    模式1）
        指令序列1;;
    模式2）
        指令序列2;;
    模式3）
        指令序列3;;
esac                        
```

### 函数
- 函数定义
函数名()
{
    函数体
}

- 函数调用：函数调用之前先定义，脚本中没有函数声明 。 
- 函数导出：使用“.”运算符将建立的函数导入Shell环境 
```
eg:  $ .sh_fun.sh      // 函数hello导入Shell 
$set | grep hello      // 使用set查看hello函数 
$hello                 //直接在命令行中调用并运行hello函数
```    



### 阶段总结
- 输入输出文件 
标准输入、标准输出、标准错误 
- 重定向符号 
<   >  >>   2>  2>>  &> 
- 管道符 
    ｜ 
- Shell脚本的组成 
-   脚本运行环境设置 
-   注释行 
-   脚本语句


---


## mkdir --help
```bash
> $ mkdir --help
Usage: mkdir [OPTION]... DIRECTORY...
Create the DIRECTORY(ies), if they do not already exist.

Mandatory arguments to long options are mandatory for short options too.
  -m, --mode=MODE   set file mode (as in chmod), not a=rwx - umask
  -p, --parents     no error if existing, make parent directories as needed
  -v, --verbose     print a message for each created directory
  -Z                   set SELinux security context of each created directory
                         to the default type
      --context[=CTX]  like -Z, or if CTX is specified then set the SELinux
                         or SMACK security context to CTX
      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/mkdir>
or available locally via: info '(coreutils) mkdir invocation'
```


---

##  ~/.bashr 文件配置
### Set alias command  设置快捷命令
```
alias cw='cd ~/catkin_ws' 
alias cs='cd ~/catkin_ws/src' 
alias cm='cd ~/catkin_ws && catkin_make' 
```



---

## ps 命令
[Linux ps命令](http://www.runoob.com/linux/linux-comm-ps.html)
Linux ps命令用于显示当前进程 (process) 的状态。
**语法**
>ps [options] [--help]

**参数：**
```
ps 的参数非常多, 在此仅列出几个常用的参数并大略介绍含义
-A 列出所有的行程
-w 显示加宽可以显示较多的资讯
-au 显示较详细的资讯
-aux 显示所有包含其他使用者的行程
au(x) 输出格式 :
USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
USER: 行程拥有者
PID: pid
%CPU: 占用的 CPU 使用率
%MEM: 占用的记忆体使用率
VSZ: 占用的虚拟记忆体大小
RSS: 占用的记忆体大小
TTY: 终端的次要装置号码 (minor device number of tty)
STAT: 该行程的状态:
D: 不可中断的静止 (通悸□□缜b进行 I/O 动作)
R: 正在执行中
S: 静止状态
T: 暂停执行
Z: 不存在但暂时无法消除
W: 没有足够的记忆体分页可分配
<: 高优先序的行程
N: 低优先序的行程
L: 有记忆体分页分配并锁在记忆体内 (实时系统或捱A I/O)
START: 行程开始时间
TIME: 执行的时间
COMMAND:所执行的指令
```

显示所有进程信息，连同命令行
```bash
# ps -ef //显示所有命令，连带命令行
UID    PID PPID C STIME TTY     TIME CMD
root     1   0 0 10:22 ?    00:00:02 /sbin/init
root     2   0 0 10:22 ?    00:00:00 [kthreadd]
root     3   2 0 10:22 ?    00:00:00 [migration/0]
root     4   2 0 10:22 ?    00:00:00 [ksoftirqd/0]
root     5   2 0 10:22 ?    00:00:00 [watchdog/0]
root     6   2 0 10:22 ?    /usr/lib/NetworkManager
……省略部分结果
root   31302 2095 0 17:42 ?    00:00:00 sshd: root@pts/2 
root   31374 31302 0 17:42 pts/2  00:00:00 -bash
root   31400   1 0 17:46 ?    00:00:00 /usr/bin/python /usr/sbin/aptd
root   31407 31374 0 17:48 pts/2  00:00:00 ps -ef
```

---
## grep命令
[Linux grep命令](http://www.runoob.com/linux/linux-comm-grep.html)   
    Linux grep命令用于查找文件里符合条件的字符串。

grep指令用于查找内容包含指定的范本样式的文件，如果发现某文件的内容符合所指定的范本样式，预设grep指令会把含有范本样式的那一列显示出来。若不指定任何文件名称，或是所给予的文件名为"-"，则grep指令会从标准输入设备读取数据。

**语法**
>grep [-abcEFGhHilLnqrsvVwxy][-A<显示列数>][-B<显示列数>][-C<显示列数>][-d<进行动作>][-e<范本样式>][-f<范本文件>][--help][范本样式][文件或目录...]

**参数：**
```
-a 或 --text : 不要忽略二进制的数据。
-A<显示行数> 或 --after-context=<显示行数> : 除了显示符合范本样式的那一列之外，并显示该行之后的内容。
-b 或 --byte-offset : 在显示符合样式的那一行之前，标示出该行第一个字符的编号。
-B<显示行数> 或 --before-context=<显示行数> : 除了显示符合样式的那一行之外，并显示该行之前的内容。
-c 或 --count : 计算符合样式的列数。
-C<显示行数> 或 --context=<显示行数>或-<显示行数> : 除了显示符合样式的那一行之外，并显示该行之前后的内容。
-d <动作> 或 --directories=<动作> : 当指定要查找的是目录而非文件时，必须使用这项参数，否则grep指令将回报信息并停止动作。
-e<范本样式> 或 --regexp=<范本样式> : 指定字符串做为查找文件内容的样式。
-E 或 --extended-regexp : 将样式为延伸的普通表示法来使用。
-f<规则文件> 或 --file=<规则文件> : 指定规则文件，其内容含有一个或多个规则样式，让grep查找符合规则条件的文件内容，格式为每行一个规则样式。
-F 或 --fixed-regexp : 将样式视为固定字符串的列表。
-G 或 --basic-regexp : 将样式视为普通的表示法来使用。
-h 或 --no-filename : 在显示符合样式的那一行之前，不标示该行所属的文件名称。
-H 或 --with-filename : 在显示符合样式的那一行之前，表示该行所属的文件名称。
-i 或 --ignore-case : 忽略字符大小写的差别。
-l 或 --file-with-matches : 列出文件内容符合指定的样式的文件名称。
-L 或 --files-without-match : 列出文件内容不符合指定的样式的文件名称。
-n 或 --line-number : 在显示符合样式的那一行之前，标示出该行的列数编号。
-o 或 --only-matching : 只显示匹配PATTERN 部分。
-q 或 --quiet或--silent : 不显示任何信息。
-r 或 --recursive : 此参数的效果和指定"-d recurse"参数相同。
-s 或 --no-messages : 不显示错误信息。
-v 或 --revert-match : 显示不包含匹配文本的所有行。
-V 或 --version : 显示版本信息。
-w 或 --word-regexp : 只显示全字符合的列。
-x --line-regexp : 只显示全列符合的列。
-y : 此参数的效果和指定"-i"参数相同。
```

---

## awk命令
参考自 [使用awk批量杀进程的命令](https://blog.csdn.net/hi_kevin/article/details/17024107)  
    在做系统运维的过程中，有时候会碰到需要杀掉某一类进程的时候，如何批量杀掉这些进程，使用awk命令是很好的选择。

```bash
ps -ef|grep aaa|grep -v grep|awk  '{print "kill -9 " $2}' |sh
```

1. ps -ef|grep aaa|grep -v grep   

从当前系统运行的进程的进程名中包含aaa关键字的进程, -v 是显示不包含匹配文本的所有行。

1. 后面部分就是awk命令了，一般awk命令的格式为：awk ' pattern {action} '

    print是打印，kill -9 是强制停止进程的命令， $2就是前面有ps -ef命令得出的结果的第二列上显示的内容。


下面举一个简单的例子：
```bash
#ps -ef|grep boco|grep -v grep
root  9884  9883  0 17:10:01 ?         0:00 sendmail -oem -oi -froot boco
root  9883  9880  0 17:10:01 ?         0:00 /usr/bin/mail boco

#ps -ef|grep boco|grep -v grep|awk '{print "kill -9 "$2}'
kill -9 9884
kill -9 9883
```

我们可以看出，ps -ef|grep boco|grep -v grep列出了当前主机中运行的进程中包含boco关键字的进程

而ps -ef|grep boco|grep -v grep|awk '{print "kill -9 "$2}'则列出了要kill掉这些进程的命令，并将之打印在了屏幕上

在ps -ef|grep boco|grep -v grep|awk '{print "kill -9 "$2}'后面加上|sh后，则执行这些命令，进而杀掉了这些进程。


整合到shell脚本


killall pppd 命令慎用。会导致无法重新拨号连接，解决方法：重新连接模块

---

获取shell脚本内 shell命令 输出的内容
直接输入命令就可以


---
## 获取时间

输出当前时间：
```bash
date +"%Y-%m-%d %H-%M-%S"
```

```bash
#[一个较为复杂的变量传递实例](https://www.cnblogs.com/OliverQin/p/5865656.html)
#!/bin/bash
##In this Script we will use variables
##Writen by 2018-06-22
# 获取日期注意事项：date +%Y%m%d 这个字符串是被英文状态下的ESC下面那个键
d1=`date +%H:%M:%S`  
echo "The Script begin at $d1."
echo "Now we will sleep 2s"
sleep 2
d2=`date +%H:%M:%S`
echo "The Script end at $d2."
```

date +"%m-%d %H:%M:%S"


---

## 传递参数
[Shell 传递参数](http://www.runoob.com/linux/linux-shell-passing-arguments.html)

我们可以在执行 Shell 脚本时，向脚本传递参数，脚本内获取参数的格式为：$n。n 代表一个数字，1 为执行脚本的第一个参数，2 为执行脚本的第二个参数，以此类推……

**实例**
以下实例我们向脚本传递三个参数，并分别输出，其中 $0 为执行的文件名：
```bash
#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com

echo "Shell 传递参数实例！";
echo "执行的文件名：$0";
echo "第一个参数为：$1";
echo "第二个参数为：$2";
echo "第三个参数为：$3";
```

为脚本设置可执行权限，并执行脚本，输出结果如下所示：
```bash
$ chmod +x test.sh 
$ ./test.sh 1 2 3
Shell 传递参数实例！
执行的文件名：./test.sh
第一个参数为：1
第二个参数为：2
第三个参数为：3
```

另外，还有几个特殊字符用来处理参数：
```
参数处理	说明
$#	传递到脚本的参数个数
$*	以一个单字符串显示所有向脚本传递的参数。
如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
$$	脚本运行的当前进程ID号
$!	后台运行的最后一个进程的ID号
$@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$-	显示Shell使用的当前选项，与set命令功能相同。
$?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
```
https://www.jb51.net/article/56559.htm


---

## 获取命令的输出
参考自 [shell 脚本中获取命令的输出](https://blog.csdn.net/haiqinma/article/details/53672368)

这个主要介绍的方法是获取命令的输出内容，而不是命令执行成功与否的返回值。

比较常用的一种方式就是， 匹配命令输出的内容中是否存在某些关键字，选择执行的不同动作。

比较常用的一种方式就是采用反向单引号的方式 --  保存结果的变量名=`需要执行的linux命令`


```bash
##! set bash diraction
# check_results=`rpm -qa | grep "zlib"`
check_results=`ls | grep sh`
echo "command(ls) results are: $check_results"
# if [[ $check_results =~ "1.8." ]] 
if [[ $check_results=~"getReturn.sh" ]]
then
	echo "sh file has already here . " # 前面的是tab键
else
	echo "This is no sh file" # 前面的是tab键
fi
```

在使用``（2个反向单引号）的方式**获取执行结果**时需要保证单引号内的命令是可以**执行成功**的。

使用  保存结果的变量名=`需要执行的linux命令` 这种方式来获取命令的输出时，注意的情况总结如下：

1）保证反单引号内的命令执行时成功的，也就是所命令执行后$?的输出必须是0，否则获取不到命令的输出

2）即便是命令的返回值是0，也需要保证结果是通过标准输出来输出的，而不是标准错误输出，否则需要重定向

因此我们推荐使用  保存结果的变量名=`需要执行的linux命令 2>&1 `的方式来获取命令的执行结果。

感兴趣的朋友可以试下第二个例子中改成  check_results=`iscsiadmm --version 2>&1`的结果。


此外还有一种获取命令执行返回值的方式 变量名=$(需要执行的命令) 对于这种方式没有进行测试，所以不再此讨论。

对于上面提到的获取命令执行输出的情况，和获取函数执行结果的方式并不同，请在使用中进行注意。
--------------------- 
作者：歪歪的酒壶 
来源：CSDN 
原文：https://blog.csdn.net/haiqinma/article/details/53672368 
版权声明：本文为博主原创文章，转载请附上博文链接！




---

多行注释：

法一：
```bash
:<<!
语句1
语句2
语句3
语句4
!

```


---

[shell 整型变量自增（加1）的几种方法](https://blog.csdn.net/zhaojinjia/article/details/25652983)

```
#!/bin/sh


a=1
a=$(($a+1))
a=$[$a+1]
a=`expr $a + 1`
let a++
let a+=1

((a++))

echo $a
```