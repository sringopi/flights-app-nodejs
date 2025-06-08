#!/bin/bash

echo "Starting Flights Application..."

# Check if MariaDB container is running
if ! sudo docker ps | grep -q flights-mariadb; then
    echo "Starting MariaDB database..."
    sudo docker start flights-mariadb || {
        echo "MariaDB container not found, creating new one..."
        sudo docker run -d \
          --name flights-mariadb \
          -e MARIADB_ROOT_PASSWORD=rootpassword \
          -e MARIADB_DATABASE=flights \
          -e MARIADB_USER=flights_user \
          -e MARIADB_PASSWORD=flights_password \
          -p 3306:3306 \
          mariadb:latest
        
        echo "Waiting for MariaDB to initialize..."
        sleep 15
        
        echo "Creating database tables..."
        sudo docker exec -i flights-mariadb mariadb -u root -prootpassword < init-scripts/04-create-tables-innodb.sql
    }
else
    echo "MariaDB is already running"
fi

# Start API server
echo "Starting API server on port 8080..."
cd src/api
if ! pgrep -f "node.*server.js" > /dev/null; then
    nohup npm start > api.log 2>&1 &
    echo "API server started"
else
    echo "API server is already running"
fi

# Start React client
echo "Starting React client on port 3000..."
cd ../client
if ! ss -tlnp | grep -q 3000; then
    NODE_OPTIONS="--openssl-legacy-provider" nohup npm start > client.log 2>&1 &
    echo "React client started"
else
    echo "React client is already running"
fi

echo ""
echo "Application is starting up..."
echo "Please wait a moment for all services to be ready."
echo ""
echo "Access the application at:"
echo "  - Frontend: http://localhost:3000"
echo "  - API: http://localhost:8080"
echo "  - Database: localhost:3306"
echo ""
echo "Database credentials:"
echo "  - User: flights_user"
echo "  - Password: flights_password"
echo "  - Database: flights"
