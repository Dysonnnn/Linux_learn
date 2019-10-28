# 原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。

# expr 是一款表达式计算工具，使用它能完成表达式的求值操作。
# 例如，两个数相加(注意使用的是反引号 ` 而不是单引号 ')：

val=`expr 2 + 2` #  要用空格隔开表达式和运算符
echo "两数之和为： $val";

a=10
b=20
echo "a = $a , b = $b"
val_c=`expr $a + $b`;
echo "val_c = a + b = $val_c"
val_c=`expr $a \* $b`;
echo "val_c = a \* b = $val_c"
val_c=`expr $b / $a`;  # a / b = 0
echo "val_c = b / a = $val_c"

val_c=`expr $b % $a`;
echo "val_c = b % a = $val_c"

a=$b;
echo "a = ${a}";

a=10;
# 注意：条件表达式要放在方括号之间，并且要有空格，例如: [$a==$b] 是错误的，必须写成 [ $a == $b ]。
if [ $a == $b ]
then
	echo " a = b "
fi
if [ $a != $b ]
then
	echo " a != b "
fi

if [ $a -eq $b ]
then
	echo "$a -eq $b? : a = b"
fi

if [ $a -ne $b ]
then
	echo "$a -ne $b?  a != b"
fi

if [ $a -gt $b ]
then
	echo "$a -gt $b? a > b "
fi

if [ $a -lt $b ]
then
	echo "$a -lt $b ?  a < b"
fi

if [ $a -ge $b ]
then
	echo "$a -ge %b ? a >= b "
fi

if [ $a -le $b ]
then
	echo "$a -le $b? a <= b"
fi

echo "布尔运算符 非运算 ！     或运算  -o   与运算 -a "

if [ $a == 10 -a $b == 20 ]
then
	echo "a=10 -a b=20"
fi

if [ $a == 10 -o $b == 10 ]
then
	echo "a=10 -o b=10"
else 
	echo "either a or b is true"
fi
