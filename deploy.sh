#!/bin/bash
LOG_FILE="/var/log/monitoring.log"

sudo cp monitoring.sh /usr/local/bin/monitoring.sh
sudo chmod +x /usr/local/bin/monitoring.sh #Копируем файл и даем право быть исполняемым
sudo chmod 644 "$LOG_FILE"
sudo cp monitoring.service /etc/systemd/system/monitoring.service
sudo cp monitoring.timer /etc/systemd/system/monitoring.timer #Копируем в systemd, чтоб работало всегда, пока enable
sudo systemctl daemon-reload 
sudo systemctl enable --now monitoring.timer #3 2 1 ПУСК