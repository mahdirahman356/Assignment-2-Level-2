-- Active: 1747490992917@@localhost@5432@conservation_db

CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);


CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);


CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes TEXT 
);

DROP TABLE sightings

INSERT INTO rangers (name, region)
VALUES('Alice Green', 'Northern Hills'),
      ('Bob White', 'River Delta'),
      ('Carol King', 'Mountain Range')


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
       ('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
       ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
       ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered')


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
VALUES (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
       (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
       (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
       (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL)

-- Problem 1
INSERT INTO rangers (name, region)
VALUES('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT count(DISTINCT scientific_name) as unique_species_count  FROM species

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%' 

-- Problem 4
SELECT name, count(ranger_id)  AS total_sightings FROM rangers
JOIN sightings USING(ranger_id)
GROUP BY name

-- Problem 5
SELECT common_name FROM species
LEFT JOIN sightings USING(species_id)
WHERE sightings.sighting_id IS NULL

-- Problem 6
SELECT common_name, sighting_time, name FROM sightings
JOIN species USING(species_id)
JOIN rangers USING(ranger_id)
ORDER BY sighting_time DESC
LIMIT 2

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE extract(YEAR FROM discovery_date ) < 1800
