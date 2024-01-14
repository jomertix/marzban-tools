DOCKER_COMPOSE_PATH="/opt/marzban"
BACKUP_DIR="/opt/marzban/backups"
DATE="$(date +%d%m%Y-%H%M%S)"
FILE_NAME="marzban_$DATE"

# Telegram settings
CHAT_ID=""
BOT_TOKEN=""

# Files that have to be backed up
ENV_FILE="/opt/marzban/.env"
DOCKER_FILE="/opt/marzban/docker-compose.yml"
SQLITE_FILE="/var/lib/marzban/db.sqlite3"
XRAY_CONFIG_FILE="/var/lib/marzban/xray_config.json"

# Directories that have to be backed up
TEMPLATES_PATH="/var/lib/marzban/templates"
ASSETS_PATH="/var/lib/marzban/assets"
CERTS_PATH="/var/lib/marzban/certs"


mkdir -p ${BACKUP_DIR}
cd ${DOCKER_COMPOSE_PATH}

# echo "Backup mysql"
# docker compose exec -T mysql /bin/bash -c 'MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysqldump -u root marzban' > "$BACKUP_DIR/$FILE_NAME".sql


echo "Backup files and directories"

# Create empty archive
tar -cf $BACKUP_DIR/$FILE_NAME.tar --files-from /dev/null

# Append archive with files
# tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $BACKUP_DIR/$FILE_NAME.sql
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $ENV_FILE
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $DOCKER_FILE
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $SQLITE_FILE
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $XRAY_CONFIG_FILE

# Append archive with directories
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $TEMPLATES_PATH
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $ASSETS_PATH
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $CERTS_PATH

echo "Compress archive"
gzip $BACKUP_DIR/$FILE_NAME.tar

echo "Send file"
curl -F chat_id="$CHAT_ID" -F document=@"$BACKUP_DIR/$FILE_NAME.tar.gz" https://api.telegram.org/bot$BOT_TOKEN/sendDocument

echo "\nFile is sent"
