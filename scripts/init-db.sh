#!/bin/bash
# init-db.sh - Initialize Database

set -e

echo "🗄️  Initializing Database..."

# Ensure data directory exists
mkdir -p logs
mkdir -p data

# Check if SQLite DB exists
if [ -f "database.sqlite" ]; then
    echo "⚠️  database.sqlite already exists."
    read -p "Do you want to overwrite it? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "🚫 Aborted."
        exit 1
    fi
fi

# Run initialization script
echo "🔨 Creating schema..."
node -e "const { sequelize } = require('./models/user'); sequelize.sync({ force: true }).then(() => console.log('Database synced')).catch(e => console.error(e));"

echo "✅ Database initialized successfully."
