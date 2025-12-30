#!/bin/bash
# restore-db.sh - Restore Database from Backup

set -e

BACKUP_DIR="./backups"
DB_FILE="database.sqlite"

echo "♻️  Starting Database Restore..."

if [ -z "$1" ]; then
    echo "❌ Error: Please specify a backup file to restore."
    echo "Usage: ./scripts/restore-db.sh <backup_filename>"
    echo "Available backups:"
    ls $BACKUP_DIR
    exit 1
fi

BACKUP_FILE="$BACKUP_DIR/$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: Backup file '$BACKUP_FILE' does not exist."
    exit 1
fi

echo "⚠️  WARNING: This will overwrite the current database."
read -p "Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🚫 Restore aborted."
    exit 1
fi

cp "$BACKUP_FILE" "$DB_FILE"
echo "✅ Database restored successfully from $1"
