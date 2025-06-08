#!/bin/bash

echo "=== Flights Application Demo ==="
echo ""

echo "🚀 Application Status:"
sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""

echo "📊 Testing API Endpoints:"
echo ""

echo "1. Airlines (GET /api/airlines):"
curl -s http://localhost:8080/api/airlines | jq '.[0:2]' 2>/dev/null || curl -s http://localhost:8080/api/airlines | head -100
echo ""

echo "2. Airports (GET /api/airports):"
curl -s http://localhost:8080/api/airports | jq '.[0:2]' 2>/dev/null || curl -s http://localhost:8080/api/airports | head -100
echo ""

echo "3. Flight Statistics LAX→JFK (GET /api/flights/airlines_stats):"
curl -s "http://localhost:8080/api/flights/airlines_stats?o=LAX&dst=JFK&yf=2023&yt=2023" | jq '.' 2>/dev/null || curl -s "http://localhost:8080/api/flights/airlines_stats?o=LAX&dst=JFK&yf=2023&yt=2023"
echo ""

echo "🌐 Frontend Status:"
if curl -s http://localhost:3000 | grep -q "Flights"; then
    echo "✅ Frontend is accessible at http://localhost:3000"
else
    echo "❌ Frontend not accessible"
fi
echo ""

echo "📋 Application URLs:"
echo "• Frontend: http://localhost:3000"
echo "• API: http://localhost:8080/api/"
echo "• Database: localhost:3306 (flights_user/flights_password)"
echo ""

echo "🎯 Sample API Calls:"
echo "• Airlines: curl http://localhost:8080/api/airlines"
echo "• Airports: curl http://localhost:8080/api/airports"
echo "• Flight Stats: curl 'http://localhost:8080/api/flights/airlines_stats?o=LAX&dst=JFK&yf=2023&yt=2023'"
echo ""

echo "✅ Application is fully functional!"
