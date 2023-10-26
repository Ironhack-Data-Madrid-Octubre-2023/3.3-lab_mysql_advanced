Challenge 1

STEP 1

select ta.au_id, ta.title_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty

from titleauthor as ta

inner join titles as t
on t.title_id = ta.title_id

inner join sales as s
on s.title_id = ta.title_id

STEP 2

select ta.au_id, ta.title_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

from titleauthor as ta

inner join titles as t
on t.title_id = ta.title_id

inner join sales as s
on s.title_id = ta.title_id
group by ta.au_id, ta.title_id

STEP 3

select ta.au_id, ta.title_id, ta.royaltyper, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

from titleauthor as ta

inner join titles as t
on t.title_id = ta.title_id

inner join sales as s
on s.title_id = ta.title_id
group by ta.au_id, ta.title_id, ta.royaltyper

Challenge 2

create TEMPORARY table TempSales (
    au_id VARCHAR(100),
    title_id VARCHAR(100),
    royaltyper INT,
    sales_royalty DECIMAL(60, 2)
);

insert into TempSales (au_id, title_id, royaltyper, sales_royalty)
select ta.au_id, ta.title_id, ta.royaltyper, round(SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100), 2) AS sales_royalty
from titleauthor as ta
inner join titles as t 
on t.title_id = ta.title_id
inner join sales as s 
on s.title_id = ta.title_id
group by ta.au_id, ta.title_id, ta.royaltyper;
    
select * from TempSales;

drop temporary table TempSales

Challenge 3

CREATE TABLE most_profiting_authors (
    au_id VARCHAR(50) PRIMARY KEY,
    profits DECIMAL(60, 2)
);

insert into most_profiting_authors (au_id, profits)
select ta.au_id, round(SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance),2) as profits
from titleauthor as ta
inner join titles as t 
on t.title_id = ta.title_id
inner join sales as s 
on s.title_id = ta.title_id
group by ta.au_id;

select * from most_profiting_authors;


