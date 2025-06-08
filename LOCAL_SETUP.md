# Flights Application - Local Setup

This document describes how to run the Flights application locally using Docker for the database.

## Prerequisites

- Node.js (v12+)
- npm (v6+)
- Docker
- Git

## Quick Start

1. **Clone and setup the application** (already done):
   ```bash
   git clone https://github.com/mariadb-developers/flights-app-nodejs.git
   cd flights-app-nodejs
   git submodule update --init --recursive
   ```

2. **Start the application**:
   ```bash
   ./start-app.sh
   ```

3. **Access the application**:
   - Frontend: http://localhost:3000
   - API: http://localhost:8080
   - Database: localhost:3306

4. **Stop the application**:
   ```bash
   ./stop-app.sh
   ```

## Manual Setup

If you prefer to start services manually:

### 1. Start MariaDB Database

```bash
# Start MariaDB container
sudo docker run -d \
  --name flights-mariadb \
  -e MARIADB_ROOT_PASSWORD=rootpassword \
  -e MARIADB_DATABASE=flights \
  -e MARIADB_USER=flights_user \
  -e MARIADB_PASSWORD=flights_password \
  -p 3306:3306 \
  mariadb:latest

# Wait for database to initialize
sleep 15

# Create tables and sample data
sudo docker exec -i flights-mariadb mariadb -u root -prootpassword < init-scripts/04-create-tables-innodb.sql
```

### 2. Start API Server

```bash
cd src/api
npm install
npm start
```

The API server will run on http://localhost:8080

### 3. Start React Client

```bash
cd src/client
npm install
NODE_OPTIONS="--openssl-legacy-provider" npm start
```

The React client will run on http://localhost:3000

## Database Configuration

The API connects to the database using these credentials:
- Host: localhost
- Port: 3306
- User: flights_user
- Password: flights_password
- Database: flights

These are configured in `src/api/.env`:
```
DB_HOST=localhost
DB_PORT=3306
DB_USER=flights_user
DB_PASS=flights_password
DB_NAME=flights
```

## API Endpoints

- `GET /api/airlines` - Get all airlines
- `GET /api/airports` - Get all airports  
- `GET /api/flights/*` - Various flight-related endpoints

## Sample Data

The application includes sample data for:
- 5 airlines (AA, DL, UA, WN, B6)
- 5 airports (LAX, JFK, ORD, ATL, DFW)
- 5 sample flights

## Troubleshooting

### React Client Issues
If you get OpenSSL errors when starting the React client, use:
```bash
NODE_OPTIONS="--openssl-legacy-provider" npm start
```

### Database Connection Issues
Check if the MariaDB container is running:
```bash
sudo docker ps | grep flights-mariadb
```

Check database logs:
```bash
sudo docker logs flights-mariadb
```

### Port Conflicts
Make sure ports 3000, 8080, and 3306 are not in use by other applications.

## Architecture

- **Frontend**: React.js application (port 3000)
- **Backend**: Node.js/Express API (port 8080)
- **Database**: MariaDB (port 3306)
- **Containerization**: Docker for database

The React client proxies API requests to the backend server, and the backend connects to the MariaDB database to serve flight data.
