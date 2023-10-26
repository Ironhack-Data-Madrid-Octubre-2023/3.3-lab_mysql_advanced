CHALLENGE 1:

--Step 1

select
    t.title_id as title_id,
    ti.au_id as author_id,
    (t.price * s.qty * t.royalty / 100 * ti.royaltyper / 100) as sales_royalty
from titleauthor as ti
inner join titles as t 
on ti.title_id = t.title_id
inner join sales as s 
on t.title_id = s.title_id;

--Step 2

select
    title_id,
    author_id,
    sum(sales_royalty) as aggregated_royalties
from (
    select
        t.title_id  title_id,
        ti.au_id as author_id,
        (t.price * s.qty * t.royalty / 100 * ti.royaltyper / 100) as sales_royalty
    from titleauthor as ti
    inner join titles as t 
    on ti.title_id = t.title_id
    inner join sales as s 
    on t.title_id = s.title_id
) as subquery
group by title_id, author_id;

--Step 3

select
    author_id,
    sum(advance + aggregated_royalties) as profits
from (
    select
        t.title_id as title_id,
        ti.au_id as author_id,
        (t.price * s.qty * t.royalty / 100 * ti.royaltyper / 100) as aggregated_royalties,
        t.advance as advance
    from titleauthor as ti
    inner join titles as t on ti.title_id = t.title_id
    inner join sales as s on t.title_id = s.title_id
) as subquery
group by author_id
order by profits desc
limit 3;