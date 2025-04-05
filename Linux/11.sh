#!/bin/bash

# Input parameter dari user
read -p "Masukkan aksi (start/stop/status): " aksi
read -p "Masukkan nama service: " service_name

# Jalankan aksi sesuai input
case "$aksi" in
  start)
    sudo systemctl start "$service_name"
    echo "Service $service_name telah dimulai."
    ;;
  stop)
    sudo systemctl stop "$service_name"
    echo "Service $service_name telah dihentikan."
    ;;
  status)
    sudo systemctl status "$service_name"
    ;;
  *)
    echo "Aksi tidak valid. Gunakan: start, stop, atau status."
    exit 1
    ;;
esac
