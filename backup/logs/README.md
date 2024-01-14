# Description

Script backups Xray logs, cleans files, leaving the last 5 lines, and sends files to Telegram. By default, log files are stored in ``/var/lib/marzban/logs/access.log`` and ``/var/lib/marzban/logs/error.log``

# Installation

Connect to the server and upload the file:
```
cd /opt/marzban/
sudo wget https://raw.githubusercontent.com/jomertix/marzban-tools/master/backup/logs/logs-backup.sh
```

Open the file and edit it:
```
sudo nano /opt/marzban/logs-backup.sh
```
Find and fill ``CHAT_ID`` and ``BOT_TOKEN`` 

# Finish installation

Add a task to crontab so backup will be automatically created every 24 hours:
```
(crontab -l ; echo "0 0 * * * /bin/bash /opt/marzban/logs-backup.sh")| crontab -
```

To check if the file is correct just create a backup:
```
sh /opt/marzban/logs-backup.sh
```

# Backup other files

A convenient feature is that you can backup any file by specifying its name when running the script. For example, you want to make a backup of ``/home/text.txt`` and ``/opt/script.sh`` then you run ``sh /opt/marzban/logs-marzban.sh /home/test.txt /opt/script.sh``
