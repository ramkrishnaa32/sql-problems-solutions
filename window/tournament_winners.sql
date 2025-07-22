DROP TABLE IF EXISTS player;

CREATE TABLE player (
    player_id INT PRIMARY KEY,
    group_id INT NOT NULL
);

DROP TABLE IF EXISTS matches;

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    first_player INT NOT NULL,
    second_player INT NOT NULL,
    first_score INT NOT NULL,
    second_score INT NOT NULL,
    FOREIGN KEY (first_player) REFERENCES player(player_id),
    FOREIGN KEY (second_player) REFERENCES player(player_id)
);

INSERT INTO player (player_id, group_id) VALUES
(1, 101),
(2, 101),
(3, 101),
(4, 102),
(5, 102),
(6, 102),
(7, 103),
(8, 103),
(9, 103),
(10, 104),
(11, 104),
(12, 104),
(13, 105),
(14, 105),
(15, 105);

INSERT INTO matches (match_id, first_player, second_player, first_score, second_score) VALUES
(1, 1, 2, 21, 17),
(2, 2, 3, 19, 21),
(3, 1, 3, 25, 20),
(4, 4, 5, 15, 21),
(5, 5, 6, 18, 22),
(6, 4, 6, 23, 19),
(7, 7, 8, 16, 21),
(8, 8, 9, 20, 18),
(9, 7, 9, 21, 19),
(10, 10, 11, 22, 25),
(11, 11, 12, 24, 22),
(12, 10, 12, 23, 26),
(13, 13, 14, 20, 21),
(14, 14, 15, 22, 23),
(15, 13, 15, 21, 17);


SELECT * FROM player;

SELECT * FROM matches;

-- Calculate the tournament winners based on the matches played
-- The winner is determined by the highest score in each group
-- If there is a tie, the player with the lower player_id wins
-- This query will return the player_id of the winners for each group

WITH player_scores AS (
SELECT
    match_id,
    player,
    score
FROM matches,
LATERAL (
    VALUES 
        (first_player, first_score),
        (second_player, second_score)
) AS temp(player, score)
),
grouped_scores AS (
SELECT p.match_id, p.player, p.score, g.group_id
FROM player_scores p
LEFT JOIN player g ON p.player = g.player_id
),
tournament_winners AS (
SELECT group_id, player, sum(score) as total_score
FROM grouped_scores
GROUP BY group_id, player
),
ranked_winners AS (
SELECT group_id, player, total_score,
       RANK() OVER (PARTITION BY group_id ORDER BY total_score DESC, player) as rank
FROM tournament_winners
)
SELECT group_id, player
FROM ranked_winners
WHERE rank = 1;

WITH player_scores AS (
SELECT 
    p.group_id, 
    p.player_id,
    CASE 
        WHEN p.player_id = m.first_player THEN m.first_score
        ELSE m.second_score
    END AS score
FROM player p
JOIN matches m ON p.player_id IN (m.first_player, m.second_player)
),
player_ranks AS (
SELECT 
    ps.group_id, 
    ps.player_id,
    SUM(ps.score) AS total_score,
    RANK() OVER (PARTITION BY ps.group_id ORDER BY SUM(ps.score) DESC, player_id) AS rank
FROM player_scores ps
GROUP BY ps.group_id, ps.player_id
)
SELECT 
    pr.group_id, 
    pr.player_id
FROM player_ranks pr
WHERE pr.rank = 1;
