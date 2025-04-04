"""
1683. Invalid Tweets
Easy

Topics
Companies
SQL Schema
Pandas Schema
Table: Tweets

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
content consists of alphanumeric characters, '!', or ' ' and no other special characters.
This table contains all the tweets in a social media app.
"""

DROP TABLE IF EXISTS Tweets;

CREATE TABLE IF NOT EXISTS Tweets (
    tweet_id INT PRIMARY KEY,
    content VARCHAR(255) NOT NULL
);

INSERT INTO Tweets (tweet_id, content) VALUES
(1, 'This is a short tweet!'),
(2, 'An extremely long tweet that exceeds the character limit...'),
(3, 'SQL is fun!'),
(4, 'Hello world!'),
(5, 'This tweet is exactly 140 characters long....................................................................................');

SELECT * FROM Tweets;

-- Write a solution to find the IDs of the invalid tweets. 
-- The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;