#!/bin/sh

BACKUP_FILE="mysql-dump-$(date +%Y-%m-%d-%H%m%S).sql"

docker info >/dev/null

docker compose exec mysql   \
  sh -c '                   \
    exec /usr/bin/mysqldump \
      -h localhost          \
      -u${MYSQL_USER}       \
      -p${MYSQL_PASSWORD}   \
      --add-drop-database   \
      --add-drop-trigger    \
      --flush-privileges    \
      --dump-date           \
      ${MYSQL_DATABASE}
  ' 2>/dev/null > ${BACKUP_FILE}

if [ $? -eq 0 ]; then
  echo "BACKUP FILE: ${BACKUP_FILE}"
else
  echo "Abort, execution failed, try to execute the script with 'sudo'"
  exit 1
fi
