-- Drop the table if it already exists
DROP TABLE IF EXISTS student_tests;

-- Create the student_tests table
CREATE TABLE student_tests
(
    test_id INT,  -- Unique ID for each test
    marks   INT   -- Marks scored in the test
);

-- Insert sample data
INSERT INTO student_tests VALUES (100, 55);
INSERT INTO student_tests VALUES (101, 55);
INSERT INTO student_tests VALUES (102, 60);
INSERT INTO student_tests VALUES (103, 58);
INSERT INTO student_tests VALUES (104, 40);
INSERT INTO student_tests VALUES (105, 50);

-- View the table
SELECT * FROM student_tests;


SELECT test_id, marks
FROM (
    SELECT *,
           LAG(marks, 1, 0) OVER (ORDER BY test_id) AS previous_marks
    FROM student_tests
) x
WHERE x.marks > x.previous_marks;


SELECT test_id, marks
FROM (
    SELECT *,
           LAG(marks, 1, marks) OVER (ORDER BY test_id) AS previous_marks
    FROM student_tests
) x
WHERE x.marks > x.previous_marks;
