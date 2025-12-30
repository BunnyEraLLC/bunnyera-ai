#!/bin/bash
# build-web.sh - Build Frontend Application

set -e

echo "🏗️  Starting Web Build Process..."

cd bunnyera-ai-web

if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

echo "🔨 Building project..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📂 Output directory: bunnyera-ai-web/dist"
else
    echo "❌ Build failed!"
    exit 1
fi
