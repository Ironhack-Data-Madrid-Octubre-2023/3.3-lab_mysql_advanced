-- Challenge 1 - Most Profiting Authors -- 

SELECT 
    titleauthor.title_id AS 'TITLE ID',
    titleauthor.au_id AS 'AUTHOR ID',
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS 'ROYALITY'
FROM
    titleauthor
        INNER JOIN
    titles ON titleauthor.title_id = titles.title_id
		INNER JOIN
	sales ON titles.title_id = sales.title_id;
    
-- Step 2: Aggregate the total royalties for each title for each autho --
SELECT 
    titleauthor.title_id AS 'TITLE ID',
    titleauthor.au_id AS 'AUTHOR ID',
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'TOTAL ROYALITIES'
FROM
    titles AS t
        INNER JOIN
    titleauthor AS ta ON t.title_id = ta.title_id
        INNER JOIN
    sales AS s ON t.title_id = s.title_id
GROUP BY ta.au_id , t.title_id;

-- Step 3: Calculate the total profits of each author-- 

SELECT 
   titleauthor.au_id AS 'AUTHOR ID',
    SUM(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) AS 'PROFITS'
FROM
    titleauthor AS ta
        INNER JOIN
    titles AS t ON ta.title_id = t.title_id
        INNER JOIN
    sales AS s ON t.title_id = s.title_id
GROUP BY ta.au_id
ORDER BY 'Profits' DESC
LIMIT 3;

-- Challenge 2 - Alternative Solution --

CREATE temporary table total_profits_author
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

