#!/bin/bash

# Nama file log
log_file="cpu_monitor_$(date +%Y%m%d).log"

# Ambil load average 1 menit pertama
load_avg=$(uptime | awk -F 'load average: ' '{print $2}' | cut -d',' -f1)

# Ambil jumlah core CPU (untuk menentukan ambang batas 75%)
core_count=$(nproc)
threshold=$(echo "$core_count * 0.75" | bc)

# Bandingkan load average dengan threshold
is_high=$(echo "$load_avg > $threshold" | bc)

# Jika load lebih tinggi dari ambang batas
if [ "$is_high" -eq 1 ]; then
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - WARNING: CPU load tinggi! Load: $load_avg | Threshold: $threshold" >> "$log_file"
    echo "Load tinggi terdeteksi dan dicatat di $log_file"
fi
