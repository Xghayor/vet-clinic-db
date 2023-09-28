/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, FALSE, -11),
         ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
        ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
        ('Angemon', '2005-06-12', 1, TRUE, -45),
        ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
        ('Blossom', '1998-10-13', 3, TRUE, 17),
        ('Ditto', '2022-05-14', 4, TRUE, 22),
        ('Agumon', '2020-02-03', 10.23, true, 0),
       ('Gabumon', '2018-11-15', 8, true, 2),
     ('Devimon', '2017-05-12', 11, true, 5),
    ('Pikachu', '2021-01-07', 15.04, false, 1);
         
         
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