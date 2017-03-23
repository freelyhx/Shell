#!/bin/bash

#-----------------------------------------------------------
# filename:update_FPGA_english.sh
# version:1.3
# date:2017/03/22
# author:yangql
# program:upgrade FPGA
#-----------------------------------------------------------

# init FPGA's update file and add execute permissions
FPGA=fpga_0227_led.bin
chmod a+x $FPGA

echo kill process
echo ...
pkill Traffic
pkill IVE_daemon.out
pkill IVE_update.out
pkill appweb
echo kill process sucess !

echo .
echo .
echo .

# upgrade FPGA
echo To upgrade the FPGA
echo ...
./fpga_flash_default_bin.out $FPGA
echo FPGA upgrade sucess!!!

echo .
echo .
echo .

# Delete the upgrade file after a successful upgrade
b="y"
c="n"
echo Please make sure the FPGA upgrade sucess or failed，sucess input:y，failed input:n
echo please input [y/n]：
while true
do
	read a
	if [ $a = $b ]
	then
		echo FPGA upgrade sucess! delete files
		echo ...
		rm -rf update_FPGA*.sh
		rm -rf $FPGA
		echo delete sucess !
		echo update_FPGA.sh running over !!!
		break
	elif [ $a = $c ]
	then
		echo upgrade failed,please running update_FPGA.sh again !!!
		break
	else
		echo input error! Please input again：
	fi
done