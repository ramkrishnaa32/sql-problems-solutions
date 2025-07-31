CREATE TABLE weathe_temp (
    id INT,
    recordDate DATE,
    temperature INT
);

INSERT INTO weathe_temp (id, recordDate, temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);

SELECT * FROM weathe_temp;

WITH temp_table AS (
SELECT
id, recordDate, temperature,
LAG(temperature, 1) OVER(ORDER BY id) as previous_day
FROM weathe_temp
)
SELECT id FROM temp_table
WHERE temperature > previous_day;