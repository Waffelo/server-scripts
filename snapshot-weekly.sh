#!/bin/sh
# ________               __     __                                              __           __   
#|  |  |  |.-----.-----.|  |--.|  |.--.--.______.-----.-----.---.-.-----.-----.|  |--.-----.|  |_ 
#|  |  |  ||  -__|  -__||    < |  ||  |  |______|__ --|     |  _  |  _  |__ --||     |  _  ||   _|
#|________||_____|_____||__|__||__||___  |      |_____|__|__|___._|   __|_____||__|__|_____||____|
# Waffelo's Server Backup tool     |_____|                        |__|                            

# Purpose: Make reliable backups for my server


# --- Directories
# Backup directory
WORK_DIR="/mnt/hdd/backup/weekly/"

# To backup
TO_BKP=(
"/etc/"
"/usr/local/bin/"
"/var/www"
"/srv/docker/"
"/root/Docs/"
)

# Script ------------------------
DT="$(date "+%Y-%m-%d")"

# Make sure that logs directory exists
if [ ! -d "${WORK_DIR}/logs" ]; then
  mkdir ${WORK_DIR}/logs
fi

sleep 5

# Check if file exists, if yes then append more details to filename
if [ -f "$WORK_DIR/backup-${DT}.tar.gz" ]; then
   DT+="_$(date "+%H%M")"
fi

sleep 5

# Archive backup
cd $WORK_DIR
echo "# ----- ARCHIVING ----------" >> logs/${DT}.log
tar -czvf backup-${DT}.tar.gz ${TO_BKP[@]} >> logs/${DT}.log

sleep 5

# Prune old backups
cd $WORK_DIR
echo "# ----- PRUNING ----------" >> logs/${DT}.log
find "$WORK_DIR" -maxdepth 1 -mtime +31 -exec rm {} \;
