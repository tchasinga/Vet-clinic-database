/* Queries that provide answers to the questions from all projects. */

-- Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with weights equal to 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;



-- Begin the transaction
BEGIN;

-- Update species for animals whose name ends in "mon"
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';

-- Update species for animals with no species set
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;

-- Verify changes before committing
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Verify changes after commit
SELECT * FROM animals;

-- Checking Data copnfimation

-- Begin the transaction
BEGIN;

-- Delete all records from the animals table
DELETE FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify records after rollback
SELECT * FROM animals;

---

-- Begin the transaction
BEGIN;

-- Delete animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update weights to be negative
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update negative weights
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;



-- Write queries to answer the following questions:

1. **How many animals are there?**

SELECT COUNT(*) AS total_animals FROM animals;

2. **How many animals have never tried to escape?**

SELECT COUNT(*) AS no_escape_animals FROM animals WHERE escape_attempts = 0;

3. **What is the average weight of animals?**

SELECT AVG(weight_kg) AS average_weight FROM animals;

4. **Who escapes the most, neutered or not neutered animals?**

SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;

5. **What is the minimum and maximum weight of each type of animal?**

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

6. **What is the average number of escape attempts per animal type of those born between 1990 and 2000?**

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;



------------------------------------------------------------------------------------------------------------------------------------------------------


-- Who was the last animal seen by William Tatcher?
SELECT a.name AS animal_name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets w ON v.vet_id = w.id
WHERE w.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS num_animals_seen
FROM visits v
JOIN vets s ON v.vet_id = s.id
WHERE s.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, COALESCE(s.name, 'No Specialization') AS specialization
FROM vets v
LEFT JOIN specializations vs ON v.id = vs.vet_id
LEFT JOIN species s ON vs.species_id = s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets s ON v.vet_id = s.id
WHERE s.name = 'Stephanie Mendez'
    AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(v.animal_id) AS num_visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name AS animal_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets m ON v.vet_id = m.id
WHERE m.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, v.visit_date, ve.name AS vet_name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id
WHERE sp.species_id IS NULL OR sp.species_id != v.animal_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS potential_specialty, COUNT(v.animal_id) AS num_visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets m ON v.vet_id = m.id
LEFT JOIN specializations sp ON m.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id
WHERE m.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY num_visits DESC
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





--- 
