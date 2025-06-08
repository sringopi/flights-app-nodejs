# Development Guide

## Project Structure
```
flights-app-nodejs/
├── src/                          # Source code
│   ├── api/                      # Node.js API backend
│   └── client/                   # React frontend
├── init-scripts/                 # Database initialization scripts
├── node_modules/                 # Node.js dependencies (for testing)
├── docker-compose.yml            # Main Docker configuration
├── docker-compose.override.yml   # Development overrides
├── package.json                  # Project dependencies and scripts
├── package-lock.json             # Dependency lock file
├── test_application.js           # Automated test script
├── demo_application.sh           # Demo script
├── start-app.sh                  # Application startup script
├── stop-app.sh                   # Application shutdown script
├── TESTING_REPORT.md             # Comprehensive testing report
└── README.md                     # Main project documentation
```

## Available Scripts

### Application Management
- `npm start` - Start the entire application stack
- `npm stop` - Stop the application stack
- `npm run docker:up` - Start Docker containers
- `npm run docker:down` - Stop Docker containers
- `npm run docker:logs` - View container logs
- `npm run docker:build` - Build Docker images

### Testing and Demo
- `npm test` - Run automated application tests
- `npm run demo` - Run demo script

## Dependencies

### Runtime Dependencies
- **axios**: HTTP client for API testing and communication

### Development Dependencies
All development dependencies are containerized within Docker:
- **Node.js 14+**: Runtime for API and testing
- **React**: Frontend framework
- **MariaDB**: Database engine
- **Docker & Docker Compose**: Containerization

## Testing

### Automated Testing
Run the comprehensive test suite:
```bash
npm test
```

This will test:
- API endpoints (/api/airlines, /api/airports, /api/flights/airlines_stats)
- Frontend accessibility and content
- Data verification and sample data display

### Manual Testing
1. Start the application: `npm start`
2. Access frontend: http://localhost:3000
3. Test API directly: http://localhost:8080/api/airlines

### Demo Mode
Run the interactive demo:
```bash
npm run demo
```

## Development Workflow

1. **Setup**: All dependencies are included in the project
2. **Start**: `npm start` to launch all services
3. **Test**: `npm test` to verify functionality
4. **Develop**: Modify code in `src/` directory
5. **Stop**: `npm stop` to shutdown services

## Environment Requirements
- Docker and Docker Compose installed
- Node.js 14+ (for local testing scripts)
- Ports 3000, 8080, and 3306 available

## Troubleshooting
- Check `TESTING_REPORT.md` for known issues and solutions
- Use `npm run docker:logs` to view container logs
- Ensure all ports are available before starting
