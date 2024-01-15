#!/bin/bash

# Database credentials
USER="root"
PASSWORD="PRG@1qaz"
DATABASE="laravel"

# Backup directory
BACKUP_DIR="/root/dbbackup"

# Timestamp (for unique backup filenames)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Dump the MySQL database
mysqldump -u$USER -p$PASSWORD $DATABASE > $BACKUP_DIR/$DATABASE_$TIMESTAMP.sql

# Compress the backup
gzip $BACKUP_DIR/$DATABASE_$TIMESTAMP.sql
