-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2. Give year of 'Citizen Kane'
SELECT yr 
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star trek movies, include the id, title, and yr. Order results by year
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%';

-- 4. What id number does the Actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'
SELECT id 
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'
SELECT name 
FROM actor JOIN casting on id=actorid
WHERE movieid = 27;

-- 7. Obtain the cast list for the film 'Alien'
SELECT name 
FROM actor JOIN casting on actor.id=actorid
JOIN movie ON movieid=movie.id
WHERE title = 'Alien';

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT title 
FROM movie JOIN casting on movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name = 'Harrison Ford';

-- 9. List the films where 'Harrison Ford has appeared - but not in the starring role
SELECT title 
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name = 'Harrison Ford'
AND ord != 1;

-- 10. List the films together with the leading star for all 1962 films
SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE yr = 1962
and ord = 1;

-- 11. Show the year and the number of movies 'Rock Hudson' made each year for any year in which he made more than 2 movies
SELECT yr, COUNT(title) AS movies
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in 
SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE movieid IN 
(SELECT movieid FROM casting
WHERE actorid = 
(SELECT id
FROM actor
WHERE name = 'Julie Andrews')
)
AND ord = 1;

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles
SELECT name
FROM actor JOIN casting ON id = actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT
(*) >= 15;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title
SELECT title, COUNT(actorid) AS number_actors
FROM movie JOIN casting ON id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;

-- 15. List all of the people who have worked with 'Art Garfunkel'
SELECT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN
(SELECT movieid FROM casting
WHERE actorid = 
(SELECT id FROM actor
WHERE name = 'Art Garfunkel'))
AND name <> 'Art Garfunkel';