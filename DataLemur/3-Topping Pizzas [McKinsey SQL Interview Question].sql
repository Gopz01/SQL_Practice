with pizza_toppings as (
  select * from pizza_toppings order by topping_name
)

SELECT 
  concat(p1.topping_name,',',p2.topping_name,',',p3.topping_name) as pizza, p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost as total_cost  
FROM 
  pizza_toppings p1 join pizza_toppings p2 on p1.topping_name < p2.topping_name 
  join pizza_toppings p3 on (p3.topping_name > p1.topping_name and p3.topping_name > p2.topping_name)
order by 2 desc,1

-- 3
-- 123

-- 4
-- 123,124,134,23

-- 5
-- 123,124,125,134,135,145,234,245,345
