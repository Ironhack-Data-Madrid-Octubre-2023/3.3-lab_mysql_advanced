--- Challenge 1

SELECT 
step2.au_id AS `AUTHOR ID`,
SUM(step2.sum_royalties) AS ROYALTIES
FROM
(SELECT 
	step1.title_id,
	step1.au_id,
	SUM(step1.sales_royalty) AS sum_royalties
FROM 
(SELECT
	titles.title_id,
	authors.au_id,
	(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM authors
INNER JOIN titleauthor 
	ON authors.au_id = titleauthor.au_id
INNER JOIN titles 
	ON titleauthor.title_id = titles.title_id
INNER JOIN sales 
	ON titles.title_id = sales.title_id)
AS step1
GROUP BY step1.au_id, step1.title_id)
AS step2
GROUP BY step2.au_id 
ORDER BY royalties DESC LIMIT 3 

--- Challenge 2

CREATE TEMPORARY TABLE publications.table_step_1
SELECT
	titles.title_id,
	authors.au_id,
	(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM authors
INNER JOIN titleauthor 
	ON authors.au_id = titleauthor.au_id
INNER JOIN titles 
	ON titleauthor.title_id = titles.title_id
INNER JOIN sales 
	ON titles.title_id = sales.title_id
;

CREATE TEMPORARY TABLE publications.table_step_2
SELECT
	table_step_1.title_id,
	table_step_1.au_id,
	SUM(table_step_1.sales_royalty) AS sum_royalties 
FROM publications.table_step_1
GROUP BY table_step_1.au_id, table_step_1.title_id
;

SELECT 
	table_step_2.au_id AS `AUTHOR ID`,
	SUM(table_step_2.sum_royalties) AS ROYALTIES
FROM publications.table_step_2
GROUP BY table_step_2.au_id 
ORDER BY ROYALTIES DESC LIMIT 3

--- Challenge 3

CREATE TABLE publications.most_profiting_authors
SELECT 
step2.au_id AS AUTHOR_ID,
SUM(step2.sum_royalties) AS ROYALTIES
FROM
(SELECT 
	step1.title_id,
	step1.au_id,
	SUM(step1.sales_royalty) AS sum_royalties
FROM 
(SELECT
	titles.title_id,
	authors.au_id,
	(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM authors
INNER JOIN titleauthor 
	ON authors.au_id = titleauthor.au_id
INNER JOIN titles 
	ON titleauthor.title_id = titles.title_id
INNER JOIN sales 
	ON titles.title_id = sales.title_id)
AS step1
GROUP BY step1.au_id, step1.title_id)
AS step2
GROUP BY step2.au_id 
ORDER BY royalties DESC 
;


SELECT 
	mpa.AUTHOR_ID,
    (t.advance + mpa.ROYALTIES) AS PROFITS
FROM most_profiting_authors mpa
INNER JOIN titleauthor ta
	ON mpa.AUTHOR_ID = ta.au_id
INNER JOIN titles t 
	ON ta.title_id = t.title_id
GROUP BY mpa.AUTHOR_ID, profits
ORDER BY PROFITS DESC 
