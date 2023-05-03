-- Analysis of Financing Data for New Investment

-- 1. Prepare the dataset for the analysis bye creating new table selecting records.

CREATE TABLE IF NOT EXISTS investment (
	market character varying,
	funding_total_usd bigint,
	status character varying,
	country_code character varying,
	founded_year bigint,
	seed bigint,
	venture bigint,
	equity_crowdfunding bigint,
	undisclosed bigint,
	convertible_note bigint,
	debt_financing bigint,
	private_equity bigint
);

-- 2. Provide SQL syntax that presents the number of observations of companies
-- operating in financial services and their average, minimum and maximum seed funding.

SELECT MIN(seed), MAX(seed), ROUND(AVG(seed),2)
FROM investment
WHERE market = 'financial services'
AND status = 'operating';

-- 3. Determine whether or not there has been a previous instance where a startup offering financial
-- services received equity crowdfunding, Provide the details of the company

SELECT status, country_code, equity_crowdfunding 
FROM investment
WHERE market = 'financial services'
AND equity_crowdfunding !=0;

-- 4. Determine whether or not a significant outlier in terms of total funding (USD)
-- exists among companies that offer financial services.

SELECT * FROM investment 
WHERE market = 'financial services'
AND funding_total_usd IS NOT NULL
ORDER BY funding_total_usd DESC;

-- END 
