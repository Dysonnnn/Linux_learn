## 文件操作
文件可以是 txt csv
读取文件 < fileName
读取行 read line
IFS 分隔符变量
line 行变量

```bash
#!/bin/bash
# 获取文件内的 第 2 3 列内容，输出到新文件内
while read line
do
	OLD_IFS="$IFS"
	# 分隔符
	IFS="|"
	arr=($line)
	IFS="OLD_IFS"
	FILE_NAME=$1
	# 创建新文件
	NEW_FILE_NAME=${FILE_NAME:0:9}.txt
	#echo $NEW_FILE_NAME
	# 输出指定内容到新文件
	echo "${arr[1]} ${arr[2]}" >> $NEW_FILE_NAME
# 从执行命令的第一个参数中指定的文件 读取内容
done < $1
# 拷贝 新文件到 /mnt/share
cp $NEW_FILE_NAME /mnt/share
echo "copy file successfully"
```