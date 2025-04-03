-- overall average salary
-- salary avg of each department

select department_id, payment_date, case 
  when dept_avg_salary < overall_avg_salary then 'lower'
  when dept_avg_salary > overall_avg_salary then 'higher'
  else 'same'
  end as comparison
from 
(
SELECT 
  department_id, to_char(payment_date, 'MM-YYYY') as payment_date, avg(amount) over () as overall_avg_salary, 
  avg(amount) over (partition by department_id) as dept_avg_salary
FROM 
  salary s inner join employee e on s.employee_id = e.employee_id
where 
  extract(year from payment_date) = 2024 and extract(month from payment_date) = 3
) x
group by 1,2,3
