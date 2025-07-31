"""
Example 1:

Input: 
Person table:
+----------+----------+-----------+
| personId | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |
+----------+----------+-----------+
Address table:
+-----------+----------+---------------+------------+
| addressId | personId | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |
+-----------+----------+---------------+------------+
Output: 
+-----------+----------+---------------+----------+
| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |
+-----------+----------+---------------+----------+
Explanation: 
There is no address in the address table for the personId = 1 so we return null in their city and state.
addressId = 1 contains information about the address of personId = 2.
"""

-- Create Person table
CREATE TABLE IF NOT EXISTS Person (
    personId SERIAL PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL
);

-- Insert sample data into Person table
INSERT INTO Person (personId, lastName, firstName) VALUES
(1, 'Wang', 'Allen'),
(2, 'Alice', 'Bob')
ON CONFLICT (personId) DO NOTHING;

-- Create Address table
CREATE TABLE IF NOT EXISTS Address (
    addressId SERIAL PRIMARY KEY,
    personId INT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL
);

-- Insert sample data into Address table
INSERT INTO Address (addressId, personId, city, state) VALUES
(1, 2, 'New York City', 'New York'),
(2, 3, 'Leetcode', 'California')
ON CONFLICT (addressId) DO NOTHING;

SELECT * FROM Person;
SELECT * FROM Address;

SELECT p.lastName, p.firstName, a.city, a.state
FROM Person p
LEFT JOIN Address a
ON p.personId = a.personId;
