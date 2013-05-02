#! /bin/sh

while true; do

eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4
eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); intervaltotal=$((total-${prevtotal:-0}))
echo -n "{#3399FF}CPU:{#999999}$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))%:"
echo -n "$(awk '/MHz/ {printf "%.0f", $4}' /proc/cpuinfo)Mz "
echo -n "{#3399FF}RAM:{#999999}$(free -m | grep -i /cache | awk '{print$3}')Mb "
echo -n "{#3399FF}T:{#999999}$(($(cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp1_input) / 1000))C "
echo -n "{#3399FF}/:{#999999}$(df -h | sed -n 2p | awk '{print $3}') "
echo -n "{#3399FF}/home:{#999999}$(df -h /dev/sda6 | sed -n 2p | awk '{print $3}') "
date +'{#3399FF}%b %d {#FFFFFF}%l:%M%P'

sleep 5

done 
