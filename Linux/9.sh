#!/bin/bash

# Input parameter dari user
read -p "Masukkan path file public key: " public_key
read -p "Masukkan username lokal: " username

# Cek apakah file public key ada
if [ ! -f "$public_key" ]; then
  echo "File public key tidak ditemukan!"
  exit 1
fi

# Tentukan direktori .ssh milik user
user_home=$(eval echo "~$username")
ssh_dir="$user_home/.ssh"
authorized_keys="$ssh_dir/authorized_keys"

# Buat direktori .ssh jika belum ada
if [ ! -d "$ssh_dir" ]; then
  mkdir -p "$ssh_dir"
  chown "$username":"$username" "$ssh_dir"
  chmod 700 "$ssh_dir"
  echo "Direktori .ssh dibuat di $ssh_dir"
fi

# Tambahkan key ke authorized_keys (jika belum ada)
if grep -qxFf "$public_key" "$authorized_keys" 2>/dev/null; then
  echo "Public key sudah ada di authorized_keys."
else
  cat "$public_key" >> "$authorized_keys"
  chown "$username":"$username" "$authorized_keys"
  chmod 600 "$authorized_keys"
  echo "Public key berhasil ditambahkan ke $authorized_keys"
fi
