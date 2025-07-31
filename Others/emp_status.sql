CREATE TABLE employee_status (
    empId INT,
    duration DATE,
    status VARCHAR(20)
);

INSERT INTO employee_status (empId, duration, status) VALUES
(101, '2022-01-10', 'hired'),
(102, '2022-02-15', 'hired'),
(101, '2022-08-20', 'terminated'),
(102, '2022-09-05', 'terminated'),
(103, '2023-03-01', 'hired');

-- Query to retrieve employee status with hired and termination dates
SELECT empId, duration, status
FROM employee_status;

-- Query to retrieve employee status with hired and termination dates
SELECT empId,
MAX(CASE WHEN status = 'hired' THEN duration END) AS hiredDate,
MAX(CASE WHEN status = 'terminated' THEN duration END) AS terminationDate
FROM employee_status
GROUP BY empId
ORDER BY empId;

SELECT empId,
CASE WHEN status = 'hired' THEN duration ELSE NULL END AS hiredDate,
CASE WHEN status = 'terminated' THEN duration ELSE NULL END AS terminationDate
FROM employee_status;