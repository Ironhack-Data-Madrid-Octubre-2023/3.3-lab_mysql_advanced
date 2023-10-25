-- CHALLENGE 1

--Step 1
SELECT 
    t.title_id Title_ID,
    ta.au_id Author_ID,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) Royalty
FROM
    titles t
        INNER JOIN
    titleauthor ta ON t.title_id = ta.title_id
        INNER JOIN
    sales s ON t.title_id = s.title_id;

-- Step 2
SELECT
	Title_ID,
    Author_ID,
    SUM(Royalty) TotalRoyalty
FROM 
(SELECT 
    t.title_id Title_ID,
    ta.au_id Author_ID,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) Royalty
FROM
    titles t
        INNER JOIN
    titleauthor ta ON t.title_id = ta.title_id
        INNER JOIN
    sales s ON t.title_id = s.title_id) AS subquery
    GROUP BY Title_ID, Author_ID
    ORDER BY TotalRoyalty DESC;

-- Step 3

       
       
       