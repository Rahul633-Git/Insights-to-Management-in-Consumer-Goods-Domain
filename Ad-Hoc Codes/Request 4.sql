/* Follow-up: Which segment had the most increase in unique products in 
2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference*/

With unique_products_2020 AS(
	select f.fiscal_year,
	p.segment,
	count(distinct f.product_code) as total_products_20
from fact_sales_monthly f join dim_product p
on f.product_code = p.product_code
where fiscal_year =2020
group by segment
),
unique_products_2021 AS(
	select f.fiscal_year,
	p.segment,
	count(distinct f.product_code) as total_products_21
from fact_sales_monthly f join dim_product p
on f.product_code = p.product_code
where fiscal_year =2021
group by segment
)
select 
	u20.segment as segments,
	u20.total_products_20 as unique_products_2020, 
	u21.total_products_21 as unique_products_2021,
	round((u21.total_products_21 - u20.total_products_20),2) AS difference
FROM unique_products_2020 u20  join unique_products_2021 u21
on u20.segment = u21.segment
order by difference desc
