#!/bin/bash

# Input parameter dari user
read -p "Masukkan username remote: " username
read -p "Masukkan IP address server: " server_ip

# Coba koneksi SSH tanpa password prompt (pakai SSH key)
ssh -o BatchMode=yes -o ConnectTimeout=5 "$username@$server_ip" exit

# Coba koneksi SSH menggunakan password prompt
# ssh -o ConnectTimeout=5 "$username@$server_ip" exit

# Cek hasil koneksi
if [ $? -eq 0 ]; then
  echo "Koneksi SSH ke $username@$server_ip berhasil."
else
  echo "Koneksi SSH ke $username@$server_ip gagal."
fi
