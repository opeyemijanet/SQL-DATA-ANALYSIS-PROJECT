--ten earliest order in orders table
SELECT *
  FROM orders
ORDER BY occurred_at 
LIMIT 10

--TOP FIVE ORDERS IN TERMS OF TOTAL
SELECT *
  FROM orders
ORDER BY total DESC 
LIMIT 5

--TOP FIVE ORDERS IN TERMS OF TOTAL AMOUNT USED IN DESCENDING ORDER
SELECT *
  FROM orders
ORDER BY total_amt_usd  DESC
LIMIT 5

	
--to check distinct channels
SELECT DISTINCT (channel)
FROM web_events

--first 50 amount where total is greater than or equals 1000
SELECT *
FROM orders
WHERE total >= 1000
LIMIT 50

--write a query to return the 20 lowest orders in terms of smallest total amount_usd, id column, account_id
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd ASC
LIMIT 20

--TRYING WITH NON NUMERIC
SELECT *
FROM accounts
WHERE name = 'Apple'

--write a query that returns all the orders where the standard qty is 
--over 1000, the poster qty is 0 and the gloss qty is 0

SELECT *
FROM orders
WHERE standard_qty > 1000
AND poster_qty = 0
AND gloss_qty = 0

--using accounts table find all the companies whose name do not start 
--with c and end with s
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%'
	AND name LIKE '%s'
	
--WRITE A QUERY THAT DISPLAYS THE ORDER DATE AND GLOSS QTY DATA FOR 
--ALL ORDERS WHERE GLOSS QUANTITY IS BETWEEN 24 AND 29
SELECT *
  FROM orders
 WHERE gloss_qty BETWEEN 24 AND 29
order by gloss_qty 
	
--PROVIDE A TABLE FOR ALL WEB EVENTS ASSOCIATED WITH ACCOUNT NAME WALMART
SELECT  A.primary_Poc, WB.occurred_at, WB.channel, A.name
  FROM orders o
  JOIN accounts  A
    ON o.id = A.id
  JOIN web_events WB
	ON A.id = WB.account_id
 WHERE A.name = 'Walmart'

--to get orders for evry region 
SELECT r.id, r.name Region_name, sr.name Salesrep_name, o.total
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
  JOIN orders o
    ON a.id = o.account_id
GROUP BY r.id, r.name, sr.name, o.total
ORDER BY o.total DESC

--provide the table that shows the region of each sales rep along with their 
--associated account.
SELECT r.name AS region_name, sr.name AS sales_rep_name, a.name AS account_name
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
 WHERE r.name = 'Midwest'
ORDER BY a.name 

--provide a table that shows the region of each sales rep along with their 
--associated account sales rep has a first name starting with s and in the midwest region
SELECT r.name AS region_name, sr.name AS sales_rep_name, a.name AS account_name
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
 WHERE r.name = 'Midwest'
   AND sr.name LIKE 'S%'
ORDER BY a.name

--provide a table for each sales rep with their associated accounts. only for 
--accounts where sales rep has a last name starting with k and in the midwest region
SELECT r.name AS region_name, sr.name AS sales_rep_name, a.name AS account_name
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
 WHERE r.name = 'Midwest'
   AND (sr.name LIKE '% K%' OR sr.name LIKE '% k%')
ORDER BY a.name

--types of join (inner, left, outer)
SELECT *
  FROM accounts a
LEFT JOIN orders o
       ON a.id = o.account_id   

--Provide the name for each region for every order, as well as the account name and the 
--unit price they paid for the order. However, you should only provide the results if the 
--standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--Sort for the largest unit price 
	WITH calculatedorders AS (
  SELECT r.name region_name, a.name account, o.total_amt_usd/(o.total + 0.01) AS unit_price
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
  JOIN orders o
    ON a.id = o.account_id
 WHERE standard_qty > 100 
   AND poster_qty > 50)
SELECT region_name, account,unit_price
  FROM calculatedorders
 WHERE unit_price > 5.96
 ORDER BY unit_price DESC

--a cte-common table expression can be reused anywhere but a subquery is not reusable.
SELECT  r.name region_name, a.name account, o.total_amt_usd/(o.total + 0.01) AS unit_price
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
  JOIN orders o
    ON a.id = o.account_id
 WHERE standard_qty > 100
   AND poster_qty > 50

--What are the different channels used by account id 1001? Your final table should have only 2 
--columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the 
--results to only the unique values.
SELECT DISTINCT we.channel, a.name
  FROM web_events we
  JOIN accounts a
    ON we.account_id = a.id
 WHERE a.id = 1001
	
--USING CTE
--Provide the name for each region for every order, as well as the account name, 
--time ordered and the unit price they paid for the order. However, you should only
--provide the results if the standard order quantity exceeds 100 and the 
--poster order quantity exceeds 50. Your final table should have 4 columns: 
--region name, account name, time ordered, and unit price. 
--Query for all orders where the unit_price exceed 6.7 and 
--sort for the largest unit price first.
  WITH calculated_orders AS (	
SELECT r.name region_name, a.name account_name, wb.occurred_at time_order,
	o.total_amt_usd/(o.total + 0.01)  unit_price
  FROM region r
  JOIN sales_reps sr
    ON r.id = sr.region_id
  JOIN accounts a
    ON sr.id = a.sales_rep_id
  JOIN web_events wb
	ON a.id = wb.account_id
  JOIN orders o
    ON a.id = o.account_id
 WHERE standard_qty > 100
   AND poster_qty > 50)
SELECT region_name, account_name, time_order,unit_price
	FROM calculated_orders
 WHERE unit_price > 6.7
ORDER BY unit_price DESC
