-- Creating database... with viclick name 
CREATE DATABASE vet_clinic;

/* inserting data in the table.. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, true, 8.0);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, true, 11.0);

-- Adding new element in the animals table

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Charmander', '2020-02-08', 0, false, -11.0, 'Fire');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Plantmon', '2021-11-15', 2, true, -5.7, 'Grass');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Squirtle', '1993-04-02', 3, false, -12.13, 'Water');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Angemon', '2005-06-12', 1, true, -45.0, 'Angel');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4, 'Mammal');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Blossom', '1998-10-13', 3, true, 17.0, 'Flower');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Ditto', '2022-05-14', 4, true, 22.0, 'Shape-shifter');

-- JOINING DATA ...


-- Insert data into the owners table
INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name) VALUES
    ('Pokemon'),
    ('Digimon');

-- Update animals based on species
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

-- Update animals with owner information
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';

-- The rest of your existing data insertions...


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
