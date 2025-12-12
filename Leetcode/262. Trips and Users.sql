with unbanned as (
    select users_id from Users where banned = 'No'
),
combined_table as (
    select * from Trips t 
    where client_id in (select * from unbanned) and driver_id in (select * from unbanned) and (request_at between '2013-10-01' and '2013-10-03')
)


Select 
  x1.Day, ifnull(rno,0) as "Cancellation Rate" 
from 
  (select request_at as "Day", ROUND(num/den,2) as rno from (
      select request_at, count(request_at) as num from combined_table
      Where status != 'completed'
      group by request_at
  ) t1 INNER JOIN (
      select request_at, count(request_at) as den from combined_table
      group by request_at
  ) t2 USING(request_at)) x
  RIGHT JOIN
  (select DISTINCT(request_at) as Day from combined_table where (request_at between '2013-10-01' and '2013-10-03')) x1
  ON x.Day = x1.Day;
