#challenge 1
#step1
SELECT 
    titles.title_id AS 'Title ID',
    titleauthor.au_id AS 'Author ID',
	titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS 'Royalties'
FROM
    titles
        INNER JOIN
    titleauthor ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id = sales.title_id;

#step2
SELECT 
    titles.title_id AS 'Title ID',
    titleauthor.au_id AS 'Author ID',
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'Aggregated royalties'
FROM
    titleauthor
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id = sales.title_id
GROUP BY titles.title_id, titleauthor.au_id;

#step 3
SELECT 
    titleauthor.au_id AS 'Author ID',
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'Profits'
FROM
    titleauthor
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id = sales.title_id
GROUP BY titles.title_id, titleauthor.au_id 
ORDER BY 'Profits' desc
LIMIT 3;

#Challenge 2
CREATE TEMPORARY TABLE TABLA
SELECT 
    titleauthor.au_id AS 'Author ID',
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'Profits'
FROM
    titleauthor
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id = sales.title_id
GROUP BY titles.title_id, titleauthor.au_id 
ORDER BY 'Profits' desc
LIMIT 3;

SELECT * FROM TABLA;

#Challenge 3
CREATE TABLE most_profiting_authors
SELECT 
    titleauthor.au_id AS 'Author ID',
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'Profits'
FROM
    titleauthor
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id = sales.title_id
GROUP BY titles.title_id, titleauthor.au_id 
ORDER BY 'Profits' desc
LIMIT 3;

#A la izquierda aparece una nueva tabla