
-- Challenge 1 - Most Profiting Authors

-- Step 1: Calculate the royalties of each sales for each author

SELECT
    titleauthor.title_id AS `TITLE ID`,
    titleauthor.au_id AS `AUTHOR ID`,
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS `SALES ROYALTY`
FROM titleauthor
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titles.title_id = sales.title_id;


-- Step 2: Aggregate the total royalties for each title for each author

SELECT
    titleauthor.title_id AS `TITLE ID`,
    titleauthor.au_id AS `AUTHOR ID`,
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS `AGGREGATED ROYALTIES`
FROM titleauthor
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titleauthor.title_id, titleauthor.au_id;


-- Step 3: Calculate the total profits of each author

SELECT
    titleauthor.au_id AS `AUTHOR ID`,
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + SUM(titles.advance) AS `TOTAL PROFITS`
FROM titleauthor
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titleauthor.au_id
ORDER BY `TOTAL PROFITS` DESC
LIMIT 3;






-- Challenge 2 - Alternative Solution

-- Step 1 Alternative:

CREATE TEMPORARY TABLE temp_salesroyalty AS
SELECT
    titleauthor.title_id AS `TITLE ID`,
    titleauthor.au_id AS `AUTHOR ID`,
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS `SALES ROYALTY`
FROM titleauthor
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titles.title_id = sales.title_id;

-- Step 2 Alternative:

CREATE TEMPORARY TABLE temp_aggregated AS
SELECT
    `TITLE ID`,
    `AUTHOR ID`,
    SUM(`SALES ROYALTY`) AS `AGGREGATED ROYALTIES`
FROM temp_salesroyalty
GROUP BY `TITLE ID`, `AUTHOR ID`;

-- Step 3 Alternative:

SELECT
    temp_aggregated.`AUTHOR ID`,
    (temp_aggregated.`AGGREGATED ROYALTIES` + titles.advance) AS `TOTAL PROFITS`
FROM temp_aggregated
INNER JOIN titles ON temp_aggregated.`TITLE ID` = titles.title_id
ORDER BY `TOTAL PROFITS` DESC
LIMIT 3;



--Challenge 3

CREATE TABLE most_profiting_authors
SELECT
    temp_aggregated.`AUTHOR ID` AS `au_id`,
    (temp_aggregated.`AGGREGATED ROYALTIES` + titles.advance) AS `profits`
FROM temp_aggregated
INNER JOIN titles ON temp_aggregated.`TITLE ID` = titles.title_id
ORDER BY `profits` DESC
LIMIT 3;