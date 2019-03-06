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
# /etc/shells: valid login shells
/bin/sh
/bin/dash
/bin/bash
/bin/rbash
/bin/zsh
/usr/bin/zsh

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

Shell变量的取值都是一个字符串，赋值采用：“变量名 =值”。注意“=”左右不能有空格！

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
$ unset DAY 

显示所有本地定义的Shell 变量 
$ set


环境变量定义用户的工作环境，用户可以在当前shell和任 意子shell中获得它们设置的信息。

环境变量必须用export命令导出，使之能够用于全部的 Shell环境。 
$ exportDAY 
使用env命令查看环境变量 
env 
常用环境变量 USER PWD SHELL HOME PATHHOSTNAME 
环境变量配置文件 /etc/profile       //所有用户登录都会先执行本文件 
/etc/bashrc//被用户主目录下的.bashrc调用执行 
~/.bash_profile//用户登录时执行，并调用本目录下.bashrc 
~/.bashrc//每次打开新的终端时执行，并调用/etc/bashrc


### 预定义变量
变量名含义
$#      传递到脚本的参数的数量
$*      以一个单字符串显示传递到脚本的所有参数的内容
$?      表示命令执行后返回的状态，用于检查上一个命令的执行 是否正确;在Linux中，命令退出状态为0表示命令正确执行 ，任何非0值表示命令执行错误 $$表示当前进程的进程号 
$!      表示后台运行的后一个进程号
$0      表示当前执行的进程名

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
- 输出重定向 
/>  将命令的执行结果重定向输出到指定的文件中，命令进行 输出重定向后执行结果将不显示在屏幕上
输出重定向

/>> 将命令执行的结果重定向并追加到指定文件的末尾保存

- 错误重定向
2>      清空指定文件的内容，并保存标准错误输出的内容到指定 文件中
2>>     向指定文件中追加命令的错误输出，而不覆盖文件中的原 有内容

### 输出重定向实例

#### 将命令输出重定向到文件 
将标准输入重定向到文件 
$ wc                //统计从键盘输入的信息，包含的行数、单词数和字符数 
$ wc    </etc/passwd 
将标准输出重定向到文件 
$ ls/etc/ >show.ls              将标准输出重定向追加到文件 
$ ls/etc/sysconfig/ >>show.ls       将错误输出重定向到文件 
$ cmd   2  >   errfile 
Eg;lsmyfile        //假设当前路径下myfile目录不存在 输出结果: “ls: myfile：没有那个目录或文件” 使用错误输出重定向到文件errfile: 
lsmyfile2   > errfile          将标准输出和错误输出重定向到文件 
$ lsafilebfile  &>  errfile

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

```
if [ 条件语句 条件语句1 ] ; then
    指令序列1 
elif[  条件语句 条件语句2 ] ; then 
    指令序列2 
else
    指令序列3 3
fi 
```

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
    >eg:  $ .sh_fun.sh      // 函数hello导入Shell 
    >$set | grep hello      // 使用set查看hello函数 
    >$hello                 //直接在命令行中调用并运行hello函数



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


# ~/.bashr 文件配置
# Set ROS alias command  快捷命令
alias cw='cd ~/catkin_ws' 
alias cs='cd ~/catkin_ws/src' 
alias cm='cd ~/catkin_ws && catkin_make' 