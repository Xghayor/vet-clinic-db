-- Day 1 

-- Find all animals whose name ends in "mon".
SELECT * from animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals
WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals
WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Day 2

-- Task 1 =======>>
-- Inside a transaction update the animals table by setting the species column to unspecified. Verify 
-- that change was made. Then roll back the change and verify that the species columns went back to the 
-- state before the transaction.

-- Inside a Transaction:
BEGIN;

-- Update animals table by setting Species Column to unspecified.
UPDATE animals
SET species = 'unspecified';

-- Verify that change was made.
SELECT species FROM animals;

-- Roll Back the Transaction
ROLLBACK;

-- Verify the Rollback
SELECT species FROM animals;

-- Task 2 =======>>
-- Start a transaction
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Verify that changes were made.
SELECT species FROM animals;

-- Commit the transaction.
COMMIT;

-- Verify that changes persist after commit.
SELECT species FROM animals;

-- Task 3 =======>>
-- Inside a transaction delete all records in the animals table, then roll back the transaction.

-- Inside a transaction
BEGIN;

-- delete all records
DELETE FROM animals;

-- then roll back the transaction
ROLLBACK;

-- After the rollback verify if all records in the animals table still exists.
SELECT COUNT(*) FROM animals;

-- Task 4 =======>>
-- Inside a transaction:
BEGIN;

-- 1# Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- 2# Create a savepoint for the transaction
SAVEPOINT save_01;

-- 3# Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- 4# Rollback to the savepoint
ROLLBACK TO save_01;

-- 5# Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- 6# Commit transaction
COMMIT;

-- Task 5 =======>>
-- Write queries to answer the following questions:
-- 1# How many animals are there?
SELECT COUNT(*) AS nums_of_animals FROM animals;

-- 2# How many animals have never tried to escape?
SELECT COUNT(*) AS zero_escape FROM animals
WHERE escape_attempts = 0;

-- 3# What is the average weight of animals?
SELECT AVG(weight_kg) AS avg_weight FROM animals;

-- 4# Who escapes the most, neutered or not neutered animals?
SELECT neutered FROM animals
GROUP BY neutered
ORDER BY SUM(escape_attempts) DESC
LIMIT 1;

-- 5# What is the minimum and maximum weight of each type of animal?
SELECT Species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY Species;

-- 6# What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT Species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY Species;

-- Day 3
-- Write queries (using JOIN) to answer the following questions:
--   What animals belong to Melody Pond?
SELECT animals.id AS id, name AS name, owner_id AS owner_id, full_name AS owner_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';
-- DONE

--   List of all animals that are pokemon (their type is Pokemon).
SELECT animals.id AS id, animals.name as animal_name, species_id AS specie_id, species.name AS specie_type
FROM animals
INNER JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';
-- DONE

--   List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.id AS owner_id, full_name AS owner_name, animals.id AS animal_id, name as animal_name
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;
-- DONE

--   How many animals are there per species?
SELECT species.name As specie, COUNT(species.name) AS count
FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;
-- DONE

--   List all Digimon owned by Jennifer Orwell.
SELECT animals.name, owners.full_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
-- DONE

--   List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS animal_no_escape, owners.full_name AS owns_by
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
-- DONE

--   Who owns the most animals?
SELECT owners.full_name AS owned_by, COUNT(owners.full_name) AS total
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY total DESC;
-- DONE

-- Day 4
-- - Write queries to answer the following:
--   - Who was the last animal seen by William Tatcher?
SELECT animals.name AS last_visited_animal 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY visit_date DESC 
LIMIT 1;
-- DONE

--   - How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name) AS visit_different_animals, vets.name AS doctor_name 
FROM animals 
JOIN visits ON visits.animals_id = animals.id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez' 
GROUP BY vets.name;
-- DONE

--   - List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name, species.name AS specialized_in
FROM specializations
FULL JOIN vets ON specializations.vet_id = vets.id
FULL JOIN species ON specializations.species_id = species.id;
-- DONE

--   - List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animals_name, vets.name AS vets_name 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-31';
-- DONE

--   - What animal has the most visits to vets?
SELECT COUNT(animals.name) AS total_visits, animals.name AS animal 
FROM visits 
JOIN animals ON visits.animals_id = animals.id 
GROUP BY animals.name 
ORDER BY total_visits DESC 
LIMIT 1;
-- DONE

--   - Who was Maisy Smith's first visit?
SELECT MIN(visit_date) AS first_visited, animals.name AS animal 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'Maisy Smith' 
GROUP BY animals.name 
ORDER BY first_visited ASC 
LIMIT 1;
-- DONE

--   - Details for most recent visit: animal information, vet information, and date of visit.
SELECT MAX(visit_date) AS recently_visited, animals.name AS animal, vets.name AS vet_name 
FROM visits 
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vet_id = vets.id 
GROUP BY animals.name, vets.name 
ORDER BY recently_visited DESC 
LIMIT 1;
-- DONE

--   - How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visit_date) AS non_specialized_visits 
FROM specializations 
JOIN vets ON specializations.vet_id = vets.id 
JOIN visits ON specializations.vet_id = visits.vet_id 
WHERE species_id IS NULL;
-- DONE

--   - What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS frequent_visit_to_specific_specialist, vets.name AS doctor_name 
FROM animals
JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON visits.vet_id = vets.id 
JOIN species ON animals.species_id = species.id 
WHERE vets.name = 'Maisy Smith' 
GROUP BY species.name, vets.name 
ORDER BY COUNT(species.name) DESC 
LIMIT 1;
-- DONE

-- Day 5
-- The following queries are taking too much time (1 sec = 1000ms can be considered as too much time for database query).
-- Try them on your machine to confirm it:

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits
WHERE animals_id = 4;

EXPLAIN ANALYZE SELECT * FROM visits 
WHERE vet_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners 
WHERE email = 'owner_18327@mail.com';