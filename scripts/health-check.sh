#!/bin/bash
# health-check.sh - Check Service Health

set -e

URL="http://localhost:3000/health"

echo "💓 Checking Service Health at $URL..."

if command -v curl &> /dev/null; then
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $URL)
    
    if [ "$RESPONSE" -eq 200 ]; then
        echo "✅ Service is HEALTHY (Status: 200)"
        exit 0
    else
        echo "❌ Service is UNHEALTHY (Status: $RESPONSE)"
        exit 1
    fi
else
    echo "⚠️  curl not found. Cannot check health."
    exit 1
fi
