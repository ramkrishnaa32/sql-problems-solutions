"
Table: Activity
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.
"

-- Drop ENUM type if it exists
DROP TYPE IF EXISTS activity_enum;

-- Create ENUM type for activity_type
CREATE TYPE activity_enum AS ENUM ('start', 'end');

-- Drop table if it exists
DROP TABLE IF EXISTS Activity;

-- Create table
CREATE TABLE Activity (
    machine_id INT,
    process_id INT,
    activity_type activity_enum, -- Use the ENUM type correctly
    timestamp FLOAT,
    PRIMARY KEY (machine_id, process_id, activity_type)
);

-- Insert data
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start', 0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.430),
(1, 1, 'end', 1.420),
(2, 0, 'start', 4.100),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.500),
(2, 1, 'end', 5.000);

-- Select data
SELECT * FROM Activity;

"
There is a factory website that has several machines each running the same number of processes.
Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
"
SELECT 
    machine_id, 
    ROUND(AVG(end_time - start_time)::NUMERIC, 3) AS processing_time
FROM (
    SELECT 
        machine_id, 
        process_id, 
        MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time,
        MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time
    FROM Activity
    GROUP BY machine_id, process_id
) AS process_durations
GROUP BY machine_id;
