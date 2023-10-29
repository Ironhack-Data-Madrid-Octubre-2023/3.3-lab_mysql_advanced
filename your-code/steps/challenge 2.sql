
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
