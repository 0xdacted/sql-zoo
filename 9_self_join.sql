-- 1. How many stops are in the database
SELECT COUNT(*) AS num_stops
FROM stops;

-- 2. Find the id value for the stop 'CraigLockhart'
SELECT id 
FROM stops
WHERE name = 'Craiglockhart';

-- 3. Give the id and the name for the stops on the '4' 'LRT' service
SELECT id, name
FROM stops
JOIN route ON stops.id = route.stop
WHERE num = 4
AND company = 'LRT';

-- 4. Add a HAVING clause to restrict the output to the two routes that link London Road (149) and CraigLockhart (53)
SELECT company, num, COUNT(*) AS count
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 5. Change the self join query so that it shows the services from Craiglockhart to London Road
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

-- 6. Change the self join query so that the services between 'Craiglockhart' and 'London Road' are shown
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name= 'Craiglockhart' AND stopb.name = 'London Road';

-- 7. Give a list of the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop = 137;

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name= 'Craiglockhart' AND stopb.name = 'Tollcross';

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart';

-- 10. Find the routes involving two buses than can go from Craiglockhart to Lochend
SELECT DISTINCT first_bus.num, first_bus.company, transfer_stop.name, second_bus.num, second_bus.company
FROM
(SELECT a.num, a.company, b.stop
FROM route a JOIN route b ON (a.num = b.num) AND (a.company = b.company)
WHERE a.stop = 
(SELECT id 
FROM stops
WHERE name = 'Craiglockhart')
) AS first_bus
JOIN 
(SELECT a.num, a.company, b.stop
FROM route a JOIN route b ON (a.num = b.num) AND (a.company = b.company)
WHERE a.stop = 
(SELECT id 
FROM stops
WHERE name = 'Lochend')
) AS second_bus ON 
(first_bus.stop = second_bus.stop)
JOIN stops AS transfer_stop ON 
(first_bus.stop = transfer_stop.id);