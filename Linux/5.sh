#!/bin/bash

# Nama file log dengan timestamp
log_file="update_log_$(date +%Y%m%d_%H%M%S).log"

# Jalankan update dan simpan log
echo "Memulai pembaruan sistem..." | tee "$log_file"

sudo apt update 2>&1 | tee -a "$log_file"
sudo apt upgrade -y 2>&1 | tee -a "$log_file"

echo "Pembaruan selesai. Log disimpan di $log_file" | tee -a "$log_file"
