/*-- Which channel helped to bring more gross sales in the fiscal year 2021 
and the percentage of contribution?  The final output  contains these fields, 
- channel 
- gross_sales_mln 
- percentage--*/
SELECT 
	C.channel,
	round(SUM(G.gross_price * FSM.sold_quantity)/1000000,2) AS gross_sales_mln,
	ROUND( SUM(G.gross_price * FSM.sold_quantity)*100/
    ( 	SELECT SUM(G.gross_price * FSM.sold_quantity) 
		FROM fact_sales_monthly FSM
		JOIN fact_gross_price G
		ON
			FSM.product_code = G.product_code
		JOIN dim_customer C 
		ON
			FSM.customer_code = C.customer_code
		WHERE FSM.fiscal_year = 2021
),2) AS Percentage
    
FROM fact_sales_monthly FSM
	JOIN fact_gross_price G
ON
	FSM.product_code = G.product_code
JOIN dim_customer C 
ON
	FSM.customer_code = C.customer_code
WHERE FSM.fiscal_year = 2021
GROUP BY C.channel
ORDER BY gross_sales_mln DESC
