#!/bin/bash

# -----------------------------
# Server Stats Script
# -----------------------------
echo "========== SERVER STATS =========="

# 1️⃣ Total CPU usage
echo -e "\n--- CPU Usage ---"
# Using top in batch mode to get CPU line
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{usage=100-$8} END {print usage "%"}')
echo "Total CPU Usage: $CPU_USAGE"

# 2️⃣ Total Memory usage
echo -e "\n--- Memory Usage ---"
MEM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
MEM_USED=$(free -h | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -h | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(free | awk '/Mem:/ {printf("%.2f%%",$3/$2*100)}')
echo "Total: $MEM_TOTAL | Used: $MEM_USED | Free: $MEM_FREE | Usage: $MEM_PERCENT"

# 3️⃣ Total Disk usage
echo -e "\n--- Disk Usage ---"
# Show root partition only
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')
echo "Total: $DISK_TOTAL | Used: $DISK_USED | Free: $DISK_FREE | Usage: $DISK_PERCENT"

# 4️⃣ Top 5 processes by CPU usage
echo -e "\n--- Top 5 Processes by CPU ---"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

# 5️⃣ Top 5 processes by Memory usage
echo -e "\n--- Top 5 Processes by Memory ---"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -n 6

echo -e "\n================================="
