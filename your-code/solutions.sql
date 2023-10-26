-- CHALLENGE1 SUBQUERIES
-- Step1
select ta.title_id, a.au_id , (t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100) as royalties
from authors as a
inner join titleauthor as ta
on a.au_id= ta.au_id
inner join titles as t
 on ta.title_id = t.title_id
inner join sales as sa
 on t.title_id =sa.title_id;


 -- Step2
SELECT  roy.title_id, roy.au_id, (SUM(roy.royalty)+t.advance) AS ROYALTY
FROM
(SELECT  T.TITLE_ID as title_id, TA.AU_ID as au_id, (t.price * s.qty * t.royalty/100 * ta.royaltyper/100) AS royalty
FROM TITLES AS T
Inner JOIN TITLEAUTHOR AS TA
ON T.TITLE_ID = TA.TITLE_ID
Inner JOIN SALES AS S
ON T.TITLE_ID = S.TITLE_ID) AS ROY
inner join titles as t
on t.title_id = roy.title_id
GROUP BY roy.title_id, roy.au_id;

-- Step3
select au_id, sum(royalty) from
(select  roy.title_id, roy.au_id, (SUM(roy.royalty)+t.advance) as ROYALTY
from
(select  T.TITLE_ID as title_id, TA.AU_ID as au_id, (t.price * s.qty * t.royalty/100 * ta.royaltyper/100) AS royalty
from TITLES as T
inner join TITLEAUTHOR as TA
on T.TITLE_ID = TA.TITLE_ID
inner join SALES as S
on T.TITLE_ID = S.TITLE_ID) as ROY
inner join titles as t
on t.title_id = roy.title_id
group by roy.title_id, roy.au_id) as ROY2
group by au_id
order by sum(royalty) desc limit 3;

-- CHALLENGE 2 TEMPORARY TABLES
-- Step1
create temporary table publications.step1
select ta.title_id, a.au_id , (t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100) as royalties
from authors as a
inner join titleauthor as ta
on a.au_id= ta.au_id
inner join titles as t
 on ta.title_id = t.title_id
inner join sales as sa
 on t.title_id =sa.title_id;

 -- Step2
create temporary table publications.step2
select title_id, au_id, sum(royalties) as royalties
from publications.step1
group by title_id, au_id;

-- Step3
select au_id, sum(royalties+t.advance) as profit from publications.step2
inner join titles as t
on publications.step2.title_id = t.title_id
group by au_id
order by profit desc limit 3
;

-- CHALLENGE 3 PERMANENT TABLE
create table most_profiting_authors
select au_id, sum(royalty) from
(select  roy.title_id, roy.au_id, (SUM(roy.royalty)+t.advance) as ROYALTY
from
(select  T.TITLE_ID as title_id, TA.AU_ID as au_id, (t.price * s.qty * t.royalty/100 * ta.royaltyper/100) AS royalty
from TITLES as T
inner join TITLEAUTHOR as TA
on T.TITLE_ID = TA.TITLE_ID
inner join SALES as S
on T.TITLE_ID = S.TITLE_ID) as ROY
inner join titles as t
on t.title_id = roy.title_id
group by roy.title_id, roy.au_id) as ROY2
group by au_id
order by sum(royalty) desc limit 3;
