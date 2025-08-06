/*
Mountain Huts & Trails

A ski resort company is planning to construct a new ski slope using a pre-existing network of
mountain huts and trails between them. A new slope has to begin at one of the mountain huts,
have a middle station at another hut connected with the first one by a direct trail, and end at
the third mountain hut which is also connected by a direct trail to the second hut. The altitude
of the three huts chosen for constructing the ski slope has to be strictly decreasing.

Each entry in the table trails represents a direct connection between huts with IDs hut1 and
hut2. Note that all trails are bidirectional.
Create a query that finds all triplets(startpt,middlept,endpt) representing the mountain huts
that may be used for construction of a ski slope.
Output returned by the query can be ordered in any way.

Assume that:
 - There is no trail going from a hut back to itself;
 - For every two huts there is at most one direct trail connecting them;
 - Each hut from table trails occurs in table mountain_huts;

*/

drop table if exists mountain_huts;
create table mountain_huts 
(
    id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;

create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);

insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;


-- joins both
WITH trails1_cte AS (
SELECT t1.hut1 as staring_hut,
       h1.name as starting_hut_name,
       h1.altitude as starting_hut_altitude,
       t1.hut2 as ending_hut
FROM trails t1
JOIN mountain_huts h1 ON t1.hut1 = h1.id
),
trails2_cte AS (
SELECT t2.staring_hut,
       t2.starting_hut_name,
       t2.starting_hut_altitude,
       t2.ending_hut,
       h2.name as ending_hut_name,
       h2.altitude as ending_hut_altitude,
       CASE WHEN t2.starting_hut_altitude > h2.altitude THEN 1 ELSE  0 END AS altitude_flag
FROM trails1_cte t2
JOIN mountain_huts h2 ON t2.ending_hut = h2.id
),
trails3_cte AS (
SELECT
    CASE WHEN altitude_flag = 1 THEN staring_hut ELSE ending_hut END AS staring_hut,
    CASE WHEN altitude_flag = 1 THEN starting_hut_name ELSE ending_hut_name END AS starting_hut_name,
    CASE WHEN altitude_flag = 1 THEN starting_hut_altitude ELSE ending_hut_altitude END AS starting_hut_altitude,
    CASE WHEN altitude_flag = 1 THEN ending_hut ELSE staring_hut END AS ending_hut,
    CASE WHEN altitude_flag = 1 THEN ending_hut_name ELSE starting_hut_name END AS ending_hut_name,
    CASE WHEN altitude_flag = 1 THEN ending_hut_altitude ELSE starting_hut_altitude END AS ending_hut_altitude
FROM trails2_cte
)
SELECT 
    c1.starting_hut_name as startPoint,
    c1.ending_hut_name as middlePoint,
    c2.ending_hut_name as endPoint
FROM trails3_cte c1
JOIN trails3_cte c2
ON c1.ending_hut = c2.staring_hut;
