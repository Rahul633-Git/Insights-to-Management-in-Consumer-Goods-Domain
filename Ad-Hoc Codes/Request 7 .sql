/* Get the complete report of the Gross sales amount for the customer  “Atliq 
Exclusive”  for each month  .  This analysis helps to  get an idea of low and 
high-performing months and take strategic decisions. 
The final report contains these columns: 
- Month 
- Year 
- Gross sales Amount
*/
SELECT 
	CONCAT(MONTHNAME(FSM.date), ' (', YEAR(FSM.date), ')') AS 'Month', 
	FSM.fiscal_year,
	ROUND(SUM(G.gross_price*FSM.sold_quantity)/1000000, 2) AS 'Gross_sales_Amount (Millions)'
FROM fact_sales_monthly FSM 
	JOIN dim_customer C 
    ON FSM.customer_code = C.customer_code
	JOIN fact_gross_price G 
    ON FSM.product_code = G.product_code
WHERE C.customer = 'Atliq Exclusive'
GROUP BY  Month, FSM.fiscal_year 
ORDER BY FSM.fiscal_year ;
