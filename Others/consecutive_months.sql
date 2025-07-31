CREATE TABLE users_v2 (
    user_id INT PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE orders_v2 (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES users_v2(user_id)
);

-- Users
INSERT INTO users_v2 (user_id, username) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- Orders (across different months)
INSERT INTO orders_v2 (order_id, user_id, order_date) VALUES
(101, 1, '2024-01-15'),
(102, 1, '2024-02-20'),
(103, 1, '2024-03-10'),
(104, 2, '2024-01-05'),
(105, 2, '2024-03-22'),
(106, 2, '2024-04-11'),
(107, 3, '2024-05-01'),
(108, 3, '2024-06-03'),
(109, 3, '2024-07-15');


-- 
SELECT * FROM users_v2;
SELECT * FROM orders_v2;


WITH order_temp AS (
SELECT user_id, order_date,
EXTRACT(MONTH FROM order_date) AS order_month
FROM orders_v2
),
consecutive_months AS (
SELECT user_id, order_date, order_month,
LEAD(order_month, 1) OVER(PARTITION BY user_id order by order_month) AS next_order_month,
LEAD(order_month, 2) OVER(PARTITION BY user_id order by order_month) AS next2_order_month
FROM order_temp
)
select user_id, order_date, order_month,
CASE 
    WHEN next_order_month = order_month + 1 AND next2_order_month = order_month + 2 
    THEN 'yes' ELSE 'no' 
    END consecutive_orders
FROM consecutive_months;


WITH order_temp AS (
SELECT user_id, order_date,
EXTRACT(MONTH FROM order_date) AS order_month
FROM orders_v2
),
consecutive_months AS (
SELECT user_id, order_date, order_month,
LEAD(order_month, 1) OVER(PARTITION BY user_id order by order_month) AS next_order_month,
LEAD(order_month, 2) OVER(PARTITION BY user_id order by order_month) AS next2_order_month
FROM order_temp
)
select user_id, order_date
FROM consecutive_months
WHERE
next_order_month = order_month + 1
AND next2_order_month = order_month + 2;