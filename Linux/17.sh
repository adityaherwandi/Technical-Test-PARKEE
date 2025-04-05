#!/bin/bash

# Pastikan script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan script ini sebagai root (sudo)."
  exit 1
fi

echo "Mengatur aturan firewall menggunakan iptables..."

# Flush semua aturan lama
iptables -F
iptables -X

# 1. Izinkan semua koneksi keluar
iptables -P OUTPUT ACCEPT

# 2. Izinkan koneksi masuk untuk SSH (22), HTTP (80), HTTPS (443)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# 3. Izinkan koneksi terkait atau yang sudah ada sebelumnya
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 4. Default policy: tolak semua koneksi masuk lainnya
iptables -P INPUT DROP
iptables -P FORWARD DROP

echo "Aturan firewall telah diterapkan:"
iptables -L -n -v
