
##CHALLENGE 1

#PASO 1

SELECT 

t.title_id AS TitleID, 
ta.au_id AS AuthorID, 
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS sales_royalty

FROM titleauthor as ta

LEFT JOIN titles as t ON ta.title_id = t.title_id
LEFT JOIN sales as s ON t.title_id = s.title_id;



#PASO 2

SELECT 

t.title_id AS TitleID, 
ta.au_id AS AuthorID, 
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty


FROM titleauthor as ta

LEFT JOIN titles as t ON ta.title_id = t.title_id
LEFT JOIN sales as s ON t.title_id = s.title_id

GROUP BY ta.au_id, t.title_id;



#PASO 3


SELECT  

ta.au_id AS AuthorID, 
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + sum(t.price * s.qty * t.advance) as ad_and_royal

FROM titleauthor as ta

LEFT JOIN titles as t ON ta.title_id = t.title_id
LEFT JOIN sales as s ON t.title_id = s.title_id

GROUP BY ta.au_id, t.title_id
ORDER BY ad_and_royal DESC 
LIMIT 3;



##CHALLENGE 2


CREATE TEMPORARY TABLE challenge2 AS

SELECT 

t.title_id AS TitleID, 
ta.au_id AS AuthorID, 
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty


FROM titleauthor as ta

LEFT JOIN titles as t ON ta.title_id = t.title_id
LEFT JOIN sales as s ON t.title_id = s.title_id

GROUP BY ta.au_id, t.title_id;





##CHALLENGE 3

CREATE TABLE most_profitable_author AS

SELECT  

ta.au_id AS AuthorID, 
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) 
+ sum(t.price * s.qty * t.advance) as ad_and_royal

FROM titleauthor as ta

LEFT JOIN titles as t ON ta.title_id = t.title_id
LEFT JOIN sales as s ON t.title_id = s.title_id

GROUP BY ta.au_id, t.title_id
ORDER BY ad_and_royal DESC 
LIMIT 3;




