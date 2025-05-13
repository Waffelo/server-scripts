#!/bin/bash
# _____         __ __               _______                           __           __
#|     \.---.-.|__|  |.--.--.______|     __|.-----.---.-.-----.-----.|  |--.-----.|  |_
#|  --  |  _  ||  |  ||  |  |______|__     ||     |  _  |  _  |__ --||     |  _  ||   _|
#|_____/|___._||__|__||___  |      |_______||__|__|___._|   __|_____||__|__|_____||____|
# Waffi's backup tool |_____|                           |__|

#Purpose: Make reliable backups for my server

# --- Directories
# Backup directory
WORK_DIR="/mnt/hdd/backup/daily/"

# To backup
TO_BKP=(
"/etc/"
"/srv/docker/"
"/usr/local/bin/"
"/root/Docs/"
)


# Script ------------------------
DT="$(date "+%Y-%m-%d")"

# Make sure log directory exists
if [ ! -d "${WORK_DIR}/logs" ]; then
  mkdir ${WORK_DIR}/logs
fi

sleep 5

# Check if the file exists, if yes, append more info to file name.
if [ -f "$WORK_DIR/backup-${DT}.tar.gz" ]; then
  DT+="$(echo "-")$(date "+%H%M")"
fi

sleep 5

# Archive the backup
cd $WORK_DIR
echo -e "# ----- ARCHIVING ----------" >> logs/${DT}.log
tar -czvf backup-${DT}.tar.gz ${TO_BKP[@]} >> logs/${DT}.log

# Prune old backups
cd $WORK_DIR
echo -e "# ----- PRUNING ----------" >> logs/${DT}.log
find "$WORK_DIR" -maxdepth 1 -mtime +7 -exec rm {} \; >> logs/${DT}.log

