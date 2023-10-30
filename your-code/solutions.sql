------------- CHALLENGE 1 ----------------

---------STEP 1 --------

SELECT 
    t.title_id,price,advance,royalty,
    s.qty,
    a.au_id,au_lname,au_fname,
    ta.royaltyper,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS ROYALTIES
FROM
    titles t
        INNER JOIN
    sales s ON s.title_id = t.title_id
        INNER JOIN
    titleauthor ta ON ta.title_id = s.title_id
        INNER JOIN
    authors a ON a.au_id = ta.au_id
ORDER BY t.title_id , a.au_id;

--------- STEP 2 -------


SELECT 
    title_id,
    au_id,
    au_lname,
    au_fname,
    advance,
    SUM(ROYALTIES) AS ROYALTIES
FROM
    (SELECT 
        t.title_id,
            t.price,
            t.advance,
            t.royalty,
            s.qty,
            a.au_id,
            au_lname,
            au_fname,
            ta.royaltyper,
            (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS ROYALTIES
    FROM
        titles t
    INNER JOIN sales s ON s.title_id = t.title_id
    INNER JOIN titleauthor ta ON ta.title_id = s.title_id
    INNER JOIN authors a ON a.au_id = ta.au_id) AS tmp
GROUP BY au_id , title_id;

-----------STEP 3 -------------

SELECT 
    au_id AS 'AUTHOR ID',
    au_lname AS 'LAST NAME',
    au_fname AS 'FIRST NAME',
    ROUND(SUM(advance * (rt / 100) + ROYALTIES), 2) AS PROFITS
FROM
    (SELECT 
        title_id,
            au_id,
            au_lname,
            au_fname,
            advance,
            rt,
            SUM(ROYALTIES) AS ROYALTIES
    FROM
        (SELECT 
        t.title_id,
            t.price,
            t.advance,
            t.royalty,
            s.qty,
            a.au_id,
            au_lname,
            au_fname,
            ta.royaltyper AS rt,
            (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS ROYALTIES
    FROM
        titles t
    INNER JOIN sales s ON s.title_id = t.title_id
    INNER JOIN titleauthor ta ON ta.title_id = s.title_id
    INNER JOIN authors a ON a.au_id = ta.au_id) AS temp
    GROUP BY au_id , title_id) AS temp2
GROUP BY au_id
ORDER BY PROFITS DESC
LIMIT 3;

-- Challenge 2

drop temporary table if exists temp1;

CREATE TEMPORARY TABLE temp1
select t.title_id, a.au_id, t.advance as advance, royaltyper as rt, (t.price * s.qty * t.royalty * ta.royaltyper / 10000) as sale_royalty
from titles t
inner join sales s on s.title_id = t.title_id
inner join titleauthor ta on ta.title_id = s.title_id
inner join authors a on a.au_id = ta.au_id
order by t.title_id, a.au_id;
--------------------------------------------------------
drop temporary table if exists temp2;

CREATE TEMPORARY TABLE temp2
select title_id, au_id, advance, rt, sum(sale_royalty) as ROYALTIES
from temp1
group by title_id, au_id;

SELECT 
    temp2.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    ROUND(SUM(t.advance * (rt / 100) + ROYALTIES),
            2) AS PROFITS
FROM
    temp2
        INNER JOIN
    titles t ON t.title_id = temp2.title_id
        INNER JOIN
    authors a ON a.au_id = temp2.au_id
GROUP BY temp2.au_id
ORDER BY PROFITS DESC
LIMIT 3;



