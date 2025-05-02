#!/bin/bash

# Generate a timestamped output file
OUTPUT_FILE="benchmark_$(date +"%Y-%m-%d_%H-%M-%S").txt"

# Start the benchmark
echo "System Benchmark Report - $(date)" > $OUTPUT_FILE
echo "==================================" >> $OUTPUT_FILE

# CPU Benchmark
echo -e "\n### CPU Benchmark ###" >> $OUTPUT_FILE
sysbench cpu --threads=4 run >> $OUTPUT_FILE

# Disk Performance
echo -e "\n### Disk Performance ###" >> $OUTPUT_FILE

sysbench fileio cleanup
sysbench fileio --file-total-size=2G --file-num=128 prepare

sysbench fileio --file-test-mode=seqwr run >> $OUTPUT_FILE
sysbench fileio --file-test-mode=rndrw run >> $OUTPUT_FILE
sysbench fileio cleanup


# Memory Benchmark
echo -e "\n### Memory Benchmark ###" >> $OUTPUT_FILE
sysbench memory --threads=4 run >> $OUTPUT_FILE

# Hardware Info
echo -e "\n### Hardware Information ###" >> $OUTPUT_FILE
lshw -short >> $OUTPUT_FILE

# Done
echo -e "\nBenchmark complete. Results saved in $OUTPUT_FILE"
