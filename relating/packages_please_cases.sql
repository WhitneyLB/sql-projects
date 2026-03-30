-- ============================================
-- Project: Packages, Please
-- Description: Investigative SQL queries to track missing packages using relational data
-- Dataset: packages.db 
-- Skills: SELECT, WHERE, JOIN, SUBQUERIES, ORDER BY, NULL handling
-- ============================================

-- *** The Lost Letter ***

--FIND ANNEKE'S ADDRESS ID
SELECT id, address FROM addresses
WHERE address = '900 Somerville Avenue';


--FIND PACKAGE DETAILS TO COMPAIRE ADDRESS ID'S TO FIND VARSHA'S ADDRESS ID
SELECT * FROM scans
WHERE package_id = (
    --FIND PACKAGE ID
    SELECT id FROM packages
    WHERE contents LIKE '%congratulatory%'
    AND from_address_id = 432);


--FIND ADDRESS INFORMATION
SELECT * FROM addresses
WHERE id = 854;


-- *** The Devious Delivery ***

--FIND PACKAGE ID THAT HAS NO FROM ADDRESS AND CONTENTS RELATED TO THE QUACK CLUE
SELECT * FROM packages
WHERE from_address_id IS NULL;


--FIND SCAN DETAILS FOR THE PACKAGE
SELECT * FROM scans
WHERE package_id = 5098;


--FIND ADDRESS INFORMATION FOR THE DROP OFF LOCATION OF THE PACKAGE
SELECT * FROM addresses
WHERE id = 348;


-- *** The Forgotten Gift ***

--FIND SCAN INFORMATION AND PACKAGE INFORMATION BY JOINING BOTH SCANS AND PACKAGES TABLES
SELECT * FROM scans
LEFT JOIN packages on packages.id = scans.package_id
WHERE package_id = (
    --FIND PACKAGE ID WITH THE CORRECT TO AND FROM ADDRESS ID'S
    SELECT id FROM packages
    WHERE from_address_id =
        --FIND GRANDMOTHER'S ADDRESS ID
        (SELECT id FROM addresses
        WHERE address = '109 Tileston Street')
    AND to_address_id =
        --FIND GRANDDAUGHTER'S ADDRESS ID
        (SELECT id FROM addresses
        WHERE address = '728 Maple Place'));


--FIND DRIVER INFORMATION FOR THE PACKAGE
SELECT name FROM drivers
WHERE id = 17;

