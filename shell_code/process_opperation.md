杀死指定名字的相关进程
ps -ef|grep read.cgi |grep -v grep|awk '{print "kill -9 "$2}'|sh