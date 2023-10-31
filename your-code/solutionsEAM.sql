-- Al corrector; siento que el este lab ha sido muy pobre por mi parte. Mucho que mejorar, pero por algún motivo, me ha sido imposible sacar más de sql (ni con el chat ni nada...) Me gustaría poder repetirlo/repasar estos conceptos. 

-- Best Selling Authors
SELECT 
  a.au_id AS 'Author ID',
  a.au_lname AS 'Last Name',
  a.au_fname AS 'First Name',
  COALESCE(SUM(s.qty), 0) AS 'BestSellingAuthors',
  s.title_id AS 'Title ID',
  s.qty AS 'number_sold'
FROM authors AS a
LEFT JOIN titleauthor AS t ON a.au_id = t.au_id
LEFT JOIN sales AS s ON t.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY 'BestSellingAuthors' DESC


-- -- Best Sellers and profitable 
SELECT 
  a.au_id AS 'Author ID',
  a.au_lname AS 'Last Name',
  a.au_fname AS 'First Name',
  COALESCE(SUM(s.qty), 0) AS 'BestSellingAuthors',
  s.title_id AS 'Title ID',
  s.qty AS 'number_sold',
  (s.qty * COALESCE(SUM(s.qty), 0)) AS 'TotalSales'
FROM authors AS a
LEFT JOIN titleauthor AS t ON a.au_id = t.au_id
LEFT JOIN sales AS s ON t.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname, s.title_id, s.qty
ORDER BY 'BestSellingAuthors' DESC;

-- Royalty

Select
titleauthor.title_id AS 'TITLE ID',
titleauthor.au_id AS 'AUTHOR ID',
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS 'ROYALITY'
FROM
titleauthor
INNER JOIN
titles ON titleauthor.title_id = titles.title_id
INNER JOIN
sales ON titles.title_id = sales.title_id