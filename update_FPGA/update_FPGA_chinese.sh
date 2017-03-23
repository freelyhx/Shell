#!/bin/bash

#-----------------------------------------------------------
# filename:update_FPGA_chinese.sh
# version:1.3
# date:2017/03/22
# author:yangql
# program:升级FPGA程序
#-----------------------------------------------------------

#初始化FPGA升级程序名及增加执行权限
FPGA=vtsc_694_top-600W.bin
chmod a+x $FPGA

echo 杀死相机进程，提高升级成功率
echo ...
pkill Traffic
pkill IVE_daemon.out
pkill IVE_update.out
pkill appweb
echo 相机进程杀死成功!

echo .
echo .
echo .

# 升级FPGA
echo 开始升级FPGA程序
echo ...
./fpga_flash_default_bin.out $FPGA
echo FPGA升级完毕，请检查是否升级成功!!!

echo .
echo .
echo .

# 升级成功后删除升级文件
b="y"
c="n"
echo 请确认FPGA是否升级成功，升级成功输入:y，升级失败输入:n，请输入：
while true
do
	read a
	if [ $a = $b ]
	then
		echo 确认FPGA升级成功，删除升级文件
		echo ...
		rm -rf update_FPGA*.sh
		rm -rf $FPGA
		echo 删除成功！
		echo 脚本运行结束！！！
		break
	elif [ $a = $c ]
	then
		echo 升级失败，请重新执行升级脚本
		break
	else
		echo 输入内容不合法，请重新输入：
	fi
done