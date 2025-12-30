#!/bin/bash
# deploy-dev.sh - Deploy to Development Environment

set -e

echo "🐰 Starting Deployment to DEVELOPMENT..."
echo "📅 Date: $(date)"

# 1. Check Git Status
# In Dev, we might allow dirty states, but let's warn
if [[ -n $(git status -s) ]]; then
    echo "⚠️  Warning: Working directory not clean."
fi

# 2. Pull Latest Code
echo "⬇️  Pulling latest code from develop..."
git pull origin develop || echo "⚠️  Git pull failed, continuing manually..."

# 3. Install Dependencies
echo "📦 Installing dependencies..."
npm install
cd bunnyera-ai-web && npm install && cd ..

# 4. Restart Services (Docker Compose Dev)
echo "🚀 Restarting containers..."
docker-compose -f docker-compose.yml up -d --build

echo "✅ Deployment to DEVELOPMENT complete!"
echo "🌍 Live at: http://localhost:3000"
