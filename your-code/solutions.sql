
-- # CHELLENGE 1

SELECT authors.au_lname, 
authors.au_fname,

round(titles.advance +
 sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),2)
AS sales_royal

FROM authors

INNER JOIN titleauthor
ON authors.au_id =  titleauthor.au_id

INNER JOIN titles
ON titleauthor.title_id = titles.title_id

INNER JOIN sales
ON titles.title_id = sales.title_id

INNER JOIN roysched
ON titles.title_id =roysched.title_id

GROUP BY authors.au_lname, authors.au_fname, titles.title,  titles.advance;
ORDER BY sales_royal DESC
LIMIT 3;



-- ## CHELLENGE 2 


CREATE TEMPORARY TABLE temptableA

SELECT authors.au_lname, 
authors.au_fname,

round(titles.advance +
 sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),2)
AS sales_royal

FROM authors

INNER JOIN titleauthor
ON authors.au_id =  titleauthor.au_id

INNER JOIN titles
ON titleauthor.title_id = titles.title_id

INNER JOIN sales
ON titles.title_id = sales.title_id

INNER JOIN roysched
ON titles.title_id =roysched.title_id

GROUP BY authors.au_lname, authors.au_fname, titles.title,  titles.advance;


-- ##

SELECT au_lname, sales_royal
FROM temptableA
ORDER BY sales_royal DESC
LIMIT 3;


-- # CHALLENGE 3


CREATE TABLE most_profiting_authors

SELECT authors.au_id AS Author_ID,
round(titles.advance +
 sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),2)
AS Profits

FROM authors

INNER JOIN titleauthor
ON authors.au_id =  titleauthor.au_id

INNER JOIN titles
ON titleauthor.title_id = titles.title_id

INNER JOIN sales
ON titles.title_id = sales.title_id

INNER JOIN roysched
ON titles.title_id =roysched.title_id

GROUP BY authors.au_id, titles.title,  titles.advance;

-- ##

SELECT * FROM most_profiting_authors

SELECT Author_ID, Profits
FROM most_profiting_authors
ORDER BY Profits DESC
LIMIT 3;

