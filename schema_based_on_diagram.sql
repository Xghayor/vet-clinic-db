-- Create a table patients
CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);

-- Create a table for medical_histories
CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at timestamp,
  patient_id INT,
  status VARCHAR(100),
  CONSTRAINT patient_id_fk FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE INDEX idx_medical_histories_patient_id ON medical_histories (patient_id);

-- Create a table for treatments
CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255)
);

-- Create a table for invoices
CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL(10, 2),
  generated_at timestamp,
  payed_at timestamp,
  medical_history_id INT,
  CONSTRAINT medical_history_id_fk FOREIGN KEY(medical_history_id) REFERENCES medical_history(id)
);

CREATE INDEX idx_invoices_medical_history_id ON invoices (medical_history_id);

-- Create a table for invoice_items
CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL(10, 2),
  quantity INT,
  total_price DECIMAL(10, 2),
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT invoice_id_fk FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  CONSTRAINT treatment_id_fk FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);

-- Craete a Many to many table between medical_histories and treatments
CREATE TABLE medical_treatments (
  medical_histories_id INT,
  treatments_id INT,
  CONSTRAINT medical_histories_id_fk FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
  CONSTRAINT treatment_id_fk FOREIGN KEY(treatments_id) REFERENCES treatments(id)
);

CREATE INDEX idx_medical_treatments_medical_histories_id ON medical_treatments (medical_histories_id);

CREATE INDEX idx_medical_treatments_treatments_id ON medical_treatments (treatments_id);
