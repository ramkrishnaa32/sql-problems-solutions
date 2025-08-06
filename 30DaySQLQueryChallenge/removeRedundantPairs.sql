/*
Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020)
    - If custom1 = custom3 and custom2 = custom4, then they are redundant.
    - Only keep one of them.
- For pairs of brands in the same
    - If custom1 != custom3 OR custom2 != custom4, then they are not redundant.
    - Keep both of them.
- For brands that do not have a pair in the same year, keep them as they are.
*/

CREATE TABLE brand_pairs (
    id INT PRIMARY KEY,
    brand1 VARCHAR(50),
    brand2 VARCHAR(50),
    year INT,
    custom1 VARCHAR(50),
    custom2 VARCHAR(50),
    custom3 VARCHAR(50),
    custom4 VARCHAR(50)
);

INSERT INTO brand_pairs (id, brand1, brand2, year, custom1, custom2, custom3, custom4) VALUES
(1, 'apple', 'samsung', 2020, 'A', 'B', 'A', 'B'), -- redundant
(2, 'samsung', 'apple', 2020, 'A', 'B', 'A', 'B'), -- redundant pair
(3, 'google', 'huawei', 2020, 'X', 'Y', 'X', 'Z'), -- not redundant
(4, 'huawei', 'google', 2020, 'X', 'Z', 'X', 'Y'), -- not redundant pair
(5, 'apple', 'sony', 2021, 'M', 'N', 'M', 'N'), -- no pair
(6, 'samsung', 'sony', 2021, 'M', 'N', 'M', 'O'), -- no pair
(7, 'lg', 'nokia', 2022, 'R', 'S', 'R', 'S'), -- redundant
(8, 'nokia', 'lg', 2022, 'R', 'S', 'R', 'S'), -- redundant pair
(9, 'apple', 'google', 2023, 'C', 'D', 'C', 'E'), -- not redundant
(10, 'google', 'apple', 2023, 'C', 'E', 'C', 'D'); -- not redundant pair

-- select query
SELECT * FROM brand_pairs;

WITH cte AS (
    SELECT *,
        CASE 
            WHEN brand1 < brand2 THEN CONCAT(brand1, brand2, year)
            ELSE CONCAT(brand2, brand1, year)
        END AS pair_id
    FROM brand_pairs
),
cte_rn AS (
    SELECT *,
        COUNT(*) OVER (PARTITION BY pair_id) AS pair_count,
        ROW_NUMBER() OVER (PARTITION BY pair_id ORDER BY id) AS rn
    FROM cte
)
SELECT brand1, brand2, year, custom1, custom2, custom3, custom4, pair_count, rn
FROM cte_rn
WHERE 
    pair_count = 1 -- Unpaired rows
    OR (custom1 <> custom3 OR custom2 <> custom4) -- Not redundant, keep both
    OR (custom1 = custom3 AND custom2 = custom4 AND rn = 1); -- Redundant, keep one


