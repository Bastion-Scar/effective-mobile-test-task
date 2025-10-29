#!/bin/bash
set -euo pipefail
# Нужные переменные
PROCESS_NAME="test"
URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
PID_FILE="/var/run/${PROCESS_NAME}.pid"

timestamp() { date "+%Y-%m-%d %H:%M:%S"; }

# Проверяем, запущен ли нужный процесс, пишем результат в файл
if pgrep -x "$PROCESS_NAME" >/dev/null; then
    if curl -fsS "$URL" -o /dev/null; then
        echo "$(timestamp) : $PROCESS_NAME процесс запущен, API мониторится" >>"$LOG_FILE"
    else
        echo "$(timestamp) : $PROCESS_NAME процесс запущен, но API не мониторится" >>"$LOG_FILE"
    fi

    # Проверяем, если текущий PID не совпадает с начальным, который указан в переменных - процесс был перезапущен
    PID_NOW=$(pgrep -x "$PROCESS_NAME" | head -n1)
    if [ -f "$PID_FILE" ]; then
        OLD_PID=$(cat "$PID_FILE")
        if [ "$OLD_PID" != "$PID_NOW" ]; then
            echo "$(timestamp) : $PROCESS_NAME перезапущен (PID $OLD_PID >> $PID_NOW)" >>"$LOG_FILE"
        fi
    fi
    echo "$PID_NOW" >"$PID_FILE" #Перезапись делаем, чтоб теперь уже перезаписанный PID сравнивать с OLD_PID(если был рестарт)
else
    echo "$(timestamp) : $PROCESS_NAME процесс не запущен" >> "$LOG_FILE" #Если pgrep не нашел процесс - нет такого процесса
fi
