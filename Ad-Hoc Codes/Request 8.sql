/* In which quarter of 2020, got the maximum total_sold_quantity? The final 
output contains these fields sorted by the total_sold_quantity, 
- Quarter 
- total_sold_quantity */
WITH get_quarters AS (
    SELECT 
        CASE
            WHEN MONTH(date) IN (9,10,11) THEN 'Q1'
            WHEN MONTH(date) IN (12,1,2) THEN 'Q2'
            WHEN MONTH(date) IN (3,4,5) THEN 'Q3'
            ELSE 'Q4'
        END AS quarter,
        sold_quantity
    FROM fact_sales_monthly
    WHERE fiscal_year = 2020
)
SELECT 
    quarter, 
    MAX(sold_quantity) AS max_sold_quantity
FROM get_quarters
GROUP BY quarter;



