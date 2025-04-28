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

# Metrics output
echo "Total CPU Usage: $cpu_usage %"
echo "Total Memory: $total_memory GiB"
echo "Used Memory: $used_memory GiB ($used_memory_percentage %)"
echo "Free Memory: $free_memory GiB ($free_memory_percentage %)"
