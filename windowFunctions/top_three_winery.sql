DROP TABLE IF EXISTS wines;

CREATE TABLE wines (
    id INT PRIMARY KEY,
    country VARCHAR(100),
    points INT,
    winery VARCHAR(255)
);

INSERT INTO wines (id, country, points, winery) VALUES
(1, 'France', 95, 'Château Margaux'),
(2, 'France', 92, 'Château Margaux'),
(3, 'Italy', 93, 'Antinori'),
(4, 'Italy', 91, 'Gaja'),
(5, 'Italy', 89, 'Tignanello'),
(6, 'USA', 90, 'Robert Mondavi'),
(7, 'USA', 92, 'Opus One'),
(8, 'USA', 88, 'Silver Oak'),
(9, 'Spain', 92, 'Marqués de Murrieta'),
(10, 'Spain', 89, 'Marqués de Murrieta'),
(11, 'Australia', 91, 'Penfolds'),
(12, 'Australia', 88, 'Yalumba'),
(13, 'Australia', 86, 'Jacobs Creek'),
(14, 'Argentina', 90, 'Catena Zapata'),
(15, 'Chile', 89, 'Concha y Toro'),
(16, 'South Africa', 90, 'Kanonkop'),
(17, 'South Africa', 87, 'Kanonkop'),
(18, 'Germany', 94, 'Dr. Loosen'),
(19, 'Germany', 92, 'Joh. Jos. Prüm'),
(20, 'Germany', 90, 'Egon Müller');

SELECT * FROM wines
ORDER BY country;