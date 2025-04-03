with prime as(
  SELECT 
    item_type, count(item_id) as p_item_cnt, sum(square_footage) as p_storage_area
  FROM 
    inventory 
  where 
    item_type = 'prime_eligible'
  group by item_type
),
not_prime as(
  SELECT 
    item_type, count(item_id) as np_item_cnt, sum(square_footage) as np_storage_area
  FROM 
    inventory 
  where 
    item_type = 'not_prime'
  group by item_type
)

select 
  item_type, round(((500000-(500000%p_storage_area))/p_storage_area)*p_item_cnt) as item_count
from
  prime

UNION ALL

select 
  np.item_type, round((((500000%p_storage_area)-((500000%p_storage_area)%np_storage_area))/np_storage_area)*np_item_cnt) as item_count
from
  not_prime np,prime
