-- 1. Show the total population of the world
SELECT SUM(population) AS total_population 
FROM world;

-- 2. List all the continents once
SELECT DISTINCT continent FROM world;

-- 3. Give the total GDP of Africa
SELECT SUM(gdp) AS africa_gdp FROM world 
WHERE continent = 'Africa';

-- 4. How many countries have an area of at least 1000000
SELECT COUNT(name) AS area_of_million_plus 
FROM world
WHERE area >= 1000000;

-- 5. What is the total population of Estonia, Latvia, and Lithuania
SELECT SUM(population) AS total_population 
FROM world
WHERE name IN('Estonia', 'Latvia', 'Lithuania');

-- 6. For each continent show the continent and number of countries
SELECT continent, COUNT(name) AS number_countries 
FROM world
GROUP BY continent;

-- 7. For each continent show the continent and number of countries with populations of at least 10 million
SELECT continent, COUNT(name) AS 10mil_plus_population
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8. List the continents that have a total population of at least 100 milllion
SELECT continent FROM world
GROUP by continent
HAVING SUM(population) >= 100000000;