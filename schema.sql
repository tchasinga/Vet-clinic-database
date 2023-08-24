/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);






-- Create the owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

-- Create the species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Modify the animals table
-- Remove the existing species column from animals table
ALTER TABLE animals DROP COLUMN species;

-- Displaying results 
 select * from animals
-- WRITE A QUERY TO JOIN 

-- What animals belong to Melody Pond?
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal.
SELECT o.full_name, COALESCE(array_agg(a.name), ARRAY[]::VARCHAR[]) AS animals_owned
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.id;

-- How many animals are there per species?
SELECT s.name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.id, s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.id, o.full_name
ORDER BY animal_count DESC
LIMIT 1;



-- todays task to do 


-- Create the vets table
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);

-- Create the species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the specializations join table
CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

-- Create the animals table
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the visits join table
CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id)
);

-- Insert data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert data for species
INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

-- Insert data for specializations
INSERT INTO specializations (vet_id, species_id)
VALUES
    (1, 1), -- William Tatcher - Pokemon
    (3, 1), -- Stephanie Mendez - Pokemon
    (3, 2), -- Stephanie Mendez - Digimon
    (4, 2); -- Jack Harkness - Digimon

-- Insert data for animals
INSERT INTO animals (name)
VALUES
    ('Agumon'),
    ('Gabumon'),
    ('Pikachu'),
    ('Devimon'),
    ('Charmander'),
    ('Plantmon'),
    ('Squirtle'),
    ('Angemon'),
    ('Boarmon'),
    ('Blossom');

-- Insert data for visits
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
    (1, 1, '2020-05-24'), -- Agumon -> William Tatcher
    (1, 3, '2020-07-22'), -- Agumon -> Stephanie Mendez
    (2, 4, '2021-02-02'), -- Gabumon -> Jack Harkness
    (3, 2, '2020-01-05'), -- Pikachu -> Maisy Smith
    (3, 2, '2020-03-08'), -- Pikachu -> Maisy Smith
    (3, 2, '2020-05-14'), -- Pikachu -> Maisy Smith
    (4, 3, '2021-05-04'), -- Devimon -> Stephanie Mendez
    (5, 4, '2021-02-24'), -- Charmander -> Jack Harkness
    (6, 2, '2019-12-21'), -- Plantmon -> Maisy Smith
    (6, 1, '2020-08-10'), -- Plantmon -> William Tatcher
    (6, 2, '2021-04-07'), -- Plantmon -> Maisy Smith
    (7, 3, '2019-09-29'), -- Squirtle -> Stephanie Mendez
    (8, 4, '2020-10-03'), -- Angemon -> Jack Harkness
    (8, 4, '2020-11-04'), -- Angemon -> Jack Harkness
    (9, 2, '2019-01-24'), -- Boarmon -> Maisy Smith
    (9, 2, '2019-05-15'), -- Boarmon -> Maisy Smith
    (9, 2, '2020-02-27'), -- Boarmon -> Maisy Smith
    (9, 2, '2020-08-03'), -- Boarmon -> Maisy Smith
    (10, 3, '2020-05-24'), -- Blossom -> Stephanie Mendez
    (10, 1, '2021-01-11'); -- Blossom -> William Tatcher

