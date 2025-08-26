DROP TABLE IF EXISTS Day_Indicator;

CREATE TABLE Day_Indicator
(
    Product_ID     VARCHAR(10),   -- Unique identifier for product
    Day_Indicator  VARCHAR(7),    -- 7-character binary string representing days of the week
    Dates          DATE           -- Calendar date
);

insert into Day_Indicator values ('AP755', '1010101', to_date('04-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('05-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('06-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('07-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('08-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('09-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('10-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('04-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('05-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('06-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('07-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('08-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('09-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('10-Mar-2024','dd-mon-yyyy'));


/*
Data Meaning
Day_Indicator field: A 7-character string where each position corresponds to a day of the week:
Position 1 → Monday
Position 2 → Tuesday
…
Position 7 → Sunday

Example:
1010101 → Include Monday, Exclude Tuesday, Include Wednesday, … Include Sunday.
Dates field: Actual calendar date to evaluate against the pattern.
*/

SELECT * FROM Day_Indicator;

SELECT product_id, day_indicator, dates
FROM (
    SELECT *, 
           EXTRACT('isodow' FROM dates) AS dow,
           CASE 
               WHEN SUBSTRING(day_indicator, EXTRACT('isodow' FROM dates)::int, 1) = '1'
               THEN 'Include' 
               ELSE 'Exclude' 
           END AS flag
    FROM day_indicator
) AS TEMP
WHERE flag = 'Include';



