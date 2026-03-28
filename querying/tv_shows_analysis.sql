-- ========================================
-- Project: TV Shows Analysis
-- Dataset: Cyberchase (CS50 SQL)
-- Skills: SELECT, WHERE, ORDER BY, GROUP BY
-- ========================================


-- 1. Select all shows from season 1
SELECT title FROM episodes
WHERE season = 1;


-- 2. Filter episodes by condition
SELECT season, title FROM episodes
WHERE episode_in_season = 1;


-- 3. Order episodes by title
SELECT production_code FROM episodes
WHERE title = 'Hackerized!';


-- 4. Count number of episodes
SELECT title FROM episodes
WHERE topic is NULL;


-- 5. Get distinct values
SELECT title FROM episodes
WHERE air_date = "2004-12-31";


-- 6. WHERE conditions
SELECT title FROM episodes
WHERE season = 6 AND air_date BETWEEN '2007-01-01' AND '2007-12-31';


-- 7. LIKE queries
SELECT title, topic FROM episodes
WHERE topic LIKE '%fractions%';


-- 8. BETWEEN filters
SELECT COUNT (title) FROM episodes
WHERE air_date BETWEEN '2018-01-01' AND '2023-12-31';


-- 9. Aggregations
SELECT COUNT (title) FROM episodes
WHERE air_date BETWEEN '2002-01-01' AND '2007-12-31';


-- 10. GROUP BY
SELECT id, title, production_code FROM episodes
ORDER BY production_code;


-- 11. JOIN queries (if applicable)
SELECT title FROM episodes
WHERE season = 5
ORDER BY title DESC;


-- 12. Subqueries
SELECT COUNT(DISTINCT title)
FROM episodes;


-- 13. Complex query
SELECT * FROM episodes
WHERE id < 15 OR id > 100;
