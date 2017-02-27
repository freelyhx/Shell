#!/bin/sh

# waiting for timing
printf "*****\n*****\n*****\n" >> date.txt
sleep 3m

# display now time
printf "NowTime: `date` \n" >> date.txt

# set time
date -s '2016-12-12 12:12:12'
printf "SetTime: `date` \n" >> date.txt

# set hwclock and display hwtime
hwclock -w
printf "HwTime: `date` \n" >> date.txt

# reboot camera
sleep 1m
shutdown -r 0

