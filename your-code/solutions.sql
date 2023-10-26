--Challenge 1 - Most Profiting Authors

-----STEP 1

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
    
-----STEP 2

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

-----STEP 3

SELECT 
    ta.au_id Author_ID,
    SUM((t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance) Profits
FROM
    titles t
        INNER JOIN
    titleauthor ta ON t.title_id = ta.title_id
        INNER JOIN
    sales s ON t.title_id = s.title_id
GROUP BY t.title_id , ta.au_id
ORDER BY Profits DESC
LIMIT 3;

--Challenge 2 - Alternative Solution

-----STEP 1

CREATE TEMPORARY TABLE Step_1
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
    
-----STEP 2

CREATE TEMPORARY TABLE Step_2
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



----- CONSULT TEMPORY TABLE



SELECT * FROM Step_1
SELECT * FROM Step_2

--Challenge 3

CREATE TABLE most_profiting_authors
SELECT 
    ta.au_id Author_ID,
    SUM((t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance) Profits
FROM
    titles t
        INNER JOIN
    titleauthor ta ON t.title_id = ta.title_id
        INNER JOIN
    sales s ON t.title_id = s.title_id
GROUP BY t.title_id , ta.au_id
ORDER BY Profits DESC
LIMIT 3;


----- CONSULT TEMPORY TABLE

SELECT * FROM most_profiting_authors
