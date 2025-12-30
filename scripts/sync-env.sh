#!/bin/bash
# sync-env.sh - Sync Environment Variables

set -e

echo "🔄 Syncing Environment Files..."

if [ -f ".env.example" ]; then
    if [ ! -f ".env" ]; then
        echo "➕ Creating .env from .env.example..."
        cp .env.example .env
    else
        echo "⚠️  .env already exists. Skipping creation."
        # Could add logic to check for missing keys
    fi
else
    echo "❌ .env.example not found!"
    exit 1
fi

echo "✅ Env sync completed."
