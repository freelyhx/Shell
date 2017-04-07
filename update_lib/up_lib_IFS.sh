#!/bin/bash

#-----------------------------------------------------------
# filename:up_lib_IFS.sh
# version:1.0
# date:2017/04/07
# author:yangql
# program:升级或替换相机库文件
# 			注：相机中shell解释器是busybox不支持数组，所以采用变量存储lib库序列，通过IFS读取变量的方式实现
#-----------------------------------------------------------

#定义替换文件的源目录、目标目录
sourceDir=`pwd`
targetDir=/tmp/work/s2/


#查看lib个数并写入变量libArr中，通过IFS读取变量中每一个条目
cd $sourceDir
libArr=$(ls *.so)
libNumber=$(ls *.so | wc -l)
echo "要替换$libNumber个文件，文件分别为："
echo $libArr

#备份被替换lib文件
for lib in $libArr
do
  mv $targetDir/$lib $targetDir/$lib-back
  echo "."
done
echo "备份完毕！"
echo "备份结果查看："
ls -l $targetDir/*.so-back


#替换lib文件到目标目录
for lib in $libArr
do
  cp $sourceDir/$lib $targetDir
  echo "."
done

#同步
sync
sync
sync

echo "文件替换完毕！"
echo "替换结果查看："
for lib in $libArr
do
  ls -l $targetDir/$lib*
done


#删除升级文件
echo 请确认是否更新成功
echo 0:失败
echo 1:成功
echo 请根据结果输入数字[0 或者 1]:

while true
do
    read num
    if [ $num == 1 ]
    then
    	echo 替换成功！删除升级文件！！！
		echo ...
		rm  -rf $sourceDir/*.so

		echo 删除成功
		echo 程序执行完毕，退出！
		break
    elif [ $num == 0 ]
    then
    	echo 升级失败，请重新运行脚本！！！
		break
    else
    	echo 输入数值错误，请重新输入:
    fi
done


