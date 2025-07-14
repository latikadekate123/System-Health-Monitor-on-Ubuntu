#!/bin/bash

logfile="$HOME/system_health_log.txt"
max_disk=75  
max_mem=90  
now=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$now] System Health Check Started..." >> "$logfile"

echo "===================================================================" >> "$logfile"
echo "-------------------------------------------------------------------" >> "$logfile"
echo "1. Disk Usage" >> "$logfile"
echo "-------------------------------------------------------------------" >> "$logfile"
while read -r mount usage; do
    usage_percent=${usage%%%}
    if [ "$usage_percent" -ge "$max_disk" ]; then
        echo " High disk usage on '$mount': ${usage_percent}%" | tee -a "$logfile"

        paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
        notify-send " Disk Usage Alert!!!" "$mount is at ${usage_percent}%"
    else
        echo " $mount is within safe usage ($usage)" >> "$logfile"
    fi
done < <(df -h --output=target,pcent | tail -n +2)

echo "-------------------------------------------------------------------" >> "$logfile"
echo "2. Memory Usage" >> "$logfile"
echo "-------------------------------------------------------------------" >> "$logfile"
mem_info=$(free -m | awk '/^Mem:/ {printf "%.2f", $3*100/$2}')
mem_usage=${mem_info%.*}

if [ "$mem_usage" -ge "$max_mem" ]; then
    echo " High memory usage: ${mem_info}%" | tee -a "$logfile"
    
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
    notify-send " Memory Alert!!!" "Memory usage is ${mem_info}%"
else
    echo " Memory usage: ${mem_info}%" >> "$logfile"
fi

echo "-------------------------------------------------------------------" >> "$logfile"
echo "3. CPU Load (1 min avg)" >> "$logfile"
echo "-------------------------------------------------------------------" >> "$logfile"
load=$(cut -d ' ' -f1 /proc/loadavg)
echo " CPU Load Average: $load" >> "$logfile"

echo "-------------------------------------------------------------------" >> "$logfile"
echo "4. Uptime" >> "$logfile"
echo "-------------------------------------------------------------------" >> "$logfile"
uptime_str=$(uptime -p)
echo " System has been running: $uptime_str" >> "$logfile"

echo "-------------------------------------------------------------------" >> "$logfile"
echo "[$now] System Health Check Complete" >> "$logfile"
echo "===================================================================" >> "$logfile"

# Notification
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
notify-send " System Health Check Completed!" "All checks passed and saved to $logfile"
