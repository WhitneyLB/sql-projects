-- ================================================
-- Project: DESE School Data Analysis (CS50 SQL)
-- Description: SQL analysis of Massachusetts school data including districts, schools,
--              expenditures, graduation rates, and staff evaluations. Focused on joins,
--              subqueries, filtering, and aggregations to answer real-world questions.
-- Dataset: dese.db (CS50 SQL)
-- Skills: SELECT, WHERE, JOIN, GROUP BY, HAVING, ORDER BY, SUBQUERIES
-- ================================================ 

--1. Retrieve all public schools in Massachusetts (name + city)
SELECT name, city FROM schools
WHERE state = 'MA' AND type = 'Public School';


-- 2. Find districts that are no longer operational (marked with "non-op")
SELECT name FROM districts
WHERE name LIKE '%non-op%';


-- 3. Calculate the average per-pupil expenditure across all districts
SELECT AVG(per_pupil_expenditure) AS 'Average District Per-Pupil Expenditure' FROM expenditures;


-- 4. Identify the top 10 cities with the most public schools
SELECT city, COUNT(*) AS 'Number of Public Schools' FROM schools
WHERE type = 'Public School'
GROUP BY CITY
ORDER BY "Number of Public Schools" DESC, city
LIMIT 10;


-- 5. Find cities with 3 or fewer public schools
SELECT city, COUNT(*) AS 'Public School Count' FROM schools
WHERE type = 'Public School'
GROUP BY city
HAVING COUNT(*) <= 3
ORDER BY "Public School Count" DESC, CITY;


-- 6. List schools with a 100% graduation rate
SELECT name from schools
JOIN graduation_rates ON graduation_rates.school_id = schools.id
WHERE graduated = 100;


-- 7. Retrieve all schools in the Cambridge school district
SELECT name FROM schools
WHERE district_id =(
    SELECT id FROM districts
    WHERE name = 'Cambridge');


-- 8. Display each district and its total number of pupils
SELECT districts.name, expenditures.pupils FROM districts
JOIN expenditures ON expenditures.district_id = districts.id
ORDER BY expenditures.pupils DESC;


-- 9. Find the district(s) with the lowest number of pupils
SELECT districts.name AS 'Name of District' FROM districts
JOIN expenditures ON expenditures.district_id = districts.id
WHERE expenditures.pupils = (
    SELECT MIN(pupils) FROM expenditures
);


-- 10. Identify the top 10 public school districts by per-pupil spending
SELECT districts.name, expenditures.per_pupil_expenditure FROM districts
JOIN expenditures ON expenditures.district_id = districts.id
WHERE districts.type = 'Public School District'
ORDER BY expenditures.per_pupil_expenditure DESC
LIMIT 10;


-- 11. Compare schools’ graduation rates with their district’s spending
SELECT
    schools.name AS 'Schools Name',
    expenditures.per_pupil_expenditure,
    graduation_rates.graduated
FROM districts
JOIN schools
    on schools.district_id = districts.id
JOIN expenditures
    ON expenditures.district_id = districts.id
JOIN graduation_rates
    ON graduation_rates.school_id = schools.id
ORDER BY expenditures.per_pupil_expenditure DESC, schools.name ASC;


-- 12. Find high-performing districts with above-average spending and exemplary staff ratings
SELECT
    districts.name,
    expenditures.per_pupil_expenditure,
    staff_evaluations.exemplary
FROM districts
JOIN expenditures
    ON expenditures.district_id = districts.id
JOIN staff_evaluations
    ON staff_evaluations.district_id = districts.id
WHERE districts.type = 'Public School District'
AND expenditures.per_pupil_expenditure > (
    SELECT AVG(expenditures.per_pupil_expenditure) FROM expenditures
)
AND staff_evaluations.exemplary > (
    SELECT AVG(staff_evaluations.exemplary) FROM staff_evaluations
)
ORDER BY staff_evaluations.exemplary DESC,
    expenditures.per_pupil_expenditure DESC;


-- 13. Identify schools in districts with above-average per-pupil expenditure
SELECT schools.name,
    expenditures.per_pupil_expenditure,
    (SELECT ROUND(AVG(per_pupil_expenditure),2)
    FROM expenditures) AS 'Average Pupil Expenditure'
FROM districts
JOIN schools
    ON schools.district_id = districts.id
JOIN expenditures
    ON expenditures.district_id = districts.id
WHERE expenditures.per_pupil_expenditure > (
    SELECT AVG(per_pupil_expenditure) FROM expenditures
);
