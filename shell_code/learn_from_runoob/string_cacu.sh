# 字符串运算符 
# 下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：
str_a=abc;
str_b=efg;

echo "str_a = $str_a, str_b =$str_b "

if [ $str_a = $str_b ]
then
	echo "$str_a = str_b"
else
	echo "$str_a != str_b"
fi

if [ $str_a != $str_b ]
then
	echo "$str_a != str_b"
else
	echo "$str_a = str_b"
fi

if [ -z $str_a ]
then
	echo "-z $str_a : 字符串长度为0"
else
	echo "-z $str_a : 字符串长度不为0"
fi


if [ -n $str_a ]
then
	echo "-n $str_a : 字符串长度不为0"
else
	echo "-n $str_a : 字符串长度为0"
fi

if [ $str_a ]
then 
	echo "$str_a : 字符串不为空"
else
	echo "$str_a: 字符串长度为空"
fi

