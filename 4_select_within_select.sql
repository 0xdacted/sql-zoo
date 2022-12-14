-- 1. List each country name where the population is larger than that of 'Russia'
SELECT name FROM world
WHERE population > 
(SELECT population FROM world 
WHERE name = 'Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'
SELECT name FROM world
WHERE gdp/population > 
(SELECT gdp/population FROM world
WHERE name = 'United Kingdom')
and continent = 'Europe';

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country
SELECT name, continent FROM world 
WHERE continent IN
((SELECT continent FROM world
WHERE name = 'Argentina'), 
(SELECT continent FROM world
WHERE name = 'Australia'))
ORDER BY name;

--4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population
SELECT name, population FROM world
WHERE population BETWEEN 
(SELECT population + 1 FROM world
WHERE name = 'United Kingdom') AND 
(SELECT population - 1 FROM world
WHERE name = 'Germany');

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany
SELECT name, CONCAT(CAST(ROUND((population/
(SELECT population FROM world
WHERE name = 'Germany') * 100), -1) AS int), '%') FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe?
SELECT name FROM world
WHERE gdp > ALL
(SELECT gdp FROM world
WHERE gdp > 0
AND continent LIKE 'europe');

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area
FROM world x
WHERE area >= ALL
(SELECT area FROM world y
WHERE y.continent = x.continent
AND area > 0);

-- 8. List each continent and the name of the country that comes first aphabetically
SELECT continent, name 
FROM world x
WHERE name <= ALL
(SELECT name FROM world y
WHERE y.continent = x.continent);

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents
SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL 
(SELECT population FROM world y
WHERE x.continent = y.continent
AND population > 0);

-- 10. Give the countries and continents of countries with a population three times bigger than all other countries in their continent
SELECT name, continent FROM world x
WHERE population > ALL
(SELECT population * 3 FROM world y
WHERE x.continent = y.continent
AND x.name <> y.name);