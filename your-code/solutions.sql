SELECT 
    titleauthor.title_id AS 'TITLE ID',
    titleauthor.au_id AS 'AUTHOR ID',
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS 'ROYALITY'
FROM
    titleauthor
        INNER JOIN
    titles ON titleauthor.title_id = titles.title_id
		INNER JOIN
	sales ON titles.title_id = sales.title_id
	
    
