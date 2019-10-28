# Shell 流程控制
# 和Java、PHP等语言不一样，sh的流程控制不可为空
# 在sh/bash里可不能这么写，如果else分支没有语句执行，就不要写这个else
echo " Shell 流程控制 "


echo ''
echo "---------------"
echo ''
echo "1. if else "
###############  if else
# if condition
# then
#    command1 
#    commandN 
# fi

# 写成一行（适用于终端命令提示符）：
if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true";else echo "no such process"; fi
echo "ps result = "$(ps -ef | grep -c "ssh") # =0
echo "ps result = "$(ps -ef | grep -c "ps") # =1

###############  if else-if else
# if condition1
# then
#     command1
# elif condition2 
# then 
#     command2
# else
#    commandN
# fi
# 以下实例判断两个变量是否相等：
a=10
b=20
if [ $a == $b ]
then
	echo "a = b"
elif [ $a -gt $b ]
then
	echo "a > b "
elif [ $a -lt $b ]
then
	echo "a < b"
else
	echo "没有符合条件"
fi

# if else语句经常与test命令结合使用，如下所示：
num1=$[2*3]
num2=$[1+5]
echo "num1 = $num1 , num2 = $num2 "
if test $[num1] -eq $[num2]
then
	echo "两个数相等"
else
	echo "两个数不相等"
fi



echo ''
echo "---------------"
echo ''
echo "2. for "
############ for 循环
# 格式
# for var in item1 item2 ... itemN
# do
#     command1
#     command2
#     ...
#     commandN
# done

# 写成一行：
# for var in item1 item2 ... itemN; do command1; command2… done;
# 当变量值在列表里，for循环即执行一次所有命令，使用变量名获取列表中的当前取值。命令可为任何有效的shell命令和语句。in列表可以包含替换、字符串和文件名。



# in列表是可选的，如果不用它，for循环使用命令行的位置参数。
# 例如，顺序输出当前列表中的数字：
for loop in 1 2 3 4 5
do
	echo "the value is : $loop"
done

echo ''

# 顺序输出字符串中的字符：
for str in "this is a string"
do
	echo $str
done


echo ''
echo "---------------"
echo ''
echo "3. while "
# while 语句
# while循环用于不断执行一系列命令，也用于从输入文件中读取数据；
# 命令通常为测试条件。其格式为：
# while condition
# do
#     command
# done
int=1
while(( $int <= 5))
do
	echo $int
	let "int++"
done
# 以上实例使用了 Bash let 命令，它用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量

# while循环可用于读取键盘信息。下面的例子中，输入信息被设置为变量FILM，按<Ctrl-D>结束循环。
echo ''
echo "while 循环："
echo '按下<CRTL-D>退出'
echo -n '输入你喜欢的网站名'
while read FILM
do
	echo "是的！ $FILM 是一个好网站"
done


# 无限循环
# 无限循环语法格式：
# while :
#do
#    command
#done

#或者
#while true
#do
#    command
#done

#或者

#for (( ; ; ))