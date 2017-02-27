#!/bin/bash

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
./fpga_flash_default_bin.out vtsc_694_top3msvn.bin
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
		rm -rf vtsc_694_top.bin
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