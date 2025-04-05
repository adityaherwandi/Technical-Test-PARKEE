#!/bin/bash

# Pastikan dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan script ini dengan sudo atau sebagai root."
  exit 1
fi

# Nama file konfigurasi Netplan (sesuaikan nama file)
config_file="/etc/netplan/01-netcfg.yaml"

# Buat konfigurasi Netplan
cat <<EOF > "$config_file"
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

# Terapkan konfigurasi
echo "Menerapkan konfigurasi netplan..."
netplan apply

# Konfirmasi hasil
echo "Konfigurasi netplan diterapkan. Cek dengan 'ip a' atau 'netplan try'"
