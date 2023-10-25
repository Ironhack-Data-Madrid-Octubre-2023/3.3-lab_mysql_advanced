-- Challenge 1
-- Step 1
SELECT
t.title_id AS Title_ID,
ta.au_id AS Author_ID,
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS Sales_royalty
FROM titleauthor as ta
LEFT JOIN titles as t
ON ta.title_id = t.title_id
LEFT JOIN sales as s
ON t.title_id = s.title_id;

-- Step 2
select 
ta.title_id as Title_ID, 
ta.au_id as Author_ID,
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as Sales_royalty

from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on t.title_id=s.title_id
group by ta.title_id, ta.au_id;

-- Step 3
select

ta.au_id as Author_ID,
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + SUM(t.price * s.qty * t.advance) as Total_Sales

from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on t.title_id=s.title_id
group by ta.au_id
order by total_sales DESC
limit 3;

-- Challange 2
create temporary table TempTabla as
select
ta.au_id as Author_ID,
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + SUM(t.price * s.qty * t.advance) as Total_Sales

from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on t.title_id=s.title_id
group by ta.au_id
order by total_sales DESC
limit 3; 

-- Challenge 3
create table most_profiting_authors as 
select
ta.au_id as Author_ID,
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + SUM(t.price * s.qty * t.advance) as Total_Sales

from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on t.title_id=s.title_id
group by ta.au_id
order by total_sales DESC
limit 3; 
