echo "hello world"
echo It is a test

echo "\"  It is a test  \""

# read name  读一行
#read name
#echo "$name It is a test"

# -e 开启转义
echo -e "OK! \n It is a test"

# 显示结果定向至文件
echo "It is a test" > testEchoFile


# 单引号 不进行转义 或 取变量 输出字符串
name="my Name";
echo '单引号原样输出字符串 $name\"'

# 显示命令执行结果 `` 反引号
echo `date`




