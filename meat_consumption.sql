-- meat_consumption

-- Dataset: https://www.kaggle.com/datasets/ulrikthygepedersen/meat-consumption

SELECT * FROM meat_consumption

-- Looking at the highest consumed type of meat vs year vs location vs time

SELECT DISTINCT(subject) AS meat, location, time, SUM(value) AS sum_meat_consumption
FROM meat_consumption
GROUP BY subject, location, time
ORDER BY SUM(value) DESC

-- Looking at the meat type and the average consumption per country vs time

SELECT DISTINCT(subject) AS meat, location, time, AVG(value) AS average_meat_consumption
FROM meat_consumption
GROUP BY subject, location, time
ORDER BY AVG(value) DESC

-- Looking at the meat type and the max consumption per country vs time

SELECT DISTINCT(subject) AS meat, location, time, MAX(value) AS average_meat_consumption
FROM meat_consumption
GROUP BY subject, location, time
ORDER BY MAX(value) DESC

-- Looking at the meat type and the min consumption per country vs time

SELECT DISTINCT(subject) AS meat, location, time, MIN(value) AS average_meat_consumption
FROM meat_consumption
GROUP BY subject, location, time
ORDER BY MIN(value)

-- END