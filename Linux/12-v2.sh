#!/bin/bash

# Input parameter dari user
read -p "Masukkan path file source: " file_source
read -p "Masukkan username remote: " username
read -p "Masukkan IP address server tujuan: " server_ip

# Cek apakah file source ada
if [ ! -f "$file_source" ]; then
  echo "File $file_source tidak ditemukan!"
  exit 1
fi

# Kirim file ke direktori home user remote menggunakan rsync
rsync -avz "$file_source" "$username@$server_ip:~"

if [ $? -eq 0 ]; then
  echo "File berhasil dikirim menggunakan rsync ke $username@$server_ip:~"
else
  echo "Gagal mengirim file menggunakan rsync"
fi
