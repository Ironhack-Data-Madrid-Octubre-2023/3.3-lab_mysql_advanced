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
SELECT 
    Author_ID,
    SUM(subquery.Royalty + t.advance) AS TotalRoyaltyAdvance
FROM
    (SELECT 
        t.title_id Title_ID,
            ta.au_id Author_ID,
            (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) Royalty
    FROM
        titles t
    INNER JOIN titleauthor ta ON t.title_id = ta.title_id
    INNER JOIN sales s ON t.title_id = s.title_id) AS subquery
        LEFT JOIN
    titles t ON subquery.Title_ID = t.title_id
GROUP BY subquery.Author_ID
ORDER BY TotalRoyaltyAdvance DESC
LIMIT 3;


-- CHALLENGE 2
--INTENTAR CON TABLAS TEMPORALES -> Se hace con: create temporary table publications.NOMBRE_TABLA_TEMPORAL

-- Step 1
CREATE TEMPORARY TABLE publications.royalty_step1 -- Mecreo una tabla temporal con lo el step 1 del primer challenge
SELECT 
    t.title_id Title_ID,
    ta.au_id Author_ID,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) SalesRoyalty
FROM
    titles t

INNER JOIN titleauthor ta
ON t.title_id = ta.title_id
INNER JOIN sales s
ON t.title_id = s.title_id;  

-- Step 2

CREATE TEMPORARY TABLE publications.royalty_step2 -- Creo una temporary table de este segundo paso
SELECT 
    Title_ID, Author_ID, SUM(SalesRoyalty) Total_Royalties -- Primeras dos filas igual, la tercera es la suma de las royalties y agrupo por title y author
FROM
    royalty_step1
GROUP BY Title_ID , Author_ID
ORDER BY Total_Royalties DESC;

-- Step 3

SELECT 
    royalty_step2.Author_ID Author_ID, -- Author_ID de la segunda tabla temporal creada
    SUM(royalty_step2.Total_royalties + t.advance) TotalEarnings -- Sumo los Total_Royalties de la 2ª tabla temporal y el adelantado de cada obra -> agrupo por Author_ID
FROM
    royalty_step2
        INNER JOIN
    titles t ON royalty_step2.title_id = t.title_id
GROUP BY Author_ID
ORDER BY TotalEarnings DESC -- Ordeno de mayor a menor
;
	
/*
No entiendo muy bien porque tengo un distinto output haciéndolo con subquerys y tablas temporales. He comprobado que los steps 1 y 2 con ambos métodos 
salen igual pero algo debo estar haciendo mal en el step 3 de alguno de los dos  (o quizás ambos jaja).

*/


--CHALLENGE 3
CREATE TABLE publications.most_profiting_authors SELECT Author_ID,
    SUM(subquery.Royalty + t.advance) AS TotalRoyaltyAdvance FROM
    (SELECT 
        t.title_id Title_ID,
            ta.au_id Author_ID,
            (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) Royalty
    FROM
        titles t
    INNER JOIN titleauthor ta ON t.title_id = ta.title_id
    INNER JOIN sales s ON t.title_id = s.title_id) AS subquery
        LEFT JOIN
    titles t ON subquery.Title_ID = t.title_id
GROUP BY subquery.Author_ID
ORDER BY TotalRoyaltyAdvance DESC
LIMIT 3;
       
       
       