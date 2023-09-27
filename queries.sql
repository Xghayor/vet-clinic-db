/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals 
WHERE (neutered = true) AND ( escape_attempts < 3);

SELECT * from animals WHERE NAME IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;


SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name != 'Gabumon';

SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;


BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = 'unspecified';
SELECT species from animals;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * from animals;
ROLLBACK TRANSACTION;
COMMIT;
SELECT * from animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS avg_weight FROM animals;
SELECT
    neutered,
    MAX(escape_attempts) AS max_escape_attempts
FROM
    animals
WHERE
    escape_attempts > 0
GROUP BY
    neutered;

SELECT
    species,
    MIN(weight_kg) AS min_weight,
    MAX(weight_kg) AS max_weight
FROM
    animals
GROUP BY
    species;


SELECT
    species,
    AVG(escape_attempts) AS avg_escape_attempts
FROM
    animals
WHERE
    date_of_birth >= DATE '1990-01-01' AND date_of_birth <= DATE '2000-12-31'
GROUP BY
    species;


SELECT animals.name
FROM animals
JOIN owners
ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';


SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.species_name = 'Pokemon';


SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;


SELECT species.species_name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.species_name;


SELECT owners.full_name, COUNT(*) AS Digimon_count
FROM owners
JOIN animals ON owners.id = animals.owners_id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell'
  AND species.species_name = 'Digimon'
GROUP BY owners.full_name;

SELECT animals.name
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owners_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;