#!/bin/bash

# Total CPU usage
cpu_usage=$((100 - $(vmstat 1 2 | tail -1 | awk '{print $15}')))

# Memory usage
memory_stats=$(free | grep -w "Mem:")
total_memory=$(echo "$memory_stats" | awk '{print $2 / 1024^2}')  # Convert to GiB
used_memory=$(echo "$memory_stats" | awk '{print $3 / 1024^2}')   # Convert to GiB
free_memory=$(echo "$memory_stats" | awk '{print $4 / 1024^2}')   # Convert to GiB

# Percentage calculation
used_memory_percentage=$(echo "scale=2; ($used_memory / $total_memory) * 100" | bc)
free_memory_percentage=$(echo "scale=2; ($free_memory / $total_memory) * 100" | bc)

# Total disk usage (Free vs Used including percentage)
disk_stats=$(df -B1 --total | grep "total")

total_disk=$(echo "$disk_stats" | awk '{print $2 / 1024^3}')
used_disk=$(echo "$disk_stats" | awk '{print $3 / 1024^3}')
free_disk=$(echo "$disk_stats" | awk '{print $4 / 1024^3}')

used_disk_percentage=$(echo "scale=2; ($used_disk / $total_disk) * 100" | bc)

# Top 5 processes by CPU usage
top_cpu_processes=$(ps -eo comm,%cpu --sort=-%cpu | head -6 | tail -5)

# Top 5 processes by memory usage (with "MEM" explicitly added)
top_memory_processes=$(ps -eo pid,comm,%mem --sort=-%mem | head -6 | tail -5 | awk '{printf "%-20s MEM: %.2f%%\n", $2, $3}' | sort -k2 -nr
)

# Metrics output
echo "Server stats:"
echo "---"
echo "Total CPU Usage: $cpu_usage %"
echo "---"
echo "Total Memory: $total_memory GiB"
echo "Used Memory: $used_memory GiB ($used_memory_percentage %)"
echo "Free Memory: $free_memory GiB ($free_memory_percentage %)"
echo "---"
echo "Total Disk Space: $total_disk GiB"
echo "Used Disk Space: $used_disk GiB ($used_disk_percentage %)"
echo "Free Disk Space: $free_disk GiB"
echo "---"
echo "Top 5 Processes by CPU Usage:"
echo "$top_cpu_processes"
echo "---"
echo "Top 5 Processes by Memory Usage:"
echo "$top_memory_processes"
