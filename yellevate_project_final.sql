-- Yellevate Project

-- Create table, Yellevate

CREATE TABLE IF NOT EXISTS yellevate 
(
country text,
customer_ID text,
invoice_number numeric,
invoice_date date,
due_date date,
invoice_amount_usd numeric,
disputed numeric,
dispute_lost numeric,
settled_date date,
days_to_settle numeric,
days_late numeric
);

-- Import data in the csv UTF8 file
-- Check the data

SELECT * FROM yellevate;

--Clean the data 

SELECT DISTINCT country FROM yellevate; -- There was no incorrect spelling, the date format is also consistent

--1. Processing time in which invoices are settled (average # of days rounded to a whole number)

SELECT ROUND(AVG(days_to_settle)) FROM yellevate;

--2. Processing time for the company to settle disputes ( average # of days rounded to a whole number)

SELECT ROUND(AVG(days_to_settle)) AS average_days_to_settle_disputes FROM yellevate
WHERE disputed = 1;

--3. Percentage of total number of lost disputes over the total number of transactions
-- Use decimal data type instead of float to have an accurate values

SELECT ROUND((count_dispute_lost :: decimal /count_of_total_transactions :: decimal)*100,2) AS percentage_dispute_lost
FROM
(SELECT COUNT (*) AS count_of_total_transactions,
		COUNT(CASE WHEN dispute_lost = 1 THEN 1 END) AS count_dispute_lost
FROM yellevate) subquery_alias;

--4. Percentage of revenue lost from disputes (within two decimal place)

SELECT ROUND(SUM(
	CASE WHEN dispute_lost = 1 THEN invoice_amount_usd ELSE 0 
	END) / SUM(invoice_amount_usd) * 100,2) AS percent_lost_from_disputes
FROM yellevate;

--5. The country where the company reached the highest losses from lost disputes (in USD)

SELECT country, SUM(invoice_amount_usd) AS sum_lost_from_disputes FROM yellevate
WHERE dispute_lost = 1 
GROUP BY country
ORDER BY sum_lost_from_disputes DESC;

-- END 

