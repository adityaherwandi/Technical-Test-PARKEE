#!/bin/bash

# Ambil nama host
hostname=$(hostname)

# Ambil waktu sistem saat ini
current_time=$(date)

# Hitung jumlah user yang sedang login
user_count=$(who | wc -l)

# Tampilkan informasi
echo "===== Informasi Sistem ====="
echo "Hostname        : $hostname"
echo "Waktu Sistem    : $current_time"
echo "Pengguna Aktif  : $user_count user(s)"
