printf "this is a printf test\n";

# %s %c %d %f都是格式替代符

# %-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐），任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。

# %-4.2f 指格式化为小数，其中.2指保留2位小数。

printf "%-10s %-10s %-4s\n" name sex  height-kg
printf "%-10s %-10s %-4.2f\n" Tom female 66.1234


# 单引号和双引号效果一样
printf '%s\n' 输出单引号里的内容

# 没有引号也能输出
printf %s\n    不带引号的输出


# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf %s abc def

printf "%s\n" abc def

printf "%s %s %s\n" a b c d e f g h i j

# 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
printf "%s and %d \n" 

