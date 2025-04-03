
with cte as (
select *, coalesce(lag(cum_num_l) over (),0) as lg from 
  (
    SELECT *, sum(num_users) over (order by searches) as cum_num_l
    FROM search_frequency
  )x
)

select 
  case when mod(sum(num_users),2) = 1 then 
  ( 
    select searches as median from cte
    where lg < (select ((sum(num_users)-1)/2)+1 from search_frequency) and (select ((sum(num_users)-1)/2)+1 from search_frequency) <= cum_num_l
  ) 
  else 
  (
    select round((s1+s2)/2::decimal,1) as median from 
    (select searches as s1 from cte
    where lg < (select (sum(num_users)/2) from search_frequency) and (select (sum(num_users)/2) from search_frequency) <= cum_num_l)x, 
    (select searches as s2 from cte
    where lg < (select (sum(num_users)/2)+1 from search_frequency) and (select (sum(num_users)/2)+1 from search_frequency) <= cum_num_l)y
  )
end 
from search_frequency



    






