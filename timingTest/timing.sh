#!/bin/bash

#-----------------------------------------------------------
# filename:timing.sh
# version:2.0
# date:2017/04/07
# author:yangql
# program:定时校时功能测试
#-----------------------------------------------------------

# 变量初始化
COUNT=0		#计数器 初始值为0
TIME=30		#延时时间（秒） 默认为60

# 删除日志文件
rm date.txt

while true
do
	# Print the delimiter
	printf "*****\n*****\n*****\n" >> date.txt	

	let COUNT++
	echo "$COUNT timing result:"
	echo "$COUNT timing result:" >> date.txt
	
	# display now time
	printf "NowTime:$(date "+%Y-%m-%d %T")\n"
	printf "NowTime:$(date "+%Y-%m-%d %T")\n" >> date.txt

	# set time
	date -s '2016-12-12 12:12:12' > /dev/null
	printf "SetTime:$(date "+%Y-%m-%d %T")\n"
	printf "SetTime:$(date "+%Y-%m-%d %T")\n" >> date.txt

	# set hwclock and display HardwareTime
	hwclock -w
	printf "HwTime:$(hwclock)\n"
	printf "HwTime:$(hwclock)\n" >> date.txt

	# waiting for timing 设置相机定时校时间隔为1小时
	echo wait $TIME second
	sleep $TIME
done
