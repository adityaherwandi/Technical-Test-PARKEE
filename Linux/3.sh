#!/bin/bash

# Input direktori dari user
read -p "Masukkan direktori: " direktori

# Cek apakah direktori valid
if [ ! -d "$direktori" ]; then
  echo "Direktori tidak ditemukan!"
  exit 1
fi

# Header tabel
printf "%-30s %-10s %-10s %-10s\n" "Nama File" "Baris" "Kata" "Karakter"
printf "%-30s %-10s %-10s %-10s\n" "----------" "-----" "----" "---------"

# Loop untuk setiap file .txt di direktori
find "$direktori" -type f -name "*.txt" | while read file; do
  baris=$(wc -l < "$file")
  kata=$(wc -w < "$file")
  karakter=$(wc -m < "$file")
  nama_file=$(basename "$file")

  printf "%-30s %-10s %-10s %-10s\n" "$nama_file" "$baris" "$kata" "$karakter"
done
