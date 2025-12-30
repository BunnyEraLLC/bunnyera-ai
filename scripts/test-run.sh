#!/bin/bash
# test-run.sh - Run Test Suite

set -e

echo "🧪 Starting Test Suite..."

# Set Test Environment
export NODE_ENV=test

# Run Backend Tests
echo "👉 Running Backend Tests..."
if [ -f "package.json" ]; then
    npm test
else
    echo "⚠️ No package.json found in root."
fi

# Run Frontend Tests
# echo "👉 Running Frontend Tests..."
# cd bunnyera-ai-web && npm test

echo "✅ All tests completed."
