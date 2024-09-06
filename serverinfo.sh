#!/bin/bash

# Colors
RED='\033[5m\033[31m'
GREEN='\033[0;32m'
BLACK='\033[0m'

# System info
TITLE=$(hostname)
HOSTIPV4=$(curl -4 -s --max-time 2 ifconfig.co || echo "Address not available")
HOSTIPV6=$(curl -6 -s --max-time 2 ifconfig.co || echo "Address not available")
uptime=$(uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days",h+0,"hours"}')
free_memory=$(free -m | awk 'NR==2{printf "Memory Usage: %sMB / %sMB (%.2f%%)\n", $3,$2,$3*100/$2}')
disk_usage=$(df -h / | grep "G" | awk {'print "Disk Usage: ",$3,"/",$2,"("$5")"'})
load_average=$(uptime | awk -F 'load average: ' '{print "Load Average: " $2}')

# OS info
echo -e "$GREEN====== $TITLE ======$BLACK"
echo "IPv4: $HOSTIPV4"
echo "IPv6: $HOSTIPV6"
echo "Uptime: $uptime"
echo $free_memory
echo $disk_usage
echo $load_average


# Check services status
echo -e "\nServices Status: "
serv1="ssh"
[ "$(systemctl list-units --type=service --state=running | grep $serv1)" ] && echo -e "[$GREEN OK $BLACK] $serv1" || echo -e "[$RED FAIL $BLACK] $serv1"

# If WireGuard
if [ -f /usr/bin/wg ]; then
    echo -e "\nWireGuard interfaces: "
    interface1="warp"
    [ "$(wg show interfaces | grep $interface1)" ] && echo -e "[$GREEN OK $BLACK] warp" || echo -e "[$RED FAIL $BLACK] warp"
fi

# If docker containers
if [ -f /usr/bin/docker ]; then
    echo -e "\nDocker containers: "
    container1="nginx"
    [ "$(docker ps | grep $container1)" ] && echo -e "[$GREEN OK $BLACK] $container1" || echo -e "[$RED FAIL $BLACK] $container1"
fi