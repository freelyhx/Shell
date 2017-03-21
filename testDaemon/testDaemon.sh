#!/bin/bash

#-----------------------------------------------------------
# filename:testDaemon.sh
# version:1.0
# date:2017/03/20
# author:yangql
# program:测试守护程序，是否可以成功守护NvrServer、OperateServer、IVE_update、appweb这4个进程
#-----------------------------------------------------------

#PNAME=NvrServer


daemonProcess(){

	oldPID=$(top -n 1 | grep $* | awk '{print $1}')
	pkill $*
	sleep 50
	newPID=$(top -n 1 | grep $* | awk '{print $1}')
	
	if [ $oldPID != $newPID ]
	then
		echo "$* oldPID is:$oldPID, newPID is:$newPID"
		echo "daemon $* sucess!"
	elif [ $oldPID == $newPID ]
	then
		echo "$* oldPID is:$oldPID, newPID is:$newPID"
		echo "daemon $* failed!"
	else
		echo "daemon $* failed! "
	fi
}

daemonProcess NvrServer
daemonProcess OperateServer
daemonProcess IVE_update
daemonProcess appweb

