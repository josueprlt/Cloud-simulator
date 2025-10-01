CREATE TABLE simulations (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  estimated_cost NUMERIC,
  date TIMESTAMP
);

INSERT INTO simulations (name, estimated_cost, date) VALUES
('Baseline', 1245.5, '2025-09-30'),
('Optimized', 842.2, '2025-09-29');
