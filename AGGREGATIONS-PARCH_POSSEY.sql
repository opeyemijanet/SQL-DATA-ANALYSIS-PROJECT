--COUNT 
--examples
SELECT COUNT(id) AS account_count
  FROM accounts

--SUM
--example
SELECT SUM (standard_amt_usd) standard_amt,
       SUM (poster_amt_usd) poster_amt,
       SUM (gloss_amt_usd)gloss_amt
      FROM orders;

--Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both 
--aggregation and a mathematical operator.
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

--MIN and MAX
--example
SELECT MIN (poster_qty)
 FROM orders
--
SELECT MIN(standard_qty) AS standard_min,
       MIN(gloss_qty) AS gloss_min,
       MIN(poster_qty) AS poster_min,
       MAX(standard_qty) AS standard_max,
       MAX(gloss_qty) AS gloss_max,
       MAX(poster_qty) AS poster_max
FROM   orders;

--AVERAGE
--example
SELECT AVG(standard_qty) AS avg_standard_qty
 FROM orders

--When was the earliest order ever placed? You only need to return the date.
SELECT  MIN(occurred_at) AS earliest_order
FROM orders;

--Try performing the same query as in question 1 without using an aggregation function.
SELECT occurred_at
  FROM orders
 ORDER BY occurred_at 
 LIMIT 1

--When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at) AS latest_event_time
FROM web_events;