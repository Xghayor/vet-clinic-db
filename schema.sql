/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT
);


ALTER TABLE animals ADD species varchar(255);

CREATE TABLE owners (
     id SERIAL PRIMARY KEY,
     full_name VARCHAR(100),
     age INT
);

CREATE TABLE species (
    id serial PRIMARY KEY,
    species_name varchar(255)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD owners_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD CONSTRAINT fk_owners_id
FOREIGN KEY (owners_id)
REFERENCES owners(id);







