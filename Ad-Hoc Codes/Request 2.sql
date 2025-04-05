/* Ad_hoc Request 2
What is the percentage increase in unique products in 2021 vs. 2020? The final output contains these fields, 
- unique_products_2020 
- unique_products_2021 
- percentage_chg
*/
With unique_products_2020 AS(
	select fiscal_year, count(distinct product_code) as total_products_20
    from fact_sales_monthly
    where fiscal_year =2020
),
unique_products_2021 AS(
	select fiscal_year, count(distinct product_code) as total_products_21
    from fact_sales_monthly
    where fiscal_year =2021
)
select u20.total_products_20 as unique_products_2020, 
	u21.total_products_21 as unique_products_2021,
	round(((u21.total_products_21 - u20.total_products_20)/ u20.total_products_20)*100,2) AS percentage_change
FROM unique_products_2020 u20 cross join unique_products_2021 u21
on 1=1
