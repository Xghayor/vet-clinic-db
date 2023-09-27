/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Charmander', '2020-02-08', 0, FALSE, -11,'NULL'),
         ('Plantmon', '2021-11-15', 2, TRUE, -5.7,'NULL'),
        ('Squirtle', '1993-04-02', 3, FALSE, -12.13,'NULL'),
        ('Angemon', '2005-06-12', 1, TRUE, -45,'NULL'),
        ('Boarmon', '2005-06-07', 7, TRUE, 20.4,'NULL'),
        ('Blossom', '1998-10-13', 3, TRUE, 17,'NULL'),
        ('Ditto', '2022-05-14', 4, TRUE, 22,'NULL');


INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob',45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (species_name)
VALUES ('Pokemon'),
       ('Digimon');


UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE species_name = 'Digimon')
    ELSE (SELECT id FROM species WHERE species_name = 'Pokemon')
END;



UPDATE animals
SET owners_id = (
    SELECT id FROM owners WHERE full_name = 'Sam Smith'
)
WHERE name IN ('Agumon');

UPDATE animals
SET owners_id = (
    SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owners_id = (
    SELECT id FROM owners WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owners_id = (
    SELECT id FROM owners WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owners_id = (
    SELECT id FROM owners WHERE full_name = 'Dean Winchester'
)
WHERE name IN ('Angemon', 'Boarmon');