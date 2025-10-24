# Скрипт для мониторинга процесса test
Программа предназначена для контроля состояния процесса test и проверки доступности API https://test.com/monitoring/test/api.
Скрипт каждую минуту проверяет и фиксирует активность процесса и её обращения к API, сохраняя информацию в лог-файле /var/log/monitoring.log

# Необходимые инструменты
- bash
- systemD
- curl
- pgrep

- sudo apt update
- sudo apt install curl
- sudo apt install procps


# Запуск скрипта
0. Клонируйте проект (начинаем с 0, верно? хехе)

git clone https://github.com/Bastion-Scar/effective-mobile-test-task

1. Перейдите в папку со скриптом

cd effective-mobile-test-task

2. Получите права на выполнение скрипта:
   
sudo chmod 755 ./deploy.sh

3. Разверните скрипт:

sudo ./deploy.sh

4. Дайте программе поработать и проверьте результаты:

sudo cat /var/log/monitoring.log

# Отключение мониторинга
sudo systemctl disable --now monitoring.timer

# Посмотреть статус
sudo systemctl status --now monitoring.timer

# Если что то поменяли в monitoring.service или monitoring.timer
- sudo systemctl daemon-reload
- sudo systemctl restart monitoring.timer
