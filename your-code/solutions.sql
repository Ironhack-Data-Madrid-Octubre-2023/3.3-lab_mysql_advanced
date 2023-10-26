# Laboratorio | MySQL avanzado

## Challenge 1 - Most Profiting Authors

### Step 1: Calculate the royalties of each sales for each author


SELECT ta.au_id AS 'Author ID', 
		ta.title_id AS 'Title ID', 
		t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS 'Sales Royalty'

FROM titleauthor AS ta
INNER JOIN titles AS t 
ON ta.title_id = t.title_id
INNER JOIN sales AS s 
ON ta.title_id = s.title_id

ORDER BY ta.au_id, ta.title_id;




### Step 2: Aggregate the total royalties for each title for each author

SELECT ta.au_id AS 'Author ID', 
		ta.title_id AS 'Title ID', 
		SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'Sales Royalty'

FROM titleauthor AS ta
INNER JOIN titles AS t 
ON ta.title_id = t.title_id
INNER JOIN sales AS s 
ON ta.title_id = s.title_id

GROUP BY ta.au_id, ta.title_id
ORDER BY `Sales Royalty` DESC;


### Step 3: Calculate the total profits of each author

SELECT 
    ta.au_id AS 'Author ID', 
    SUM(t.advance + s.qty * t.price * t.royalty / 100 * ta.royaltyper / 100) AS 'Total Earnings'

FROM titleauthor AS ta
INNER JOIN titles AS t 
ON ta.title_id = t.title_id
INNER JOIN sales AS s 
ON ta.title_id = s.title_id

GROUP BY ta.au_id, ta.title_id
ORDER BY 'Total Earnings' DESC
LIMIT 3;


## Challenge 2 - Alternative Solution

###CREATE TEMPORARY TABLE sales_royalties AS
SELECT title_id, SUM(qty * price * royalty / 100 * royaltyper / 100) AS sales_royalty
FROM sales
JOIN titles ON sales.title_id = titles.title_id
GROUP BY title_id;

SELECT 
    authors.au_id AS 'Author ID', 
    SUM(titleauthor.advance + sales_royalties.sales_royalty) AS 'Total Earnings'
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN sales_royalties ON titleauthor.title_id = sales_royalties.title_id
GROUP BY authors.au_id
ORDER BY 'Total Earnings' DESC
###LIMIT 3;

### Step 1: Calculate the royalties of each sales for each author (Alternativo)

CREATE temporary TABLE tempor_salesroyalty as 

SELECT ta.au_id AS 'Author ID', 
		ta.title_id AS 'Title ID', 
		t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS 'Sales Royalty'
FROM titleauthor AS ta
INNER JOIN titles AS t 
ON ta.title_id = t.title_id
INNER JOIN sales AS s 
ON ta.title_id = s.title_id

ORDER BY ta.au_id, ta.title_id;

### Step 2: Aggregate the total royalties for each title for each author (Alternativo)


CREATE temporary TABLE suma_salesroyalty as 
SELECT `Author ID`, 
		`Title ID`, 
		SUM(`Sales Royalty`) AS `suma salesroyalty`

FROM tempor_salesroyalty 
GROUP BY `Author ID`, `Title ID`


### Step 3: Aggregate the total royalties for each title for each author (Alternativo)






