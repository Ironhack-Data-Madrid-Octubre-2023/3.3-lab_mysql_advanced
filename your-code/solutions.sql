-- Challenge 1 - Most Profiting Authors

use publications;

SELECT tr.au_id as 'Author ID',
	   sum(royalty + tr.advance) as 'TOTAL EARNINGS'
FROM

(SELECT royalties.title_id,
		royalties.au_id,
        royalties.advance,
		SUM(ROYALTY) royalty
FROM

(SELECT  t.title_id,
	 ta.au_id,
         t.advance,
         T.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS 'ROYALTY'

FROM titles AS t 
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN sales AS s
ON t.title_id = s.title_id) as royalties

GROUP BY royalties.title_id, royalties.au_id, royalties.advance) as tr

GROUP BY tr.au_id;

-- Challenge 2 - Alternative Solution 

USE publications;

CREATE TEMPORARY TABLE publications.royalties

SELECT  t.title_id,
		ta.au_id,
		t.advance,
		T.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS 'ROYALTY'

FROM titles AS t 
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN sales AS s
ON t.title_id = s.title_id;

CREATE TEMPORARY TABLE publications.royaltiessum

SELECT  royalties.title_id,
		royalties.au_id,
        royalties.advance,
		SUM(ROYALTY) royalty

FROM publications.royalties

GROUP BY royalties.title_id, royalties.au_id, royalties.advance;

SELECT royaltiessum.au_id as 'Author ID',
	   sum(royalty + royaltiessum.advance) as 'TOTAL EARNINGS'

FROM publications.royaltiessum

GROUP BY royaltiessum.au_id;

-- Challenge 3

USE publications;

CREATE TABLE most_profiting_authors

SELECT royaltiessum.au_id as 'Author ID',
	   sum(royalty + royaltiessum.advance) as 'TOTAL EARNINGS'

FROM publications.royaltiessum

GROUP BY royaltiessum.au_id;

SELECT * 
FROM most_profiting_authors;
