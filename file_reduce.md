linux文本处理三剑客  grep awk sed

grep擅长查找，awk擅长分析（select），sed擅长批量编辑行

SED的英文全称是 Stream EDitor，它是一个简单而强大的文本解析转换工具


[第十三课 linux文本处理三剑客之sed](https://www.jianshu.com/p/171a1cad4f7f)

[Linux怎么使用命令查看文件指定行数的内容?](https://www.jb51.net/LINUXjishu/543510.html)

本文介绍Linux如何显示文件指定行数的内容的方法，有下面几种方法：

1、tail -n +/-数字 文件名
tail -n -数字 文件名，表示查看文件的最后几行
tail -n +数字 文件名，表示查看文件的某一行到最后一行
2、head -n 数字 文件名
head -n 数字 文件名，表示查看文件前几行的内容

3、sed -n "开始行，结束行p" 文件名
sed -n "开始行，结束行p" 文件名，表示查看文件的开始行到结束行的内容






