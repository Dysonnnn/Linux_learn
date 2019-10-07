# 数组中可以存放多个值。Bash Shell 只支持一维数组（不支持多维数组），初始化时不需要定义数组大小（与 PHP 类似）。
# 与大部分编程语言类似，数组元素的下标由0开始。
# Shell 数组用括号来表示，元素用"空格"符号分割开，语法格式如下：
array_name=(A B C "D" E);
array_name[0]=F;

echo "array_name[0]: "${array_name[0]};
echo "数组的元素为“ ${array_name[*]}";
echo "数组的元素为“ ${array_name[@]}";


echo "数组元素的个数为“ ${#array_name[*]}";
echo "数组元素的个数为“ ${#array_name[*]}";
