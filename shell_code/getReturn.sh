##! set bash diraction
# check_results=`rpm -qa | grep "zlib"`
# check_results=`ls | grep sh 2>&1`
# check_results=`ls | grep sh `
check_results=`ls | grep ttyUSB2`
# check_results=`ls /dev/ttyUSB 2>&1`
echo "command(ls) results are: $check_results"
# if [[ $check_results =~ "1.8." ]] 
# if [[ $check_results=~"getReturn.sh" ]]

# if [[ $check_results=~"ttyUSB2" ]]
if [[ $check_results=~"cannnot" ]];
then
	echo "This is no ttyUSB2 file" # 前面的是tab键
else
	echo "ttyUSB2 file has already here . " # 
fi

# --------------------- 
# 作者：歪歪的酒壶 
# 来源：CSDN 
# 原文：https://blog.csdn.net/haiqinma/article/details/53672368 
# 版权声明：本文为博主原创文章，转载请附上博文链接！