-- SELECT names

-- 1. Find the country that starts with Y
SELECT name FROM world
WHERE name LIKE 'y%';

-- 2. Find the countries that end with Y
SELECT name FROM world
WHERE name LIKE '%y';

-- 3. Find the countries that contain the letter x
SELECT name FROM world
WHERE name LIKE '%x%';

-- 4. Find the countries that end with land
SELECT name FROM world
WHERE name LIKE '%land';

-- 5. Find the countries that start with C and end with IA
SELECT name FROM world
WHERE name LIKE 'c%ia';

-- 6. Find the country that has 'oo' in the name
SELECT name FROM world
WHERE name like '%oo%';

-- 7. Find the countries that have three or more 'a' in the name
SELECT name FROM world
WHERE name LIKE '%a%a%a%';

-- 8. Find the countries that have "t" as the second character
SELECT name FROM world 
WHERE name LIKE '_t%';

-- 9. Find the countries that have two 'o' characters spearated by two others
SELECT name FROM world
WHERE name LIKE '%o__o%';

-- 10. Find the countries that have exactly four characters
SELECT name FROM world
WHERE name LIKE '____';

-- 11. Find the country where the name is the capital city
SELECT name FROM world
WHERE name LIKE capital;

-- 12. Find the country where the capital is the country plus "City"
SELECT name FROM world
WHERE capital LIKE CONCAT(name, ' City');

-- 13. Find the capital and the name where the capital includes the name of the country
SELECT capital, name FROM world
WHERE capital LIKE CONCAT('%', name, '%');

-- 14. Find the capital and the name where the capital is an extension of name of the country
SELECT capital, name FROM world
WHERE capital LIKE CONCAT(name, '%')
AND capital NOT LIKE name;

-- 15. Show the name and the extension where the capital is an extension of name of the country
SELECT name, REPLACE(capital, name, '') AS extension FROM world
WHERE capital LIKE CONCAT(name, '%')
AND capital NOT LIKE name;