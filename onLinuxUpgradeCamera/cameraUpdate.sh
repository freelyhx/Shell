#!/bin/bash

#--------------------------------------------------------
# 文件名：cameraUpdate.sh
# 版本：1.0
# 日期：2017/04/19
# 作者：yangql
# 用途：在linux系统中升级相机程序
#--------------------------------------------------------
# 版本：1.1
# 日期：2017/04/20
# 作者：yangql
# 更新日志：增加注释，便于维护
#--------------------------------------------------------

upgradeFile=upgradePackage.tar.gz
localDir=`pwd`


# use FTP connect camera and up upgradePackage
function sendfile
{
    ftp -n << EOF


    open $1
    user root
    mkdir /tmp/s2
    cd /tmp/s2
    bin
    lcd $localDir
    put $upgradeFile
    exit
EOF
}


# telnet camera and upgrade camera
function upCamera
{
    (
        sleep 5
        echo 'root'
        sleep 5
        echo 'ls /tmp/s2'
        sleep 5
        echo 'cd /opt/IVE_update_s2'
        sleep 10
        echo './update_traffic1.sh'
        sleep 5
        echo './update_traffic2.sh'
        sleep 40
        echo 'reboot'
        sleep 5
    )|telnet $1
}

printf "Please input camera IP:"
read cameraIP
printf "Make sure update $cameraIP\nPlease input(y or n):"
read x
if [ $x == "y" ]
then
    sendfile $cameraIP
    upCamera $cameraIP
elif [ $x == "n" ]
then
    echo "Cancel update and quit."
    exit 2
else
    echo "Input error!"
    echo "quit!"
    exit 1
fi
