#!/bin/bash

#-----------------------------------------------------------
# filename:shouhu.sh
# version:1.0
# date:2017/02/10
# author:yangql
# program:守护程序，守护进程PRO_NAME
#-----------------------------------------------------------


#定义被守护进程名
PRO_NAME=test.sh
LOCAL_PATH=/home/vion/shell/


#建立一个循环定时检查被守护进程是否存在
while true
do
    # 用ps获取被守护进程的数量，如果存在则为1，不存在则为0，启动过多则大于1
    NUM=`ps -aux | grep ${PRO_NAME} | grep -v grep | wc -l`
	if [ $NUM -lt 1 ]
	then
        #进程不存在，打印时间及进程killed日志
		echo $PRO_NAME is killed
		date >> ~/shouhu.log
		echo $PRO_NAME is killed >> ~/shouhu.log

        #启动进程，打印时间并启动被守护进程
		cd $LOCAL_PATH
		date >> ~/shouhu.log
		echo $PRO_NAME is started >> ~/shouhu.log
		nohup ./test.sh &
    elif [ $NUM -gt 1 ]
    then
        #进程数大于1，杀死所有被守护进程，重新启动被守护进程
        killall -9 $PRO_NAME
		date >> ~/shouhu.log
        echo more than 1 program killall >> ~/shouhu.log
        
        #启动被守护进程
		cd $LOCAL_PATH
		date >> ~/shouhu.log
		echo $PRO_NAME is started >> ~/shouhu.log
		nohup ./test.sh &
    elif [ $NUM == 1 ]
    then
        #守护进程运行正常
		date >> ~/shouhu.log
        echo $PRO_NAME is running >> ~/shouhu.log
    else
        #不在上述范围之内，报错
        echo error! >> ~/shouhu.log
	fi

    #启动程序后等待10秒
    sleep 10
done
