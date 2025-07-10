
DROP TABLE IF EXISTS user_visits;

CREATE TABLE user_visits (
    user_id INT,
    visit_date DATE
);

INSERT INTO user_visits (user_id, visit_date) VALUES
(1, '2024-01-01'),
(1, '2024-01-05'),
(1, '2024-01-10'),
(2, '2024-01-03'),
(2, '2024-01-06'),
(2, '2024-01-08'),
(3, '2024-01-02');


SELECT * FROM user_visits;

WITH temp AS (
SELECT 
        user_id,
        visit_date,
        COALESCE(
            LEAD(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date),
            CURRENT_DATE
        ) AS next_visit_date
    FROM user_visits
)
SELECT user_id, max(next_visit_date - visit_date) AS window_days
FROM temp
GROUP BY user_id;
