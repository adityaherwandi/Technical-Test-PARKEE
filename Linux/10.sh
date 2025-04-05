#!/bin/bash

# Input parameter dari user
read -p "Masukkan string unik dari public key: " unique_string
read -p "Masukkan username lokal: " username

# Tentukan path file authorized_keys
user_home=$(eval echo "~$username")
authorized_keys="$user_home/.ssh/authorized_keys"

# Cek apakah file authorized_keys ada
if [ ! -f "$authorized_keys" ]; then
  echo "File authorized_keys tidak ditemukan untuk user $username."
  exit 1
fi

# Cek apakah key yang dimaksud ada
if grep -q "$unique_string" "$authorized_keys"; then
  # Hapus baris yang mengandung string unik
  sed -i "/$unique_string/d" "$authorized_keys"
  echo "Public key dengan string '$unique_string' telah dihapus dari $authorized_keys"
else
  echo "Tidak ditemukan public key dengan string '$unique_string' di $authorized_keys"
fi
