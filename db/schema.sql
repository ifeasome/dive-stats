DROP DATABASE IF EXISTS diving_db;

CREATE DATABASE diving_db;

\c diving_db;

--UNSIGNED CUSTOM DATATPE--
CREATE DOMAIN UNSIGNED AS INTEGER CHECK (VALUE > 0);

--CERTIFICATIONS TABLE--
CREATE TABLE certifications (

    id SERIAL PRIMARY KEY, 

    name VARCHAR(50) NOT NULL,

    minimum_age UNSIGNED, 

    required_hours INT

);

--DIVERS TABLE--
CREATE TABLE divers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    is_instructor BOOLEAN DEFAULT FALSE NOT NULL,
    certification_id INTEGER REFERENCES certifications(id) ON DELETE SET NULL
);

--LATLONG CUSTOM DATA TYPE--
CREATE DOMAIN LATLONG AS POINT
  CHECK (VALUE[0] BETWEEN -90 AND 90)
  CHECK (VALUE[1] BETWEEN -180 AND 180);

--LOCATIONS TABLE--
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    coordinates LATLONG NOT NULL
);

--TAGS TABLE--
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  location_id INTEGER NOT NULL REFERENCES locations(id) ON DELETE CASCADE,
  UNIQUE(name, location_id)
);

--DIVES TABLE--
CREATE TABLE dives (
    id SERIAL PRIMARY KEY, 
    depth NUMERIC(5, 2) NOT NULL, 
    dive_date TIMESTAMP NOT NULL DEFAULT NOW(),
    duration UNSIGNED NOT NULL, 
    diver_id INTEGER NOT NULL REFERENCES divers(id) ON DELETE CASCADE,
    location_id INTEGER NOT NULL REFERENCES locations(id) ON DELETE CASCADE
);

--CUSTOM FUNCTION: random number between a high and low number--
CREATE FUNCTION random_between(low INT, high INT)
RETURNS INT AS $$ 
BEGIN 
  RETURN FLOOR(RANDOM() * (high - low +1) + low);
END;
$$ LANGUAGE plpgsql;
