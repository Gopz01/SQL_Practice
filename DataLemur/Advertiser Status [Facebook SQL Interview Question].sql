select
  COALESCE(a.user_id,d.user_id) as user_id, CASE
  when a.user_id is null then 'NEW'
  when paid is null then 'CHURN'
  when status = 'CHURN' then 'RESURRECT'
  else 'EXISTING'
  end as new_status
FROM advertiser a full outer JOIN daily_pay d on a.user_id=d.user_id
order by 1;
