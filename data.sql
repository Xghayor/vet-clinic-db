-- Day 1

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
('Agumon', '2020-02-03', 10.23, TRUE, 0),
('Gabumon', '2018-11-15', 8, TRUE, 2),
('Pikachu', '2021-01-07', 15.04, FALSE, 1),
('Devimon', '2017-05-12', 11, TRUE, 5);

-- Day 2
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
('Charmander', '2020-02-08', -11, FALSE, 0),
('Plantmon', '2021-11-15', -5.7, TRUE, 2),
('Squirtle', '1993-04-02', -12.13, FALSE, 3),
('Angemon', '2005-06-12', -45, TRUE, 1),
('Boarmon', '2005-06-07', 20.4, TRUE, 7),
('Blossom', '1998-10-13', 17, TRUE, 3),
('Ditto', '2022-05-14', 22, TRUE, 4);

-- Day 3
-- Insert the following data into the owners table:
--   Sam Smith 34 years old.
--   Jennifer Orwell 19 years old.
--   Bob 45 years old.
--   Melody Pond 77 years old.
--   Dean Winchester 14 years old.
--   Jodie Whittaker 38 years old.
INSERT INTO owners(full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);
-- DONE

-- Insert the following data into the species table:
--   Pokemon
--   Digimon
INSERT INTO species(name)
VALUES
('Pokemon'),
('Digimon');
-- DONE

-- Modify your inserted animals so it includes the species_id value:
--   If the name ends in "mon" it will be Digimon
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon') 
WHERE name LIKE '%mon';
-- DONE

--   All other animals are Pokemon
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') 
WHERE species_id IS NULL;
-- DONE

-- Modify your inserted animals to include owner information (owner_id):
--   Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';
-- DONE

--   Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');
-- DONE

--   Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');
-- DONE

--   Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
-- DONE

--   Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');
-- DONE

-- Day 4
-- `vets`: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called `visits` to handle this relationship, it should also keep track of the date of the visit.
-- - Insert the following data for vets:
--   - Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
--   - Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
--   - Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
--   - Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets ( name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2000-04-23');


-- - Insert the following data for specializations:
--   - Vet William Tatcher is specialized in Pokemon.
--   - Vet Stephanie Mendez is specialized in Digimon and Pokemon.
--   - Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vet_id, species_id)
VALUES 
(1, 1),
(3, 1),
(3, 2),
(4, 2);
-- DONE

-- - Insert the following data for visits:
--   - Agumon visited William Tatcher on May 24th, 2020.
--   - Agumon visited Stephanie Mendez on Jul 22th, 2020.
--   - Gabumon visited Jack Harkness on Feb 2nd, 2021.
--   - Pikachu visited Maisy Smith on Jan 5th, 2020.
--   - Pikachu visited Maisy Smith on Mar 8th, 2020.
--   - Pikachu visited Maisy Smith on May 14th, 2020.
--   - Devimon visited Stephanie Mendez on May 4th, 2021.
--   - Charmander visited Jack Harkness on Feb 24th, 2021.
--   - Plantmon visited Maisy Smith on Dec 21st, 2019.
--   - Plantmon visited William Tatcher on Aug 10th, 2020.
--   - Plantmon visited Maisy Smith on Apr 7th, 2021.
--   - Squirtle visited Stephanie Mendez on Sep 29th, 2019.
--   - Angemon visited Jack Harkness on Oct 3rd, 2020.
--   - Angemon visited Jack Harkness on Nov 4th, 2020.
--   - Boarmon visited Maisy Smith on Jan 24th, 2019.
--   - Boarmon visited Maisy Smith on May 15th, 2019.
--   - Boarmon visited Maisy Smith on Feb 27th, 2020.
--   - Boarmon visited Maisy Smith on Aug 3rd, 2020.
--   - Blossom visited Stephanie Mendez on May 24th, 2020.
--   - Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits ( animals_id, vet_id, visit_date)
VALUES
(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(6, 2, '2021-04-07'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'),
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-08-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');
