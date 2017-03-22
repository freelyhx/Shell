#!/bin/bash

#-----------------------------------------------------------
# filename:testDaemon.sh
# version:2.0
# date:2017/03/21
# author:yangql
# program:�����ػ������Ƿ���Գɹ��ػ�NvrServer��OperateServer��IVE_update��appweb��4������
#-----------------------------------------------------------


COUNT=0		#������,��0��ʼ����
TIME=10		#ÿ�εȴ�ʱ�䣬Ĭ��10��
MAX=5		#�ȴ�������Ĭ��5��

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