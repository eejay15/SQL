-- Analysis of Netflix Movies Dataset

-- 1.The data has missing values in the "dir" (director) and "ctry" (country) columns,
-- whichare considered meaningful information. We want to make it more user-friendly.
-- Write a single SQL statement that changes "-" in the data to "not given" for both columns.

SELECT 
CASE 
	WHEN director = '-' THEN 'not given'
	ELSE director
END AS director,
CASE 
	WHEN country = '-' THEN 'not given'
	ELSE country
END AS country 
FROM movies;

-- 2. The management wanted to see the months when the shows were released.
-- However, we do not have this infromation in our table explicitly.
-- Write a SQL statement to create a column "month_added" containing the months extracted from the "date_added".

SELECT show_id,
CASE 
	WHEN EXTRACT(MONTH FROM date_added) = 1 THEN 'January'
	WHEN EXTRACT(MONTH FROM date_added) = 2 THEN 'February'
	WHEN EXTRACT(MONTH FROM date_added) = 3 THEN 'March'
	WHEN EXTRACT(MONTH FROM date_added) = 4 THEN 'April'
	WHEN EXTRACT(MONTH FROM date_added) = 5 THEN 'May'
	WHEN EXTRACT(MONTH FROM date_added) = 6 THEN 'June'
	WHEN EXTRACT(MONTH FROM date_added) = 7 THEN 'July'
	WHEN EXTRACT(MONTH FROM date_added) = 8 THEN 'August'
	WHEN EXTRACT(MONTH FROM date_added) = 9 THEN 'September'
	WHEN EXTRACT(MONTH FROM date_added) = 10 THEN 'October'
	WHEN EXTRACT(MONTH FROM date_added) = 11 THEN 'November'
	WHEN EXTRACT(MONTH FROM date_added) = 12 THEN 'December'
	ELSE NULL
END AS month_added
FROM movies;

-- 3. There is no explicit information if the title is a movie or a TV series. 
-- However, the duration column has either minutes or the number of seasons in it.
-- Create a select statement the as two columns:"duration" and a conditional one named "title_type"
-- with a "TV series" value if the corresponding duration has "Season" in it and "Movie" otherwise.

SELECT duration,
CASE 
	WHEN duration LIKE '%Season' THEN 'TV series'
	ELSE 'Movie'
END AS title_type
FROM movies;

-- 4. Write a SQL statement that concatenates "rating_1" and "rating_2" with "-"
-- between the values into a single column and name it "rating".

SELECT show_id, CONCAT(rating_1,'-',rating_2) AS rating 
FROM movies;

-- 5. Write a single SQL statement that compines the processing and cleaning steps from #1 through #4 above

SELECT show_id,	
INITCAP	
(CASE 	
	WHEN director = '-' THEN 'not given'
	ELSE director
END)AS director,	
INITCAP	
(CASE 	
 	WHEN country = '-' THEN 'not given'
	ELSE country
END) AS country,	
	CASE 
	WHEN EXTRACT(MONTH FROM date_added) = 1 THEN 'January'
	WHEN EXTRACT(MONTH FROM date_added) = 2 THEN 'February'
	WHEN EXTRACT(MONTH FROM date_added) = 3 THEN 'March'
	WHEN EXTRACT(MONTH FROM date_added) = 4 THEN 'April'
	WHEN EXTRACT(MONTH FROM date_added) = 5 THEN 'May'
	WHEN EXTRACT(MONTH FROM date_added) = 6 THEN 'June'
	WHEN EXTRACT(MONTH FROM date_added) = 7 THEN 'July'
	WHEN EXTRACT(MONTH FROM date_added) = 8 THEN 'August'
	WHEN EXTRACT(MONTH FROM date_added) = 9 THEN 'September'
	WHEN EXTRACT(MONTH FROM date_added) = 10 THEN 'October'
	WHEN EXTRACT(MONTH FROM date_added) = 11 THEN 'November'
	WHEN EXTRACT(MONTH FROM date_added) = 12 THEN 'December'
	ELSE NULL
END AS month_added,	
TO_CHAR(date_added,'Mon-DD-YYYY') AS date_added,	
release_year,	
	CASE 
	WHEN duration LIKE '%Season%' THEN 'TV series'
	ELSE 'Movie' 
END AS title_type,	
CONCAT(rating_1,'-',rating_2) AS rating,	
duration 	
FROM movies;	

-- END