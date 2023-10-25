#Challenge 1 - Most Profiting Authors
#Step 1: Calculate the royalties of each sales for each author
SELECT
    t.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    t.price * sl.qty * t.royalty / 100 * ta.royaltyper / 100 as 'sales_royalty'
FROM titleauthor as ta
left JOIN titles as t 
ON ta.title_id = t.title_id
left JOIN sales as sl 
ON t.title_id = sl.title_id;

#Step 2: Aggregate the total royalties for each title for each author
SELECT
    t.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    sum(t.price * sl.qty * t.royalty / 100 * ta.royaltyper / 100) as 'Aggregated_Royalties'
FROM titleauthor as ta
left JOIN titles as t 
ON ta.title_id = t.title_id
left JOIN sales as sl 
ON t.title_id = sl.title_id
group by t.title_id, ta.au_id;


#Step 3: Calculate the total profits of each author
SELECT
    ta.au_id AS 'Author ID',
    sum((t.price * sl.qty * t.royalty / 100 * ta.royaltyper / 100)+t.advance) as 'Profits_of_each_author'
FROM titleauthor as ta
left JOIN titles as t 
ON ta.title_id = t.title_id
left JOIN sales as sl 
ON t.title_id = sl.title_id
group by t.title_id, ta.au_id
order by Profits_of_each_author desc;

#Challenge 2 - Alternative Solution
#creo una tabla temporal del step 1
create temporary table publications.store_sales_summary
SELECT
    t.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    t.price * sl.qty * t.royalty / 100 * ta.royaltyper / 100 as 'sales_royalty'
FROM titleauthor as ta
left JOIN titles as t 
ON ta.title_id = t.title_id
left JOIN sales as sl 
ON t.title_id = sl.title_id;
#borro la tabla temporal
DROP TABLE store_sales_summary;



#creo una tabla permanebte
create table publications.store_sales_summary
SELECT
    ta.au_id AS 'Author ID',
    sum((t.price * sl.qty * t.royalty / 100 * ta.royaltyper / 100)+t.advance) as 'Profits_of_each_author'
FROM titleauthor as ta
left JOIN titles as t 
ON ta.title_id = t.title_id
left JOIN sales as sl 
ON t.title_id = sl.title_id
group by t.title_id, ta.au_id
order by Profits_of_each_author desc;
#borro la tabla permanente
DROP TABLE store_sales_summary;



#Challenge 3
CREATE TABLE most_profiting_authors
SELECT
    ta.au_id AS 'Author ID',
    sum((t.price * sl.qty * t.royalty / 100 * ta.royaltyper / 100)+t.advance) as 'Profits'
FROM titleauthor as ta
left JOIN titles as t 
ON ta.title_id = t.title_id
left JOIN sales as sl 
ON t.title_id = sl.title_id
group by t.title_id, ta.au_id
order by Profits desc
limit 1;
select * from most_profiting_authors


