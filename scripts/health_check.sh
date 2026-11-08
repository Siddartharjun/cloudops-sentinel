
#!/bin/bash

# CloudOps Sentinel - Linux Health Check

PROJECT_DIR="$HOME/cloudops-sentinel"
LOG_FILE="$PROJECT_DIR/logs/alerts.log"

# Create log directory if missing
mkdir -p "$PROJECT_DIR/logs"

# Alert logging function
log_alert() {
    local severity="$1"
    local message="$2"
    local timestamp

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "$timestamp | $severity | $message" | tee -a "$LOG_FILE"
}

echo "======================================"
echo "          CLOUDOPS SENTINEL"
echo "          Linux Health Check"
echo "======================================"

echo ""
echo "HOST INFORMATION"
echo "Hostname: $(hostname)"
echo "Date: $(date)"

# --------------------------------------
# DISK HEALTH
# --------------------------------------

echo ""
echo "========== DISK HEALTH =========="

disk_usage=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Root Disk Usage: ${disk_usage}%"

if [ "$disk_usage" -ge 90 ]; then
    echo "Status: CRITICAL"
    log_alert "CRITICAL" "Root disk usage reached ${disk_usage}%"
elif [ "$disk_usage" -ge 80 ]; then
    echo "Status: WARNING"
    log_alert "WARNING" "Root disk usage reached ${disk_usage}%"
else
    echo "Status: OK"
fi

# --------------------------------------
# CPU HEALTH
# --------------------------------------

echo ""
echo "========== CPU HEALTH =========="

read -r cpu user nice system idle iowait irq softirq steal rest < /proc/stat

total1=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle1=$((idle + iowait))

sleep 1

read -r cpu user nice system idle iowait irq softirq steal rest < /proc/stat

total2=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle2=$((idle + iowait))

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
    log_alert "CRITICAL" "CPU usage reached ${cpu_usage}%"
elif [ "$cpu_usage" -ge 70 ]; then
    echo "Status: WARNING"
    log_alert "WARNING" "CPU usage reached ${cpu_usage}%"
else
    echo "Status: OK"
fi

# --------------------------------------
# MEMORY HEALTH
# --------------------------------------

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
    log_alert "CRITICAL" "Memory usage reached ${mem_usage}%"
elif [ "$mem_usage" -ge 80 ]; then
    echo "Status: WARNING"
    log_alert "WARNING" "Memory usage reached ${mem_usage}%"
else
    echo "Status: OK"
fi

# --------------------------------------
# SYSTEM LOAD
# --------------------------------------

echo ""
echo "========== SYSTEM LOAD =========="
uptime

echo ""
echo "======================================"
echo "          HEALTH CHECK COMPLETE"
echo "======================================"

