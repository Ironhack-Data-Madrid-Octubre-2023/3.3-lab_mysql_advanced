SELECT
    a.au_id AS Author_ID,
    SUM(t.advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)) AS Total_Profits
FROM
    authors a
JOIN
    titleauthor ta ON ta.au_id = a.au_id
JOIN
    titles t ON t.title_id = ta.title_id
JOIN
    sales s ON s.title_id = t.title_id
GROUP BY
    a.au_id
ORDER BY
    Total_Profits DESC
LIMIT 3;
