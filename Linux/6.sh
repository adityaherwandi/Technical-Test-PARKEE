#!/bin/bash

# Input direktori penyimpanan dari user
read -p "Masukkan direktori untuk menyimpan SSH key: " key_direktori

# Cek dan buat direktori jika belum ada
if [ ! -d "$key_direktori" ]; then
  mkdir -p "$key_direktori"
  echo "Direktori $key_direktori telah dibuat."
fi

# Path lengkap file key
key_path="$key_direktori/id_rsa"

# Cek apakah file sudah ada
if [ -f "$key_path" ] || [ -f "${key_path}.pub" ]; then
  echo "SSH key sudah ada di direktori ini:"
  echo "Private: $key_path"
  echo "Public : ${key_path}.pub"
  echo "Proses dibatalkan untuk mencegah overwrite."
  exit 1
fi

# Generate SSH key tanpa passphrase
ssh-keygen -t rsa -b 4096 -f "$key_path" -N ""

echo "SSH key berhasil dibuat di:"
echo "Private key: $key_path"
echo "Public key : ${key_path}.pub"
