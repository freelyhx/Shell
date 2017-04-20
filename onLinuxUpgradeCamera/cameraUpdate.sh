#!/bin/bash

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
