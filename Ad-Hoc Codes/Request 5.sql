 /* Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, 
- product_code 
- product 
- manufacturing_cost
*/

WITH ranked_products as (
    select distinct p.product_code, 
           p.product, 
           mc.manufacturing_cost,
           rank() over (order by  mc.manufacturing_cost desc) as highest_rank,
           rank() over (order by  mc.manufacturing_cost asc) as lowest_rank
    FROM dim_product p 
    join fact_manufacturing_cost mc 
    on p.product_code = mc.product_code
)
select 
	product_code, 
	product, 
	manufacturing_cost
from ranked_products
where highest_rank = 1 OR lowest_rank = 1
order by manufacturing_cost desc;

