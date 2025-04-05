#!/bin/bash

# Input parameter dari user
read -p "Masukkan path file public key: " public_key
read -p "Masukkan username remote: " username
read -p "Masukkan IP address server: " server_ip

# Cek apakah file public key ada
if [ ! -f "$public_key" ]; then
  echo "File public key tidak ditemukan!"
  exit 1
fi

# Salin public key ke server remote
ssh-copy-id -i "$public_key" "$username@$server_ip"

# Tampilkan hasil
if [ $? -eq 0 ]; then
  echo "Public key berhasil dikirim ke $username@$server_ip"
  echo "Sekarang kamu bisa SSH tanpa password."
else
  echo "Gagal menyalin public key."
fi
