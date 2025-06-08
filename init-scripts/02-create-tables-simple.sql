-- Create the flights database tables for ColumnStore
USE flights;

-- Airlines table
CREATE TABLE IF NOT EXISTS airlines (
    iata_code VARCHAR(3) PRIMARY KEY,
    airline VARCHAR(255) NOT NULL
) ENGINE=ColumnStore;

-- Airports table  
CREATE TABLE IF NOT EXISTS airports (
    iata_code VARCHAR(3) PRIMARY KEY,
    airport VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    state VARCHAR(2),
    country VARCHAR(255),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6)
) ENGINE=ColumnStore;

-- Flights table (without indexes for ColumnStore)
CREATE TABLE IF NOT EXISTS flights (
    year INT,
    month INT,
    day INT,
    day_of_week INT,
    fl_date DATE,
    carrier VARCHAR(3),
    tail_num VARCHAR(10),
    fl_num INT,
    origin VARCHAR(3),
    dest VARCHAR(3),
    crs_dep_time INT,
    dep_time INT,
    dep_delay INT,
    taxi_out INT,
    wheels_off INT,
    wheels_on INT,
    taxi_in INT,
    crs_arr_time INT,
    arr_time INT,
    arr_delay INT,
    cancelled TINYINT DEFAULT 0,
    cancellation_code VARCHAR(1),
    diverted TINYINT DEFAULT 0,
    crs_elapsed_time INT,
    actual_elapsed_time INT,
    air_time INT,
    distance INT,
    carrier_delay INT,
    weather_delay INT,
    nas_delay INT,
    security_delay INT,
    late_aircraft_delay INT
) ENGINE=ColumnStore;

-- Insert some sample data for testing
INSERT IGNORE INTO airlines (iata_code, airline) VALUES 
('AA', 'American Airlines'),
('DL', 'Delta Air Lines'),
('UA', 'United Airlines'),
('WN', 'Southwest Airlines'),
('B6', 'JetBlue Airways');

INSERT IGNORE INTO airports (iata_code, airport, city, state, country, latitude, longitude) VALUES 
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'CA', 'USA', 33.942536, -118.408075),
('JFK', 'John F. Kennedy International Airport', 'New York', 'NY', 'USA', 40.639751, -73.778925),
('ORD', 'Chicago O\'Hare International Airport', 'Chicago', 'IL', 'USA', 41.978603, -87.904842),
('ATL', 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta', 'GA', 'USA', 33.636719, -84.428067),
('DFW', 'Dallas/Fort Worth International Airport', 'Dallas', 'TX', 'USA', 32.896828, -97.037997);

-- Insert some sample flight data
INSERT IGNORE INTO flights (year, month, day, day_of_week, fl_date, carrier, tail_num, fl_num, origin, dest, crs_dep_time, dep_time, dep_delay, cancelled, diverted, distance) VALUES 
(2023, 1, 15, 1, '2023-01-15', 'AA', 'N123AA', 100, 'LAX', 'JFK', 800, 805, 5, 0, 0, 2475),
(2023, 1, 15, 1, '2023-01-15', 'DL', 'N456DL', 200, 'JFK', 'LAX', 1000, 1000, 0, 0, 0, 2475),
(2023, 1, 16, 2, '2023-01-16', 'UA', 'N789UA', 300, 'ORD', 'ATL', 1200, 1215, 15, 0, 0, 606),
(2023, 1, 16, 2, '2023-01-16', 'WN', 'N012WN', 400, 'ATL', 'DFW', 1400, 1400, 0, 0, 0, 732),
(2023, 1, 17, 3, '2023-01-17', 'B6', 'N345B6', 500, 'DFW', 'ORD', 1600, 1620, 20, 0, 0, 925);
