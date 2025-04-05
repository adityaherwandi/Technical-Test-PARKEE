#!/bin/bash

# Minta input dari user
read -p "Masukkan path ke script Python (contoh: /home/aditya/my_script.py): " python_script
read -p "Masukkan nama service (contoh: mypython): " service_name

# Validasi script Python
if [ ! -f "$python_script" ]; then
  echo "Script Python tidak ditemukan di path: $python_script"
  exit 1
fi

# Buat unit file systemd
unit_file="/etc/systemd/system/${service_name}.service"

sudo bash -c "cat > $unit_file" << EOF
[Unit]
Description=Python Service untuk $service_name
After=network.target

[Service]
ExecStart=/usr/bin/python3 $python_script
Restart=always
User=$USER
WorkingDirectory=$(dirname "$python_script")

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon & enable service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable "$service_name"

echo " Service '$service_name' telah dibuat dan di-enable."
echo "  Gunakan perintah berikut untuk mengelolanya:"
echo "   sudo systemctl start $service_name"
echo "   sudo systemctl stop $service_name"
echo "   sudo systemctl status $service_name"
