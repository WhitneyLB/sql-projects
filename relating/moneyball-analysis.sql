-- ===============================================================
-- Project: MLB Player Performance & Salary Analysis (Moneyball SQL)
-- Description: SQL analysis of Major League Baseball data to evaluate
--             player performance (hits, home runs, RBIs) in relation to 
--             salaries. Focused on identifying undervalued players, 
--             analyzing salary trends, and comparing team performance 
--             using Moneyball-style decision making.
--
-- Dataset: moneyball.db (CS50 SQL)
-- Skills: SELECT, WHERE, JOIN, GROUP BY, HAVING, ORDER BY, SUBQUERIES,
-- AGGREGATIONS (SUM, AVG, MAX), DATA FILTERING, MULTI-TABLE JOINS
-- ===============================================================

-- 1. Calculate average player salary by year (identify salary trends)
SELECT year, ROUND(AVG(salary),2) AS "average salary" FROM salaries
GROUP BY year
ORDER BY year DESC

  
-- 2. Retrieve salary history for Cal Ripken (player-specific earnings analysis)
SELECT salaries.year, salaries.salary FROM players
JOIN salaries ON players.id = salaries.player_id
WHERE first_name = "Cal"
AND last_name = 'Ripken'
ORDER BY salaries.year DESC;


-- 3. Analyze Ken Griffey Jr.'s home run history (performance tracking with disambiguation)
SELECT performances.year, performances.HR FROM players
join performances ON performances.player_id = players.id
WHERE players.birth_year = 1969 AND first_name = 'Ken' AND last_name = 'Griffey'
ORDER BY performances.year DESC;


-- 4. Find the 50 lowest-paid players in 2001 (identify undervalued players)
SELECT players.first_name, players.last_name, salaries.salary FROM players
JOIN salaries ON salaries.player_id = players.id
WHERE salaries.year = 2001
ORDER BY salaries.salary, players.first_name, players.last_name, players.id
LIMIT 50;


-- 5. Find all teams Satchel Paige played for (player team history)
SELECT DISTINCT teams.name FROM teams
JOIN performances ON performances.team_id = teams.id
JOIN players ON players.id = performances.player_id
WHERE first_name = 'Satchel' AND last_name = 'Paige';


-- 6. Find top 5 teams by total hits in 2001 (team performance comparison)
SELECT teams.name, SUM(performances.H) AS 'total hits' FROM performances
JOIN teams ON teams.id = performances.team_id
WHERE performances.year = 2001
GROUP BY teams.name
ORDER BY SUM(performances.H) DESC
LIMIT 5;


-- 7. Identify the highest-paid player of all time (salary outlier analysis)
SELECT players.first_name, players.last_name FROM players
JOIN salaries ON salaries.player_id = players.id
WHERE salaries.salary = (SELECT MAX(salary)
                        FROM salaries);


-- 8. Find the 2001 salary of the player with the most home runs (performance vs pay)
SELECT salary from players
JOIN salaries ON salaries.player_id = players.id
JOIN performances ON performances.player_id = players.id
WHERE salaries.year = 2001 AND performances.year = 2001 AND
performances.HR =
    (SELECT MAX(performances.HR)
    FROM performances
    WHERE year = 2001);


-- 9. Find the 5 lowest-paying teams by average salary in 2001 (team spending comparison)
SELECT teams.name, ROUND(AVG(salary),2) AS "average salary" FROM salaries
JOIN teams ON teams.id = salaries.team_id
WHERE salaries.year = 2001
GROUP BY teams.name
ORDER BY "average salary" ASC
LIMIT 5;


-- 10. Combine player salary and performance data by year (multi-table integration)
SELECT players.first_name, players.last_name, salaries.salary, performances.HR, performances.year FROM players
JOIN salaries ON players.id = salaries.player_id
JOIN performances ON performances.player_id = players.id
    AND performances.year = salaries.year
ORDER BY players.id, performances.year DESC, performances.HR DESC, salaries.salary DESC;


-- 11. Calculate cost efficiency using dollars per hit (value-based player analysis)
SELECT players.first_name, players.last_name, salaries.salary/performances.H AS 'dollars per hit' FROM players
JOIN salaries ON salaries.player_id = players.id
JOIN performances ON performances.player_id = players.id
    AND performances.year = salaries.year
WHERE performances.H != 0 and salaries.year = 2001
ORDER BY "dollars per hit", players.first_name, players.last_name
LIMIT 10;


-- 12. Identify players undervalued across multiple metrics (dollars per hit & RBI overlap)
SELECT players.first_name, players.last_name FROM players
WHERE players.id IN (
    SELECT players.id FROM players
    JOIN salaries ON salaries.player_id = players.id
    JOIN performances ON performances.player_id = players.id
       AND performances.year = salaries.year
    WHERE performances.H != 0 and salaries.year = 2001
    ORDER BY salaries.salary/performances.H
    LIMIT 10)
AND players.id IN (
    SELECT players.id FROM players
    JOIN salaries ON salaries.player_id = players.id
    JOIN performances ON performances.player_id = players.id
    AND performances.year = salaries.year
    WHERE performances.RBI != 0 and salaries.year = 2001
    ORDER BY salaries.salary/performances.RBI
    LIMIT 10
    )
ORDER BY players.id;
