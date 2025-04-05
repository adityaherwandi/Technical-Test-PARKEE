#!/bin/bash

# Ambang batas penggunaan disk (dalam %)
threshold=80

# Alamat email tujuan notifikasi
email_tujuan="<name-email>@example.com"

# Cek apakah mailutils terinstal
if ! command -v mail &> /dev/null; then
    echo "mailutils tidak terinstal. Silakan instal dengan 'sudo apt install mailutils'."
    exit 1
fi

# Cek semua mount point
df -hP | grep '^/dev/' | while read line; do
    usage=$(echo $line | awk '{print $5}' | tr -d '%')
    mount_point=$(echo $line | awk '{print $6}')

    if [ "$usage" -ge "$threshold" ]; then
        message="⚠️ Disk usage pada mount point $mount_point mencapai $usage%."
        echo "$message"

        # Kirim notifikasi via email
        echo "$message" | mail -s "Peringatan Disk Penuh ($usage%) di $mount_point" "$email_tujuan"
    fi
done
