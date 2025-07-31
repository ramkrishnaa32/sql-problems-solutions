"
Creating papulations table
Records belongs to should appear at the top
"
CREATE TABLE IF NOT EXISTS population (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    country VARCHAR(50)
);

INSERT INTO population (name, age, country) VALUES
('Amit', 30, 'INDIA'),
('John', 45, 'USA'),
('Meena', 25, 'INDIA'),
('Carlos', 40, 'MEXICO'),
('Priya', 28, 'INDIA'),
('Chen', 33, 'CHINA'),
('Maria', 37, 'BRAZIL'),
('Ravi', 22, 'INDIA');


-- Normal query
SELECT * FROM population WHERE country = 'INDIA'
UNION ALL
SELECT * FROM population WHERE country != 'INDIA';


-- Optimized query
SELECT * FROM population
ORDER BY CASE WHEN country = 'INDIA' THEN 0 ELSE 1 END;
