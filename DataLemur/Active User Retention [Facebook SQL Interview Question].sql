with filtered_users as (
  SELECT 
    distinct user_id 
  from 
    user_actions 
  where 
    event_type in ('sign-in', 'like', 'comment') 
    and extract(
      month from event_date
    ) = 6
)

select 
  extract(
    month from event_date
  ) as month, 
  count(distinct user_id) as monthly_active_users 
from 
  user_actions 
where 
  extract(
    month from event_date
  ) = 7 
  and user_id in (
    select * from filtered_users
  ) 
group by 
  1
