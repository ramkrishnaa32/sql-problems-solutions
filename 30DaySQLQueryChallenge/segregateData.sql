-- Segregate Data

DROP TABLE IF EXISTS segregate_data;

CREATE TABLE segregate_data 
(
	id 			INT PRIMARY KEY,
	name 		VARCHAR(20), 
	location 		VARCHAR(20)
);

INSERT INTO segregate_data VALUES (1, NULL, NULL);
INSERT INTO segregate_data VALUES (2, 'David', NULL);
INSERT INTO segregate_data VALUES (3, NULL, 'London');
INSERT INTO segregate_data VALUES (4, NULL, NULL);
INSERT INTO segregate_data VALUES (5, 'David', NULL); 

SELECT * FROM segregate_data;

SELECT 
    MIN(id) AS id, 
    MIN(name) AS name, 
    MIN(location) AS location
FROM segregate_data;


SELECT 
    MAX(id) AS id, 
    MIN(name) AS name, 
    MIN(location) AS location
FROM segregate_data;







