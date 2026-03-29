-- ============================================
-- Project: Baseball Players Analysis
-- Description: SQL queries analyzing player biographical and career data
-- Dataset: players.db (CS50 SQL)
-- Skills: SELECT, WHERE, ORDER BY, COUNT, AVG, ROUND, NULL checks, subqueries
-- ============================================

-- 1. Find Jackie Robinson's hometown
-- Return Jackie Robinson's birth city, birth state, and birth country.
SELECT birth_city, birth_state, birth_country FROM players
WHERE first_name = 'Jackie' AND last_name = 'Robinson';


-- 2. Find Babe Ruth's batting side
-- Return the batting side recorded for Babe Ruth.
SELECT bats FROM players
WHERE first_name = 'Babe' AND last_name = 'Ruth';


-- 3. Find missing debut records
-- Return the ids of players whose debut date is missing.
SELECT id FROM players
WHERE debut is NULL;


-- 4. Find players born outside the United States
-- Return first and last names of players not born in the USA, sorted alphabetically.
SELECT first_name, last_name FROM players
WHERE birth_country != 'USA'
ORDER BY first_name, last_name;


-- 5. Find right-handed batters
-- Return first and last names of players who bat right-handed, sorted alphabetically.
SELECT first_name, last_name FROM players
WHERE bats = 'R'
ORDER BY first_name , last_name;


-- 6. Find Pittsburgh-born players and their debut dates
-- Return first name, last name, and debut date for players born in Pittsburgh, Pennsylvania, sorted by most recent debut first.
SELECT first_name, last_name, debut FROM players
WHERE birth_city = 'Pittsburgh' AND birth_state = 'PA'
ORDER BY debut DESC, first_name, last_name;


-- 7. Count opposite batting and throwing sides
-- Count players who bat right-handed and throw left-handed, or bat left-handed and throw right-handed.
SELECT COUNT(*) FROM players
WHERE (bats = 'R' AND throws = 'L') OR (bats = 'L' AND throws = 'R');


-- 8. Find average height and weight since 2000
-- Return the average height and average weight of players who debuted on or after January 1, 2000.
SELECT ROUND(AVG(height),2) AS 'Average Height', ROUND(AVG(weight),2) AS 'Average Weight' FROM players
WHERE debut >= '2000-01-01';


-- 9. Find players whose final MLB game was in 2022
-- Return first and last names of players whose final game occurred in 2022, sorted alphabetically.
SELECT first_name, last_name FROM players
WHERE final_game BETWEEN '2022-01-01' AND '2022-12-31'
ORDER BY first_name, last_name;


-- 10. Custom analysis: Players taller than average
-- Return players whose height is above the overall average height, sorted by height.
SELECT first_name AS 'First Name', last_name AS 'Last Name', height AS 'Height' FROM players
WHERE height > (SELECT AVG(height) FROM players)
ORDER BY height;
