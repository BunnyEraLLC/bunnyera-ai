#!/bin/bash
# deploy-prod.sh - Deploy to Production Environment

set -e

echo "🐰 Starting Deployment to PRODUCTION..."
echo "📅 Date: $(date)"

# 1. Check Git Status
if [[ -n $(git status -s) ]]; then
    echo "❌ Error: Working directory not clean. Commit changes first."
    exit 1
fi

# 2. Pull Latest Code
echo "⬇️  Pulling latest code from main..."
git pull origin main

# 3. Install Production Dependencies
echo "📦 Installing production dependencies..."
npm ci --only=production
cd bunnyera-ai-web && npm ci && cd ..

# 4. Build Frontend
echo "🏗️  Building frontend..."
cd bunnyera-ai-web
npm run build
cd ..

# 5. Database Migration
echo "🗄️  Running database migrations..."
# npm run migrate

# 6. Restart Services (Docker Compose)
echo "🚀 Restarting containers..."
docker-compose down
docker-compose up -d --build

echo "✅ Deployment to PRODUCTION complete!"
echo "🌍 Live at: https://api.bunnyera.org"
