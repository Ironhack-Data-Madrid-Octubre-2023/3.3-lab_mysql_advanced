--Challenge 1 - Most Profiting Authors

--STEP 1

SELECT 
    t.title_id Title_ID,
    ta.au_id Author_ID,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) Total_Royalty
FROM
    titles t
        INNER JOIN
    titleauthor ta ON t.title_id = ta.title_id
        INNER JOIN
    sales s ON t.title_id = s.title_id;
    
--STEP 2

SELECT 
    t.title_id Title_ID,
    ta.au_id Author_ID,
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) Total_Royalty
FROM
    titles t
        INNER JOIN
    titleauthor ta ON t.title_id = ta.title_id
        INNER JOIN
    sales s ON t.title_id = s.title_id
    
GROUP BY t.title_id , ta.au_id;

--STEP 3


