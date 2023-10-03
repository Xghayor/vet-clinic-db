-- Day 1

CREATE TABLE animals (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name varchar(255),
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg decimal
);

-- Day 2

-- Add a column species of type string to your animals table. Modify your schema.sql file.
ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

-- Day 3
-- Create a table named owners with the following columns:
-- 	id: integer (set it as autoincremented PRIMARY KEY)
-- 	full_name: string
-- 	age: integer
CREATE TABLE owners(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(255), 
	age INT
);
-- DONE

-- Create a table named species with the following columns:
-- 	id: integer (set it as autoincremented PRIMARY KEY)
-- 	name: string
CREATE TABLE species(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255)
);
-- DONE

-- Modify animals table:
-- 	Make sure that id is set as autoincremented PRIMARY KEY
-- Type SERIAL to column id was set immidiately after creating animals table. 
-- Please see line 12 - 19.
-- DONE

-- 	Remove column species from animals table:
ALTER TABLE animals
DROP COLUMN species;
-- DONE

-- 	Add column species_id into animals table which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);
-- DONE

-- 	Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);
-- DONE

-- Day 4
-- - Create a table named `vets` with the following columns:
--   - `id`: integer (set it as autoincremented PRIMARY KEY)
--   - `name`: string
--   - `age`: integer
--   - `date_of_graduation`: date
BEGIN;
CREATE TABLE vets (
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	age INT,
	date_of_graduation DATE
);
COMMIT;
	
-- - There is a **many-to-many** relationship between the tables `species` and `vets`: 
			-- a vet can specialize in multiple species, and 
			-- a species can have multiple vets specialized in it. 
			-- Create a "join table" called `specializations` to handle this relationship.
CREATE TABLE specializations (
	vet_id INT REFERENCES vets(id),
	species_id INT REFERENCES species(id)
);

-- - There is a **many-to-many** relationship between the tables `animals` and `vets`: 
			-- an animal can visit multiple vets 
			-- and one vet can be visited by multiple animals. 
			-- Create a "join table" called `visits` to handle this relationship, 
			-- it should also keep track of the date of the visit.
CREATE TABLE visits (
  animals_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  visit_date DATE
);


-- Day 5
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create Index for visits (animals_id)
CREATE INDEX idx_animals_id ON visits (animals_id);
-- Create Index for visits (animals_id)
CREATE INDEX idx_vet_id ON visits (vet_id);
-- Create Index for visits (animals_id)
CREATE INDEX idx_email ON owners (email);