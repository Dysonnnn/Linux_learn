name="Tim"
echo "name : "${name}

for skill in Ada Coffe Action Java;do
	echo "I am good at ${skill}Script"
done

# set read only variable
myUrl="http://www.baidu.com"
readonly myUrl

# delete variable , it can not delete readonly variable
unset var_name

# string   , variable in ' '   is useless
# 单引号字符串的限制：
#单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
#单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。
# 双引号内可以放 变量
str='this is a string'
echo ${str}
str2="this is a string in \"\" ${str}"

# get the length of string
echo "the length of str is " ${#str}

# cut the string  提取字符串 切割字符串
echo ${str:1:3}

# 查找子字符串
string="hahah is a good word"
echo `expr index "$string" io` # 输出i,o的位置，哪个先出现就计算哪个

# array bash 支持一维数组，不支持多维数组
arr1=(1 2 3 4 5 6 7 8 9 0 )
arr1[0]=111

# 使用@可以获取数组中的所有元素
echo ${arr1[@]}

# get the length of arr
# 取得数组元素的个数
array_name=(hahah is hahah)
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}



