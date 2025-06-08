#!/bin/bash

echo "Stopping Flights Application..."

# Stop React client
echo "Stopping React client..."
pkill -f "react-scripts start" 2>/dev/null || echo "React client was not running"

# Stop API server
echo "Stopping API server..."
pkill -f "node.*server.js" 2>/dev/null || echo "API server was not running"

# Stop MariaDB container
echo "Stopping MariaDB database..."
sudo docker stop flights-mariadb 2>/dev/null || echo "MariaDB container was not running"

echo "Application stopped."
