#!/bin/bash

#-----------------------------------------------------------
# filename:camInfo.sh
# version:1.0
# date:2017/03/17
# author:yangql
# program:Camera running status information
#-----------------------------------------------------------

top -n 1 > /tmp/top.log
TEMP=$(cat /sys/bus/i2c/devices/0-004f/temp1_input)
VSZ=$(egrep Traffic /tmp/top.log | awk '{printf $5}' | egrep -o [0-9]+m)
CPU=$(egrep Traffic /tmp/top.log | awk '{printf $7}')
USED=$(egrep Mem /tmp/top.log | awk '{printf $2}')
FREE=$(egrep Mem /tmp/top.log | awk '{printf $4}')
CACHED=$(egrep Mem /tmp/top.log | awk '{printf $10}')

printf "%-10s %-10s %-10s %-10s %-10s %-10s\n" VSZ CPU USED FREE CACHED TEMP
printf "%-10s %-10s %-10s %-10s %-10s %-10i\n" $VSZ $CPU $USED $FREE $CACHED $TEMP

printf "\nsystem.log:\n"
tail /sdcard/data/system.log