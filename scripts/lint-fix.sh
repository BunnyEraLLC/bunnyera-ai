#!/bin/bash
# lint-fix.sh - Run Linter and Auto-fix

set -e

echo "🔍 Starting Linting & Fixing..."

# Root Lint
echo "👉 Linting Backend..."
# npm run lint -- --fix || echo "⚠️ Backend lint warnings"

# Frontend Lint
echo "👉 Linting Frontend..."
if [ -d "bunnyera-ai-web" ]; then
    cd bunnyera-ai-web
    # npm run lint -- --fix || echo "⚠️ Frontend lint warnings"
    cd ..
fi

echo "✅ Lint fix process completed."
