-- GLOBAL EMISSION

-- Data: https://www.kaggle.com/datasets/ashishraut64/global-methane-emissions?resource=download

CREATE TABLE IF NOT EXISTS global_emission
(
	region text,
	country text,
	emissions numeric,
	type text,
	segment text,
	reason text,
	base_year text,
	notes text
);

SELECT * FROM global_emission;

-- Import global_emission.csv file to the table, UTF8
-- Check the table
-- Explore the data 

SELECT * FROM global_emission;

-- Looking at the highest emission by country 
-- Excluding the country "World"

SELECT base_year, country, type, SUM(emissions) as total_emissions
FROM global_emission
WHERE country <> 'World'
GROUP BY base_year, country, type
ORDER BY total_emissions DESC;

-- Looking at the AVERAGE of emissions of country, base_year, type and segment

SELECT DISTINCT(base_year),country, AVG(emissions) AS average_emission_per_country, type, segment
FROM global_emission
WHERE country <> 'World'
AND country <> 'Other'
GROUP BY base_year, country, type, segment, emissions
ORDER BY AVG(emissions), country DESC;

-- Looking at the highest sum of emissions from country and type

SELECT DISTINCT(country), type, SUM(emissions) AS sum_of_emission FROM global_emission
WHERE country <> 'World'
AND country <> 'Other'
GROUP BY type, country
ORDER BY SUM(emissions) DESC

-- Looking at the highest sum of emission vs year

SELECT base_year, SUM(emissions) AS sum_emission
FROM global_emission
GROUP BY base_year
ORDER BY SUM(emissions) DESC

-- Looking at the highest average emission vs year

SELECT base_year, AVG(emissions) AS average_emission
FROM global_emission
GROUP BY base_year
ORDER BY AVG(emissions) DESC

-- Looking at the maximum emission vs year

SELECT base_year, MAX(emissions) AS max_emission
FROM global_emission
GROUP BY base_year

-- Looking at the minimum emission vs year

SELECT base_year, MIN(emissions) AS min_emission
FROM global_emission
GROUP BY base_year