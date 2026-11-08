#!/bin/bash

# CloudOps Sentinel - Linux Health Check

echo "======================================"
echo "       CLOUDOPS SENTINEL"
echo "       Linux Health Check"
echo "======================================"

echo ""
echo "HOST INFORMATION"
echo "Hostname: $(hostname)"
echo "Date: $(date)"

echo ""
echo "========== DISK HEALTH =========="

disk_usage=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Root Disk Usage: ${disk_usage}%"

if [ "$disk_usage" -ge 90 ]; then
    echo "Status: CRITICAL"
elif [ "$disk_usage" -ge 80 ]; then
    echo "Status: WARNING"
else
    echo "Status: OK"
fi

echo ""
echo "========== CPU HEALTH =========="

# First CPU reading
read -r cpu user nice system idle iowait irq softirq steal rest < /proc/stat

total1=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle1=$((idle + iowait))

# Wait one second before the second reading
sleep 1

# Second CPU reading
read -r cpu user nice system idle iowait irq softirq steal rest < /proc/stat

total2=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle2=$((idle + iowait))

# Calculate CPU utilization
total_diff=$((total2 - total1))
idle_diff=$((idle2 - idle1))

if [ "$total_diff" -gt 0 ]; then
    cpu_usage=$((100 * (total_diff - idle_diff) / total_diff))
else
    cpu_usage=0
fi

echo "CPU Usage: ${cpu_usage}%"

if [ "$cpu_usage" -gt 85 ]; then
    echo "Status: CRITICAL"
elif [ "$cpu_usage" -ge 70 ]; then
    echo "Status: WARNING"
else
    echo "Status: OK"
fi

echo ""
echo "========== MEMORY HEALTH =========="

mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
mem_available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)

mem_used=$((mem_total - mem_available))
mem_usage=$((100 * mem_used / mem_total))

echo "Total Memory: $((mem_total / 1024)) MiB"
echo "Available Memory: $((mem_available / 1024)) MiB"
echo "Memory Usage: ${mem_usage}%"

if [ "$mem_usage" -ge 90 ]; then
    echo "Status: CRITICAL"
elif [ "$mem_usage" -ge 80 ]; then
    echo "Status: WARNING"
else
    echo "Status: OK"
fi


echo ""
echo "SYSTEM LOAD"
uptime

echo ""
echo "======================================"
echo "       HEALTH CHECK COMPLETE"
echo "======================================"
