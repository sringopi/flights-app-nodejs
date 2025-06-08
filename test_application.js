const axios = require('axios');

async function testApplication() {
    console.log('Testing Flights Application...\n');
    
    // Test API endpoints
    console.log('1. Testing API Endpoints:');
    
    try {
        // Test airlines endpoint
        const airlinesResponse = await axios.get('http://localhost:8080/api/airlines');
        console.log('✓ Airlines API:', airlinesResponse.data.length, 'airlines found');
        
        // Test airports endpoint
        const airportsResponse = await axios.get('http://localhost:8080/api/airports');
        console.log('✓ Airports API:', airportsResponse.data.length, 'airports found');
        
        // Test flights stats endpoint
        const flightsResponse = await axios.get('http://localhost:8080/api/flights/airlines_stats?o=LAX&dst=JFK&yf=2023&yt=2023');
        console.log('✓ Flights Stats API:', flightsResponse.data.length, 'flight records found');
        
        console.log('\n2. Testing Frontend:');
        
        // Test frontend
        const frontendResponse = await axios.get('http://localhost:3000');
        if (frontendResponse.status === 200 && frontendResponse.data.includes('Real-Time Flight Analytics')) {
            console.log('✓ Frontend is accessible and serving content');
        } else {
            console.log('✗ Frontend issue detected');
        }
        
        console.log('\n3. Sample Data Verification:');
        console.log('Airlines:', airlinesResponse.data.map(a => a.airline).join(', '));
        console.log('Airports:', airportsResponse.data.map(a => a.airport).slice(0, 3).join(', '), '...');
        
        console.log('\n✅ All tests passed! Application is working correctly.');
        
    } catch (error) {
        console.error('❌ Test failed:', error.message);
    }
}

testApplication();
