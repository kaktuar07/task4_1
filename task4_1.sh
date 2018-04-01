#!/bin/bash

FILE_NAME=task4_1.out

rm -rf $FILE_NAME || true

############### HARDWARE ###################3

echo --- Hardware --- >> $FILE_NAME
echo CPU: `cat /proc/cpuinfo  | grep 'name' | uniq | awk '{$1=$2=$3=""; print $0}' | sed -e 's/^[ \t]*//'` >> $FILE_NAME
echo RAM: $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024)))MB >> $FILE_NAME

man=`sudo dmidecode -s baseboard-manufacturer`
if [[ -z $man ]]; then man=Unknown; fi
prod=`sudo dmidecode -s baseboard-product-name`
if [[ -z $prod ]]; then prod=Unknown; fi
ser=`sudo dmidecode -s system-serial-number`
if [[ -z $ser ]]; then ser=Unknown; fi

echo Motherboard: $man $prod >> $FILE_NAME
echo System Serial Number: $ser >> $FILE_NAME

############### SYSTEM #####################

echo --- System --- >> $FILE_NAME
echo OS Distribution: `lsb_release -d -s` >> $FILE_NAME
echo Kernel version: `uname -r` >> $FILE_NAME
echo Installation date: `sudo tune2fs -l /dev/sda1 | grep 'Filesystem created:' | awk '{$1=$2=""; print $0}' | sed -e 's/^[ \t]*//'` >> $FILE_NAME
echo Hostname: `hostname -f` >> $FILE_NAME
echo Uptime: `uptime -p | awk '{$1=""; print $0}' | sed -e 's/^[ \t]*//'` >> $FILE_NAME
echo Processes running: `ps aux --no-heading | wc -l` >> $FILE_NAME
echo Users logged in: `who | wc -l` >> $FILE_NAME

############# NETWORK ####################

echo --- Network --- >> $FILE_NAME
ip -o -4 a | awk '{print $2":",$4}'  >> $FILE_NAME

exit 0
