BACKUP_DIR="/var/log/xray/backups"
DATE="$(date +%d%m%Y-%H%M%S)"
FILE_NAME="xray-logs-$DATE"

# Telegram settings
CHAT_ID=""
BOT_TOKEN=""

# Files to be saved
ACCESS_FILE="/var/lib/marzban/logs/access.log"
ERRORS_FILE="/var/lib/marzban/logs/error.log"


# Sending files via Telegram
sendFiles() {
        ip=$(hostname -I | awk '{ print $1 }')
        caption="IP: $ip. Server: server_name"
        for file in "$@"; do
                curl -F chat_id="$CHAT_ID" -F caption="$caption" -F document=@$file https://api.telegram.org/bot$BOT_TOKEN/sendDocument
       	echo "\nFile $file is sent"
	done
}


# Send files that given in args and exit
if [ "$1" ]; then
	echo "Sending files"
        sendFiles $@
        exit
fi


mkdir -p ${BACKUP_DIR}

echo "Backup logs"
# Create empty archive
tar -cf $BACKUP_DIR/$FILE_NAME.tar --files-from /dev/null

# Append archive with files
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names "$ACCESS_FILE"
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names "$ERRORS_FILE"

echo "Compress archive"
gzip $BACKUP_DIR/$FILE_NAME.tar

echo "Clean files"
sed -i -e :a -e '$q;N;6,$D;ba' $ACCESS_FILE
sed -i -e :a -e '$q;N;6,$D;ba' $ERRORS_FILE

echo "Send file"
sendFiles "$BACKUP_DIR/$FILE_NAME.tar.gz"
