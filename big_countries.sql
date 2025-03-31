"""
Table: World

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
"""

DROP TABLE IF EXISTS World;

CREATE TABLE IF NOT EXISTS World (
    name VARCHAR(100) PRIMARY KEY,
    continent VARCHAR(50) NOT NULL,
    area INT NOT NULL,
    population INT NOT NULL,
    gdp BIGINT NOT NULL
);

INSERT INTO World (name, continent, area, population, gdp) VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000)
ON CONFLICT (name) DO NOTHING;

SELECT * FROM World;

"
- It has an area of at least three million (i.e., 3000000 km2), or
- It has a population of at least twenty-five million (i.e., 25000000).
- Write a solution to find the name, population, and area of the big countries.
"

SELECT name, population, area
FROM World
WHERE population > 25000000
OR area > 3000000;