
"
Table: Signups
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
"

-- Drop tables if they exist
DROP TABLE IF EXISTS Confirmations;
DROP TABLE IF EXISTS Signups;
DROP TYPE IF EXISTS confirmation_action;

-- Create ENUM type for action
CREATE TYPE confirmation_action AS ENUM ('confirmed', 'timeout');

-- Create Signups table
CREATE TABLE Signups (
    user_id INT PRIMARY KEY,
    time_stamp TIMESTAMP
);

-- Create Confirmations table
CREATE TABLE Confirmations (
    user_id INT,
    time_stamp TIMESTAMP,
    action confirmation_action,
    PRIMARY KEY (user_id, time_stamp),
    FOREIGN KEY (user_id) REFERENCES Signups(user_id)
);

-- Insert data into Signups
INSERT INTO Signups (user_id, time_stamp) VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

-- Insert data into Confirmations
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');


SELECT * FROM Confirmations;
SELECT * FROM Signups;

SELECT s.user_id, c.action, c.actionCount
FROM Signups s
LEFT JOIN 
( SELECT user_id, action, count(*) as actionCount
FROM Confirmations
GROUP BY user_id, action) c
ON s.user_id = c.user_id;

SELECT 
    s.user_id,
    ROUND(
        COALESCE(
            COUNT(CASE WHEN c.action = 'confirmed' THEN 1 END)::DECIMAL 
            / NULLIF(COUNT(c.action), 0), 
        0), 
    2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

WITH confirmation_stats AS (
    SELECT 
        user_id,
        COUNT(*) AS total_actions,
        COUNT(*) FILTER (WHERE action = 'confirmed') AS confirmed_actions
    FROM Confirmations
    GROUP BY user_id
)

SELECT 
    s.user_id,
    ROUND(
        COALESCE(cs.confirmed_actions::DECIMAL / cs.total_actions, 0), 
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN confirmation_stats cs ON s.user_id = cs.user_id
ORDER BY s.user_id;
