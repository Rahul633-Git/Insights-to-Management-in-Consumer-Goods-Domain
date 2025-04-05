/* Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
- customer_code 
- customer 
- average_discount_percentage*/

SELECT 
	c.customer_code,
	c.customer,
    round(avg(pre.pre_invoice_discount_pct) over(order by pre.pre_invoice_discount_pct desc),4) as average_discount_percentage
FROM dim_customer c join fact_pre_invoice_deductions pre
on c.customer_code = pre.customer_code
where c.market = "india" and pre.fiscal_year = 2021
limit 5;


