--Best Investment: Gold VS Silver 
--Data: https://www.kaggle.com/datasets/kapturovalexander/gold-and-silver-prices-2013-2023

----------------------------
-- Create gold_price table--
----------------------------
CREATE TABLE IF NOT EXISTS gold_price(
date date,
close_last numeric,
volume numeric,
open numeric,
high numeric,
low numeric
);

------------------------------
-- Create silver_price table--
------------------------------
CREATE TABLE IF NOT EXISTS silver_prices(
date date,
close_last numeric,
volume numeric,
open numeric,
high numeric,
low numeric
);

-------------------------------------------------
--Check the columns order it by ascending order--
-------------------------------------------------
SELECT * FROM gold_prices
ORDER BY date; 

SELECT * FROM silver_prices
ORDER BY date;

----------------------------------
--Volume traded per year in gold--
----------------------------------
SELECT
    EXTRACT(YEAR FROM date) AS year,
    SUM(volume) AS total_volume
FROM gold_prices
GROUP BY year
ORDER BY year;
	
-----------------------------------
--Volume traded per month in gold--
-----------------------------------
SELECT 
	CASE 
	WHEN EXTRACT(MONTH FROM date) = 1 THEN 'January'
	WHEN EXTRACT(MONTH FROM date) = 2 THEN 'February'
	WHEN EXTRACT(MONTH FROM date) = 3 THEN 'March'
	WHEN EXTRACT(MONTH FROM date) = 4 THEN 'April'
	WHEN EXTRACT(MONTH FROM date) = 5 THEN 'May'
	WHEN EXTRACT(MONTH FROM date) = 6 THEN 'June'
	WHEN EXTRACT(MONTH FROM date) = 7 THEN 'July'
	WHEN EXTRACT(MONTH FROM date) = 8 THEN 'August'
	WHEN EXTRACT(MONTH FROM date) = 9 THEN 'September'
	WHEN EXTRACT(MONTH FROM date) = 10 THEN 'October'
	WHEN EXTRACT(MONTH FROM date) = 11 THEN 'November'
	WHEN EXTRACT(MONTH FROM date) = 12 THEN 'December'
	ELSE NULL
	END AS month,
	EXTRACT (YEAR FROM date) AS year,
	SUM(volume) AS total_volume
FROM gold_prices
GROUP BY year, month
ORDER BY year, month DESC;					
	
--------------------------------------------	
--Lowest closing price of gold in 10 years--
--------------------------------------------
SELECT date, MIN(close_last) AS min_close_last
FROM gold_prices
GROUP BY date
ORDER BY min_close_last;

--------------------------------------------
--Higest closing price of gold in 10 years--
--------------------------------------------
SELECT date, MAX(close_last) AS max_close_last
FROM gold_prices
GROUP BY date
ORDER BY max_close_last DESC

----------------------------------------------------------------------------------
--Return of Investment in gold from year 2013 to 2023 if you dollar cost average--
----------------------------------------------------------------------------------
WITH avg_yearly AS (
    SELECT
        EXTRACT(YEAR FROM date) AS year,
        ROUND(AVG(close_last), 3) AS yearly_avg
    FROM gold_prices
    GROUP BY year
)
SELECT
    ((MAX(CASE WHEN year = 2023 THEN yearly_avg END) - MAX(CASE WHEN year = 2013 THEN yearly_avg END)) /
    MAX(CASE WHEN year = 2013 THEN yearly_avg END)) * 100 AS percentage_gain
FROM avg_yearly
WHERE year IN (2013, 2023);

------------------------------------
--Volume traded per year in silver--
------------------------------------
SELECT
    EXTRACT(YEAR FROM date) AS year,
    SUM(volume) AS total_volume
FROM silver_prices
GROUP BY year
ORDER BY year;

-------------------------------------
--Volume traded per month in silver--
-------------------------------------
SELECT 
	CASE 
	WHEN EXTRACT(MONTH FROM date) = 1 THEN 'January'
	WHEN EXTRACT(MONTH FROM date) = 2 THEN 'February'
	WHEN EXTRACT(MONTH FROM date) = 3 THEN 'March'
	WHEN EXTRACT(MONTH FROM date) = 4 THEN 'April'
	WHEN EXTRACT(MONTH FROM date) = 5 THEN 'May'
	WHEN EXTRACT(MONTH FROM date) = 6 THEN 'June'
	WHEN EXTRACT(MONTH FROM date) = 7 THEN 'July'
	WHEN EXTRACT(MONTH FROM date) = 8 THEN 'August'
	WHEN EXTRACT(MONTH FROM date) = 9 THEN 'September'
	WHEN EXTRACT(MONTH FROM date) = 10 THEN 'October'
	WHEN EXTRACT(MONTH FROM date) = 11 THEN 'November'
	WHEN EXTRACT(MONTH FROM date) = 12 THEN 'December'
	ELSE NULL
	END AS month,
	EXTRACT (YEAR FROM date) AS year,
	SUM(volume) AS total_volume
FROM silver_prices
GROUP BY year, month
ORDER BY year, month DESC;					
	
----------------------------------------------
--Lowest closing price of silver in 10 years--
----------------------------------------------
SELECT date, MIN(close_last)
FROM silver_prices
GROUP BY date
ORDER BY date DESC;

-----------------------------------------------
--Highest closing price of silver in 10 years--
-----------------------------------------------
SELECT date, MAX(close_last) AS max_close_last
FROM silver_prices
GROUP BY date
ORDER BY max_close_last DESC;

---------------------------------------------------------
--Return of Investment in silver from year 2013 to 2023--
---------------------------------------------------------
WITH avg_yearly AS (
    SELECT
        EXTRACT(YEAR FROM date) AS year,
        ROUND(AVG(close_last), 3) AS yearly_avg
    FROM silver_prices
    GROUP BY year
)
SELECT
    ((MAX(CASE WHEN year = 2023 THEN yearly_avg END) - MAX(CASE WHEN year = 2013 THEN yearly_avg END)) /
    MAX(CASE WHEN year = 2013 THEN yearly_avg END)) * 100 AS percentage_gain
FROM avg_yearly
WHERE year IN (2013, 2023);
	
--What is the best investment in the past 10 years?
--Silver or Gold? 
--GOLD with 49.45% roi if you DCA since 2013.




