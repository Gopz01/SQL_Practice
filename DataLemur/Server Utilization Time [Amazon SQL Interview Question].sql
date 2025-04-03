with start as (
  select *, row_number() over (order by status_time) as rn1 from server_utilization where session_status = 'start'
), 
end1 as (
  select *, row_number() over (order by status_time) as rn2 from server_utilization where session_status = 'stop'
)

SELECT extract(day from sum(e.status_time - s.status_time)) + floor(extract(hour from sum(e.status_time - s.status_time))/24) as total_uptime_days
from start s inner join end1 e 
on rn1 = rn2
