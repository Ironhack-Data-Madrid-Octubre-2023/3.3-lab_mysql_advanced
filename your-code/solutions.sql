##Challenge 1 - Most Profiting Authors
### Step 1:
SELECT authors.au_id as `AUTHOR ID`, titles.title_id as `TITLE ID`, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as `ROYALTY`
FROM (authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titles.title_id = titleauthor.title_id
INNER JOIN sales ON sales.title_id = titles.title_id
);

### Step 2:
SELECT authors.au_id as `AUTHOR ID`, titles.title_id as `TITLE ID`, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as `ROYALTY`
FROM (authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titles.title_id = titleauthor.title_id
INNER JOIN sales ON sales.title_id = titles.title_id)
GROUP BY authors.au_id, titles.title_id;

### Step 3:
SELECT authors.au_id as `AUTHOR ID`, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as `ROYALTY`
FROM (authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titles.title_id = titleauthor.title_id
INNER JOIN sales ON sales.title_id = titles.title_id)
GROUP BY authors.au_id, titles.title_id
ORDER BY ROYALTY DESC
LIMIT 3;

##Challenge 2 - Alternative Solution
CREATE TEMPORARY TABLE Challenge1
SELECT authors.au_id as `AUTHOR ID`, titles.title_id as `TITLE ID`, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as `ROYALTY`
FROM (authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titles.title_id = titleauthor.title_id
INNER JOIN sales ON sales.title_id = titles.title_id)
GROUP BY authors.au_id, titles.title_id
ORDER BY ROYALTY DESC
LIMIT 3;

SELECT * FROM Challenge1 # para comprobar que existe la tabla aunque no me salga a la izquierda

##Challenge 3

CREATE TABLE most_profiting_authors
SELECT authors.au_id as `AUTHOR ID`, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as `ROYALTY`
FROM (authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titles.title_id = titleauthor.title_id
INNER JOIN sales ON sales.title_id = titles.title_id)
GROUP BY authors.au_id, titles.title_id
ORDER BY ROYALTY DESC;


