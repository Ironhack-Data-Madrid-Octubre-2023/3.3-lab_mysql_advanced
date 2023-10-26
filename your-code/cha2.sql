CREATE TEMPORARY TABLE publications.step1
SELECT 
	t.title_id, 
	a.au_id,
	(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty,
	t.advance 
FROM publications.authors a 
JOIN titleauthor ta on ta.au_id = a.au_id 
JOIN titles t on t.title_id =ta.title_id 
JOIN sales s on s.title_id = t.title_id;


CREATE TEMPORARY TABLE publications.step2
SELECT 
    au_id,
    MAX(title_id) AS title_id, 
    SUM(sales_royalty) AS total_sales_royalty,
    MAX(advance) AS advance
FROM publications.step1
GROUP BY
    au_id;

   
CREATE TEMPORARY TABLE publications.step3
SELECT 
    au_id AS author,
    SUM(advance + total_sales_royalty) AS Total_Profits
FROM publications.step2
GROUP BY au_id
ORDER BY Total_Profits DESC
LIMIT 3;

SELECT * from publications.step3
