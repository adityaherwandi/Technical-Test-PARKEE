#!/bin/bash

# Input direktori sumber dan tujuan backup
read -p "Masukkan direktori sumber: " source_direktori
read -p "Masukkan direktori tujuan backup: " backup_direktori

# Cek apakah direktori sumber valid
if [ ! -d "$source_direktori" ]; then
  echo "Direktori sumber tidak ditemukan!"
  exit 1
fi

# Cek apakah direktori backup ada, kalau tidak buat
if [ ! -d "$backup_direktori" ]; then
  mkdir -p "$backup_direktori"
fi

# Nama file backup dengan timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")
nama_backup="backup_$timestamp.tar.gz"

# Proses backup
tar -czvf "$backup_direktori/$nama_backup" "$source_direktori"

# Hapus backup yang lebih lama dari 7 hari
find "$backup_direktori" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;
