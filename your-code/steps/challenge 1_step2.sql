SELECT
t.title_id AS 'Title ID',
ta.au_id AS 'Author ID',
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'Aggregated royalties'

FROM titles t

INNER JOIN titleauthor ta
ON t.title_id = ta.title_id
INNER JOIN sales s
ON t.title_id = s.title_id
GROUP BY ta.au_id, t.title_id;