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
echo "MEMORY USAGE"
free -h

echo ""
echo "SYSTEM LOAD"
uptime

echo ""
echo "======================================"
echo "       HEALTH CHECK COMPLETE"
echo "======================================"
