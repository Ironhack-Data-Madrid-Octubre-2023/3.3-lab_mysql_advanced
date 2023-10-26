--- Challenge 1. Step 1
SELECT
    authors.au_id AS `AUTHOR ID`,
    titles.title_id AS `TITLE ID`,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS `SALES_ROYALTY`
FROM
    titleauthor
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id;

--- Challenge 1. Step 2

SELECT
    authors.au_id AS `AUTHOR ID`,
    titles.title_id AS `TITLE ID`,
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS `AGGREGATED_ROYALTIES`
FROM
    titleauthor
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id;

--- Challenge 1. Step 3

SELECT
    authors.au_id AS `AUTHOR ID`,
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) +SUM(titles.advance) AS `PROFITS_ROYALTIES`
FROM
    titleauthor
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY PROFITS_ROYALTIES DESC
LIMIT 3;

--- Challenge 2.
-- Temporary table for aggregated royalties
CREATE TEMPORARY TABLE tmp_royalties AS
SELECT
    authors.au_id AS `AUTHOR ID`,
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS `AGGREGATED_ROYALTIES`
FROM
    titleauthor
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY `AUTHOR ID`;

-- Temporary table for advances
CREATE TEMPORARY TABLE tmp_advances AS
SELECT
    authors.au_id AS `AUTHOR ID`,
    SUM(titles.advance) AS `TOTAL_ADVANCE`
FROM
    titleauthor
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY `AUTHOR ID`;

-- Total earnings (royalties - advances) for each author
CREATE TEMPORARY TABLE tmp_earnings AS
SELECT
    tmp_royalties.`AUTHOR ID`,
    (tmp_royalties.`AGGREGATED_ROYALTIES` - IFNULL(tmp_advances.`TOTAL_ADVANCE`, 0)) AS `TOTAL EARNINGS`
FROM tmp_royalties
LEFT JOIN tmp_advances ON tmp_royalties.`AUTHOR ID` = tmp_advances.`AUTHOR ID`;

-- Final result with author names
SELECT
    authors.au_id AS `AUTHOR ID`,
    authors.au_lname AS `LAST NAME`,
    authors.au_fname AS `FIRST NAME`,
    tmp_earnings.`TOTAL EARNINGS`
FROM authors
LEFT JOIN tmp_earnings ON authors.au_id = tmp_earnings.`AUTHOR ID`;

--- Challenge 3.

