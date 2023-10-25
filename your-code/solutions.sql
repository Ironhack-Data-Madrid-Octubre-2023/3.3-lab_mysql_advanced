--CHALLENGE 1 STEP 1
SELECT titles.title_id AS "TITLE ID", authors.au_id AS "AUTHOR ID", 
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as "ROYALTY"
FROM authors
LEFT JOIN titleauthor
ON authors.au_id=titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN publishers
ON publishers.pub_id=titles.pub_id
LEFT JOIN sales
ON titles.title_id=sales.title_id

--CHALLENGE1 STEP 2 
SELECT titles.title_id AS "TITLE ID",
authors.au_id AS "AUTHOR IDs",
 SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS "ROYALTY"
FROM titles
LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title_id, authors.au_id;

--CHALLENGE 1 STEP 3
SELECT titles.title_id AS "TITLE ID",
authors.au_id AS "AUTHOR IDs",
 SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)+advance AS "ROYALTY"
FROM titles
LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title_id, authors.au_id
ORDER BY SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)+advance desc
LIMIT 3;

--CHALLENGE 2 ALTERNATIVE SOLUTION

CREATE TEMPORARY TABLE Step1 AS
SELECT titles.title_id AS `TITLE ID`,
       authors.au_id AS `AUTHOR ID`, 
       titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as `ROYALTY`
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers ON publishers.pub_id = titles.pub_id
LEFT JOIN sales ON titles.title_id = sales.title_id;

CREATE TEMPORARY TABLE Step2 AS
SELECT `TITLE ID` as title_id , `AUTHOR ID`, SUM(`ROYALTY`) AS `ROYALTY`
FROM p1
GROUP BY `TITLE ID`, `AUTHOR ID`;

CREATE TEMPORARY TABLE Step3 AS
SELECT title_id , `AUTHOR ID`, SUM(`ROYALTY`) + advance AS `ROYALTY`
FROM p1
LEFT JOIN titles ON TtempStep1.title_id = titles.title_id
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY `TITLE ID`, `AUTHOR ID`
ORDER BY SUM(`ROYALTY`) + advance DESC
LIMIT 3;

SELECT * FROM Step3;

--CHALLENGE 3
CREATE TABLE publications.most_profiting_authors
SELECT authors.au_id AS "Author ID",
SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)+advance AS "profits"
FROM titles
LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id
ORDER BY SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)+advance desc
