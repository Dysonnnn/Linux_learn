# 文件测试运算符用于检测 Unix 文件的各种属性。
file="./fileTest.sh"
if [ -r $file ]
then
	echo "文件可读"
else
	echo "文件不可读"
fi

if [ -w $file ]
then
	echo "文件可写"
else
	echo "文件不可写"
fi

if [ -x $file ]
then
	echo "文件可执行"
else
	echo "文件不可执行"
fi

if [ -f $file ]
then
	echo "文件为普通文件"
else
	echo "文件为特殊文件"
fi


if [ -d $file ]
then
	echo "文件是个目录"
else
	echo "文件不是个目录"
fi


if [ -s $file ]
then
	echo "文件不为空"
else
	echo "文件为空"
fi

if [ -e $file ]
then 
	echo "文件存在"
else
	echo "文件不存在"
fi

