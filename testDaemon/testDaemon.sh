#!/bin/bash

#-----------------------------------------------------------
# filename:testDaemon.sh
# version:2.0
# date:2017/03/21
# author:yangql
# program:测试守护程序，是否可以成功守护NvrServer、OperateServer、IVE_update、appweb这4个进程
#-----------------------------------------------------------


COUNT=0		#计数器,从0开始计数
TIME=10		#每次等待时间，默认10秒
MAX=5		#等待次数，默认5次

daemonProcess(){
	top -n 1 | grep $* > /dev/null
	s=$?
	if [ $s != 0 ]
	then
		echo "error!!"
		echo "$* process does not exit!"
		return 1
	fi

	oldPID=$(top -n 1 | grep $* | awk '{print $1}')
	echo "$* oldPID is:$oldPID"
	pkill $*
	
	while true
	do
		if [ $COUNT -ge $MAX ]
		then
			echo "time out! daemon $* failed."
			COUNT=0
			return 1
		fi
	
		top -n 1 | grep $* > /dev/null
		status=$?
		if [ $status == 0 ]
		then
			newPID=$(top -n 1 | grep $* | awk '{print $1}')
			if [ $oldPID != $newPID ]
			then
				echo "$* newPID is:$newPID"
				echo "daemon $* sucess!"
				COUNT=0
			fi
			return 0
		fi
		
		let COUNT++
		echo "$COUNT wait $TIME second."
		sleep $TIME
	done
}

daemonProcess NvrServer
daemonProcess OperateServer
daemonProcess IVE_update
daemonProcess appweb