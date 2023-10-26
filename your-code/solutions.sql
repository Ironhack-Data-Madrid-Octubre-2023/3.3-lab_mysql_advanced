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
    ta.title_id AS 'TITLE ID',
    SUM(t.advance + s.qty * t.price * t.royalty / 100 * ta.royaltyper / 100) AS 'Total Earnings'

FROM titleauthor AS ta
INNER JOIN titles AS t 
ON ta.title_id = t.title_id
INNER JOIN sales AS s 
ON ta.title_id = s.title_id

GROUP BY ta.au_id, ta.title_id
ORDER BY 'Total Earnings' DESC
LIMIT 3;


## Challenge 2 - Alternative Solution - Temporary table

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


### Step 3: Calculate the total profits of each author (Alternativo)

SELECT 
		suma_salesroyalty.`Author ID`, 
        (suma_salesroyalty.`suma salesroyalty`+ t.advance) AS `TOTAL PROFIT`

FROM suma_salesroyalty
INNER JOIN titles AS t 
ON suma_salesroyalty.`Title ID` = t.title_id

ORDER BY `TOTAL PROFIT` DESC
LIMIT 3;


## Challenge 3 - Most Profiting Authors

CREATE TABLE most_profiting_authors AS
SELECT 
    suma_salesroyalty.`Author ID` AS au_id, 
    (suma_salesroyalty.`suma salesroyalty`+ t.advance) AS `profits`

FROM suma_salesroyalty
INNER JOIN titles AS t 
ON suma_salesroyalty.`Title ID` = t.title_id

ORDER BY profits DESC;
