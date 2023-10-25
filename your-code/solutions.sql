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
select ta.title_id, a.au_id , sum(t.price * sa.qty * t.royalty / 100*ta.royaltyper / 100) as royalties
 from authors as a
inner join titleauthor as ta
on a.au_id= ta.au_id
inner join titles as t
 on ta.title_id = t.title_id
inner join sales as sa
 on t.title_id =sa.title_id
 group by ta.title_id, a.au_id;

-- Step3
select au_id, sum(profit) as profit from
(select ta.title_id, a.au_id, ((sum(t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100))+t.advance) as profit
 from authors as a
inner join titleauthor as ta
on a.au_id= ta.au_id
inner join titles as t
 on ta.title_id = t.title_id
inner join sales as sa
 on t.title_id =sa.title_id
 group by ta.title_id, a.au_id) as step3
 group by au_id
 order by profit desc limit 3
;
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
select au_id, sum(profit) as profit from
(select ta.title_id, a.au_id, ((sum(t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100))+t.advance) as profit
 from authors as a
inner join titleauthor as ta
on a.au_id= ta.au_id
inner join titles as t
 on ta.title_id = t.title_id
inner join sales as sa
 on t.title_id =sa.title_id
 group by ta.title_id, a.au_id) as step3
 group by au_id
 order by profit desc limit 3
;
