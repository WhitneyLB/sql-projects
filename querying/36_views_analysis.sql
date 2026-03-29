-- ============================================
-- Project: 36 Views Analysis
-- Description: SQL analysis of woodblock print dataset (Hokusai & Hiroshige)
-- Dataset: views.db (CS50 SQL)
-- Skills: SELECT, WHERE, ORDER BY, GROUP BY, LIKE, COUNT, AVG, MAX
-- ============================================

-- 1. Show Japanese and English titles
-- Select the Japanese title and English title for each print.
SELECT japanese_title, english_title FROM views;


-- 2. Filter Hokusai prints with "river"
-- Select average colors for Hokusai prints whose English title includes "river".
SELECT average_color FROM views
WHERE artist = 'Hokusai' AND english_title LIKE '%river%';


-- 3. Count titles containing "Fuji"
-- Count how many Hokusai prints include "Fuji" in the English title.
SELECT COUNT(english_title) FROM views
WHERE artist = 'Hokusai' AND english_title LIKE '%Fuji%';


-- 4. Count Hiroshige titles about Edo
-- Count how many Hiroshige prints refer to the Eastern Capital / Edo.
SELECT COUNT(english_title) FROM views
WHERE artist = 'Hiroshige' AND english_title LIKE '%Eastern Capital%';


-- 5. Highest contrast (Hokusai)
-- Find the maximum contrast value for Hokusai's prints.
SELECT MAX(contrast) AS 'Maximum Contrast' FROM views
WHERE artist = 'Hokusai';


-- 6. Average entropy
-- Calculate Hiroshige's average entropy and round to two decimal places.
SELECT ROUND(AVG(entropy),2) AS 'Hiroshige Average Entropy' FROM views
WHERE artist = 'Hiroshige';


-- 7. Brightest Hiroshige prints
-- List the 5 brightest Hiroshige prints from most to least bright.
SELECT english_title FROM views
WHERE artist = 'Hiroshige'
ORDER BY brightness DESC
LIMIT 5;


-- 8. Lowest contrast Hokusai prints
-- List the 5 Hokusai prints with the lowest contrast.
SELECT english_title FROM views
WHERE artist = 'Hokusai'
ORDER BY contrast
LIMIT 5;


-- 9. Brightest print (overall)
-- Return the English title and artist of the brightest print in the database.
SELECT english_title, artist FROM views
ORDER BY brightness DESC
LIMIT 1;


-- 10. Custom analysis: Fuji-related prints
-- Use a custom query with AS, WHERE, and ORDER BY to analyze the prints.
SELECT artist AS 'Artist', english_title AS 'English', japanese_title AS 'Japanese' FROM views
WHERE english_title LIKE '%Fuji%'
ORDER BY artist;
