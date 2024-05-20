#!/bin/bash

arc=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
fram=$(free -m | grep '^Mem' | awk '{print $2}')
uram=$(free -m | grep '^Mem' | awk '{print $3}')
pram=$(free | grep '^Mem' | awk '{printf("%.2f") , $3/$2 * 100}')
fdisk=$(df -Bg | grep '^/dev/' | grep '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bm | grep '^/dev/' | grep '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep '/boot$' | awk '{ut += $3} {ft += $2} END {printf("%d") , (ut/ft *100)}')
cpul=$(mpstat | grep 'all' | awk '{print 100 - $13}')
lb=$(who -b | awk '{printf $3 " " $4}')
lvmu=$(lsblk | grep -q lvm && echo yes || echo no)
ctcp=$(ss -t | grep -c ESTAB)
ulog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | grep 'link/ether' | awk '{print $2}')
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
echo "#Architecture: $arc"
echo "#CPU physical: $pcpu"
echo "#vCPU: $vcpu"
echo "#Memory Usage: $uram/${fram}MB ($pram%)"
echo "#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)"
echo "#CPU load: ($cpul%)"
echo "#Last boot: $lb"
echo "#LVM use: $lvmu"
echo "#Connections TCP: $ctcp ESTABLISHED"
echo "#User log: $ulog"
echo "#Network: IP $ip ($mac)"
echo "#Sudo: $cmds cmd"
