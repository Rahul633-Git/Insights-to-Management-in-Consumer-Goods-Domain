/*-- 
    Get the Top 3 products in each division that have a high 
total_sold_quantity in the fiscal_year 2021? The final output contains these 
fields, 
- division dim_product
- product_code dim_p
- product  dim_p
- total_sold_quantity 
- rank_order 
--*/

WITH Product_sales_2021 AS (
SELECT 
    P.division,
    P.product_code,
    P.product,
    SUM(sold_quantity) as total_sold_quantity,
    DENSE_RANK() OVER (PARTITION BY division ORDER BY SUM(sold_quantity) DESC) AS rank_order

FROM dim_product P
JOIN  fact_sales_monthly FSM
ON 
	P.product_code = FSM.product_code
WHERE FSM.fiscal_year = 2021
GROUP BY P.division, P.product_code, P.product
)

SELECT 
	division,
    product_code,
    product,
    total_sold_Quantity,
    rank_order
FROM Product_sales_2021
WHERE rank_order<=3 
ORDER BY division, rank_order ;
