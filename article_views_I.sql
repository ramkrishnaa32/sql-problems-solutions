"
Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
"

DROP TABLE IF EXISTS Views;

CREATE TABLE IF NOT EXISTS Views (
    article_id INT NOT NULL,
    author_id INT NOT NULL,
    viewer_id INT NOT NULL,
    view_date DATE NOT NULL
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21')
ON CONFLICT DO NOTHING;

SELECT * FROM Views;

"
Write a solution to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
"

SELECT distinct author_id as id 
FROM Views
WHERE author_id = viewer_id
ORDER BY id;