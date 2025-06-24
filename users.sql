-- How do indexes make databases read faster?
-- Indexes improve read performance by allowing the database to quickly locate and access rows in a table without scanning the entire table.

-- This SQL script creates a table for users and inserts sample data into it.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    bio TEXT,
    total_blog INT,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);


-- Insert sample data into the users table
INSERT INTO users (name, age, bio, total_blog, email)
VALUES
('Alice Smith', 30, 'Tech blogger and speaker.', 15, 'alice@example.com'),
('Bob Johnson', 24, 'Writes about travel and photography.', 8, 'bob@example.com'),
('Charlie Lee', 35, 'Finance and crypto enthusiast.', 22, 'charlie@example.com'),
('Dana White', 28, 'Fitness and health coach.', 12, 'dana@example.com'),
('Eli Zhang', 40, 'Writes about history and politics.', 30, 'eli@example.com'),
('Fiona Gray', 32, 'Lifestyle and wellness blogger with a focus on minimalism.', 18, 'fiona@example.com'),
('George Patel', 27, 'Writes about startups, tech trends, and entrepreneurship.', 10, 'george@example.com');


-- Query to retrieve all users
SELECT * FROM users;

EXPLAIN SELECT * FROM users;


-- Index creation for faster read operations
CREATE INDEX idx_users_age ON users (age);

-- Query to retrieve users with age greater than 30
SELECT * FROM users WHERE age > 30;

EXPLAIN SELECT * FROM users WHERE age > 30;
