-- CHALLENGE 1 - Most Profiting Authors

-- Step 1

CREATE TEMPORARY TABLE royaltiespersale
SELECT 
    a.au_id,
    t.title_id,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM
    sales AS s
        INNER JOIN
    titles AS t ON s.title_id = t.title_id
        INNER JOIN
    titleauthor AS ta ON t.title_id = ta.title_id
        INNER JOIN
    authors AS a ON ta.au_id = a.au_id;
    
    
-- Step 2 

CREATE TEMPORARY TABLE step22
SELECT 
    au_id, title_id, sum(sales_royalty) AS aggroyalty
FROM
    step1
GROUP BY 
	au_id, title_id;
    

-- Step 3

SELECT 
    a.au_id, ROUND(SUM(advance + aggroyalty), 1) AS totalprofit
FROM
    step22
        INNER JOIN
    titles AS t ON step22.title_id = t.title_id
        INNER JOIN
    authors AS a ON step22.au_id = a.au_id
GROUP BY a.au_id;

