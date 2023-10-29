/* CHALLENGE 1 - Most Profiting Authors */

/* Step 1 - Calculate de royalties of each sales for each author */

SELECT
t.title_id AS 'Title ID',
ta.au_id AS 'Author ID',
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS 'Sales Royalty'
FROM
titles t
INNER JOIN titleauthor ta
ON t.title_id = ta.title_id
INNER JOIN
sales s ON t.title_id = s.title_id;
    
/* Step 2 - Aggregate the total royalties for each title for each author */

SELECT
t.title_id AS 'Title ID',
ta.au_id AS 'Author ID',
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'Aggregated royalties'

FROM titles t

INNER JOIN titleauthor ta
ON t.title_id = ta.title_id
INNER JOIN sales s
ON t.title_id = s.title_id
GROUP BY ta.au_id, t.title_id;

/* Step 2 - Calculate the total profits of each author */

SELECT
    ta.au_id AS 'Author ID',
    SUM(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) AS 'Profits'
FROM
    titleauthor ta
INNER JOIN titles t 
ON ta.title_id = t.title_id
INNER JOIN sales s
ON t.title_id = s.title_id
GROUP BY ta.au_id
ORDER BY 'Profits' DESC
LIMIT 3;

/* CHALLENGE 2 - Alternative solution*/

/* STEP 1*/

CREATE temporary table sales_royalty_step1

SELECT
t.title_id AS 'Title ID',
ta.au_id AS 'Author ID',
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS 'Sales Royalty'
FROM
titles t
INNER JOIN titleauthor ta
ON t.title_id = ta.title_id
INNER JOIN
sales s ON t.title_id = s.title_id;
    
/* STEP 2*/

CREATE TEMPORARY TABLE aggregated_royalties_step2

SELECT
t.title_id AS 'Title ID',
ta.au_id AS 'Author ID',
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'Aggregated royalties'

FROM titles t

INNER JOIN titleauthor ta
ON t.title_id = ta.title_id
INNER JOIN sales s
ON t.title_id = s.title_id
GROUP BY ta.au_id, t.title_id;

----- CONSULT TEMPORY TABLE

SELECT * FROM Step_1
SELECT * FROM Step_2

/* STEP 3*/

CREATE total_profits_step3

SELECT
    ta.au_id AS 'Author ID',
    SUM(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) AS 'Profits'
FROM
    titleauthor ta
INNER JOIN titles t 
ON ta.title_id = t.title_id
INNER JOIN sales s
ON t.title_id = s.title_id
GROUP BY ta.au_id
ORDER BY 'Profits' DESC
LIMIT 3;

----- CONSULT TEMPORY TABLE

SELECT * FROM most_profiting_authors