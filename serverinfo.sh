#!/bin/bash

# Colors
RED='\033[5m\033[31m'
GREEN='\033[0;32m'
BLACK='\033[0m'

# System info
TITLE=$(hostname)
HOSTIP=$(hostname -I | awk {'print $1'})
uptime=$(uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days",h+0,"hours"}')
free_memory=$(free -m | awk 'NR==2{printf "Memory Usage: %sMB / %sMB (%.2f%%)\n", $3,$2,$3*100/$2}')
disk_usage=$(df -h / | grep "G" | awk {'print "Disk Usage: ",$3,"/",$2,"("$5")"'})

# Services:
serv1="ssh"
# serv2="postgres"

# Docker containers:
# container1="mongodb"
# container2="linkwarden"

# OS info
[ -f /usr/bin/toilet ] && toilet -f mono12 -F metal -w 120 $TITLE || echo -e "$GREEN====== $TITLE ($HOSTIP) ======$BLACK"
echo "Uptime: $uptime"
echo $free_memory
echo $disk_usage

# Check services status
echo -e "\nServices Status: "
[ "$(systemctl list-units --type=service --state=running | grep $serv1)" ] && echo -e "[$GREEN OK $BLACK] $serv1" || echo -e "[$RED FAIL $BLACK] $serv1"
# [ "$(systemctl list-units --type=service --state=running | grep $serv2)" ] && echo -e "[$GREEN OK $BLACK] $serv2" || echo -e "[$RED FAIL $BLACK] $serv2"

# If docker containers
# echo -e "\nDocker containers: "
# [ "$(docker ps | grep $container1)" ] && echo -e "[$GREEN OK $BLACK] $container1" || echo -e "[$RED FAIL $BLACK] $container1"
# [ "$(docker ps | grep $container2)" ] && echo -e "[$GREEN OK $BLACK] $container2" || echo -e "[$RED FAIL $BLACK] $container2"
