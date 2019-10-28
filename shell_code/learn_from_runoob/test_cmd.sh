# Shell test 命令
# Shell中的 test 命令用于检查某个条件是否成立，
# 它可以进行数值、字符和文件三个方面的测试。
# 数值测试
#参数	说明
# -eq	等于则为真
# -ne	不等于则为真
# -gt	大于则为真
# -ge	大于等于则为真
# -lt	小于则为真
# -le	小于等于则为真
# ----------------
echo "Shell test 命令"


echo ''
echo "---------------"
echo ''
echo "1. 数值测试"
num1=100
num2=200

if test $[num1] -eq $[num2]
then
	echo 'num1 等于 num2'
else
	echo 'num1 不等于 num2'
fi

echo ''
# 代码中的 [] 执行基本的算数运算
a=2
b=4
echo "代码中的 [] 执行基本的算数运算,例如[a+b]"
result=$[a+b]  # 注意等号两边不能有空格
echo "reuslt 为 $result"


echo ''
echo "---------------"
echo ''
echo "2. 字符串测试"
# 参数	说明
# =	等于则为真
# !=	不相等则为真
# -z 字符串	字符串的长度为零则为真
# -n 字符串	字符串的长度不为零则为真

str1="test"
str2="testt"
echo 'str1 : $str1 , str2 : $str2 '
if test $str1 = $str2
then
	echo '两个字符串相等'
else
	echo '两个字符串不相等'
fi

if test -n $str1
then
	echo '字符串的长度不为零'
else
	echo '字符串的长度为零'
fi


echo ''
echo "---------------"
echo ''
echo "3. 文件测试"
# 参数	说明
# -e 文件名	如果文件存在则为真
# -r 文件名	如果文件存在且可读则为真
# -w 文件名	如果文件存在且可写则为真
# -x 文件名	如果文件存在且可执行则为真
# -s 文件名	如果文件存在且至少有一个字符则为真
# -d 文件名	如果文件存在且为目录则为真
# -f 文件名	如果文件存在且为普通文件则为真
# -c 文件名	如果文件存在且为字符型特殊文件则为真
# -b 文件名	如果文件存在且为块特殊文件则为真
fileName="echo.sh"
if test -e $fileName
then
	echo "$fileName 文件已存在！"
else
	echo "$fileName 文件不存在！"
fi

# 另外，Shell还提供了与( -a )、或( -o )、非( ! )三个逻辑操作符用于将测试条件连接起来，
# 其优先级为："!"最高，"-a"次之，"-o"最低。例如：
echo ''
if test -e echo.sh -o -e haha
then
	echo "至少有一个文件存在"
else
	echo "两个文件都不存在"
fi

