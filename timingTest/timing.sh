#!/bin/sh

# 相机启动，等待3分钟与中心校时
echo wait 3 min
sleep 3m

while true
do
	# Print the delimiter
	printf "*****\n*****\n*****\n" >> date.txt	
	
	# display now time
	printf "NowTime: `date` \n" >> date.txt

	# set time
	date -s '2016-12-12 12:12:12'
	printf "SetTime: `date` \n" >> date.txt

	# set hwclock and display HardwareTime
	hwclock -w
	printf "HwTime: `date` \n" >> date.txt

	# waiting for timing 设置相机定时校时间隔为1小时
	echo wait 1 hour
	sleep 1h
done


