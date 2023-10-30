SELECT
    p.pub_id AS author_id,
    COALESCE(SUM(t.advance), 0) AS total_advance,
    COALESCE(SUM(s.qty * t.royalty), 0) AS total_royalty,
    COALESCE(SUM(t.advance), 0) + COALESCE(SUM(s.qty * t.royalty), 0) AS total_profit
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
LEFT JOIN sales s ON s.title_id = t.title_id
GROUP BY p.pub_id;



2
SELECT 
    sa.title_id,
    sa.author_id,
    SUM(sa.royalty) AS aggregated_royalties
FROM (
    
    SELECT 
        s.title_id,
        p.pub_id AS author_id,
        s.qty * t.royalty AS royalty
    FROM sales s
    JOIN titles t ON s.title_id = t.title_id
    JOIN publishers p ON t.pub_id = p.pub_id
) sa
GROUP BY sa.title_id, sa.author_id;

3

SELECT 
    sa.author_id AS Author_ID,
    COALESCE(SUM(t.advance), 0) + COALESCE(SUM(sa.total_royalty), 0) AS Total_Profits
FROM (
    SELECT
        t.title_id,
        p.pub_id AS author_id,
        SUM(s.qty * t.royalty) AS total_royalty
    FROM sales s
    JOIN titles t ON s.title_id = t.title_id
    JOIN publishers p ON t.pub_id = p.pub_id
    GROUP BY t.title_id, p.pub_id
) sa
LEFT JOIN titles t ON sa.title_id = t.title_id
LEFT JOIN publishers p ON sa.author_id = p.pub_id
GROUP BY sa.author_id
ORDER BY Total_Profits DESC
LIMIT 3;