#!/bin/bash
# backup-db.sh - Backup Database

set -e

BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
DB_FILE="database.sqlite"

echo "💾 Starting Database Backup..."

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

if [ -f "$DB_FILE" ]; then
    cp $DB_FILE "$BACKUP_DIR/db_backup_$DATE.sqlite"
    echo "✅ Backup created: $BACKUP_DIR/db_backup_$DATE.sqlite"
else
    echo "❌ Database file not found!"
    exit 1
fi

# Cleanup old backups (keep last 7 days)
echo "🧹 Cleaning up old backups..."
find $BACKUP_DIR -name "db_backup_*.sqlite" -mtime +7 -delete

echo "✨ Backup process completed."
