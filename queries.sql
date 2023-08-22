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