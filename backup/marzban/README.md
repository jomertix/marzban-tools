# Description

Script backups the Marzban data and other files that you want to be saved and sends them to Telegram


# Installation

Connect to the server and upload the file:
```
cd /opt/marzban/
sudo wget https://raw.githubusercontent.com/jomertix/marzban-tools/master/backup/marzban/marzban-backup.sh
```

Open the file and edit it:
```
sudo nano /opt/marzban/marzban-backup.sh
```
Find and fill ``CHAT_ID`` and ``BOT_TOKEN`` 


## SQLite backup

By default script backups sqlite database file. Skip this part.

## MySQL backup

If you store the data in MySQL and want to backup it, open the script:
```
sudo nano /opt/marzban/marzban-backup.sh
```
then find and comment lines:
```
# SQLITE_FILE="/var/lib/marzban/db.sqlite3"
# tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $SQLITE_FILE
```

uncomment following lines:
```
docker compose exec -T mysql /bin/bash -c 'MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysqldump -u root marzban' > "$BACKUP_DIR/$FILE_NAME".sql
tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $BACKUP_DIR/$FILE_NAME.sql
```

# Finish Installation

Add a task to crontab so backup will be automatically created every 12 hours:
```
(crontab -l ; echo "0 0,12 * * * /bin/bash /opt/marzban/marzban-backup.sh")| crontab -
```

To check if the file is correct just create a backup:
```
sh /opt/marzban/marzban-backup.sh
```
# Restore backup

```
docker compose exec -T mysql mysql -pPASSWORD -u root marzban < dump.sql
```

# Backup other files and directories

* Add variable to bash script: ``ANOTHER_FILE="/path/to/file"``
* To add the file/directory to the archive add this line to the according section in script: ``tar -rf $BACKUP_DIR/$FILE_NAME.tar --absolute-names $ANOTHER_FILE``
